Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B0AC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189A32082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYT+4jlt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 189A32082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbeLEBrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 20:47:11 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:40562 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbeLEBrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 20:47:10 -0500
Received: by mail-it1-f194.google.com with SMTP id h193so17744929ita.5;
        Tue, 04 Dec 2018 17:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TXxg5Oa7Ff2vkS0J3Oqcr8Gh996iy1JLISadTQFqazg=;
        b=VYT+4jltaeYPDuFFLBz6UMKHkq9Te6gwH3K/7eA650n3vrOmaj+q3tqzTWM3Cu5D4j
         UtxBNI7o4KJG+GIt6Kqqh0odPgAsVeDRfVWQvqt064MxtN3/ptre0Yh5eNgwtDe/cCay
         rsSKX/txJhYtPJosa5RG66wV0VCOoDxx6zvRWx5vQtE4z1aigyk0NFl8ROf+Oclf9//1
         aFcFehrPK09/kVCm2IsfP6b/NFsGI8EzBU015tb1Z/lQxZx5R+97xv/rzhrLkNWU9PG4
         kqVkiHbiCbk7z19Rng8aMjMh+nSasOMcysejFcML/KbU7r8xRmij8dWboMiohdoQ9kk9
         dEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TXxg5Oa7Ff2vkS0J3Oqcr8Gh996iy1JLISadTQFqazg=;
        b=duksRx0bzmEY6YWMt1oqFfEbt09UnWuLc0nDpaAXrZiV/DcbIV0c0gVBoltnEgPv4E
         h0b5z9gu4LoXYxloDjmc5xw7qo+003Hb+DBFpv3xMNSKkqXHBcpTGPapWm4b/lSgjYjG
         3dm9biy7Zb4E9aU3zXqwEdKR8kSLezuMKp86Izh09awyg7mZBe8MfsPKRb+lab7ZHhru
         +IQcQ/yjxJV8Qf0M5lJvX72rMXmhD1pvAHN2XjBFJbSSqp9nAMwe77teksh2qwNgpBkn
         ECjpYXES39ra+LwgY0Ey6sN0yvj0qbXEzc45E8GuqRpKNd/MFRTSMaCgGBYovTE28eW6
         R99w==
X-Gm-Message-State: AA+aEWZrXwCaiGZ1FrkWWXpGEiyV6W3RT17zNJ2aFvXzjmOJAjRi+kU7
        gUmefbyAyTtlzW3HL8EoXttONHHKx1jztJCy/ziOCt3iAk8=
X-Google-Smtp-Source: AFSGD/XTEoqo40wfyQk+n+sjdIuw34OMS5xi+6Mlo5iuggY5GXGFCcwbuWpEAOiCpR81PTQIU4deOg+5dqLGX0+Lw4g=
X-Received: by 2002:a02:9d27:: with SMTP id n36mr19530350jak.30.1543974429182;
 Tue, 04 Dec 2018 17:47:09 -0800 (PST)
MIME-Version: 1.0
References: <20181201155229.8532-1-tiny.windzz@gmail.com> <CAHp75VdEbr9YfaCgHXNqScZC-KMobF2fU8rZb29nhZPBJvm2gg@mail.gmail.com>
 <CAEExFWvRFrS-ZTSkrS5Npe7g-rxtxfCfk+AyTz00Lx4oAWhQ_g@mail.gmail.com>
 <CAHp75VcSVEakAK4MeoG8zA7MaCWNoL2fOr48iFmxTsjbBpa5XA@mail.gmail.com>
 <CAEExFWtE7Yi8D+Dr=J7B3zqBRet0AX=ABHnUrJkZ2LO3aHdNeg@mail.gmail.com>
 <CAHp75Vc7Xfqnid9WLvQMPPWcFnRG0T4ZoHweA6Q-1ypWn29J2Q@mail.gmail.com>
 <CAEExFWso=uBKj4geVTr2zWOd74V1p5EWq=7r6AATSPh63MQ=mg@mail.gmail.com> <CAHp75VcXO0YNd32PVfk+BE68+OUCy=THNi9buU2Wu=PUZhPt8g@mail.gmail.com>
In-Reply-To: <CAHp75VcXO0YNd32PVfk+BE68+OUCy=THNi9buU2Wu=PUZhPt8g@mail.gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Wed, 5 Dec 2018 09:47:42 +0800
Message-ID: <CAEExFWtxJrGnoCq1_Nx3uMCW009Qe3LksG4e10s6nW3=p=UWiw@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: convert to DEFINE_SHOW_ATTRIBUTE
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     rajneesh.bhardwaj@intel.com, vishwanath.somayaji@intel.com,
        dvhart@infradead.org, andy@infradead.org,
        David Box <david.e.box@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 1:39 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Dec 4, 2018 at 6:58 PM Frank Lee <tiny.windzz@gmail.com> wrote:
>
> > $ git br -r
> >   origin/HEAD -> origin/master
> >   origin/fixes
> >   origin/for-next
> >   origin/master
> >   origin/review-andy
> > $ git remote set-branches --add origin for-next
> > $ git br -vv
> > * for-next 651022382c7f [origin/for-next] Linux 4.20-rc1
>
> Here is the problem,
>
> For a few days at least we have
> 4ecd94b8e13b (HEAD -> for-next) platform/x86: dell-laptop: Mark
> expected switch fall-throughs
>
> > $ git apply ../../0001-platform-x86-convert-to-DEFINE_SHOW_ATTRIBUTE.pa=
tch
> > $ git st
> > On branch for-next
> > Your branch is up to date with 'origin/for-next'.
> >
> > Changes not staged for commit:
> >   (use "git add <file>..." to update what will be committed)
> >   (use "git checkout -- <file>..." to discard changes in working direct=
ory)
> >
> >         modified:   drivers/platform/x86/intel_pmc_core.c
> >         modified:   drivers/platform/x86/intel_telemetry_debugfs.c
> >
> > no changes added to commit (use "git add" and/or "git commit -a")
>
> > Andy,I don't know why.
> > Is there a problem with my operation?
>
> Definitely.
Where can I find the correct git repository=EF=BC=9F
I haven't found the correct one for a long time,
which include the commit(4ecd94b8e13b ) you said.

MBR,
Yangtao
>
> --
> With Best Regards,
> Andy Shevchenko
