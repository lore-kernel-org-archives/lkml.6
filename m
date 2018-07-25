Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4768C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A7820833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="HvhVMqFL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LeHe5Mfp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72A7820833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731787AbeGZAjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 20:39:08 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:44850 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731401AbeGZAjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 20:39:07 -0400
Received: by mail-ua0-f195.google.com with SMTP id k25-v6so6196789uao.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 16:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=fEnrshrcyRFKFn5tq0Gixa/dOugjjsLUO399Bf7wjsw=;
        b=HvhVMqFLe48NH5J+vHIHwqADHSjhDqxOvpwcsTI1UmsPqrPzENKBz/e7AhF3znw8hO
         qbBBrkM4EZYXaDXGa7d7z5K0Z/0uzuIgnFFLwQCbnkETxDv0qEcQGgaH26r1PoVwC+AC
         t5LwKqTwtzO6capazoX9hTPGjCeT9Vv7lef3c2jxT4DWDBiZjgUZrgErUwg82ck2ax70
         PF73N/HwSS9jxYzZ/YSYSQn9V/1d8eAj0Qy9P26+eTq/jrAh/bfVy98WQC8YNUQHlNDk
         DrBXYX2btqtADxCOytNB4FARB0W9cZiqYPG2CHohz5GZSL3VaoLaMEvX8Q2NDMNL41DX
         NkIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=fEnrshrcyRFKFn5tq0Gixa/dOugjjsLUO399Bf7wjsw=;
        b=LeHe5MfpguzT+FXGakLTrCqq77YYJNUJeAuVppOjM4gUza3NhQTm63SQntCCj+RwKE
         2vq7VJVxJc4tsSPYk/aU6D8N/6I7sdyojKavveMFhD6lSkBxdZfwz+yXTCe7cUHpCeY3
         9E86qm3ItpLY5bmLSPuj8PWZYgmH5GQIFVxwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=fEnrshrcyRFKFn5tq0Gixa/dOugjjsLUO399Bf7wjsw=;
        b=VRx7IacyTgfyRGmxVMJ0baE4CqyMNaDeI1/GkudrdNkvCo2pXsJjsejPvpDDFw64d4
         oN0t3lV0OxDzckHgVuuf8tz/B649yUKAjuUgHTYouzOhWvy3fJXQ43KLA6G1JKsYQO0q
         pj8PmiTnkDaD0AmlXY5wEpX0rH2XIsNdVFqHqicOM7tA74spgGAoaejXXoFbrzmNfU41
         bWAdm04NzZS43MH4WEVHLW1D2i/tR+4vF34nYqR7Tm0YZy1ziwV0wfuaFa0ofrggu2kD
         E/MPTLvnRlMGrFcwbIrJVfJNOw0ggDsrP/Ha/dX4fbZMmymY0kfNC8JcD/fS+1P+Vtfs
         JICg==
X-Gm-Message-State: AOUpUlHnAcpkK7VfMIL3kde8zrOt6fiQtsrDZz2Qp4zW7n3sCkt5m5D4
        UsbP/rL8ghae/HHgwXoYYt4T+zc9FAcLJ2+o44xfRw==
X-Google-Smtp-Source: AAOMgpd6Hij2GNxxYHrwRReWlYsEegdmo8WWt1x8E9DQ5+MYSbwOYe0oKuECcub+ITRG6qCfYMoWK7IWLC549+gPWv8=
X-Received: by 2002:a9f:3b69:: with SMTP id j41-v6mr15349738uah.37.1532561110492;
 Wed, 25 Jul 2018 16:25:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 16:25:09 -0700 (PDT)
In-Reply-To: <20180724235035.58146-1-mka@chromium.org>
References: <20180724235035.58146-1-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 25 Jul 2018 16:25:09 -0700
X-Google-Sender-Auth: DZs6jxv_hj1BiR-m7GlrXNTGyXo
Message-ID: <CAD=FV=W9cpLt2EQwyTDyZyFiueV2yrLO_SLXOFcS09P_wGYnLw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: thermal: qcom-spmi-temp-alarm: Improve
 thermal zone in example
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 24, 2018 at 4:50 PM, Matthias Kaehlcke <mka@chromium.org> wrote=
:
> The current example for a thermal zone isn't very useful as reference
> since it would result in a hardware shutdown at 145=C2=B0C, instead of
> allowing the system to try to shutdown gracefully. Without an ADC
> channel a maximum of two trip points is useful in practice for this
> sensor, with temperatures corresponding to the stage 1 and stage 2
> 'hardware trip points'. A critical trip point at stage 2 may allow the
> system to shutdown before a hardware shutdown at stage 3 kicks in. It
> should be noted though that by default the chip performs a 'partial
> shutdown' when the temperature reaches stage 2, which may prevent an
> orderly shutdown. The 'partial shutdown' can be disabled by software.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  .../bindings/thermal/qcom-spmi-temp-alarm.txt         | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

Assuming your patch to disable the partial shutdown lands, then:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

...if that patch doesn't land (or if someone disagrees with me and
thinks we need an extra property to disable the partial shutdown) then
we would need the example to be different.  Because of that, maybe
this should be appended to the end of your series which includes the
patch to disable partial shutdown?

-Doug
