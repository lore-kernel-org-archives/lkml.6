Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF386ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E6F205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+R/SYA4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1E6F205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeJQWSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:18:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbeJQWSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:18:25 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4EE3205F4;
        Wed, 17 Oct 2018 14:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539786149;
        bh=c2t9attt+FBs4wgQjfbUfmk/qR/0vzxMcb3wtCqp/AM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H+R/SYA4PxDSRj0G+3dKQ522TOzUKYVQRqUXeiI5laK6zEJOepe0Rb2J+g8xEzjlb
         vKgye75a6NFd6DIIjUWcOJe10jELQqLHmjJuA+M52+g4TQZ4LltoyRFCBSA/YwdGV9
         0Z3M/dF4OCj4Vhybk+dQ6zaSzoHVpNYbNkofP5AI=
Received: by mail-qk1-f172.google.com with SMTP id q5-v6so16560846qki.6;
        Wed, 17 Oct 2018 07:22:28 -0700 (PDT)
X-Gm-Message-State: ABuFfoi4rakX4ZJbB2m1yJ2ULtRMSAfOTsGqRZFcnWQCY3HxTt0xEr2m
        JaRBoSF4JehtXnNs3i4h66bV3+9MrmBM91P8MA==
X-Google-Smtp-Source: ACcGV60iid+6OwnbnQTFN9P+D2MuV/hPaWMJngsd7r5RkHl5VrRyMCCAZYqh59/UzFeXI8ruxrsgyGoHLg2NtXVJfv8=
X-Received: by 2002:a37:3ac1:: with SMTP id h184-v6mr1523326qka.147.1539786148134;
 Wed, 17 Oct 2018 07:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <1538734081-26585-1-git-send-email-david.hernandezsanchez@st.com>
 <1538734081-26585-4-git-send-email-david.hernandezsanchez@st.com> <20181016224009.GA24851@bogus>
In-Reply-To: <20181016224009.GA24851@bogus>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 17 Oct 2018 09:22:16 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKavGoXKdEzq+n0+qfd6VF+gjHiGQbvzKLuHcmEvVa-qA@mail.gmail.com>
Message-ID: <CAL_JsqKavGoXKdEzq+n0+qfd6VF+gjHiGQbvzKLuHcmEvVa-qA@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: stm32: add thermal sensor support on STM32MP157c
To:     David HERNANDEZ SANCHEZ <david.hernandezsanchez@st.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 5:40 PM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, 5 Oct 2018 10:08:46 +0000, David HERNANDEZ SANCHEZ wrote:
> > QWRkIGNvbmZpZ3VyYXRpb24gb24gRFQgZm9yIHRoZXJtYWwgc2Vuc29yIGRyaXZlcg0KDQpTaWdu
> > ZWQtb2ZmLWJ5OiBEYXZpZCBIZXJuYW5kZXogU2FuY2hleiA8ZGF2aWQuaGVybmFuZGV6c2FuY2hl
> > ekBzdC5jb20+DQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9zdG0zMm1wMTU3Yy5k
> > dHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvc3RtMzJtcDE1N2MuZHRzaQ0KaW5kZXggNjYxYmU5NC4u
> > ZTkwYjlmNiAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL3N0bTMybXAxNTdjLmR0c2kN
> > CisrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3N0bTMybXAxNTdjLmR0c2kNCkBAIC04NCw2ICs4NCwz
> > MSBAQA0KIAkJfTsNCiAJfTsNCg0KKwl0aGVybWFsLXpvbmVzIHsNCisJCWNwdV90aGVybWFsOiBj
> > cHUtdGhlcm1hbCB7DQorCQkJcG9sbGluZy1kZWxheS1wYXNzaXZlID0gPDA+Ow0KKwkJCXBvbGxp
> > bmctZGVsYXkgPSA8MD47DQorCQkJdGhlcm1hbC1zZW5zb3JzID0gPCZkdHM+Ow0KKw0KKwkJCXRy
> > aXBzIHsNCisJCQkJY3B1X2FsZXJ0MTogY3B1LWFsZXJ0MSB7DQorCQkJCQl0ZW1wZXJhdHVyZSA9
> > IDw4NTAwMD47DQorCQkJCQloeXN0ZXJlc2lzID0gPDA+Ow0KKwkJCQkJdHlwZSA9ICJwYXNzaXZl
> > IjsNCisJCQkJfTsNCisNCisJCQkJY3B1LWNyaXQgew0KKwkJCQkJdGVtcGVyYXR1cmUgPSA8MTIw
> > MDAwPjsNCisJCQkJCWh5c3RlcmVzaXMgPSA8MD47DQorCQkJCQl0eXBlID0gImNyaXRpY2FsIjsN
> > CisJCQkJfTsNCisJCQl9Ow0KKw0KKwkJCWNvb2xpbmctbWFwcyB7DQorCQkJfTsNCisJCX07DQor
> > CX07DQorDQogCXNvYyB7DQogCQljb21wYXRpYmxlID0gInNpbXBsZS1idXMiOw0KIAkJI2FkZHJl
> > c3MtY2VsbHMgPSA8MT47DQpAQCAtOTA4LDYgKzkzMywxNiBAQA0KIAkJCXN0YXR1cyA9ICJkaXNh
> > YmxlZCI7DQogCQl9Ow0KDQorCQlkdHM6IHRoZXJtYWxANTAwMjgwMDAgew0KKwkJCWNvbXBhdGli
> > bGUgPSAic3Qsc3RtMzItdGhlcm1hbCI7DQorCQkJcmVnID0gPDB4NTAwMjgwMDAgMHgxMDA+Ow0K
> > KwkJCWludGVycnVwdHMgPSA8R0lDX1NQSSAxNDcgSVJRX1RZUEVfTEVWRUxfSElHSD47DQorCQkJ
> > Y2xvY2tzID0gPCZyY2MgVE1QU0VOUz47DQorCQkJY2xvY2stbmFtZXMgPSAicGNsayI7DQorCQkJ
> > I3RoZXJtYWwtc2Vuc29yLWNlbGxzID0gPDA+Ow0KKwkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQor
> > CQl9Ow0KKw0KIAkJY3J5cDE6IGNyeXBANTQwMDEwMDAgew0KIAkJCWNvbXBhdGlibGUgPSAic3Qs
> > c3RtMzJtcDEtY3J5cCI7DQogCQkJcmVnID0gPDB4NTQwMDEwMDAgMHg0MDA+Ow0KLS0NCjIuNy40
> > DQo=
> >
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Rest assured that I did review the decoded base64. Please fix your
mailer to not send base64 encoded mails.

Rob
