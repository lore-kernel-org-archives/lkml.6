Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7016FC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 23:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 304CA20836
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 23:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="0qS+OE57";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A+CivTrQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfALXcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 18:32:48 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33635 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726399AbfALXcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 18:32:47 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 1F8F621AAD;
        Sat, 12 Jan 2019 18:32:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 12 Jan 2019 18:32:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=3
        NxPxNIGiSzNWT0s/W2ZCnb7jgAT5mi9uinyciQgQYg=; b=0qS+OE57rXAooGNNb
        rArDHRPMKxhpX6VJabM+AShz7kU6/Oeh7Tmygg8qW8qceWcVDssd98RYODtl0OiX
        U4jJlNe7TpRyqyI3+x89Gey7KZkRqN0ewHSwgIxXIymgB0EzTLBF1fDoVhWcyjCg
        yMlxMew7SXyDwv4NcofqibWbDkZT4OSR6HfwUewnYFLRiLB15WIZsdh4j+KA4rNQ
        rXuqGi550bQw6RyKBNfNUlNxPaLeI/q5NEuVBjn05VQAMAOqop3gMTOdzh5rnyGe
        XIR3Ekx6hd/dM24y/wVPn+L8GE0isQ42+YrK9mU9MiCyQ1xpdqb8UE61J6rwqQbW
        nICyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=3NxPxNIGiSzNWT0s/W2ZCnb7jgAT5mi9uinyciQgQ
        Yg=; b=A+CivTrQx9vckpl+WJviaMFcSaWU7ZvGAHAEIdpjMSGxsBueqYAPwgjyJ
        dt4+w8UbZ45wKUB9RQVlNerNlvAyiSxG65RozHESfPM8QJu0BLEVg8buarL2soLv
        SBDPyKI+k/0v5fbBwyOmQ+I0KBZbd/7U5ciO8Af90wd5D5BafnAsAUKCUQVlciFm
        I+Ihd3TPEF+BWEdZ97evxxr/bucSR4tS20N8Br6vRrll3dnZqlW7c1PQwGw0XBc2
        owuO7mMk6u7aKVxV2gnpDkMKcGrIcekZazMyo1tm5kpMK/Y9lblFMwFOMVTGMUcV
        GmuUCjOnABgRTvAeUvVPYHYhwnqpQ==
X-ME-Sender: <xms:Gnk6XGrOgXrpP71bWIsdlTvNYg-bYPrYF87-BNypbxaMQFlUcwmWEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrfeejgddujeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhhtnecuuegrihhlohhuthemucef
    tddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkff
    gfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgvlhcujfholhhlrghnugcu
    oehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucffohhmrghinhepkhgvrhhnvg
    hlrdhorhhgnecukfhppeejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghi
    lhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghruf
    hiiigvpedt
X-ME-Proxy: <xmx:Gnk6XNxMqGAgXCiOY-2ZsfyvaLS1XzAbZ97Ofp2Rcq-Y9xh0eO6_1g>
    <xmx:Gnk6XEHUqpNBBiUVcqoLxZge4DpUDAL3mftDTm7C4gK_EKl1zaci3A>
    <xmx:Gnk6XIi5dfReuShwwg3dVoOMDOqROzcifZkiYhjainwOFP6pGOP7-g>
    <xmx:HHk6XMH3CO0XSDkO6vayjnDrqjwe5v9_IPH0OjKXnKZeetV02p01ow>
Received: from [192.168.50.162] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3C994100E5;
        Sat, 12 Jan 2019 18:32:42 -0500 (EST)
Subject: Re: [PATCH v5 1/2] powerpc/32: add stack protector support
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
References: <8e81b0647fea15e533a73ad4e9063c059fdfc6df.1537987712.git.christophe.leroy@c-s.fr>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <f5600a1d-71ca-f1d7-3973-026462990059@sholland.org>
Date:   Sat, 12 Jan 2019 17:32:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8e81b0647fea15e533a73ad4e9063c059fdfc6df.1537987712.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

On 09/27/18 02:05, Christophe Leroy wrote:
[..snip..]
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 07d9dce7eda6..45b8eb4d8fe7 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -112,6 +112,9 @@ KBUILD_LDFLAGS	+= -m elf$(BITS)$(LDEMULATION)
>  KBUILD_ARFLAGS	+= --target=elf$(BITS)-$(GNUTARGET)
>  endif
>  
> +cflags-$(CONFIG_STACKPROTECTOR)	+= -mstack-protector-guard=tls
> +cflags-$(CONFIG_STACKPROTECTOR)	+= -mstack-protector-guard-reg=r2
> +
>  LDFLAGS_vmlinux-y := -Bstatic
>  LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) := -pie
>  LDFLAGS_vmlinux	:= $(LDFLAGS_vmlinux-y)
> @@ -404,6 +407,13 @@ archclean:
>  
>  archprepare: checkbin
>  
> +ifdef CONFIG_STACKPROTECTOR
> +prepare: stack_protector_prepare
> +
> +stack_protector_prepare: prepare0
> +	$(eval KBUILD_CFLAGS += -mstack-protector-guard-offset=$(shell awk '{if ($$2 == "TASK_CANARY") print $$3;}' include/generated/asm-offsets.h))
> +endif
> +

This breaks when building out-of-tree kernel modules. GCC is not getting passed
the -mstack-protector-guard-offset argument, so the default offset is used. The
kernel then panics the first time a function with stack protector is called.

I'm seeing this on powerpc64. It looks like it was reported for powerpc on
kernel bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201891

Linux 4.20 does not have a "prepare" target when KBUILD_EXTMOD is set. One is
added by:

  commit e07db28eea38ed4e332b3a89f3995c86b713cb5b
  Author: Masahiro Yamada <yamada.masahiro@socionext.com>
  Date:   Thu Nov 22 08:11:54 2018 +0900

      kbuild: fix single target build for external module

However, after cherry-picking that patch, the build fails because it's missing
prepare0. I applied the patch below and I successfully built an out-of-tree
module with CONFIG_STACKPROTECTOR=y.

diff --git a/Makefile b/Makefile
index 826826553085..f0a93e1ba1b6 100644
--- a/Makefile
+++ b/Makefile
@@ -1596,9 +1596,10 @@ help:
        @echo  ''

 # Dummies...
-PHONY += prepare scripts
-prepare:
+PHONY += prepare prepare0 scripts
+prepare: prepare0
        $(cmd_crmodverdir)
+prepare0: ;
 scripts: ;
 endif # KBUILD_EXTMOD

The context has been changed some in later patches, but I think a change like
this one should go into 5.0, and it e07db28eea38 should go into 4.20.y.

Thanks,
Samuel
