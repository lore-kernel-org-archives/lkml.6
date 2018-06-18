Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D793C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 04:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319E620836
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 04:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIpJ0T3b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 319E620836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751704AbeFREAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 00:00:44 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:46962 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbeFREAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 00:00:42 -0400
Received: by mail-ot0-f193.google.com with SMTP id v24-v6so8429855otk.13
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 21:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XrncbmxfYlp9PSdBmkEvXZfFiQoM7LAT+7nJ0SOKuE0=;
        b=jIpJ0T3b010++hqFE5kovY7gy/QnN33MjRt2V1cTWLy2noQGWER2RpfyJOdwfDiSvy
         5fJLcUkaPizdbfrr1NM/SXcW1JHcQ1re42GcrnabijoFEX0RhHPw/SMvFeUZRbkVAOXU
         8qyZxHCOLZJ5etKqmDz/QgHkdKL+xGOl0OhHwrpk3MQxtrnrTO9DeeUYQJMfbi9JPvcf
         I+JfGhW7lyRgPkgh996adfUNyo/+HG4VdeO3812U8B9KUgJLKwkAsYEAizHWy6tgOnvJ
         hk9Rmwvm+/68M9KYjmDYOD2swhgwRwBa3CBdawhGNhlC0qsYn4Uf92RVROfiGIvxxP01
         yBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XrncbmxfYlp9PSdBmkEvXZfFiQoM7LAT+7nJ0SOKuE0=;
        b=TcBHKpPweuSfifNOxbidI6GPyyx8eHOR9HmY7IYjbiUh3sRPEGxTygro1kdKoTiCPO
         cIy+gDif0BQFs2jrLHI2aW/zuDLmJ3+ththvR9Jginf4yIfjwXYUf3qJJcJGe5+9uZpw
         0+7WEkDHfpkmCJNUCpWqCzaFgTkb6yq6JRuIBidr4srQaxn6BHhjUu3fqVVs6rR2jcED
         W15P/8QQb5+uIqeXoCycpcgIfgXp5k8+hr9PF+5rBPyeeXNNLntezLXAOtc52VOk0aJ2
         Ex7FMv1Q4E5o/0DYOh0oUGho6P7VLoCO9pDwgHyQXPdVzTOsSMgISU63J9DsR1XytAcF
         RWOQ==
X-Gm-Message-State: APt69E2uQAnW/PruHNEoO6GJ5Wopx6rNfHyqvitQMv2r18CNd8UNcGjP
        7/UV/j5ofbnlxVUpk2XhWO9e9grOzwv1V8AAhYQ=
X-Google-Smtp-Source: ADUXVKKQvrbysRkJnO3kGuHK2ANJFdQWEtLUusx4Z8BDUY1GiJcoghVFiClm+B+jkXQNtMyyki39Srtry5nYjxrm+XU=
X-Received: by 2002:a9d:56e8:: with SMTP id b37-v6mr6365157otj.175.1529294442241;
 Sun, 17 Jun 2018 21:00:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Sun, 17 Jun 2018 21:00:41
 -0700 (PDT)
In-Reply-To: <20180226134741.neqkpge33zo3pfzt@earth.universe>
References: <20180212123945.15732-1-sebastian.reichel@collabora.co.uk>
 <20180212123945.15732-2-sebastian.reichel@collabora.co.uk>
 <20180224074543.GF3217@dragon> <20180226134741.neqkpge33zo3pfzt@earth.universe>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 18 Jun 2018 01:00:41 -0300
Message-ID: <CAOMZO5Czdpdo3Vt0TjGYGUFoz=ZMuy_6F3C=dq4gp4NEvXBZAQ@mail.gmail.com>
Subject: Re: [PATCHv4 1/2] ARM: imx53: add secure-reg-access support for PMU
To:     Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Martin Fuzzey <mfuzzey@parkeon.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ian Ray <ian.ray@ge.com>, Sascha Hauer <kernel@pengutronix.de>,
        Nandor Han <nandor.han@ge.com>,
        Fabio Estevam <fabio.estevam@nxp.com>, kernel@collabora.com,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

[Adding Martin on Cc who also tried to enable DBGEN bit in a previous patch]

On Mon, Feb 26, 2018 at 10:47 AM, Sebastian Reichel
<sebastian.reichel@collabora.co.uk> wrote:
> Hi Shawn,
>
> On Sat, Feb 24, 2018 at 03:45:44PM +0800, Shawn Guo wrote:
>> On Mon, Feb 12, 2018 at 01:39:44PM +0100, Sebastian Reichel wrote:
>> > On i.MX53 it is necessary to set the DBG_EN bit in the
>> > platform GPC register to enable access to PMU counters
>> > other than the cycle counter.
>> >
>> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
>> > ---
>> >  arch/arm/mach-imx/mach-imx53.c | 39 ++++++++++++++++++++++++++++++++++++++-
>> >  1 file changed, 38 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
>> > index 07c2e8dca494..658e28604dca 100644
>> > --- a/arch/arm/mach-imx/mach-imx53.c
>> > +++ b/arch/arm/mach-imx/mach-imx53.c
>> > @@ -28,10 +28,47 @@ static void __init imx53_init_early(void)
>> >     mxc_set_cpu_type(MXC_CPU_MX53);
>> >  }
>> >
>> > +#define MXC_CORTEXA8_PLAT_GPC 0x63fa0004
>>
>> The base address should be retrieved from device tree.
>
> DT has no entry for 0x63fa0000-0x63fa3fff. iMX53 TRM lists it as "ARM Platform"
> with 8 platform specific 32 bit registers. Do you think it's worth the trouble
> adding a new binding? Do you have a suggestion for a compatible value?

I also think we should add a compatible string for the "ARM platform" region.

This way both mx51 and mx53 could retrieve the base address from the
device tree.

What about:

--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -672,6 +672,11 @@
                                status = "disabled";
                        };

+                       arm_plat: arm-plat@63fa0000 {
+                               compatible = "fsl,imx53-arm-plat",
"fsl,imx51-arm-plat";
+                               reg = <0x63fa0000 0x4000>;
+                       };
+
                        owire: owire@63fa4000 {
                                compatible = "fsl,imx53-owire",
"fsl,imx21-owire";
                                reg = <0x63fa4000 0x4000>;
