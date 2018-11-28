Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FB0C04EBA
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 02:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC2320989
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 02:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/CUct/L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC2320989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbeK1NBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 08:01:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:33596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbeK1NBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 08:01:07 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7A1F2081B;
        Wed, 28 Nov 2018 02:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543370475;
        bh=A271NRnsXJaThRSM5S+cUrYGSh0bKN7K/2LQL/sM8rI=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=R/CUct/L6tLSburCfFq59NLVUDl9AhAUVjsCpFRG5Z8hSYRqLQobY85lZlVfsT2r3
         h1g1x4es1kCA0b25H6Y09JEHbdQrTWtgAf/oKQdYaQ4Ju/C0YwAQfe/pJCom9yekc8
         8VOOtdk+e8uvX0VBYksx4TAWxGPSRSZjJD8ADSbg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Sugaya Taichi <sugaya.taichi@socionext.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1542589274-13878-3-git-send-email-sugaya.taichi@socionext.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Sugaya Taichi <sugaya.taichi@socionext.com>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-3-git-send-email-sugaya.taichi@socionext.com>
Message-ID: <154337047410.88331.9696178601340675631@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 02/14] dt-bindings: soc: milbeaut: Add Milbeaut trampoline
 description
Date:   Tue, 27 Nov 2018 18:01:14 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sugaya Taichi (2018-11-18 17:01:07)
> Add DT bindings document for Milbeaut trampoline.
> =

> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> ---
>  .../devicetree/bindings/soc/socionext/socionext,m10v.txt     | 12 ++++++=
++++++
>  1 file changed, 12 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/socionext/socio=
next,m10v.txt
> =

> diff --git a/Documentation/devicetree/bindings/soc/socionext/socionext,m1=
0v.txt b/Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt
> new file mode 100644
> index 0000000..f5d906c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt
> @@ -0,0 +1,12 @@
> +Socionext M10V SMP trampoline driver binding
> +
> +This is a driver to wait for sub-cores while boot process.
> +
> +- compatible: should be "socionext,smp-trampoline"
> +- reg: should be <0x4C000100 0x100>
> +
> +EXAMPLE
> +       trampoline: trampoline@0x4C000100 {

Drop the 0x part of unit addresses.

> +               compatible =3D "socionext,smp-trampoline";
> +               reg =3D <0x4C000100 0x100>;

Looks like a software construct, which we wouldn't want to put into DT
this way. DT doesn't describe drivers.

