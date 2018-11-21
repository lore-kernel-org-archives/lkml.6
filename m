Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FEDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE6821527
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="avoIkrYF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE6821527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732435AbeKVEPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:15:38 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:60662 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbeKVEPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 23:15:38 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 1D36510C061C;
        Wed, 21 Nov 2018 09:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542822019; bh=Mit0QLFovEEak/exI0yYij+ll3zPXuoP3GXRPrk++1A=;
        h=From:To:CC:Subject:Date:References:From;
        b=avoIkrYFkdaV1oKHQWbsK4qzHDN31L1Lj+KoT0ebvheCRKFjJVyXG1RmtR/9XY34l
         behlfYOzu9umsnpo5HCIYMPJiIlermZZ2ssM5TApXaqrz/jhzmEs+CMY+3oR9IqmKx
         TD7GQmtFPNLZMqQxAwI2wYRF9ynRplP9YNV7qLJE/jl6UbLRp2AItVAF1KvuQzrnON
         JxxHjfHq7rgPtsJUDh8/0UHmge7y6AkG+RxlZV4byI8GVAxmYOCTkB03NfKuXjpV1C
         p6izp+rymijsx7bHQI97c3VWSLbPngFmhUKlRNwIQTSGafyhgIGntqA/mmI9Ad0Nys
         gzs7MnEUc4Djg==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        by mailhost.synopsys.com (Postfix) with ESMTP id 0B59C3151;
        Wed, 21 Nov 2018 09:40:19 -0800 (PST)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0415.000; Wed, 21 Nov 2018 09:40:18 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Alexey Brodkin <alexey.brodkin@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Cupertino Miranda" <cupertino.miranda@synopsys.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] arc: [devboards] Add support of NFSv3 ACL
