Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25182C6787D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 23:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE69F2088F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 23:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQFw+fOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE69F2088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbeJHGrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 02:47:09 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42031 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbeJHGrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 02:47:08 -0400
Received: by mail-qt1-f196.google.com with SMTP id j46-v6so3592561qtc.9
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 16:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F7l9zbnmkmEDW3mC5NLTGd5WWdAa8uXYxyPUl7JS/YM=;
        b=nQFw+fOFswjse90t+2a1LqriieLWg/BylvZ+m1GswKakQopG8+YkL8mNiGI0mCcMgl
         YO0GtemraxTSDra+6fEnv6s52wtXBtFg/tzYwAeUlhkpXTvv5huDH0/qY/AKw1g8UcOQ
         vZ8pbhg36IAJ4TU6LPAawsq4djzyHhcMymsFj6U2lKR+mq1pwQ9rzBmuZXcf1Npn/rdf
         2nBW8NAk98ABlH/WYE3dhn3jkrE7mEvHtl72vMj0OCCpD2sTy9zlQD3E4+juPcsRQpFL
         2LV7fWOtGeJjuJ1+Bc4GnjOBbjFZoHTFjIBGUXjodi16VkJwcva8BIJWAjasavVRi0Jb
         V2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F7l9zbnmkmEDW3mC5NLTGd5WWdAa8uXYxyPUl7JS/YM=;
        b=kQkq6Xt7Ds//fxXAUgMe/9sBPGEc/NLbporll0MH4U+23q5auVjIKkdFejDuzS4Byv
         j0S0STOamroW4VTvyaLW40KkYfHoAUFLeI3MA6Wh6l6xTG4OfN4grKdOpHmwJjvXA/RK
         2zd740FPohsIvse/jO+r2U4jG+fJPK4pt1niF+J1NiAxA5Yl0N/D5yTdD72TbR/nqIUT
         AWA/E9QHjJwVAXLfh+XWJ3+skt/mI0k9uVkcKB81ctJ6jq6sUvOjreK5NfzqbUtojVj2
         bjNIzEAVnJpX0Sd3ge2WXIxQCEQmjccEs50m7jDTYJDckf/kI1GDLDhTLudpXpu9Lv5I
         6BLg==
X-Gm-Message-State: ABuFfoiK+if7feCCqMf2x4FnJurfCH15kMB67LrbqGke9FoxDYiqbLu+
        TBICGkpHhlKkO2lYTxIqE79IrTT/RwyKEmDQ8zZsMg==
X-Google-Smtp-Source: ACcGV637dfqD+qzV2baeWvH4UWwcse1uahQDbMCvGaz0TRTMZ0x/tYlQZBJrara4yNHkLjzGZA9+f+5ZBmy6V0BsZYY=
X-Received: by 2002:ac8:d02:: with SMTP id q2-v6mr17932040qti.182.1538955493054;
 Sun, 07 Oct 2018 16:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <1538861738.4088.5.camel@HansenPartnership.com>
 <1538861799.4088.6.camel@HansenPartnership.com> <CAPM=9tz3Z=vD6qWUL2boZGEAgMeC_o9euBXFu2V58RHOn6gR9g@mail.gmail.com>
 <20181007225613.GZ32577@ZenIV.linux.org.uk>
In-Reply-To: <20181007225613.GZ32577@ZenIV.linux.org.uk>
From:   Dave Airlie <airlied@gmail.com>
Date:   Mon, 8 Oct 2018 09:37:59 +1000
Message-ID: <CAPM=9tzU_wy77j=sx9u9gFsJp-M4ktH7hLQE5=_wKbow9p+iuQ@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH 1/2] code-of-conduct: Fix the ambiguity
 about collecting email addresses
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        LKML <linux-kernel@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2018 at 08:56, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Oct 08, 2018 at 08:25:35AM +1000, Dave Airlie wrote:
>
> > This isn't a legally binding license or anything, but departing from
> > the upstream wording makes it tricker to merge new upstream versions
> > if they are considered appropriate.
>
> Nicely done, that - gotta love the passive voice use.  Considered appropriate
> *by* *whom*?

Good question, do we have a CoC maintainer? Is Linus it, Greg, TAB?

Maybe step one is to find the person who can make changes to the
kernel CoC (has anyone checked if Linus or Greg will merge this).

>
> Anyway, upstream clearly is a poor fit for Linus kernel community structure
> - the use of open lists, amount of subprojects, the length of transmission
> chains into the mainline, total amount of contributors, amount of people
> elsewhere in the project with occasional forays into any given area, etc.
> And IIRC the CoC upstream's opinion was that it wouldn't fit.

I think we can try, fixing upstream is a worthy goal for other
projects in the same position, rather than everyone diverging.
>
> We can surround it with "explanations" until we get something that more or
> less fits, but then we'd need to reanalyse them every time an upstream
> change gets merged.  And the lack of textual conflicts is not a good thing
> in such situations, obviously.

We do this already for the GPL (hence the GPLv2 only, and syscall exceptions).

Dave.
