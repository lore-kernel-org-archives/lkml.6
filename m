Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0845C6787D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 22:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B962087D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 22:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QO2U1Kh7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79B962087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbeJHFea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 01:34:30 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41744 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeJHFea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 01:34:30 -0400
Received: by mail-qt1-f196.google.com with SMTP id l41-v6so6624132qtl.8
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 15:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PVuOoMPxZx+0WC0U+AcmhsryKNgOQdjSQpTGaLhVVhA=;
        b=QO2U1Kh7VtHfJ7HJgkaatGeaabGdJtFp69tFmJ62ATu4g/DtgOZ2OCPbBjgSuKZ9GZ
         3nbndPKhzdusH6HaNay1vRwUMsjjrRqREWj4GIwWLrcTV+IUJ8ztIuZJ1/R4zevEM038
         /8x17X2nZccEnXmqcKMYuT/dkVLi7XIO8wVkpLnJGWdovbPvC3gxp6Ka5SXabddG9S9y
         S6LDNsgV0YZ+WblfNpylqJRHF/L6hLDarqrjzR7R+J+xGL6Wv9LCgVZMXVVwzluS5lUv
         gB/Aw+Lsa55LrU6o8cghdbbWqxJGQqSAH7GSf+a4T39iTthMDRw7RbDYESU0iU2hLQBH
         MKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PVuOoMPxZx+0WC0U+AcmhsryKNgOQdjSQpTGaLhVVhA=;
        b=auHbraeb6h1BkWq/e8cohZqWWlPUZGXS/05pciojJ7MQgPtQPn2woIWayKUB+jCFZE
         Bn8cdUlSnsyYuuXW4ei668ilvgKwbC1oL8h7zFcUTMSyiM9ZQON4x1k+o+fOccEUYZCN
         YpvSP3vBNAjFMZgmpZjj4WLmtzKmnAnJJq45vSQQ5yA0Ac0mU7I0cuH0OVRv9ScH8KxB
         u5j4z4vNFgILc30SbsvLTFMB3ZH7dJbKqQVwEUZGVD++2EncoGdKcSVZgYJIhz0m+5Uq
         kLtkxgwpdy25Rm82GmHE1CRlcRTRL1LR7xWUZ7fxlcMAhOPSO3cffH2+18SvWJGKza94
         B8rQ==
X-Gm-Message-State: ABuFfojmVuAe97UzpnntngI12zZToWqua/G0FCDPEq+bb5xtpibGSAIf
        gWn4sj/KCHJZp9OpNefWZ3vXeqBSUi5dqpFUF9Wj3A==
X-Google-Smtp-Source: ACcGV63C6A9GCt6GQ/xUd9l0J2EE0sgxlGITdWRNWiwQwKWtk88NAjD5J8axrOkWQFzdUHBCMWefX5McIlR9eiI2zTs=
X-Received: by 2002:a0c:9213:: with SMTP id a19mr561040qva.124.1538951147626;
 Sun, 07 Oct 2018 15:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <1538861738.4088.5.camel@HansenPartnership.com> <1538861799.4088.6.camel@HansenPartnership.com>
In-Reply-To: <1538861799.4088.6.camel@HansenPartnership.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Mon, 8 Oct 2018 08:25:35 +1000
Message-ID: <CAPM=9tz3Z=vD6qWUL2boZGEAgMeC_o9euBXFu2V58RHOn6gR9g@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH 1/2] code-of-conduct: Fix the ambiguity
 about collecting email addresses
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Oct 2018 at 07:36, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> From 4a614e9440148894207bef5bf69e74071baceb3b Mon Sep 17 00:00:00 2001
> From: James Bottomley <James.Bottomley@HansenPartnership.com>
> Date: Sat, 6 Oct 2018 14:21:56 -0700
> Subject: [PATCH 1/2] code-of-conduct: Fix the ambiguity about collecting =
email
>  addresses
>
> The current code of conduct has an ambiguity in the it considers publishi=
ng
> private information such as email addresses unacceptable behaviour.  Sinc=
e
> the Linux kernel collects and publishes email addresses as part of the pa=
tch
> process, add an exception clause for email addresses ordinarily collected=
 by
> the project to correct this ambiguity.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  Documentation/process/code-of-conduct.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
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
>

I agree we want something like this, the question is whether we want
to change the CoC text from upstream, or clarify it in a separate
section.

This isn't a legally binding license or anything, but departing from
the upstream wording makes it tricker to merge new upstream versions
if they are considered appropriate.

Dave.
