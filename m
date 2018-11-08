Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3095CC46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82CD2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5AvSY7A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E82CD2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeKHT0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 14:26:51 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37356 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbeKHT0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 14:26:51 -0500
Received: by mail-vs1-f68.google.com with SMTP id h18so11232548vsj.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 01:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+fdqrZGWaYe24d3IZyFZ6tMU0m7UiAizlKQbjnRGHdg=;
        b=P5AvSY7AYsuxl55FTwAw1OoiNjU4KTmN7SqJc28xuq5+j1GAp+EWLcV6tXiBgKpkMU
         HBGbPuF3n1w6foomY/39M5raOI+RsxVAwRErGZxLmFEbslmfp7Gtw+c9GSzgXOeABqc8
         xA5JAICZk4kIG3jQawPs4oDN6904pyWhuz9raOqFuXMuBMiRCOI61sNqZ5E3fZIRfqv2
         fbxhZPKtxvnUwLxqaVFPzGpaiRfEKsVwqyaLhZg0Da4pY9t2bqTGPDLh/b7FqH1bFjPC
         SSkx2WWfsloYkIDvg7mWE4R/s1BhCGK61mkIzdnuodw5i2h1GKF2uVqqsveV7Fw64k1i
         7aSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+fdqrZGWaYe24d3IZyFZ6tMU0m7UiAizlKQbjnRGHdg=;
        b=ClXKkoOfReRCcQM5Un8i9KRVoDsKARc5BzlUuMazV6w48zVSjIJzVln9RG83dzS+PJ
         Sb9tf2z6lSWzSfVUJ7ZGt3WWu4fB7WjGOaqVYBX76iSBCwUt6AEC54zKoy7kl10hkmWG
         brwZW4RAuZP8gCMbRugDJFBahzZPZmjNONii/xUiIG5RYCXYxEHeK0TJpZ3zUk8mf+NN
         C3037iRhEFAMVLdBj3Sd6/cvdzubMTn0Phi5VxUPcHBE8+6FUwg3XkNa6erJ167nrrmw
         SuHmb15TAsWCpX9OvRyaWcrfPTG+VGNdbmBLHQReEuLQ/5qXTnSkjpD8LlCWrViLwbIJ
         qSRw==
X-Gm-Message-State: AGRZ1gI6dvvfTkt8hnOfCnWgQceYLLDgyl5CKBUexHY/9gx3dizZLITZ
        3EYK8DyIMmyV5pezoAnmHBMwlRvZZbUQSnjsXgYiEA==
X-Google-Smtp-Source: AJdET5dlx5PpcOF6f8pQtDqiayBy28Ga2q62qg+YgXUMzlymseLnPW5aLxXNmWQzpVyJkuLnkdmnkcyzV74ussfCNdw=
X-Received: by 2002:a67:f756:: with SMTP id w22mr1624766vso.30.1541670729401;
 Thu, 08 Nov 2018 01:52:09 -0800 (PST)
MIME-Version: 1.0
References: <CAOuPNLjuM5qq3go9ZFZcK0G5pQxTQb0DY36xu+8SL4vC4zJntw@mail.gmail.com>
 <20181105155815.i654i5ctmfpqhggj@angband.pl> <79d0c96a-a0a2-63ec-db91-42fd349d50c1@gmail.com>
In-Reply-To: <79d0c96a-a0a2-63ec-db91-42fd349d50c1@gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Thu, 8 Nov 2018 15:21:58 +0530
Message-ID: <CAOuPNLi4GS_xbqugQSbQJygSeKFnaNyq1e7DguSpPbY2TfMyaw@mail.gmail.com>
Subject: Re: Creating compressed backing_store as swapfile
To:     ahferroin7@gmail.com
Cc:     kilobyte@angband.pl, linux-mm@kvack.org,
        open list <linux-kernel@vger.kernel.org>,
        kernelnewbies@kernelnewbies.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 9:37 PM Austin S. Hemmelgarn
<ahferroin7@gmail.com> wrote:
>
> On 11/5/2018 10:58 AM, Adam Borowski wrote:
> > On Mon, Nov 05, 2018 at 08:31:46PM +0530, Pintu Agarwal wrote:
> >> Hi,
> >>
> >> I have one requirement:
> >> I wanted to have a swapfile (64MB to 256MB) on my system.
> >> But I wanted the data to be compressed and stored on the disk in my swapfile.
> >> [Similar to zram, but compressed data should be moved to disk, instead of RAM].
> >>
> >> Note: I wanted to optimize RAM space, so performance is not important
> >> right now for our requirement.
> >>
> >> So, what are the options available, to perform this in 4.x kernel version.
> >> My Kernel: 4.9.x
> >> Board: any - (arm64 mostly).
> >>
> >> As I know, following are the choices:
> >> 1) ZRAM: But it compresses and store data in RAM itself
> >> 2) frontswap + zswap : Didn't explore much on this, not sure if this
> >> is helpful for our case.
> >> 3) Manually creating swapfile: but how to compress it ?
> >> 4) Any other options ?
> >
> > Loop device on any filesystem that can compress (such as btrfs)?  The
> > performance would suck, though -- besides the indirection of loop, btrfs
> > compresses in blocks of 128KB while swap wants 4KB writes.  Other similar
> > option is qemu-nbd -- it can use compressed disk images and expose them to a
> > (local) nbd client.
>
> Swap on any type of a networked storage device (NBD, iSCSI, ATAoE, etc)
> served from the local system is _really_ risky.  The moment the local
> server process for the storage device gets forced out to swap, you deadlock.
>
> Performance isn't _too_ bad for the BTRFS case though (I've actually
> tested this before), just make sure you disable direct I/O mode on the
> loop device, otherwise you run the risk of data corruption.

Sorry, btrfs is not an option for us. We want something more lighter
weight as our requirement is just < 200 MBs.
