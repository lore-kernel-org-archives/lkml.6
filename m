Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4119318-1520453518-2-13914960521110486619
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520453518; b=svd3LEa/STiRKS52ND3w6Y9OCLEuzVHnW9XYdC/1aU3oQ1P
    M61No4vQUiTLjoTwK/46RA6//A5xd4LM8l2SrLIVKDsxrYptsOuTXQR8R0YsllZ9
    Rdf4ATqfMHr6Oo0fcTLU89xlcyCObGVJalJwDFEkvUmnJlQgTKmePFmUPjhPnuxN
    /Mq2OWe1nWeNxNU8YRBbWxOWE9Meqle10V1yYp8HRSPm/kupxfZe50luc02UN0WA
    92tx6ra3d7/mKdi/aIUqLP2jjddRPUeZhbHjBdfCEEKH1L6wlrU9Zo+J707ae+dh
    aosQvjScgq7CdGRPPly9JcFKVSzw/3KSDzOqcsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520453518; bh=PBN2DEFDcAVdNoB+CJrX7S+pGwbqjmH/++UTk7ZoMLo=; b=S
    ryk/OdqNinnDxLvmpDXscgotBr0kJIkUcSerhbrdReawT5WS3DUXLJ1S4nV4xeO6
    B7PjI2lsib8T8i0u4jrWekvYQBFXo3WOuDJplrvUFsWS0uul+wkfa2HCYbgpBW8d
    yregz9svNhR+THB/Zd3+ZuP9tM/zM5NdQ+lcWjKCljJAcppzbnsdblfGj3Ij1xOH
    nXk7COEfzIoTGJd/8OCmzPLBnaP7W9pjQFBRe0hNyQkq36BsQr7fV0m8V+sXwp1G
    +Ni7ixKHcBrkDWUbThY5a3qPuhX8dnkFRKDzUtAXekdi6Az2/uRkWDSJpCJcBBly
    AiaS9MfzG79Ur/JF4hZZw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=MA2BHisu x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GOvr0QFW;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=MA2BHisu x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GOvr0QFW;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965431AbeCGULr (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 15:11:47 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44961 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965386AbeCGULo (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 15:11:44 -0500
X-Google-Smtp-Source: AG47ELuPMaeFMH+mkGYyE3/OdJZE1gI58plDj1xrQIblR6RBm8v4HptfOwr5s+iiYd11+tW6EvqFGQ==
Subject: Re: [PATCH] kbuild: Handle builtin dtb files containing hyphens
To: James Hogan <jhogan@kernel.org>, linux-kbuild@vger.kernel.org,
        devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org,
        stable@vger.kernel.org
References: <20180307140633.26182-1-jhogan@kernel.org>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <7ecea7ca-2931-16bc-a110-1ecdaf17f0f2@gmail.com>
Date: Wed, 7 Mar 2018 12:11:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180307140633.26182-1-jhogan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I initially misread the patch description (and imagined an entirely
different problem).


On 03/07/18 06:06, James Hogan wrote:
> On dtb files which contain hyphens, the dt_S_dtb command to build the> dtb.S files (which allow DTB files to be built into the kernel) results> in errors like the following:> > bcm3368-netgear-cvg834g.dtb.S: Assembler messages:> bcm3368-netgear-cvg834g.dtb.S:5: Error: : no such section> bcm3368-netgear-cvg834g.dtb.S:5: Error: junk at end of line, first unrecognized character is `-'> bcm3368-netgear-cvg834g.dtb.S:6: Error: unrecognized opcode `__dtb_bcm3368-netgear-cvg834g_begin:'> bcm3368-netgear-cvg834g.dtb.S:8: Error: unrecognized opcode `__dtb_bcm3368-netgear-cvg834g_end:'> bcm3368-netgear-cvg834g.dtb.S:9: Error: : no such section> bcm3368-netgear-cvg834g.dtb.S:9: Error: junk at end of line, first unrecognized character is `-'
Please replace the following section:

> This is due to the hyphen being used in symbol names. Replace all
> hyphens 
> with underscores in the dt_S_dtb command to avoid this problem.
> 
> Quite a lot of dts files have hyphens, but its only a problem on MIPS
> where such files can be built into the kernel. For example when
> CONFIG_DT_NETGEAR_CVG834G=y, or on BMIPS kernels when the dtbs target is
> used (in the latter case it admitedly shouldn't really build all the
> dtb.o files, but thats a separate issue).

with:

   cmd_dt_S_dtb constructs the assembly source to incorporate a devicetree
   FDT (that is, the .dtb file) as binary data in the kernel image.
   This assembly source contains labels before and after the binary data.
   The label names incorporate the file name of the corresponding .dtb
   file.  Hyphens are not legal characters in labels, so transform all
   hyphens from the file name to underscores when constructing the labels.

> 
> Fixes: 695835511f96 ("MIPS: BMIPS: rename bcm96358nb4ser to bcm6358-neufbox4-sercom")
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Kevin Cernekee <cernekee@gmail.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kbuild@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: <stable@vger.kernel.org> # 4.9+
> ---
>  scripts/Makefile.lib | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 5589bae34af6..a6f538b31ad6 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -297,11 +297,11 @@ cmd_dt_S_dtb=						\
>  	echo '\#include <asm-generic/vmlinux.lds.h>'; 	\
>  	echo '.section .dtb.init.rodata,"a"';		\
>  	echo '.balign STRUCT_ALIGNMENT';		\
> -	echo '.global __dtb_$(*F)_begin';		\
> -	echo '__dtb_$(*F)_begin:';			\
> +	echo '.global __dtb_$(subst -,_,$(*F))_begin';	\
> +	echo '__dtb_$(subst -,_,$(*F))_begin:';		\
>  	echo '.incbin "$<" ';				\
> -	echo '__dtb_$(*F)_end:';			\
> -	echo '.global __dtb_$(*F)_end';			\
> +	echo '__dtb_$(subst -,_,$(*F))_end:';		\
> +	echo '.global __dtb_$(subst -,_,$(*F))_end';	\
>  	echo '.balign STRUCT_ALIGNMENT'; 		\
>  ) > $@
>  
> 

Reviewed-by: Frank Rowand <frowand.list@gmail.com>
