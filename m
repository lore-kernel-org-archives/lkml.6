Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2E6C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D6420851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544549023;
	bh=mYeG+0DpwcM7IBim3r822MA2q74OrgiVJHAlwvjdZjM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=l1Py25Wrt8wtQXEhbkMhPY4c3iN/wh9s8bZ54Wwd5LVAekAv/aV07te3h2X8AAfW4
	 UGVUFYfuZ2+spk4OZdwGvf+qDfLDtuRrKy0Uk4uL5pHe/5otbw+68/p1tqDhUCSU30
	 yEejE7ap702dCWRejionWVGYiaBkbOYee64y6cuc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1D6420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbeLKRXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:23:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:58100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbeLKRXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:23:42 -0500
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABDB121104
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 17:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544549021;
        bh=mYeG+0DpwcM7IBim3r822MA2q74OrgiVJHAlwvjdZjM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=swUDEfPU3fkVcmYbuEg2CbQ08NJUAd9SoQkJtf5FhSOd2fNOq4rEPgrYWPI5rD/a9
         jge4a2WQj0jc1giqzo046EblMOrvlW1LXrRLGLgH1lQ3QqlI6P3lesFYzDH5AsM9Rw
         Ez21ek7RiMiltDdddnUNv+yS95a5qAaUv33ge7mc=
Received: by mail-wr1-f44.google.com with SMTP id r10so14929485wrs.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 09:23:41 -0800 (PST)
X-Gm-Message-State: AA+aEWa9YfNuBKv29k98p8C5FXDq4jqDQP5rAS/EdFmfsepQ5frsKdOA
        IngoWHqDB+XWDUKb6cFFWplTQckGT8z3Bv9bveBU0Q==
X-Google-Smtp-Source: AFSGD/WoKVCtl/gOlZLjb5rIZAq2ekdP+feai0u1gm3NnTIogLnL3knd7gtwDNqG1zgs0JdDOzsG5i+QD5v6WpC9X1k=
X-Received: by 2002:adf:f1c2:: with SMTP id z2mr15034785wro.218.1544549020063;
 Tue, 11 Dec 2018 09:23:40 -0800 (PST)
MIME-Version: 1.0
References: <1544434201-14190-1-git-send-email-krzk@kernel.org> <1544434201-14190-5-git-send-email-krzk@kernel.org>
In-Reply-To: <1544434201-14190-5-git-send-email-krzk@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 11 Dec 2018 11:23:29 -0600
X-Gmail-Original-Message-ID: <CABGGiszi3cgkQy0+h4q6nEY0V1Td2x3eR_kZ50cu3awrSGscMQ@mail.gmail.com>
Message-ID: <CABGGiszi3cgkQy0+h4q6nEY0V1Td2x3eR_kZ50cu3awrSGscMQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] dt-bindings: leds: Add pattern initialization from
 Device Tree
To:     krzk@kernel.org
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 3:30 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Document new linux,trigger-pattern property for initialization of LED
> pattern trigger.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/leds/common.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Documentation/devicetree/bindings/leds/common.txt
> index aa1399814a2a..4c65e854bb91 100644
> --- a/Documentation/devicetree/bindings/leds/common.txt
> +++ b/Documentation/devicetree/bindings/leds/common.txt
> @@ -37,6 +37,13 @@ Optional properties for child nodes:
>       "ide-disk" - LED indicates IDE disk activity (deprecated),
>                    in new implementations use "disk-activity"
>       "timer" - LED flashes at a fixed, configurable rate
> +     "pattern" - LED alters the brightness for the specified duration with one
> +                 software timer (see
> +                 Documentation/ABI/testing/sysfs-class-led-trigger-pattern)
> +
> +- linux,trigger-pattern : Default pattern for "pattern" trigger (see
> +                          Documentation/ABI/testing/sysfs-class-led-trigger-pattern
> +                          for description of format)

Binding documents should generally not refer to kernel docs and need
to stand on their own.

I don't think this needs to be linux specific. I'd just call it
'led-pattern'. I don't think this should be tied to the trigger types.
Isn't possible you would want to tie a pattern to different triggers.
IOW, when event X happens, run the pattern. And you could have
one-shot versus continuous.

Rob
