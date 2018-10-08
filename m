Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3ECC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528C82145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a465I0gv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 528C82145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbeJIDgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 23:36:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57594 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbeJIDgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 23:36:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9Wg1ba4/QUK1MYSpn+rcAuBLeY47DC0iGmOq5FH/lWk=; b=a465I0gvm2rhTkfelT44PRllV
        SRSwfL6ffPvrJZM2OvpVeDTgTDykj8wnV05oi9B/E+TyG2aIoyn65mT/FJwQb1wlAs1UQ0vodCUTu
        vCI9GWUqi2/pJyhYlZohSXBXreSHt/H6bElemFb1B7AaG6DdMv9ZFE53cZLX4xquLvDS+Dzk97/sz
        AHx5QdqXt5rKQwBIh8t3RvZ7he1FOsizgK5nf+qpTvy/UpjNphF1nZtKe8ent6c0KuPLiQjIiBRjo
        xAupVFSseTEoi93VMpJd6EmNEgdeAPpWMarjCtBD5O1fMN8oE6tZg2OJB22XFoVwV8bUm2u9b3WWX
        LQ1GJ/G/Q==;
Received: from [179.183.98.126] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9c3V-0004FS-UG; Mon, 08 Oct 2018 20:23:06 +0000
Date:   Mon, 8 Oct 2018 17:23:03 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Ksummit-discuss] [PATCH 2/2] code-of-conduct: Strip the
 enforcement paragraph pending community discussion
Message-ID: <20181008172303.4f06cd94@coco.lan>
In-Reply-To: <1538861851.4088.7.camel@HansenPartnership.com>
References: <1538861738.4088.5.camel@HansenPartnership.com>
        <1538861851.4088.7.camel@HansenPartnership.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, 06 Oct 2018 14:37:31 -0700
James Bottomley <James.Bottomley@HansenPartnership.com> escreveu:

> Significant concern has been expressed about the responsibilities outline=
d in
> the enforcement clause of the new code of conduct.  Since there is concern
> that this becomes binding on the release of the 4.19 kernel, strip the
> enforcement clauses to give the community time to consider and debate how=
 this
> should be handled.
>=20
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>


With my maintainer's hat, my main concern would be solved with this hunk:

diff --git a/Documentation/process/code-of-conduct.rst b/Documentation/proc=
ess/code-of-conduct.rst
index ab7c24b5478c..f07d51129d4b 100644
--- a/Documentation/process/code-of-conduct.rst
+++ b/Documentation/process/code-of-conduct.rst
@@ -43,7 +43,7 @@ Maintainers are responsible for clarifying the standards =
of acceptable behavior
 and are expected to take appropriate and fair corrective action in respons=
e to
 any instances of unacceptable behavior.
=20
-Maintainers have the right and responsibility to remove, edit, or reject
+Maintainers may remove, edit, or reject
 comments, commits, code, wiki edits, issues, and other contributions that =
are
 not aligned to this Code of Conduct, or to ban temporarily or permanently =
any
 contributor for other behaviors that they deem inappropriate, threatening,

The previous text seems too much legal for my taste.

> ---
>  Documentation/process/code-of-conduct.rst | 15 ---------------
>  1 file changed, 15 deletions(-)
>=20
> diff --git a/Documentation/process/code-of-conduct.rst b/Documentation/pr=
ocess/code-of-conduct.rst
> index aa40e34e7785..4dd90987305b 100644
> --- a/Documentation/process/code-of-conduct.rst
> +++ b/Documentation/process/code-of-conduct.rst
> @@ -59,21 +59,6 @@ address, posting via an official social media account,=
 or acting as an appointed
