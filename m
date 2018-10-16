Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3DDC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5ACB20869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5ACB20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbeJPL5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 07:57:06 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42278 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbeJPL5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 07:57:06 -0400
Received: by mail-ed1-f67.google.com with SMTP id b7-v6so19879333edd.9;
        Mon, 15 Oct 2018 21:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nDhV0QHL1AOUPGY6lvhj7WHShGcLbPJgG6TnCyqSOpU=;
        b=LAnUrxwIDGV3Oc6YeNZNjQOC15SC8Gk9DPh37BsF4x6pdqV5qvEDiBEu9oIhycPhZh
         MK68bcjUdSHG208XMprrcDXvWUBOsRMRpozNkfPqQxOYrSKR3K2k9r9msPD7TVs+zbbB
         i+0S+vStfj6lTQk1UAEoKXMBX4cFDyzKClFzeeqIp8LJlxaPHrBgRUQL6gZ9SIkM0j6c
         w54LVuFECcJeqIK3CNWJKJFdJKqheR7YpEF2Y1V+UKX1C7XcVfly36donIsQRnYZiEL/
         u8Cwa8PDL9eKoK9hrHJKehLViHns5ehgc12d+e418CC5x5O9+Ff1MBqGO/cOIcQBVAO7
         pEig==
X-Gm-Message-State: ABuFfogjr8Cv9XwuTdakxX8GI/RHMGuRW87cWnernML7dv1i1u9NAVnv
        D/oJesmXTLVAe9c1uYyjq/ADXL+e
X-Google-Smtp-Source: ACcGV60bmOcOlIHZzj6kmvkeJNzia1hptMyMr4op67loLKQ1IxT1eb9YeKTPY0kzklcATWg9tyuuaw==
X-Received: by 2002:a50:e602:: with SMTP id y2-v6mr28873229edm.278.1539662923356;
        Mon, 15 Oct 2018 21:08:43 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id r55-v6sm7267269edd.80.2018.10.15.21.08.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 21:08:42 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id e4-v6so23705936wrs.0;
        Mon, 15 Oct 2018 21:08:42 -0700 (PDT)
X-Received: by 2002:adf:edc2:: with SMTP id v2-v6mr15836968wro.208.1539662921945;
 Mon, 15 Oct 2018 21:08:41 -0700 (PDT)
MIME-Version: 1.0
References: <20181013080848.29894-1-oskari@lemmela.net> <20181013080848.29894-3-oskari@lemmela.net>
In-Reply-To: <20181013080848.29894-3-oskari@lemmela.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 16 Oct 2018 12:08:28 +0800
X-Gmail-Original-Message-ID: <CAGb2v66WEx049805p65+4xaTnfeCQqT6EOCKmx=KD8dU=ogAbA@mail.gmail.com>
Message-ID: <CAGb2v66WEx049805p65+4xaTnfeCQqT6EOCKmx=KD8dU=ogAbA@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] ARM: dts: axp81x: add AC power supply subnode
To:     oskari@lemmela.net
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 4:09 PM Oskari Lemmela <oskari@lemmela.net> wrote:
>
> Add AC power supply subnode for AXP81X PMIC.
>
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
