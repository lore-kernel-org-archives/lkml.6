Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE09EC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A386220818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OWaH0vEB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A386220818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbeKJCW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:22:58 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:55702 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbeKJCW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:22:58 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 7FA0324E12DE;
        Fri,  9 Nov 2018 08:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1541781697; bh=txYAmWXH0KHt9VNmLVb9nU9lQs6SlcbZ9lsP4C4lcog=;
        h=From:To:CC:Subject:Date:References:From;
        b=OWaH0vEBTA0fK5xfBfmUp4b6GtnnS4TdUFmAHB2EAq1l6wgTupDZaZSOtW2Qqqovu
         082cwRIz5ALgJdJEgVpFYfHsaQKm+45PzWfSnhR4GCijFWr3XhjH3qIjiO+B6vwrCC
         6WzFUy0xVHBy1QjA50VlEFyFc5IfBYzRJc8DkeeoxN/eZUWJS+YvpC868UOCZ5oNBU
         OjND77w1wmd/ozpR5X3Pj3WbKBUOoMKkOXGWyRqUBPK2cd8/gZUi1BANOCd8GFEHol
         KrsE6z7xzzGmlGq6TQjWF6QJCRnGacmH5rk4cvqVhKx5txufSczhKjne6jyu+KC3mM
         5o+qXV3HbMafQ==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        by mailhost.synopsys.com (Postfix) with ESMTP id 6AFD636AC;
        Fri,  9 Nov 2018 08:41:37 -0800 (PST)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.228]) by
 US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0415.000; Fri, 9 Nov 2018 08:41:37 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     "Dmitry V. Levin" <ldv@altlinux.org>,
        Andy Lutomirski <luto@kernel.org>
CC:     Elvira Khabirova <lineprinter@altlinux.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/13] elf-em.h: add EM_ARC
Thread-Topic: [PATCH 02/13] elf-em.h: add EM_ARC
Thread-Index: AQHUd9p9BoKyorwTN06SlBlpnoGSJw==
Date:   Fri, 9 Nov 2018 16:41:36 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075013A59237C@us01wembx1.internal.synopsys.com>
References: <20181109031536.GB21511@altlinux.org>
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

On 11/8/18 7:15 PM, Dmitry V. Levin wrote:=0A=
> The uapi/linux/audit.h header is going to use EM_ARC in order=0A=
> to define AUDIT_ARCH_ARC which is needed to implement=0A=
> syscall_get_arch() which in turn is required to extend=0A=
> the generic ptrace API with PTRACE_GET_SYSCALL_INFO request.=0A=
>=0A=
> The value for EM_ARC has been taken from=0A=
> https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__www.sco.com_develop=
ers_gabi_2012-2D12-2D31_ch4.eheader.html&d=3DDwIBAg&c=3DDPL6_X_6JkXFx7AXWqB=
0tg&r=3Dc14YS-cH-kdhTOW89KozFhBtBJgs1zXscZojEZQ0THs&m=3DUCr-dDO1BWV4K-CXhpc=
DRnN4Urr4_UgSKBeEaczUAmE&s=3DXmSWUKeqq324aU46NSTbHc12dH-1vVnA4G3Rm-01WD4&e=
=3D=0A=
>=0A=
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>=0A=
> ---=0A=
>  include/uapi/linux/elf-em.h | 1 +=0A=
>  1 file changed, 1 insertion(+)=0A=
>=0A=
> diff --git a/include/uapi/linux/elf-em.h b/include/uapi/linux/elf-em.h=0A=
> index ba3696e3d694..56ff3f9d9633 100644=0A=
> --- a/include/uapi/linux/elf-em.h=0A=
> +++ b/include/uapi/linux/elf-em.h=0A=
> @@ -26,6 +26,7 @@=0A=
>  #define EM_ARM		40	/* ARM 32 bit */=0A=
>  #define EM_SH		42	/* SuperH */=0A=
>  #define EM_SPARCV9	43	/* SPARC v9 64-bit */=0A=
> +#define EM_ARC		45	/* Argonaut RISC Core */=0A=
=0A=
Please use EM_ARCOMPACT (for original ARC ISA) and EM_ARCV2 - both defined =
in=0A=
arch/arc/include/asm/elf.h=0A=
=0A=
-Vineet=0A=
=0A=
>  #define EM_H8_300	46	/* Renesas H8/300 */=0A=
>  #define EM_IA_64	50	/* HP/Intel IA-64 */=0A=
>  #define EM_X86_64	62	/* AMD x86-64 */=0A=
=0A=
