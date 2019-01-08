Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5811BC43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 288CD20883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIdzqI4z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbfAHPdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 10:33:11 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46926 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbfAHPdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 10:33:11 -0500
Received: by mail-pf1-f196.google.com with SMTP id c73so2071134pfe.13;
        Tue, 08 Jan 2019 07:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FGk5RZmfmPt1xkmRzBtKE3trE9Sxmrlvu+fkpWw0lRc=;
        b=MIdzqI4zaFL8Ti3gNI939pQV1bW+rJ0lTx56KI9Ip6ix7MQ9iSGu9m8cN0jyM/vm8f
         jTSUtOKDpkCnDzFtaRUVNBOwr+gA36CJg4t7gctoaaQOdx1293PkUuhQEZSS6jiyf3YA
         JzQfgDEKfbYyjDIw4TBZZevA1NAVpvNrKhyyX9Ykv8l6Za5mqvOnjLpksZ7K9MHNE+pD
         wFOfzNgTpdE+yoVanMAGdOjesPGYjZxLAyFpjpv+P+sp5fWyoy+2cFURE6nPcD1r5LsY
         oNCkluQWVSYI6pyK6dz/rgOeX9XkyJQzlIlBDO4hDB9Ye7jSaDLWJ1cWBTmTuUBIxJlR
         WBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FGk5RZmfmPt1xkmRzBtKE3trE9Sxmrlvu+fkpWw0lRc=;
        b=mSe9W4CoE7S5/OkyGtwyxnBLKQ+/IeX76LhrXgN//Wbjshivm4I/upvprLvLcbazNi
         u+ubVSoO8huNzuJVRIXen3NT4kd5XiFZyP+6q1rj077X4ExzzCgdz3SFy/mn5oFw8wYd
         9BmCEshL5QcqUxvWa0n4Pg2xATYXD1CCPsN6RNERKnGuH5hUYD1exy8yVvyCQndJpXhM
         KnaUTEZDFGTjjnaaS1OW+hN9IChagp5FtI+FClfIOpUY0ZCmfSj9ldvXBm3vYn6z25OE
         kbBGmNHT7Q6N9b4eQf/etlK91eHGYyY7k+j7KPWsNkCL3zjDiYqVV33ffzTaGh5gAHN5
         Xzvg==
X-Gm-Message-State: AJcUukd/SYCmWsHqL73uhmdXuAD1mFXG+f1hevH+Lkyuw8a5TGDT2K0w
        bqg0Xbntjeb1WeC+LBEGkSRsuW+aAOisRprFUBk=
X-Google-Smtp-Source: ALg8bN4C3FJRlaN4gbMxFWyYXXmLMxmfLs4PdUKkKcJRaS7F/tQIJv59Scd5qJnijKCVJiG/0Cddlz+v77CyYnBYatA=
X-Received: by 2002:a63:20e:: with SMTP id 14mr1906156pgc.161.1546961590274;
 Tue, 08 Jan 2019 07:33:10 -0800 (PST)
MIME-Version: 1.0
References: <20180929084038.an6pfhnsd6tblejl@pali> <20181002081654.jxesr3kj62snzez5@pali>
 <510499199.34825028.1538469850257.JavaMail.zimbra@redhat.com>
 <20181012091941.o22srnhse4kzqjhf@fatal.se> <20181114113341.yx2wlzqku5yh3k4h@pali>
 <CAPXf_qN66-Mi+o+9ENGqCDe-_2tHaf9uM3moRcCGNvmxwH3ExQ@mail.gmail.com>
 <20181206083828.4bp3oypkto2ngobu@pali> <20181212135736.xtb57r2eatqsgenb@pali>
 <20181217095004.c6c6itvyfp7cf3ta@pali> <20181227221748.zsz6bwqqia7ybfwj@pali>
In-Reply-To: <20181227221748.zsz6bwqqia7ybfwj@pali>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 8 Jan 2019 17:32:55 +0200
Message-ID: <CAHp75VfJpy572t8swsEsz0kPKfpOE-v0SZVxM2aakX0hkjX4=Q@mail.gmail.com>
Subject: Re: Future of dosfstools project (FAT)
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     Andreas Bombe <andreas.bombe@gmail.com>,
        Andreas Henriksson <andreas@fatal.se>,
        Jaroslav Skarvada <jskarvad@redhat.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        util-linux@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mpluskal@suse.com, base-system@gentoo.org,
        Karel Zak <kzak@redhat.com>, Andreas Bombe <aeb@debian.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Richard Weinberger <richard.weinberger@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 12:18 AM Pali Roh=C3=A1r <pali.rohar@gmail.com> wro=
te:
> On Monday 17 December 2018 10:50:04 Pali Roh=C3=A1r wrote:
> > On Wednesday 12 December 2018 14:57:36 Pali Roh=C3=A1r wrote:

> > Thanks for review of #94! As next you can take #92 from list.
>
> Andreas, can you look at next pull requests?

Looking from a side how slow this is being processed I think the best
option to fork and abandon the old project if author / maintainer by
some reason wouldn't like to give a push rights.

--=20
With Best Regards,
Andy Shevchenko
