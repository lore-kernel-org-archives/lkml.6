Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2797DC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08E720850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9+6bsyD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E08E720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbeLEImf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:42:35 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36341 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbeLEImf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:42:35 -0500
Received: by mail-qt1-f195.google.com with SMTP id t13so21376740qtn.3;
        Wed, 05 Dec 2018 00:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+o5LJF3GMMOAAIYKP0h83Kmx/lOPWbuzuHoB7mUPdtA=;
        b=Q9+6bsyDPVz+lTMwcJynx9BdSoqa5UYajVJaa8UqvPoQOlDuk2JiADs6C5XZJbkdsK
         NwRwSx1gCbyxFFVdLw7JduU8iHIjVwJt6YDUS0OS8LD7WeRrVHJASz/UlXneHQC8u+o5
         ly84ZKNeDnucHyxmjKb/X4SPKhN+qJpdlfNiHtV3QGMA3vslsVXw7Jv0qsj8ocdBNq2+
         mEbT827dyUVaxIFqKOcUl10OM6RnIycz2JtyL5OyBlbflTKebnQ1Ls2uOakdVPBTkZ0p
         E7vvbFkbh7cjWIHlmwdyt4/GEmdZodGsiMZk5GdiDuOtUBKUXYLvQJAQIfYx83N7lzNT
         tcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+o5LJF3GMMOAAIYKP0h83Kmx/lOPWbuzuHoB7mUPdtA=;
        b=qtKShaQweIbtpPVrKMZartFhBZvBd0K4bCWUIRbHPJ9iOP4phdrsZ9J+KOscyzNDty
         ME/OmBOd29QiqjU37l8tOlm+lTk3MqhRtnELKSEgwv3W54/CLp0KehndG1F2GKGJlywo
         l0m2ou2rxzE6DNVZT9IL/rqfl7HVYPc6F2NrXY/VSFUovg50IX4MkqlguAXqL9ChGW14
         3K/19tleN51Oipc1FxsKi4WnXwXXe/eWxYC9lfz+nldxfRerfeF+ACnfWvnDCFnB1PoS
         mx/CKLjbwRtBwil6hSctfRTKKnhBeUEb3FNCSHieZgp8Q5x/EUYE3qR/KUulpq3deolo
         Fnjw==
X-Gm-Message-State: AA+aEWZn2z6ZFpHOTx51XvUZ+KGnuobJpRBVMYk4PuqrJb4CwBnFHxYl
        7PCgUuBdok7Dw/0TlGq06HSySWH1rQ+Tr+8oLbE=
X-Google-Smtp-Source: AFSGD/VAST8W5GqV7O1M2R05L6BimuPbsG0AYnbhRey/ClF9ORFqY0UgTlujWgKKrUCBbI6jOOZFi5wiShMeK0dHFKU=
X-Received: by 2002:aed:2d26:: with SMTP id h35mr22923220qtd.373.1543999353783;
 Wed, 05 Dec 2018 00:42:33 -0800 (PST)
MIME-Version: 1.0
References: <20181201155229.8532-1-tiny.windzz@gmail.com> <CAHp75VdEbr9YfaCgHXNqScZC-KMobF2fU8rZb29nhZPBJvm2gg@mail.gmail.com>
 <CAEExFWvRFrS-ZTSkrS5Npe7g-rxtxfCfk+AyTz00Lx4oAWhQ_g@mail.gmail.com>
 <CAHp75VcSVEakAK4MeoG8zA7MaCWNoL2fOr48iFmxTsjbBpa5XA@mail.gmail.com>
 <CAEExFWtE7Yi8D+Dr=J7B3zqBRet0AX=ABHnUrJkZ2LO3aHdNeg@mail.gmail.com>
 <CAHp75Vc7Xfqnid9WLvQMPPWcFnRG0T4ZoHweA6Q-1ypWn29J2Q@mail.gmail.com>
 <CAEExFWso=uBKj4geVTr2zWOd74V1p5EWq=7r6AATSPh63MQ=mg@mail.gmail.com>
 <CAHp75VcXO0YNd32PVfk+BE68+OUCy=THNi9buU2Wu=PUZhPt8g@mail.gmail.com> <CAEExFWtxJrGnoCq1_Nx3uMCW009Qe3LksG4e10s6nW3=p=UWiw@mail.gmail.com>
In-Reply-To: <CAEExFWtxJrGnoCq1_Nx3uMCW009Qe3LksG4e10s6nW3=p=UWiw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 5 Dec 2018 10:42:21 +0200
Message-ID: <CAHp75Vd1Nzd+CDArk+26vwJvq=rULXxOHfq5rQEQjByJtWjH9w@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: convert to DEFINE_SHOW_ATTRIBUTE
To:     tiny.windzz@gmail.com
Cc:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        David Box <david.e.box@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 3:47 AM Frank Lee <tiny.windzz@gmail.com> wrote:
> On Wed, Dec 5, 2018 at 1:39 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Tue, Dec 4, 2018 at 6:58 PM Frank Lee <tiny.windzz@gmail.com> wrote:

> > > $ git remote set-branches --add origin for-next
> > > $ git br -vv
> > > * for-next 651022382c7f [origin/for-next] Linux 4.20-rc1
> >
> > Here is the problem,
> >
> > For a few days at least we have
> > 4ecd94b8e13b (HEAD -> for-next) platform/x86: dell-laptop: Mark
> > expected switch fall-throughs

> Where can I find the correct git repository=EF=BC=9F

I think even old address still exists:
http://git.infradead.org/users/dvhart/linux-platform-drivers-x86.git

> I haven't found the correct one for a long time,
> which include the commit(4ecd94b8e13b ) you said.

And newest one is available via
http://git.infradead.org/linux-platform-drivers-x86.git

http://git.infradead.org/linux-platform-drivers-x86.git/commit/4ecd94b8e13b=
014a28be48c94f751fb62f7c749e

Though it's already advanced to contain new portion of accepted
patches (doesn't matter for you, because they don't touch file in
question).



--=20
With Best Regards,
Andy Shevchenko
