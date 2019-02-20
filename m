Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDF6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB29F208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfBTI7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:59:04 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35442 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfBTI7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 03:59:03 -0500
Received: by mail-ed1-f65.google.com with SMTP id g19so10211347edp.2;
        Wed, 20 Feb 2019 00:59:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rAdoxIJZWnnE6eiIWpkNn6CLgQlgSDug3I3b8dKQXHU=;
        b=YKqIoOu+aaAfUruJWezJKvNU2TindIrXkyMKTUkhi+qchTrm9oGo1mQtp+dE9PKz64
         KJvH5lb40hX4eT9KxfABSSHm4bsjVjdfdL0QA1aPsV3xoKIwumvgoRGZ0wTmSkQJ3kpL
         qsm6DCM0bf2KL81N19MapCn+ddSiPAgaw3jMZVpbuDBjk5sOhKXhdehLpuN3nASo6iWp
         RGMih07b1OYcr4kDlMh4zyEESDMWkHKxbTq8+s/UDeTaChhTOfUguv183zNRxN+qWlVX
         m2LaM9IXNzUX7p1m2sjjpP6FTSPjlxKq+ki0fUClQSVcuVJOTHqJGJYZ8IshOSKoG6AC
         DjOA==
X-Gm-Message-State: AHQUAuaBK+eupniC8eB4HhZOMbVz72l0ZyzlunUF/e9QLkwmb671cGJs
        ri4YykUoxD8hjAPOLtMH6LxONCdSO9w=
X-Google-Smtp-Source: AHgI3IbsPHN9nziP4JaG2pyjwddyJNMO9sAQMtielzc288iuZrWFz5Fguy8RB70T+mqHGRupT9CJOQ==
X-Received: by 2002:a50:ad4b:: with SMTP id z11mr26228348edc.157.1550653141490;
        Wed, 20 Feb 2019 00:59:01 -0800 (PST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id f6sm864749eja.33.2019.02.20.00.59.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 00:59:00 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id l5so23933192wrw.6;
        Wed, 20 Feb 2019 00:59:00 -0800 (PST)
X-Received: by 2002:a5d:66c1:: with SMTP id k1mr9498091wrw.120.1550653140186;
 Wed, 20 Feb 2019 00:59:00 -0800 (PST)
MIME-Version: 1.0
References: <20190216182132.12895-1-mans@mansr.com>
In-Reply-To: <20190216182132.12895-1-mans@mansr.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 20 Feb 2019 16:58:49 +0800
X-Gmail-Original-Message-ID: <CAGb2v66C6HFKgF8kERfp2UQ5XUyNS0-prgC3sX2iobkz7SjBcw@mail.gmail.com>
Message-ID: <CAGb2v66C6HFKgF8kERfp2UQ5XUyNS0-prgC3sX2iobkz7SjBcw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: sun7i: add pinctrl for missing uart mux options
To:     Mans Rullgard <mans@mansr.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 17, 2019 at 2:21 AM Mans Rullgard <mans@mansr.com> wrote:
>
> This adds pinctrl settings for various missing uart options.
>
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
>  arch/arm/boot/dts/sun7i-a20.dtsi | 45 ++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index af5b067a5f83..2295ff5adf48 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -944,6 +944,31 @@
>                                 function = "uart0";
>                         };
>
> +                       uart0_pf_pins: uart0-pf-pins {
> +                               pins = "PF2", "PF4";
> +                               function = "uart0";
> +                       };

We've had the policy of not adding pinctrl nodes that aren't used in-tree,
to avoid bloating up the blob size. However DTC 1.4.7 introduced the new
/omit-if-no-ref/ directive, which would make the compiler discard marked
nodes if they aren't referenced.

So please add this to all the new nodes. It seems to work regardless whether
you add it before or after the label, though having it after the label seems
to make vim syntax highlighting happier.

Regards
ChenYu
