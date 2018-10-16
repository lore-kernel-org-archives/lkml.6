Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,UPPERCASE_50_75,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E488EC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D2B21471
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3D2B21471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbeJQGcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 02:32:45 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40123 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbeJQGcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 02:32:45 -0400
Received: by mail-oi1-f196.google.com with SMTP id j68-v6so19504611oib.7;
        Tue, 16 Oct 2018 15:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zRWqvO4R+4jg3yhcMakYBcOJztroXJMZI4tGizd4PpU=;
        b=qdlGZ5q8GsSNfkCAneuRDiMw7Lz8CZn9kLAzBmnoj+ARDYe24SUAM13Fq4aYZybYUg
         eU0voV6SbeEqErlVnMBfmp8OI8NkiLiGOcddbu5Dp3GW2+qD8K8slSI2LtjPlfU0JxWE
         BUTpgGt0WYN+c1VFHSQa3zELVosv6GZwU2DSKuJljth1FOrooHsgiMH5Uvnf8CMmlTnt
         zfT2bMgqw01jQ8xx7U1c17MbrFPZAXWEgJGPQwE3zw2ruHFP3s82O9ddkhrqQWOUI2av
         XI4MDwi9v3NFd71IWXdhCOZB3fUvuWn+acyGWKen7ryUfNAI3Iqlb7bEDI0/lHeSFXJ6
         Fb6w==
X-Gm-Message-State: ABuFfoizmWaKGU0ejG+9SPhjT2V1XPTfyVKlWjH9b0XaoqNxwhrDC65L
        I6NoTkEI2udSHGfDOfwP2Q==
X-Google-Smtp-Source: ACcGV63kGM4DnSAAJ2TyyaRAsOz7R+u+7S/oN/X3ybjd6zEtCGtFqCyZOokvnCUWDxal+CyvIJJZ1w==
X-Received: by 2002:aca:4b97:: with SMTP id y145-v6mr13186091oia.132.1539729610974;
        Tue, 16 Oct 2018 15:40:10 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b185-v6sm4566711oia.12.2018.10.16.15.40.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 15:40:10 -0700 (PDT)
Date:   Tue, 16 Oct 2018 17:40:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     David HERNANDEZ SANCHEZ <david.hernandezsanchez@st.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH 3/3] ARM: dts: stm32: add thermal sensor support on
  STM32MP157c
Message-ID: <20181016224009.GA24851@bogus>
References: <1538734081-26585-1-git-send-email-david.hernandezsanchez@st.com>
 <1538734081-26585-4-git-send-email-david.hernandezsanchez@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538734081-26585-4-git-send-email-david.hernandezsanchez@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Oct 2018 10:08:46 +0000, David HERNANDEZ SANCHEZ wrote:
> QWRkIGNvbmZpZ3VyYXRpb24gb24gRFQgZm9yIHRoZXJtYWwgc2Vuc29yIGRyaXZlcg0KDQpTaWdu
> ZWQtb2ZmLWJ5OiBEYXZpZCBIZXJuYW5kZXogU2FuY2hleiA8ZGF2aWQuaGVybmFuZGV6c2FuY2hl
> ekBzdC5jb20+DQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9zdG0zMm1wMTU3Yy5k
> dHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvc3RtMzJtcDE1N2MuZHRzaQ0KaW5kZXggNjYxYmU5NC4u
> ZTkwYjlmNiAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL3N0bTMybXAxNTdjLmR0c2kN
> CisrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3N0bTMybXAxNTdjLmR0c2kNCkBAIC04NCw2ICs4NCwz
> MSBAQA0KIAkJfTsNCiAJfTsNCg0KKwl0aGVybWFsLXpvbmVzIHsNCisJCWNwdV90aGVybWFsOiBj
> cHUtdGhlcm1hbCB7DQorCQkJcG9sbGluZy1kZWxheS1wYXNzaXZlID0gPDA+Ow0KKwkJCXBvbGxp
> bmctZGVsYXkgPSA8MD47DQorCQkJdGhlcm1hbC1zZW5zb3JzID0gPCZkdHM+Ow0KKw0KKwkJCXRy
> aXBzIHsNCisJCQkJY3B1X2FsZXJ0MTogY3B1LWFsZXJ0MSB7DQorCQkJCQl0ZW1wZXJhdHVyZSA9
> IDw4NTAwMD47DQorCQkJCQloeXN0ZXJlc2lzID0gPDA+Ow0KKwkJCQkJdHlwZSA9ICJwYXNzaXZl
> IjsNCisJCQkJfTsNCisNCisJCQkJY3B1LWNyaXQgew0KKwkJCQkJdGVtcGVyYXR1cmUgPSA8MTIw
> MDAwPjsNCisJCQkJCWh5c3RlcmVzaXMgPSA8MD47DQorCQkJCQl0eXBlID0gImNyaXRpY2FsIjsN
> CisJCQkJfTsNCisJCQl9Ow0KKw0KKwkJCWNvb2xpbmctbWFwcyB7DQorCQkJfTsNCisJCX07DQor
> CX07DQorDQogCXNvYyB7DQogCQljb21wYXRpYmxlID0gInNpbXBsZS1idXMiOw0KIAkJI2FkZHJl
> c3MtY2VsbHMgPSA8MT47DQpAQCAtOTA4LDYgKzkzMywxNiBAQA0KIAkJCXN0YXR1cyA9ICJkaXNh
> YmxlZCI7DQogCQl9Ow0KDQorCQlkdHM6IHRoZXJtYWxANTAwMjgwMDAgew0KKwkJCWNvbXBhdGli
> bGUgPSAic3Qsc3RtMzItdGhlcm1hbCI7DQorCQkJcmVnID0gPDB4NTAwMjgwMDAgMHgxMDA+Ow0K
> KwkJCWludGVycnVwdHMgPSA8R0lDX1NQSSAxNDcgSVJRX1RZUEVfTEVWRUxfSElHSD47DQorCQkJ
> Y2xvY2tzID0gPCZyY2MgVE1QU0VOUz47DQorCQkJY2xvY2stbmFtZXMgPSAicGNsayI7DQorCQkJ
> I3RoZXJtYWwtc2Vuc29yLWNlbGxzID0gPDA+Ow0KKwkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQor
> CQl9Ow0KKw0KIAkJY3J5cDE6IGNyeXBANTQwMDEwMDAgew0KIAkJCWNvbXBhdGlibGUgPSAic3Qs
> c3RtMzJtcDEtY3J5cCI7DQogCQkJcmVnID0gPDB4NTQwMDEwMDAgMHg0MDA+Ow0KLS0NCjIuNy40
> DQo=
> 

Reviewed-by: Rob Herring <robh@kernel.org>
