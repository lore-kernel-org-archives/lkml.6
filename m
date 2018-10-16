Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73850C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2935421471
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:38:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2935421471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeJQGba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 02:31:30 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:32955 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbeJQGba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 02:31:30 -0400
Received: by mail-ot1-f67.google.com with SMTP id q50so24271581otd.0;
        Tue, 16 Oct 2018 15:38:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X5SXXkJsSry05MfNme3Zlj/t9raAgEvWV40Uxg+bm28=;
        b=WplDb5F0e0TWRfOr8WCuzvjJx8Dqn7p8s8458sGaaVq+srz0P+NQBrVM//Dl0M1cO7
         DusL0nhoGZcF9DIjSXuAdMMgbGv6bjZvUaDyqG3LDzdB8iHPlw4+wZEaBPi+WgaWc9eJ
         QQOXSNaf0KFoNSJjIugMFqHszOwnQeh+yHBI1CYDicOAmUEQxZp6XTL72AmKj9VlLPr5
         j+hBIxhgzDy2UEDXyZ0DvBgOmfCMKOz4t1yJlOz6pQhhAV4V+jKyaa/s89VCbPHuV1Mr
         WVEKi9bz5GDP8pTBLpBqDqXWWPLZY9Kl2P9L7A0/BgDNQhAm7AZde1+h2AfeUMAmb5mL
         fyXQ==
X-Gm-Message-State: ABuFfoirw4ouX37WGgDOD+O/yXwUW13NOoQuTRF8we0t3XkBJRjBQolJ
        NT/MfJuPJCvMIaS8ZS1P9w==
X-Google-Smtp-Source: ACcGV63Vf79I6Pfv16A7u2c7MX8Kyue7BqqqSs9mq1znuXohNZmDmde19h3hB9Pd2IJU2Dm6S2dKlQ==
X-Received: by 2002:a9d:720e:: with SMTP id u14mr14305808otj.211.1539729536222;
        Tue, 16 Oct 2018 15:38:56 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u123-v6sm5308192oie.22.2018.10.16.15.38.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 15:38:55 -0700 (PDT)
Date:   Tue, 16 Oct 2018 17:38:54 -0500
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
Subject: Re: [PATCH 1/3] dt-bindings: stm32-thermal: add binding documentation
Message-ID: <20181016223854.GA23012@bogus>
References: <1538734081-26585-1-git-send-email-david.hernandezsanchez@st.com>
 <1538734081-26585-2-git-send-email-david.hernandezsanchez@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538734081-26585-2-git-send-email-david.hernandezsanchez@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Oct 2018 10:08:45 +0000, David HERNANDEZ SANCHEZ wrote:
