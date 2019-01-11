Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07557C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 04:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B680A20870
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 04:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="Q59fHcXQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbfAKEIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 23:08:41 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42206 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728393AbfAKEIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 23:08:41 -0500
Received: by mail-pf1-f193.google.com with SMTP id 64so6309602pfr.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 20:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UshM6NUyXRlQgz27vJAD5k6b+wPXY2bJIXsdtLxpWb8=;
        b=Q59fHcXQOJS6CiuwUF8XWSB/zd9vmdpFI6BLAZ5/ffYBBPnNigJ5xMmstfbQQPyhZ5
         0gOGKV81rbAX9SgGcW1LB2nvowGtppca4XdcD+yWOcFXoSvIsrb+X+/I5vV/02oI5RKw
         2LfRhdNhu81JfAQxiHISreaoWqSdCk7nLayawwiJ3xZ+CmG7wirBaFIn69LVOEzRsmYY
         e8rQ8QwaTBRIr0lGK3mXtIvz05W9uQpoNRK2Ydobw7DW0jYktUIvUmdn7Ksa4QwSxzYR
         wmb2z4yhgHc6rRhSYOp4OBIq4LOx+JzCfUFTPt6KGZAmnEiilHkSeQ/+xkhnHOFQA+HT
         0guA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UshM6NUyXRlQgz27vJAD5k6b+wPXY2bJIXsdtLxpWb8=;
        b=RvYi7qFCMAJs8h8g9g0kPzUXEcl8Oie/qeRTn7r+qqFGPBzKz9LAm51uw9FZTf9y5y
         rQvRndXyt3P1q4UtgjvipzEqQQScnhzSPUewZyQOwoZy7qvNJzXfZj6GMrGcFPJFIPW4
         EoAyW6GbMyEMgMnO7sB1PicjgrVhngBtaFJ6iAI+eklBho3pRo/FxL63J3Zb9zpr66Hi
         QjmedgcoKERFrJpycbv7j8QerNkL0G/MuA6funZA9UEfllFYONby7etYfRg+7IKV5i8w
         UWSBNAUj68CrkLDlF2sc0nRAUarsOon5YnshAgD+jcHHmrDK+/3P9Ui1p+1htoeMBbMb
         +GEg==
X-Gm-Message-State: AJcUukfMvfnc5ex7az3YcNiFplkzEj32irVWnOih7RKiuN821R97ZRnh
        aOUN6uaQdgi1mIhGo6xQOwBV1A==
X-Google-Smtp-Source: ALg8bN5/MHa4yTQ0LI5hqxpiyH6d+zg8rFb1LDwOBs7CZLP/AmapngOwQMORpwkn8p27w4BpggBKBw==
X-Received: by 2002:a62:9111:: with SMTP id l17mr12952263pfe.200.1547179720178;
        Thu, 10 Jan 2019 20:08:40 -0800 (PST)
Received: from ?IPv6:2600:1010:b053:f1a7:6de6:32aa:8366:8e00? ([2600:1010:b053:f1a7:6de6:32aa:8366:8e00])
        by smtp.gmail.com with ESMTPSA id t12sm120796110pfi.45.2019.01.10.20.08.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 20:08:39 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16C101)
In-Reply-To: <20190111040434.GN27534@dastard>
Date:   Thu, 10 Jan 2019 20:08:37 -0800
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jiri Kosina <jikos@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6955E7C1-A61C-49F3-8BB6-0624D5A70BD6@amacapital.net>
References: <20190109043906.GF27534@dastard> <CAHk-=wic28fSkwmPbBHZcJ3BGbiftprNy861M53k+=OAB9n0=w@mail.gmail.com> <20190110004424.GH27534@dastard> <CAHk-=wg1jSQ-gq-M3+HeTBbDs1VCjyiwF4gqnnBhHeWizyrigg@mail.gmail.com> <20190110070355.GJ27534@dastard> <CAHk-=wigwXV_G-V1VxLs6BAvVkvW5=Oj+xrNHxE_7yxEVwoe3w@mail.gmail.com> <20190110122442.GA21216@nautica> <CAHk-=wip2CPrdOwgF0z4n2tsdW7uu+Egtcx9Mxxe3gPfPW_JmQ@mail.gmail.com> <20190111020340.GM27534@dastard> <CAHk-=wgLgAzs42=W0tPrTVpu7H7fQ=BP5gXKnoNxMxh9=9uXag@mail.gmail.com> <20190111040434.GN27534@dastard>
To:     Dave Chinner <david@fromorbit.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 10, 2019, at 8:04 PM, Dave Chinner <david@fromorbit.com> wrote:
>=20
>> On Thu, Jan 10, 2019 at 06:18:16PM -0800, Linus Torvalds wrote:
>>> On Thu, Jan 10, 2019 at 6:03 PM Dave Chinner <david@fromorbit.com> wrote=
:
>>>=20
>>>> On Thu, Jan 10, 2019 at 02:11:01PM -0800, Linus Torvalds wrote:
>>>> And we *can* do sane things about RWF_NOWAIT. For example, we could
>>>> start async IO on RWF_NOWAIT, and suddenly it would go from "probe the
>>>> page cache" to "probe and fill", and be much harder to use as an
>>>> attack vector..
>>>=20
>>> We can only do that if the application submits the read via AIO and
>>> has an async IO completion reporting mechanism.
>>=20
>> Oh, no, you misunderstand.
>>=20
>> RWF_NOWAIT has a lot of situations where it will potentially return
>> early (the DAX and direct IO ones have their own), but I was thinking
>> of the one in generic_file_buffered_read(), which triggers when you
>> don't find a page mapping. That looks like the obvious "probe page
>> cache" case.
>>=20
>> But we could literally move that test down just a few lines. Let it
>> start read-ahead.
>>=20
>> .. and then it will actually trigger on the *second* case instead, where w=
e have
>>=20
>>                if (!PageUptodate(page)) {
>>                        if (iocb->ki_flags & IOCB_NOWAIT) {
>>                                put_page(page);
>>                                goto would_block;
>>                        }
>>=20
>> and that's where RWF_MNOWAIT would act.
>>=20
>> It would still return EAGAIN.
>>=20
>> But it would have started filling the page cache. So now the act of
>> probing would fill the page cache, and the attacker would be left high
>> and dry - the fact that the page cache now exists is because of the
>> attack, not because of whatever it was trying to measure.
>>=20
>> See?
>=20
> Except for fadvise(POSIX_FADV_RANDOM) which triggers this code in
> page_cache_sync_readahead():
>=20
>        /* be dumb */
>        if (filp && (filp->f_mode & FMODE_RANDOM)) {
>                force_page_cache_readahead(mapping, filp, offset, req_size)=
;
>                return;
>        }
>=20
> So it will only read the single page we tried to access and won't
> perturb the rest of the message encoded into subsequent pages in
> file.
>=20

There are two types of attacks.  One is an intentional side channel where tw=
o cooperating processes communicate. This is, under some circumstances, a pr=
oblem, but it=E2=80=99s not one we=E2=80=99re about to solve in general. The=
 other is an attacker monitoring an unwilling process. I think we care a lot=
 more about that, and Linus=E2=80=99 idea will help.=
