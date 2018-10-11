Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB88C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 02:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F46206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 02:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pQ6x+u4I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18F46206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbeJKJ60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 05:58:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48548 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeJKJ60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 05:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GunYBA/zzjNHqX2HlsOdf7LANDsIsX5/ofyGulMfXvo=; b=pQ6x+u4IsGAB3duEtL0yCLNst
        d6Y3oMwhswiSikBJln+HVkJl04txOTvasn0liI9WLA3BCinM1VtakrtzF44D8jiSPFVEhOz6d9iyq
        uTCmESxeEn+QjIlmPcH+4fSRS3jD82O77G2D6ALoIzqDwDmhctdB1FoKFBbTdzNHJs8HiBjbcKnPW
        WGcOk+kDMtT7POsZOAf16auvi/aLlQkc6olP0hCFxa5JWWgjE3sYpx0J+BnXPWD6s0RberHeGYq19
        gZ0mqpIfgz8Aihtrp5HcXgYO675kbKmi69FDSaVm90ObEd0YvsDuFEcQEby/Yak35ex7RpQqqPq2u
        iVALBN0BA==;
Received: from 177.43.144.224.dynamic.adsl.gvt.net.br ([177.43.144.224] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gAQmx-00059X-E8; Thu, 11 Oct 2018 02:33:23 +0000
Date:   Wed, 10 Oct 2018 23:33:20 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Ksummit-discuss] [PATCH v2 1/3] code-of-conduct: Fix the
 ambiguity about collecting email addresses
Message-ID: <20181010233320.04981d6e@coco.lan>
In-Reply-To: <1539202115.12644.9.camel@HansenPartnership.com>
References: <1539202053.12644.8.camel@HansenPartnership.com>
        <1539202115.12644.9.camel@HansenPartnership.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 10 Oct 2018 13:08:35 -0700
James Bottomley <James.Bottomley@HansenPartnership.com> escreveu:

> The current code of conduct has an ambiguity in the it considers publishi=
ng
> private information such as email addresses unacceptable behaviour.  Since
> the Linux kernel collects and publishes email addresses as part of the pa=
tch
> process, add an exception clause for email addresses ordinarily collected=
 by
> the project to correct this ambiguity.
>=20
> Fixes: 8a104f8b5867c682 ("Code of Conduct: Let's revamp it.")
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Shuah Khan <shuah@kernel.org>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Alan Cox <alan@llwyncelyn.cymru>
> Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

In time, please change my reviewed by to:

	Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>

As I'm speaking for myself, not for my employer.

> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  Documentation/process/code-of-conduct.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/process/code-of-conduct.rst b/Documentation/pr=
ocess/code-of-conduct.rst
> index ab7c24b5478c..aa40e34e7785 100644
> --- a/Documentation/process/code-of-conduct.rst
> +++ b/Documentation/process/code-of-conduct.rst
> @@ -31,7 +31,7 @@ Examples of unacceptable behavior by participants inclu=
de:
>  * Trolling, insulting/derogatory comments, and personal or political att=
acks
>  * Public or private harassment
>  * Publishing others=E2=80=99 private information, such as a physical or =
electronic
> -  address, without explicit permission
> +  address not ordinarily collected by the project, without explicit perm=
ission
>  * Other conduct which could reasonably be considered inappropriate in a
>    professional setting
> =20



Thanks,
Mauro