Thread-Topic: [PATCH] arc: [devboards] Add support of NFSv3 ACL
Thread-Index: AQHUgLwOF1eu85U5oUezfol+m7ZGcA==
Date:   Wed, 21 Nov 2018 17:40:17 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307501464156CB@US01WEMBX2.internal.synopsys.com>
References: <20181120103019.12852-1-abrodkin@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.106]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/18 2:30 AM, Alexey Brodkin wrote:=0A=
> By default NFSv3 doesn't support ACL (Access Control Lists)=0A=
> which might be quite convenient to have so that=0A=
> mounted NFS behaves exactly as any other local file-system.=0A=
>=0A=
> In particular missing support of ACL makes umask useless.=0A=
> This among other thigs fixes Glibc's "nptl/tst-umask1".=0A=
>=0A=
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>=0A=
> Cc: Cupertino Miranda <cmiranda@synopsys.com>=0A=
> Cc: stable@vger.kernel.org=0A=
=0A=
What is this fixing in the kernel, for this to be stable backported  ?=0A=
=0A=
> ---=0A=
>  arch/arc/configs/axs101_defconfig          | 1 +=0A=
>  arch/arc/configs/axs103_defconfig          | 1 +=0A=
>  arch/arc/configs/axs103_smp_defconfig      | 1 +=0A=
>  arch/arc/configs/hsdk_defconfig            | 1 +=0A=
>  arch/arc/configs/nps_defconfig             | 1 +=0A=
>  arch/arc/configs/nsimosci_defconfig        | 1 +=0A=
>  arch/arc/configs/nsimosci_hs_defconfig     | 1 +=0A=
>  arch/arc/configs/nsimosci_hs_smp_defconfig | 1 +=0A=
>  arch/arc/configs/vdk_hs38_defconfig        | 1 +=0A=
>  arch/arc/configs/vdk_hs38_smp_defconfig    | 1 +=0A=
=0A=
I understand a sweeping change is easy, more consistent so a good guiding=
=0A=
principel in general. But really all these defconfigs need NFS ? We keep on=
=0A=
increasing the bloat with this. IMHO we should update only relevant defconf=
igs.=0A=
=0A=
>  10 files changed, 10 insertions(+)=0A=
>=0A=
> diff --git a/arch/arc/configs/axs101_defconfig b/arch/arc/configs/axs101_=
defconfig=0A=
> index 41bc08be6a3b..8c23bd086cd0 100644=0A=
> --- a/arch/arc/configs/axs101_defconfig=0A=
> +++ b/arch/arc/configs/axs101_defconfig=0A=
> @@ -95,6 +95,7 @@ CONFIG_VFAT_FS=3Dy=0A=
>  CONFIG_NTFS_FS=3Dy=0A=
>  CONFIG_TMPFS=3Dy=0A=
>  CONFIG_NFS_FS=3Dy=0A=
> +CONFIG_NFS_V3_ACL=3Dy=0A=
>  CONFIG_NLS_CODEPAGE_437=3Dy=0A=
>  CONFIG_NLS_ISO8859_1=3Dy=0A=
>  # CONFIG_ENABLE_WARN_DEPRECATED is not set=0A=
> diff --git a/arch/arc/configs/axs103_defconfig b/arch/arc/configs/axs103_=
defconfig=0A=
> index 1e1c4a8011b5..666314fffc60 100644=0A=
> --- a/arch/arc/configs/axs103_defconfig=0A=
> +++ b/arch/arc/configs/axs103_defconfig=0A=
> @@ -94,6 +94,7 @@ CONFIG_VFAT_FS=3Dy=0A=
>  CONFIG_NTFS_FS=3Dy=0A=
>  CONFIG_TMPFS=3Dy=0A=
>  CONFIG_NFS_FS=3Dy=0A=
> +CONFIG_NFS_V3_ACL=3Dy=0A=
>  CONFIG_NLS_CODEPAGE_437=3Dy=0A=
>  CONFIG_NLS_ISO8859_1=3Dy=0A=
>  # CONFIG_ENABLE_WARN_DEPRECATED is not set=0A=
> diff --git a/arch/arc/configs/axs103_smp_defconfig b/arch/arc/configs/axs=
103_smp_defconfig=0A=
> index 6b0c0cfd5c30..429832b8560b 100644=0A=
> --- a/arch/arc/configs/axs103_smp_defconfig=0A=
> +++ b/arch/arc/configs/axs103_smp_defconfig=0A=
> @@ -97,6 +97,7 @@ CONFIG_VFAT_FS=3Dy=0A=
>  CONFIG_NTFS_FS=3Dy=0A=
>  CONFIG_TMPFS=3Dy=0A=
>  CONFIG_NFS_FS=3Dy=0A=
> +CONFIG_NFS_V3_ACL=3Dy=0A=
>  CONFIG_NLS_CODEPAGE_437=3Dy=0A=
>  CONFIG_NLS_ISO8859_1=3Dy=0A=
>  # CONFIG_ENABLE_WARN_DEPRECATED is not set=0A=
> diff --git a/arch/arc/configs/hsdk_defconfig b/arch/arc/configs/hsdk_defc=
onfig=0A=
> index 1dec2b4bc5e6..2a1d2cbfee1a 100644=0A=
> --- a/arch/arc/configs/hsdk_defconfig=0A=
> +++ b/arch/arc/configs/hsdk_defconfig=0A=
> @@ -65,6 +65,7 @@ CONFIG_EXT3_FS=3Dy=0A=
>  CONFIG_VFAT_FS=3Dy=0A=
>  CONFIG_TMPFS=3Dy=0A=
>  CONFIG_NFS_FS=3Dy=0A=
> +CONFIG_NFS_V3_ACL=3Dy=0A=
>  CONFIG_NLS_CODEPAGE_437=3Dy=0A=
>  CONFIG_NLS_ISO8859_1=3Dy=0A=
>  # CONFIG_ENABLE_WARN_DEPRECATED is not set=0A=
> diff --git a/arch/arc/configs/nps_defconfig b/arch/arc/configs/nps_defcon=
fig=0A=
> index 31ba224bbfb4..ae7a0d8be98d 100644=0A=
> --- a/arch/arc/configs/nps_defconfig=0A=
> +++ b/arch/arc/configs/nps_defconfig=0A=
> @@ -73,6 +73,7 @@ CONFIG_PROC_KCORE=3Dy=0A=
>  CONFIG_TMPFS=3Dy=0A=
>  # CONFIG_MISC_FILESYSTEMS is not set=0A=
>  CONFIG_NFS_FS=3Dy=0A=
> +CONFIG_NFS_V3_ACL=3Dy=0A=
>  CONFIG_ROOT_NFS=3Dy=0A=
>  CONFIG_DEBUG_INFO=3Dy=0A=
>  # CONFIG_ENABLE_WARN_DEPRECATED is not set=0A=
> diff --git a/arch/arc/configs/nsimosci_defconfig b/arch/arc/configs/nsimo=
sci_defconfig=0A=
> index f14eeff7d308..ad77f20e5aa6 100644=0A=
> --- a/arch/arc/configs/nsimosci_defconfig=0A=
> +++ b/arch/arc/configs/nsimosci_defconfig=0A=
> @@ -66,5 +66,6 @@ CONFIG_EXT2_FS_XATTR=3Dy=0A=
>  CONFIG_TMPFS=3Dy=0A=
>  # CONFIG_MISC_FILESYSTEMS is not set=0A=
>  CONFIG_NFS_FS=3Dy=0A=
> +CONFIG_NFS_V3_ACL=3Dy=0A=
>  # CONFIG_ENABLE_WARN_DEPRECATED is not set=0A=
>  # CONFIG_ENABLE_MUST_CHECK is not set=0A=
> diff --git a/arch/arc/configs/nsimosci_hs_defconfig b/arch/arc/configs/ns=
imosci_hs_defconfig=0A=
> index 025298a48305..1638e5bc9672 100644=0A=
> --- a/arch/arc/configs/nsimosci_hs_defconfig=0A=
> +++ b/arch/arc/configs/nsimosci_hs_defconfig=0A=
> @@ -65,5 +65,6 @@ CONFIG_EXT2_FS_XATTR=3Dy=0A=
>  CONFIG_TMPFS=3Dy=0A=
>  # CONFIG_MISC_FILESYSTEMS is not set=0A=
>  CONFIG_NFS_FS=3Dy=0A=
> +CONFIG_NFS_V3_ACL=3Dy=0A=
>  # CONFIG_ENABLE_WARN_DEPRECATED is not set=0A=
>  # CONFIG_ENABLE_MUST_CHECK is not set=0A=
> diff --git a/arch/arc/configs/nsimosci_hs_smp_defconfig b/arch/arc/config=
s/nsimosci_hs_smp_defconfig=0A=
> index df7b77b13b82..11cfbdb0f441 100644=0A=
> --- a/arch/arc/configs/nsimosci_hs_smp_defconfig=0A=
> +++ b/arch/arc/configs/nsimosci_hs_smp_defconfig=0A=
> @@ -76,6 +76,7 @@ CONFIG_EXT2_FS_XATTR=3Dy=0A=
>  CONFIG_TMPFS=3Dy=0A=
>  # CONFIG_MISC_FILESYSTEMS is not set=0A=
>  CONFIG_NFS_FS=3Dy=0A=
> +CONFIG_NFS_V3_ACL=3Dy=0A=
>  # CONFIG_ENABLE_WARN_DEPRECATED is not set=0A=
>  # CONFIG_ENABLE_MUST_CHECK is not set=0A=
>  CONFIG_FTRACE=3Dy=0A=
> diff --git a/arch/arc/configs/vdk_hs38_defconfig b/arch/arc/configs/vdk_h=
s38_defconfig=0A=
> index db47c3541f15..1e59a2e9c602 100644=0A=
> --- a/arch/arc/configs/vdk_hs38_defconfig=0A=
> +++ b/arch/arc/configs/vdk_hs38_defconfig=0A=
> @@ -85,6 +85,7 @@ CONFIG_NTFS_FS=3Dy=0A=
>  CONFIG_TMPFS=3Dy=0A=
>  CONFIG_JFFS2_FS=3Dy=0A=
>  CONFIG_NFS_FS=3Dy=0A=
> +CONFIG_NFS_V3_ACL=3Dy=0A=
>  CONFIG_NLS_CODEPAGE_437=3Dy=0A=
>  CONFIG_NLS_ISO8859_1=3Dy=0A=
>  # CONFIG_ENABLE_WARN_DEPRECATED is not set=0A=
> diff --git a/arch/arc/configs/vdk_hs38_smp_defconfig b/arch/arc/configs/v=
dk_hs38_smp_defconfig=0A=
> index a8ac5e917d9a..b5c3f6c54b03 100644=0A=
> --- a/arch/arc/configs/vdk_hs38_smp_defconfig=0A=
> +++ b/arch/arc/configs/vdk_hs38_smp_defconfig=0A=
> @@ -90,6 +90,7 @@ CONFIG_NTFS_FS=3Dy=0A=
>  CONFIG_TMPFS=3Dy=0A=
>  CONFIG_JFFS2_FS=3Dy=0A=
>  CONFIG_NFS_FS=3Dy=0A=
> +CONFIG_NFS_V3_ACL=3Dy=0A=
>  CONFIG_NLS_CODEPAGE_437=3Dy=0A=
>  CONFIG_NLS_ISO8859_1=3Dy=0A=
>  # CONFIG_ENABLE_WARN_DEPRECATED is not set=0A=
=0A=
