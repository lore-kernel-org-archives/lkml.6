Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48180ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 22:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00BE020862
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 22:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00BE020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730627AbeGPWpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 18:45:25 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:43673 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729245AbeGPWpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 18:45:25 -0400
Received: by mail-oi0-f67.google.com with SMTP id b15-v6so77772118oib.10;
        Mon, 16 Jul 2018 15:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NE5JQd3XDT/c7L7J6bLRzznKIMqJyEMxXF316nZWc/o=;
        b=IuUwYpVfR1yDw05DfILfyCHvVhMuCVgY30QSLKMICYmgEc4KGqU+MwRZmyAqav6kKl
         XDKAPQLR69jLdh03qPEem4D8iyVKWpjNqr4EVImmgAbJc+mUQhUf9SyWgWEG6JG6Z6bk
         KepjHPH63ZsjhrHAQ1JkZ1/d8/kTb8G6ZR+1V3liOUqYPZOUS7FxRg1vdk6ESInE13JL
         QlvXGu0YrM/++NM36y6SLa7n0T6ftQ5uq2fl95jNDDRB0HFKXueaLBv/U7cGtsfdTCfI
         Mzjaq5yjslKfFV+7bkE9DXwg43t4Q9Op1VFh+pFGLHUxYoJnch8jk/x22ceaKbvF96jC
         cVhQ==
X-Gm-Message-State: AOUpUlGcWnZMxFQ0iNwQk5EvPetqahE/zlEHhFZg0oIKKmKH4SucQnhM
        8KuLA+VDdtFHntGjE4i3SA==
X-Google-Smtp-Source: AAOMgpd5Ql+Iu1nIb33KuUUBCzJcMhSUiK8dO4O+Op9fGNmOpUKARuRMYQrHZoyP3ODQ4vdjmSqtjw==
X-Received: by 2002:aca:b641:: with SMTP id g62-v6mr1349961oif.71.1531779359504;
        Mon, 16 Jul 2018 15:15:59 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id z196-v6sm65332466oig.12.2018.07.16.15.15.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 15:15:58 -0700 (PDT)
Date:   Mon, 16 Jul 2018 16:15:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pascal PAILLET-LME <p.paillet@st.com>
Cc:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
Subject: Re: [PATCH 2/8] mfd: stpmu1: add stpmu1 pmic driver
Message-ID: <20180716221558.GA3786@rob-hp-laptop>
References: <1530803657-17684-1-git-send-email-p.paillet@st.com>
 <1530803657-17684-3-git-send-email-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530803657-17684-3-git-send-email-p.paillet@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 03:14:22PM +0000, Pascal PAILLET-LME wrote:
> From: pascal paillet <p.paillet@st.com>
> 
> stpmu1 is a pmic from STMicroelectronics. The stpmu1 integrates 10
> regulators and 3 switches with various capabilities.
> 
> Signed-off-by: pascal paillet <p.paillet@st.com>
> ---
>  drivers/mfd/Kconfig                 |  14 ++
>  drivers/mfd/Makefile                |   1 +
>  drivers/mfd/stpmu1.c                | 490 ++++++++++++++++++++++++++++++++++++
>  include/dt-bindings/mfd/st,stpmu1.h |  46 ++++

This belongs with patch 1.

>  include/linux/mfd/stpmu1.h          | 220 ++++++++++++++++
>  5 files changed, 771 insertions(+)
>  create mode 100644 drivers/mfd/stpmu1.c
>  create mode 100644 include/dt-bindings/mfd/st,stpmu1.h
>  create mode 100644 include/linux/mfd/stpmu1.h
