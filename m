Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295E1C10F02
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF87521B18
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1MMCNnR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388940AbfBOUEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 15:04:35 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37677 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfBOUEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 15:04:35 -0500
Received: by mail-pf1-f193.google.com with SMTP id s22so5335039pfh.4;
        Fri, 15 Feb 2019 12:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fOZGFRQl45f1Ym24WEhg7VeKHjMFtcXeLiFEtULushQ=;
        b=P1MMCNnRfb1B0VKf20P2J2zaygosW/d26D5nxb3/eWQT4B56+NDfaS7lIs0x/WzuER
         vEe29iCuNBkBibDXiFR+O1K+cejOPCG9eUHb4QvD5m1p8DVA7pJq9e6uezDmEDz36HA1
         SsbBGoLWH6l6JwWRh3vpwbiLrzKz5GNCPg3JdQ8WLx6lJu9+GaBDRL6XR6VR6CEm8ZVt
         gvvgh5KJ1L6pSbaxNreWMxqO79BZ/0NAu1Kh0J/Nm9NmGbI6soNyV0TsCSZFGPZNPum3
         fhnlp6yFi2k+GwkqJRxGa9kT8+vrWGuhWVec/W5T+Jp4zR5Id4ycfVAZtnmocx4O7c/b
         x/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fOZGFRQl45f1Ym24WEhg7VeKHjMFtcXeLiFEtULushQ=;
        b=oBD5XCy+lAvQV06gBcbiaHr7QKNH89Dgec3x5OyLQJKl6m/7C3vp/A07VjbNnXIZR1
         02PJJUi0RAfymQlly3xWPLJbBhRvU/EF6nJXS1c1puK3AAUFm51ZJRAhDZMgCHcnWbWk
         qsUlfsomZ1zePIXe/uicftqj3l+9TdJrBlGXRMeOtYJC4AFIb0RvDBxWfVePgHh2QN8n
         FqhBl7BGqAzT5j6rhepKzQS2XeNxTRyY+IUiko1gX/3+dd10liM7M/SVHo61cidYoXMt
         PShKlYiZNs3I/tn6A3kekukwFaD/S0UP+k65bgC5WMWppFcKs6n3fGAeP1BHtTrakfZh
         iSaw==
X-Gm-Message-State: AHQUAuZbGqJ0cA8+SobTBjSNsLamZz7UGOiNHYmJDthqHlccApmTqJp9
        3UW5Bl8d/Be1br/BKYeIcs8OCPYLeDJL1WJPQZw=
X-Google-Smtp-Source: AHgI3Ia7BvN5XS70DHtxGE9DmVGRtRpWj5u+PDGdv90Yn/wKvR3LqEwbqLxLR3s3exZcQsg+OUlFJgvzK0eBIgyxnvQ=
X-Received: by 2002:a63:20e:: with SMTP id 14mr6990000pgc.161.1550261074326;
 Fri, 15 Feb 2019 12:04:34 -0800 (PST)
MIME-Version: 1.0
References: <20181002081654.jxesr3kj62snzez5@pali> <510499199.34825028.1538469850257.JavaMail.zimbra@redhat.com>
 <20181012091941.o22srnhse4kzqjhf@fatal.se> <20181114113341.yx2wlzqku5yh3k4h@pali>
 <CAPXf_qN66-Mi+o+9ENGqCDe-_2tHaf9uM3moRcCGNvmxwH3ExQ@mail.gmail.com>
 <20181206083828.4bp3oypkto2ngobu@pali> <20181212135736.xtb57r2eatqsgenb@pali>
 <20181217095004.c6c6itvyfp7cf3ta@pali> <20181227221748.zsz6bwqqia7ybfwj@pali>
 <CAHp75VfJpy572t8swsEsz0kPKfpOE-v0SZVxM2aakX0hkjX4=Q@mail.gmail.com> <20190209154004.fwsfajwg75dadfbd@pali>
In-Reply-To: <20190209154004.fwsfajwg75dadfbd@pali>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 15 Feb 2019 22:04:23 +0200
Message-ID: <CAHp75VdD9pZLTXwJ9WcHcNCqu6nAk8VGaBL74e+Sy8bXnV5xrQ@mail.gmail.com>
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

On Sat, Feb 9, 2019 at 5:40 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrote=
:
>
> On Tuesday 08 January 2019 17:32:55 Andy Shevchenko wrote:
> > On Fri, Dec 28, 2018 at 12:18 AM Pali Roh=C3=A1r <pali.rohar@gmail.com>=
 wrote:
> > > On Monday 17 December 2018 10:50:04 Pali Roh=C3=A1r wrote:
> > > > On Wednesday 12 December 2018 14:57:36 Pali Roh=C3=A1r wrote:
> >
> > > > Thanks for review of #94! As next you can take #92 from list.
> > >
> > > Andreas, can you look at next pull requests?
> >
> > Looking from a side how slow this is being processed I think the best
> > option to fork and abandon the old project if author / maintainer by
> > some reason wouldn't like to give a push rights.
>
> Just quick update: I got github permission for merging pull requests.
> I already merge some small changes. Others needs and waiting for review.

Good news for the project, thanks, Pali!

--=20
With Best Regards,
Andy Shevchenko
