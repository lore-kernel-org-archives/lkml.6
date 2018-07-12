Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67565E9B57E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72AF213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DzOHvjzm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E72AF213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbeGLRqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:46:36 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:36295 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbeGLRqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:46:35 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 4C0AA24E0698;
        Thu, 12 Jul 2018 10:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1531416962; bh=+o2QfWf/VonA6qmr25Mn2aqmG07bzwfHJycQMzL0uwc=;
        h=From:To:CC:Subject:Date:References:From;
        b=DzOHvjzmTBt1NvcAWxhF+q4ti0IgMAkR7FtP4a8/Jq4FFXbnIPuhuKLJtKi4MYP9/
         DpuuJcnPalowlGYhGeSth0S0x7QvNw/+R1HlmqPmOvlvByaF1z95J+91zhWLiPTk4x
         1xfJ0y1dlle2LWaYPeGiG/Ezm58mxeX+OBHcvm/Vw8n0DCJj3ZvVdKYE5MbS9W23Es
         +qrxReZi9rLk5/o7D4lQBHYygOGSO/iJ4YeALFluREOSGuHel/yq/C59NsklALCOrI
         R3P8k50vf3kymIJcsLA+yM9lCUAsWrTyNJPxSC0JMDKCTLT8jdY1Z0cU+oVLtCwrxl
         Tcrv5ZADaiQBQ==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 419EE3409;
        Thu, 12 Jul 2018 10:36:02 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.147]) by
 us01wehtc1.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Thu, 12
 Jul 2018 10:36:01 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARC: [plat-axs10x] Get rid of auto-selected
 CONFIG_AX10x options
Thread-Topic: [PATCH] ARC: [plat-axs10x] Get rid of auto-selected
 CONFIG_AX10x options
Thread-Index: AQHUGTqDPIuwyMPWM0eH714KEaIslg==
Date:   Thu, 12 Jul 2018 17:36:01 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA230750110F6680C@us01wembx1.internal.synopsys.com>
References: <20180711171333.1745-1-abrodkin@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.104]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2018 10:13 AM, Alexey Brodkin wrote:=0A=
> Commit 4fbaf649ebbc ("ARC: [plat-axs10x] auto-select AXS101 or AXS103 giv=
en the  ISA config")=0A=
> made selection of CONFIG_AXS10x option automatic so there's no point=0A=
> in keeping them in defconfigs.=0A=
>=0A=
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>=0A=
=0A=
Can you regenerate the defconfigs - there seem to be more changes now than =
just those.=0A=
=0A=
Also for the other patch for FUSE, is this something we will need day in da=
y out -=0A=
I'm afraid we will start bloating stuff .=0A=
=0A=
If you insist I can add it - but i's still prefer you build them using modu=
les and=0A=
start testing that infra as well.=0A=
=0A=
-Vineet=0A=
=0A=
> ---=0A=
>  arch/arc/configs/axs101_defconfig     | 1 -=0A=
>  arch/arc/configs/axs103_defconfig     | 1 -=0A=
>  arch/arc/configs/axs103_smp_defconfig | 1 -=0A=
>  3 files changed, 3 deletions(-)=0A=
>=0A=
> diff --git a/arch/arc/configs/axs101_defconfig b/arch/arc/configs/axs101_=
defconfig=0A=
> index 13500399ea86..55686cc4bb19 100644=0A=
> --- a/arch/arc/configs/axs101_defconfig=0A=
> +++ b/arch/arc/configs/axs101_defconfig=0A=
> @@ -23,7 +23,6 @@ CONFIG_MODULE_UNLOAD=3Dy=0A=
>  CONFIG_MODULE_FORCE_UNLOAD=3Dy=0A=
>  CONFIG_PARTITION_ADVANCED=3Dy=0A=
>  CONFIG_ARC_PLAT_AXS10X=3Dy=0A=
> -CONFIG_AXS101=3Dy=0A=
>  CONFIG_ARC_CACHE_LINE_SHIFT=3D5=0A=
>  CONFIG_ARC_BUILTIN_DTB_NAME=3D"axs101"=0A=
>  CONFIG_PREEMPT=3Dy=0A=
> diff --git a/arch/arc/configs/axs103_defconfig b/arch/arc/configs/axs103_=
defconfig=0A=
> index a0576308cccd..20fb8e4e7337 100644=0A=
> --- a/arch/arc/configs/axs103_defconfig=0A=
> +++ b/arch/arc/configs/axs103_defconfig=0A=
> @@ -23,7 +23,6 @@ CONFIG_MODULE_UNLOAD=3Dy=0A=
>  CONFIG_MODULE_FORCE_UNLOAD=3Dy=0A=
>  CONFIG_PARTITION_ADVANCED=3Dy=0A=
>  CONFIG_ARC_PLAT_AXS10X=3Dy=0A=
> -CONFIG_AXS103=3Dy=0A=
>  CONFIG_ISA_ARCV2=3Dy=0A=
>  CONFIG_ARC_BUILTIN_DTB_NAME=3D"axs103"=0A=
>  CONFIG_PREEMPT=3Dy=0A=
> diff --git a/arch/arc/configs/axs103_smp_defconfig b/arch/arc/configs/axs=
103_smp_defconfig=0A=
> index 9bd590c22620..51d1e866ce94 100644=0A=
> --- a/arch/arc/configs/axs103_smp_defconfig=0A=
> +++ b/arch/arc/configs/axs103_smp_defconfig=0A=
> @@ -23,7 +23,6 @@ CONFIG_MODULE_UNLOAD=3Dy=0A=
>  CONFIG_MODULE_FORCE_UNLOAD=3Dy=0A=
>  CONFIG_PARTITION_ADVANCED=3Dy=0A=
>  CONFIG_ARC_PLAT_AXS10X=3Dy=0A=
> -CONFIG_AXS103=3Dy=0A=
>  CONFIG_ISA_ARCV2=3Dy=0A=
>  CONFIG_SMP=3Dy=0A=
>  CONFIG_ARC_BUILTIN_DTB_NAME=3D"axs103_idu"=0A=
=0A=
