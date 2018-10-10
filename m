Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E849FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96782086E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HBNyVYvh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A96782086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbeJJX77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 19:59:59 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:40157 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbeJJX77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 19:59:59 -0400
Received: by mail-it1-f194.google.com with SMTP id i191-v6so8916288iti.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 09:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5pLrEX8aKiFORwIa2j4zls0X1nMxYq5uiIukvN+NTys=;
        b=HBNyVYvhCqMBOQXkU5ZtYA4b2dr7VV8ybDuHC7vJhnmeXxZ/ZNH1xGQsHFrTQysHT2
         FCzjNphJmJ/xXR3ZWe1zV3p5acwP/LmifgjCD8i1D4Tx3nKJKWN8//sBUBwCMn9Eq2B6
         jwBDN0r81MF3onWAZqRivB20Vr1pi/E4UCARtmhFfFKwIVQfdo6zKaaHaLwb1f2chibu
         RRLTk6X7/42wNLHFp1/97CuYJ9zav5MvOr4Wc1h3/GggGdUZyf/qMFa+69hJVi+VUY7p
         htLVwkv+ntVyqZjHeVeUEzikZUjssObPPbT1dsNpWf+CY3B5qUDSObIkWTfClQF/6wYL
         cuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5pLrEX8aKiFORwIa2j4zls0X1nMxYq5uiIukvN+NTys=;
        b=Hu2xmj1UgHc88l/CSHcYyEPN6QWlB83Zt7VoG7uIoIFKpDSMBBWzNmQgGs2J4Aavq2
         esfkcwoQPh2nKcUGCn9nD3t54Gf+WFANH9Bqxzfl1MmDWDCyKaZos4xOtgWd3KmXqyLr
         F8ynpwoCAoi5MwdizzYCwjfJIMmSFzHpq4qx/DgTYY0C7vR2Nd/UiF3QrP5Wf6o91kty
         uqU+azdG49LwN2SWkPxZnf2hFf6QbumUGrCxIKCI4u+nNWv5alNMr8UMbaTI2DGTknZW
         gS8KJ789rIyVZsY9Tmz6RRvpRui79t68GxsTUW0Mwi+zPyy9dnfxux2iVHtv016L/FM9
         L9DA==
X-Gm-Message-State: ABuFfohzJ30bOH3oH3lujt4AoscsaIMplHQBtLj/kAlgGowgnQmiE/Xl
        fTXp5d4sit1OI052dfM49VNmWMtHeD9JUTp5jrjHUg==
X-Google-Smtp-Source: ACcGV61C0GW/Nkulu07rdV3+ygybeuwb5xcseeJGViLyXh2ItZwOh2w9CH5UuHbj23FYcspdOjfWoKm6XXzPl4x2Poo=
X-Received: by 2002:a24:f584:: with SMTP id k126-v6mr1287821ith.166.1539189421567;
 Wed, 10 Oct 2018 09:37:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Wed, 10 Oct 2018 09:36:40
 -0700 (PDT)
In-Reply-To: <20181010161003.GA5371@nautica>
References: <20181010144855.GB20918@nautica> <00000000000010889e0577e0f5f2@google.com>
 <20181010160022.GD20918@nautica> <20181010161003.GA5371@nautica>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 10 Oct 2018 18:36:40 +0200
Message-ID: <CACT4Y+ayTAyRghU5VmJgBdKaHxNCyoXf0NxXLgMGQf8aiY37Tg@mail.gmail.com>
Subject: Re: Re: BUG: corrupted list in p9_read_work
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     syzbot <syzbot+2222c34dc40b515f30dc@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        netdev <netdev@vger.kernel.org>,
        Ron Minnich <rminnich@sandia.gov>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 6:10 PM, Dominique Martinet
<asmadeus@codewreck.org> wrote:
> Dominique Martinet wrote on Wed, Oct 10, 2018:
>> It works though, is it just picky because I didn't end it in .git? let's
>> try again, sorry for the noise...
>>
>> #syz test: git://github.com/martinetd/linux.git e4ca13f7d075e551dc158df6af18fb412a1dba0a
>
> And I guess the commit hash needs to be in the default clone branch to
> work ?
> ('git fetch <repo> <hash>' happily fetches the commit in a new clone for
> me... But that feels like a github specific behaviour maybe)

yeeeep, this is bug:
https://github.com/google/syzkaller/issues/728

Turns out git fetch of a named remote and just a tree work
differently. The latter only fetches the main branch.

'git fetch <repo> <hash>' is it a thing? Is it something that requires
special server configuration? I remember something similar that wasn't
able to fetch a random commit hash all the time...

The plan was to make a named remote and then fetch it, this should
fetch everything.


> Oh, well; made a branch for it, last try for me.
>
> #syz test: git://github.com/martinetd/linux.git for-syzbot
>
> --
> Dominique