> QWRkIHRoZXJtYWwgYmluZGluZyBkb2N1bWVudGF0aW9uIGZvciBTVE0zMiBEVFMgc2Vuc29yDQoN
> ClNpZ25lZC1vZmYtYnk6IERhdmlkIEhlcm5hbmRleiBTYW5jaGV6IDxkYXZpZC5oZXJuYW5kZXpz
> YW5jaGV6QHN0LmNvbT4NCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
> aW5kaW5ncy90aGVybWFsL3N0bTMyLXRoZXJtYWwudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
> cmVlL2JpbmRpbmdzL3RoZXJtYWwvc3RtMzItdGhlcm1hbC50eHQNCm5ldyBmaWxlIG1vZGUgMTAw
> NjQ0DQppbmRleCAwMDAwMDAwLi44YzBkNWE0DQotLS0gL2Rldi9udWxsDQorKysgYi9Eb2N1bWVu
> dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdGhlcm1hbC9zdG0zMi10aGVybWFsLnR4dA0KQEAg
> LTAsMCArMSw2MSBAQA0KK0JpbmRpbmcgZm9yIFRoZXJtYWwgU2Vuc29yIGZvciBTVE1pY3JvZWxl
> Y3Ryb25pY3MgU1RNMzIgc2VyaWVzIG9mIFNvQ3MuDQorDQorT24gU1RNMzIgU29DcywgdGhlIERp
> Z2l0YWwgVGVtcGVyYXR1cmUgU2Vuc29yIChEVFMpIGlzIGluIGNoYXJnZSBvZiBtYW5hZ2luZyBh
> bg0KK2FuYWxvZyBibG9jayB3aGljaCBkZWxpdmVycyBhIGZyZXF1ZW5jeSBkZXBlbmRpbmcgb24g
> dGhlIGludGVybmFsIFNvQydzDQordGVtcGVyYXR1cmUuIEJ5IHVzaW5nIGEgcmVmZXJlbmNlIGZy
> ZXF1ZW5jeSwgRFRTIGlzIGFibGUgdG8gcHJvdmlkZSBhIHNhbXBsZQ0KK251bWJlciB3aGljaCBj
> YW4gYmUgdHJhbnNsYXRlZCBpbnRvIGEgdGVtcGVyYXR1cmUgYnkgdGhlIHVzZXIuDQorDQorRFRT
> IHByb3ZpZGVzIGludGVycnVwdCBub3RpZmljYXRpb24gbWVjaGFuaXNtIGJ5IHRocmVzaG9sZC4g
> VGhpcyBtZWNoYW5pc20NCitvZmZlcnMgdHdvIHRlbXBlcmF0dXJlIHRyaXAgcG9pbnRzOiBwYXNz
> aXZlIGFuZCBjcml0aWNhbC4gVGhlIGZpcnN0IGlzIGludGVuZGVkDQorZm9yIHBhc3NpdmUgY29v
> bGluZyBub3RpZmljYXRpb24gd2hpbGUgdGhlIHNlY29uZCBpcyB1c2VkIGZvciBvdmVyLXRlbXBl
> cmF0dXJlDQorcmVzZXQuDQorDQorUmVxdWlyZWQgcGFyYW1ldGVyczoNCistLS0tLS0tLS0tLS0t
> LS0tLS0tDQorDQorY29tcGF0aWJsZTogCVNob3VsZCBiZSAic3Qsc3RtMzItdGhlcm1hbCINCity
> ZWc6IAkJVGhpcyBzaG91bGQgYmUgdGhlIHBoeXNpY2FsIGJhc2UgYWRkcmVzcyBhbmQgbGVuZ3Ro
> IG9mIHRoZQ0KKwkJc2Vuc29yJ3MgcmVnaXN0ZXJzLg0KK2Nsb2NrczogCVBoYW5kbGUgb2YgdGhl
> IGNsb2NrIHVzZWQgYnkgdGhlIHRoZXJtYWwgc2Vuc29yLg0KKwkJICBTZWU6IERvY3VtZW50YXRp
> b24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9jbG9jay1iaW5kaW5ncy50eHQNCitjbG9jay1u
> YW1lczogCVNob3VsZCBiZSAicGNsayIgZm9yIHJlZ2lzdGVyIGFjY2VzcyBjbG9jayBhbmQgcmVm
> ZXJlbmNlIGNsb2NrLg0KKwkJICBTZWU6IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
> cy9yZXNvdXJjZS1uYW1lcy50eHQNCisjdGhlcm1hbC1zZW5zb3ItY2VsbHM6IFNob3VsZCBiZSAw
> LiBTZWUgLi90aGVybWFsLnR4dCBmb3IgYSBkZXNjcmlwdGlvbi4NCitpbnRlcnJ1cHRzOglTdGFu
> ZGFyZCB3YXkgdG8gZGVmaW5lIGludGVycnVwdCBudW1iZXIuDQorDQorRXhhbXBsZToNCisNCisJ
> dGhlcm1hbC16b25lcyB7DQorCQljcHVfdGhlcm1hbDogY3B1LXRoZXJtYWwgew0KKwkJCXBvbGxp
> bmctZGVsYXktcGFzc2l2ZSA9IDwwPjsNCisJCQlwb2xsaW5nLWRlbGF5ID0gPDA+Ow0KKw0KKwkJ
> CXRoZXJtYWwtc2Vuc29ycyA9IDwmdGhlcm1hbD47DQorDQorCQkJdHJpcHMgew0KKwkJCQljcHVf
> YWxlcnQxOiBjcHUtYWxlcnQxIHsNCisJCQkJCXRlbXBlcmF0dXJlID0gPDg1MDAwPjsNCisJCQkJ
> CWh5c3RlcmVzaXMgPSA8MD47DQorCQkJCQl0eXBlID0gInBhc3NpdmUiOw0KKwkJCQl9Ow0KKw0K
> KwkJCQljcHUtY3JpdDogY3B1LWNyaXQgew0KKwkJCQkJdGVtcGVyYXR1cmUgPSA8MTIwMDAwPjsN
> CisJCQkJCWh5c3RlcmVzaXMgPSA8MD47DQorCQkJCQl0eXBlID0gImNyaXRpY2FsIjsNCisJCQkJ
> fTsNCisJCQl9Ow0KKw0KKwkJCWNvb2xpbmctbWFwcyB7DQorCQkJfTsNCisJCX07DQorCX07DQor
> DQorCXRoZXJtYWw6IHRoZXJtYWxANTAwMjgwMDAgew0KKwkJY29tcGF0aWJsZSA9ICJzdCxzdG0z
> Mi10aGVybWFsIjsNCisJCXJlZyA9IDwweDUwMDI4MDAwIDB4MTAwPjsNCisJCWNsb2NrcyA9IDwm
> cmNjIFRNUFNFTlM+Ow0KKwkJY2xvY2stbmFtZXMgPSAicGNsayI7DQorCQkjdGhlcm1hbC1zZW5z
> b3ItY2VsbHMgPSA8MD47DQorCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTQ3IElSUV9UWVBFX0xF
> VkVMX0hJR0g+Ow0KKwl9Ow0KLS0NCjIuNy40DQo=
> 

Reviewed-by: Rob Herring <robh@kernel.org>