>  representative at an online or offline event. Representation of a projec=
t may be
>  further defined and clarified by project maintainers.
> =20
> -Enforcement
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -Instances of abusive, harassing, or otherwise unacceptable behavior may =
be
> -reported by contacting the Technical Advisory Board (TAB) at
> -<tab@lists.linux-foundation.org>. All complaints will be reviewed and
> -investigated and will result in a response that is deemed necessary and
> -appropriate to the circumstances. The TAB is obligated to maintain
> -confidentiality with regard to the reporter of an incident.  Further det=
ails of
> -specific enforcement policies may be posted separately.
> -
> -Maintainers who do not follow or enforce the Code of Conduct in good fai=
th may
> -face temporary or permanent repercussions as determined by other members=
 of the
> -project=E2=80=99s leadership.
> -
>  Attribution
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

After looking at the comments, I would just keep TAB as a point of contact
for CoC violations:

diff --git a/Documentation/process/code-of-conduct.rst b/Documentation/proc=
ess/code-of-conduct.rst
index ab7c24b5478c..fa908dbff51c 100644
--- a/Documentation/process/code-of-conduct.rst
+++ b/Documentation/process/code-of-conduct.rst
@@ -59,20 +59,12 @@ address, posting via an official social media account, =
or acting as an appointed
 representative at an online or offline event. Representation of a project =
may be
 further defined and clarified by project maintainers.
=20
-Enforcement
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Reports
+=3D=3D=3D=3D=3D=3D=3D
=20
 Instances of abusive, harassing, or otherwise unacceptable behavior may be
 reported by contacting the Technical Advisory Board (TAB) at
-<tab@lists.linux-foundation.org>. All complaints will be reviewed and
-investigated and will result in a response that is deemed necessary and
-appropriate to the circumstances. The TAB is obligated to maintain
-confidentiality with regard to the reporter of an incident.  Further detai=
ls of
-specific enforcement policies may be posted separately.
-
-Maintainers who do not follow or enforce the Code of Conduct in good faith=
 may
-face temporary or permanent repercussions as determined by other members o=
f the
-project=E2=80=99s leadership.
+<tab@lists.linux-foundation.org>.
=20
 Attribution
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Keeping the rest implicit. This can be revisited after having more
discussions.

Thanks,
Mauro

-

Both hunks are shown below.


diff --git a/Documentation/process/code-of-conduct.rst b/Documentation/proc=
ess/code-of-conduct.rst
index ab7c24b5478c..df44867a2db5 100644
--- a/Documentation/process/code-of-conduct.rst
+++ b/Documentation/process/code-of-conduct.rst
@@ -43,7 +43,7 @@ Maintainers are responsible for clarifying the standards =
of acceptable behavior
 and are expected to take appropriate and fair corrective action in respons=
e to
 any instances of unacceptable behavior.
=20
-Maintainers have the right and responsibility to remove, edit, or reject
+Maintainers may remove, edit, or reject
 comments, commits, code, wiki edits, issues, and other contributions that =
are
 not aligned to this Code of Conduct, or to ban temporarily or permanently =
any
 contributor for other behaviors that they deem inappropriate, threatening,
@@ -59,20 +59,12 @@ address, posting via an official social media account, =
or acting as an appointed
 representative at an online or offline event. Representation of a project =
may be
 further defined and clarified by project maintainers.
=20
-Enforcement
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Reports
+=3D=3D=3D=3D=3D=3D=3D
=20
 Instances of abusive, harassing, or otherwise unacceptable behavior may be
 reported by contacting the Technical Advisory Board (TAB) at
-<tab@lists.linux-foundation.org>. All complaints will be reviewed and
-investigated and will result in a response that is deemed necessary and
-appropriate to the circumstances. The TAB is obligated to maintain
-confidentiality with regard to the reporter of an incident.  Further detai=
ls of
-specific enforcement policies may be posted separately.
-
-Maintainers who do not follow or enforce the Code of Conduct in good faith=
 may
-face temporary or permanent repercussions as determined by other members o=
f the
-project=E2=80=99s leadership.
+<tab@lists.linux-foundation.org>.
=20
 Attribution
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

