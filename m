Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0FAC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7091214F1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pb7c9liU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7091214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbeLFQBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:01:32 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42312 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeLFQBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:01:31 -0500
Received: by mail-ot1-f68.google.com with SMTP id v23so845251otk.9;
        Thu, 06 Dec 2018 08:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dGsnISE4FIz3KQANOsJodhs5OOKMBBgVf9JyNqy91KY=;
        b=Pb7c9liUJiikpZkKTCPiEfgLwt/PLPzsQunOw8ew3+Lg0nErefYWMfrTyFftv7Soj1
         vnKvRjjpGTXaAPewKbn0rRp8V0WgBTlTWZHB74zIFemgWfXGy2GJQhvLTuTa6mWP/Cfy
         NudE5H/KKO9zujAfmsn0EXV31mg3DUga6A2mQFpIggfYfkGGIuo9tknd4/iV2hQKURHI
         KH0XVFj0ifaBaVmp1bvHVgjQ/MApP8ajWOkoikcbJrxgAnTqyZNOVq2OKz6VOk821LVW
         Dnx8/uPDgdUIu6NaW9yWQ5JwSPyYwuCLJKhsDw/FSpYHjc32MH1qdbsInYtXCczHzNoj
         0QBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dGsnISE4FIz3KQANOsJodhs5OOKMBBgVf9JyNqy91KY=;
        b=l7pKAetZ2r15ZnefMom0HZxXt6x9DSR7cRARIeegatR00MeS0mcb1m02kVLii1YlE6
         bb9ACCUQjw24cJUIZ1ZfobYmZZjQyYbsKb/zYpqjnwB+RkL1dAgJSx5jvUblAsJ6KA4E
         LsLk7JcR01Pl+DeX48Y3/LWrj8aRYM6mBIUqe3gUnmkG+JUm3dBkWPen+fdtyZSb6gXI
         4aNyxfS8OzHNTj7lCJ7vvOAcwMQHJkhWj+kj7dXC3nzo3wdeA34U6HADSamTte+mrIVk
         bvyXKp9BQPrnmolc7xNjA5wWmrhgxXCl9NvYg+e+HVuUJwJ3JnKjczqc1bV38DaQ8Alv
         UaBg==
X-Gm-Message-State: AA+aEWY4ymnTOf96Qh/nsdrbxJbmRBP3705mJprz9dOc52uzn5mhNuGA
        cqYqWiw1LS74KDufxDKe2ye+iG5/eCJUvfqfGQ66L6n9
X-Google-Smtp-Source: AFSGD/U2HcJuBLCF0Rzz5fG7dqBs1l/1mPF6ZVMRqidGWc0mp5Dd0H5KvetGCI3cpTmsyUeIizr8pwJ5E6bBb8Z91zY=
X-Received: by 2002:a9d:2c65:: with SMTP id f92mr18615316otb.18.1544112091176;
 Thu, 06 Dec 2018 08:01:31 -0800 (PST)
MIME-Version: 1.0
References: <20181206115053.7665-1-ganapatrao.kulkarni@cavium.com> <20181206123420.GA26473@arm.com>
In-Reply-To: <20181206123420.GA26473@arm.com>
From:   Ganapatrao Kulkarni <gklkml16@gmail.com>
Date:   Thu, 6 Dec 2018 21:31:19 +0530
Message-ID: <CAKTKpr6QHWO=G6cMS8WFM8HNpTv4ZMZeieT8QoBSYfZYBiCWqQ@mail.gmail.com>
Subject: Re: [PATCH v11 0/2] Add ThunderX2 SoC Performance Monitoring Unit driver
To:     Will Deacon <will.deacon@arm.com>
Cc:     Ganapatrao Kulkarni <Ganapatrao.Kulkarni@cavium.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>, suzuki.poulose@arm.com,
        Randy Dunlap <rdunlap@infradead.org>,
        "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>,
        Robert Richter <Robert.Richter@cavium.com>,
        Vadim.Lomovtsev@cavium.com, Jan.Glauber@cavium.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 6:04 PM Will Deacon <will.deacon@arm.com> wrote:
>
> Hi Ganapat,
>
> On Thu, Dec 06, 2018 at 11:51:24AM +0000, Kulkarni, Ganapatrao wrote:
> > This patchset adds PMU driver for Cavium's ThunderX2 SoC UNCORE devices.
> > The SoC has PMU support in L3 cache controller (L3C) and in the
> > DDR4 Memory Controller (DMC).
> >
> >
> > v11:
> >       Updated Patch 2 with minor comments.
>
> Thanks. I've pushed this out on my perf/updates branch:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=perf/updates
>
> but note that I did make some spelling and formatting changes to the
> Documentation patch, as well as removal of the event descriptions (they
> should be part of the perf tool, as is done for the other system PMUs).

Thanks Will.
>
> Will

Thanks,
Ganapat
