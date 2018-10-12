Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6304C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC5AC20865
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC5AC20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbeJLXFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:05:24 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43430 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728857AbeJLXFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:05:24 -0400
Received: by mail-ot1-f66.google.com with SMTP id k9so12730951otl.10;
        Fri, 12 Oct 2018 08:32:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c3Er9xlOl/80PyAQ9uxJ5l3IRvUPkTzLiHqMRBxEdp4=;
        b=GwplVOk/GvyYyfgAwGOq+FV8zOLqAg+aWO4y3fpofU9rJz3RDCGjW39EBU55ajbU5a
         QP1WtwmkwW/Rg/HxQmXE3i7EtZOYvNmYhDVUByZ6vG9tg9LNyN9zhjAImtoTmjRDMs4i
         kOV8ebKOaP8A1y+OVrTr5N/yN7TuAZQ9oHQwaLqXlQjt+Fqv6BFuvNpujMca5nAIyU1k
         e2nVEC7U4iRIv6auCCfm0X1263HjDsfsA67UDKxMOO7Bu7+BmcgPvJTpqj2LdTFUY66l
         3HcABQag7lLT9VMB0hOBW3hEQUZroTI5hUTT179M9UeFn7xZMicXHWncHUT8EtYSyWFr
         H/xg==
X-Gm-Message-State: ABuFfohp0kpd4+Syz0qICduCn3ctQ05JL6T5LRbz9iwq3exR164GUgjn
        BVnaMohv/5DtEG4tInKKNg==
X-Google-Smtp-Source: ACcGV61axsrk3ftmW7USIt/DurTmm29RfSdlhh5UWeJycaz3/DsbmIBLwxXeLC0R1ypCzkotikft2A==
X-Received: by 2002:a9d:554a:: with SMTP id h10-v6mr3816594oti.151.1539358343773;
        Fri, 12 Oct 2018 08:32:23 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 19-v6sm394569oty.16.2018.10.12.08.32.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 08:32:23 -0700 (PDT)
Date:   Fri, 12 Oct 2018 10:32:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pascal PAILLET-LME <p.paillet@st.com>
Cc:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
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
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>,
        Pascal PAILLET-LME <p.paillet@st.com>
Subject: Re: [PATCH v3 3/8] dt-bindings: regulator: document stpmic1 pmic
  regulators
Message-ID: <20181012153222.GA29914@bogus>
References: <1539016176-4072-1-git-send-email-p.paillet@st.com>
 <1539016176-4072-4-git-send-email-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539016176-4072-4-git-send-email-p.paillet@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2018 16:29:40 +0000, Pascal PAILLET-LME wrote:
> From: pascal paillet <p.paillet@st.com>
> 
> The STPMIC1 regulators supply power to the application processor as well as
> to the external system peripherals such as DDR, Flash memories and system
> devices.
> 
> Signed-off-by: pascal paillet <p.paillet@st.com>
> ---
> changes in v3: nothing
> 
>  .../bindings/regulator/st,stpmic1-regulator.txt    | 68 ++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/st,stpmic1-regulator.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
