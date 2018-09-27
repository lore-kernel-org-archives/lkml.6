Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6CAC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6232152A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hnwfSA8u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA6232152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbeI0UrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:47:06 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:51234 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbeI0UrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:47:06 -0400
Received: by mail-it1-f194.google.com with SMTP id 74-v6so6434494itw.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 07:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2JPXstb3jFGY09mSuU+vjFgBbqeibpUZ+oSlX/v1qU4=;
        b=hnwfSA8uB3SL7j14wt5lvniIYKXVOc41ePp/Iduf7P2pVhVYq0RbTgJOsts26sqY+3
         Bfqd6bAJmhuWD15LRiq8ZN/BbzKXCUigKhkbWUWSD+ZzZ6cC6RC/nUZOd2udyGLDNVpz
         egqwmWnjghbqaeOH/R1Q73kzDUgwbVorjJYD0otEMzwsZP1QFAxurivx+T7SUYo4NkLS
         zXoR/8w0Sj/xJCqCtC5XYoBadEKd6SMW7sixPw8Dqc4+ikPevXk4Ou6gH9Knyp8pS3pT
         7vIzxu9HSU3IDcQh3hmXAJFp20FOxv9Wa/i14CzEV4DfdZV3hNCkjTctwCrEEfHmEF6T
         1uPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2JPXstb3jFGY09mSuU+vjFgBbqeibpUZ+oSlX/v1qU4=;
        b=DZAcFefD7N1l+bsjP2jXTh0li+qW/JWkL1QPee44MXowC0OCcGifTkT/2mRye2oVNd
         Uz6Zfn74BngobkeKbtAHiyACXk8wsib/X/bNF3HhUFyiZn5mERI7OssmNY9TjxCHY+0U
         q7w47Bd/o0vvwSrQ/HnxIBE8id0M299YD0tC/CQlOEjuL+Jf7fZJQw6bMhbs1V5LOApT
         HA3JRgDu5q2TG9Mtf22k/ZlTrRZLup3HFAxqFYxsegorwES0VVYirjY4ojZU3RKahmlY
         mrqMK71S2BXDlOCwJNBECgR13oZ2Xne7Iev9kfvNKyMRih2puXREFi/93CQMx8nwPjLy
         Bv1A==
X-Gm-Message-State: ABuFfogVZfM/MWfq1SX42yUVhVuxAT5BAwwvxxsLET0FrpZtaPphtMYJ
        1c4rIwt3XAr/G0MXXezSDJ+czK3xq1bZW0lGDBpYCw==
X-Google-Smtp-Source: ACcGV63O4zscNJeQgNuIPbIQFi6lzWQCm3gMAPFf7TwqASc1U2PtLC/JraYpUkWtaE12sjrubMY1bckULvG5jKPYDCM=
X-Received: by 2002:a02:88f7:: with SMTP id b52-v6mr10300472jak.25.1538058513132;
 Thu, 27 Sep 2018 07:28:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:ab8c:0:0:0:0:0 with HTTP; Thu, 27 Sep 2018 07:28:12
 -0700 (PDT)
In-Reply-To: <010001661b631a3e-f398fc0a-127c-4c6e-b6ca-b2bd63bc4a9a-000000@email.amazonses.com>
References: <000000000000e5f76c057664e73d@google.com> <CAKdAkRS7PSXv65MTnvKOewqESxt0_FtKohd86ioOuYR3R0z9dw@mail.gmail.com>
 <CACT4Y+YOb6M=xuPG64PAvd=0bcteicGtwQO60CevN_V67SJ=MQ@mail.gmail.com>
 <010001660c1fafb2-6d0dc7e1-d898-4589-874c-1be1af94e22d-000000@email.amazonses.com>
 <CACT4Y+ayX8vzd2JPrLeFhf3K_Quf4x6SDtmtkNJuwNLyOh67tQ@mail.gmail.com>
 <010001660c4a8bbe-91200766-00df-48bd-bc60-a03da2ccdb7d-000000@email.amazonses.com>
 <20180924184158.GA156847@dtor-ws> <CACT4Y+ZPrngv8GTC-Cw68PBDxZ2T5x1kKMNXL3DmP24Xd0m_5g@mail.gmail.com>
 <01000166110bb882-0b1fa048-fe1c-4139-a1ba-702754bbc267-000000@email.amazonses.com>
 <CACT4Y+aUdAmRmgiV5-KWXF-eGoCUCMhUC+ddLU-heQTQ53PhRA@mail.gmail.com> <010001661b631a3e-f398fc0a-127c-4c6e-b6ca-b2bd63bc4a9a-000000@email.amazonses.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 27 Sep 2018 16:28:12 +0200
Message-ID: <CACT4Y+biYtFUV7hK2ne2RfrbZjMt=4FK4deE0B6WykwT2qSt2g@mail.gmail.com>
Subject: Re: WARNING: kmalloc bug in input_mt_init_slots
To:     Christopher Lameter <cl@linux.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        syzbot+87829a10073277282ad1@syzkaller.appspotmail.com,
        Pekka Enberg <penberg@kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 4:16 PM, Christopher Lameter <cl@linux.com> wrote:
> On Thu, 27 Sep 2018, Dmitry Vyukov wrote:
>
>> On Tue, Sep 25, 2018 at 4:04 PM, Christopher Lameter <cl@linux.com> wrote:
>> > On Tue, 25 Sep 2018, Dmitry Vyukov wrote:
>> >
>> >> Assuming that the size is large enough to fail in all allocators, is
>> >> this warning still useful? How? Should we remove it?
>> >
>> > Remove it. It does not make sense because we check earlier if possible
>> > without the warn.
>>
>> Mailed "mm: don't warn about large allocations for slab" to remove the warning.
>>
>
> Hoe it arrives here at some point.

It's here:
https://lore.kernel.org/patchwork/patch/992660/
