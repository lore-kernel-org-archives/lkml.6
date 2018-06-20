Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2020C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8668620693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBoi/vVZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8668620693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754340AbeFTAbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:31:40 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:43242 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752827AbeFTAbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:31:32 -0400
Received: by mail-pg0-f67.google.com with SMTP id a14-v6so617783pgw.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 17:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3ZpeC+UKztRPWYDWnPsFG1JxhFy8L83OScTNK3MFdtw=;
        b=CBoi/vVZqpjc2zc8Z08/9ywE3+AKseZY/kpGOPg3yhmbchrlwisKhMhqaJ3C1YdnuV
         JMXj80jC6vqTnECJdM6EvzXiCn4elgw94jXL1fAuHB417/MS+jlUcjA0w8R0c5nkWbrx
         ZT3SzK724shJi6HKqI2yS6frv4w+YysQCpsOlZHhNoDMzIsp+/w6d+F4VlWZDrIhabhj
         QAAADAzqMWO01dkhzKpa6QD0JY2hMfXmVerSn1zWRC++is+B9UyDv61aUGsogLw6mol9
         xPO3YqegMvqyb+RzY1xSbghRgkiKJse4G+GQ2FaxDSfHaagwHpwnvLE5RdUfe3UK0Osq
         wBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3ZpeC+UKztRPWYDWnPsFG1JxhFy8L83OScTNK3MFdtw=;
        b=CVyW8nwzAQ6tLjhZpWJBk7WruUERyl/+K1sHHbsd4zcr33UDDDFWL9ck6YVjmf/US3
         mzf9uZHTUPnZSSGwf+pq0Y6VgnIg84+yC0qZIgMD9HQ3DbVoMHsXF8+kj05Tnnt6YV5X
         ntykfPjCsP9mn/lU3TGgznwvW/BWlGSSXYrlxY/R7M8/f6RHdQwuwjl4DLTAAD86mtda
         76bTH/oS56hOjl+YNmJKP3nLbNH9q8OVSOks+2WVJnxxDPgU1L/6wGgxZMaJROX+J5f9
         hpPgd5TpikE+f2i9/nuGWEKZHfQ1lOLfLze/dbTosrRZpyJYsq4ZSNzvP6cGA7H59O2J
         pO3w==
X-Gm-Message-State: APt69E0aQC0r0164F5X05J3zpiv0sA3WOjwZ/Y/eRqCK562d860pqBvT
        PFAsdLH7tT9SSkqlJGDHZjM=
X-Google-Smtp-Source: ADUXVKLCZurRip6OCP3Zg1sZLNoKe1S1fLO5OaULRTAim+g2P4DVe9VFg9oKdSEPXi1HMew/bGk3pA==
X-Received: by 2002:a63:b305:: with SMTP id i5-v6mr16840142pgf.370.1529454691572;
        Tue, 19 Jun 2018 17:31:31 -0700 (PDT)
Received: from [10.2.101.129] ([208.91.2.2])
        by smtp.gmail.com with ESMTPSA id e131-v6sm117604pgc.6.2018.06.19.17.31.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 17:31:31 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [RFC v2 PATCH 2/2] mm: mmap: zap pages with read mmap_sem for
 large mapping
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <158a4e4c-d290-77c4-a595-71332ede392b@linux.alibaba.com>
Date:   Tue, 19 Jun 2018 17:31:27 -0700
Cc:     Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        ldufour@linux.vnet.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BFD6A249-B1D7-43D5-8D7C-9FAED4A168A1@gmail.com>
References: <1529364856-49589-1-git-send-email-yang.shi@linux.alibaba.com>
 <1529364856-49589-3-git-send-email-yang.shi@linux.alibaba.com>
 <3DDF2672-FCC4-4387-9624-92F33C309CAE@gmail.com>
 <158a4e4c-d290-77c4-a595-71332ede392b@linux.alibaba.com>
To:     Yang Shi <yang.shi@linux.alibaba.com>
X-Mailer: Apple Mail (2.3445.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 4:08 PM, Yang Shi <yang.shi@linux.alibaba.com> wrote:

>=20
>=20
> On 6/19/18 3:17 PM, Nadav Amit wrote:
>> at 4:34 PM, Yang Shi <yang.shi@linux.alibaba.com>
>>  wrote:
>>=20
>>=20
>>> When running some mmap/munmap scalability tests with large memory =
(i.e.
>>>=20
>>>> 300GB), the below hung task issue may happen occasionally.
>>>>=20
>>> INFO: task ps:14018 blocked for more than 120 seconds.
>>>       Tainted: G            E 4.9.79-009.ali3000.alios7.x86_64 #1
>>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
>>> message.
>>> ps              D    0 14018      1 0x00000004
>>>=20
>>>=20
>> (snip)
>>=20
>>=20
>>> Zapping pages is the most time consuming part, according to the
>>> suggestion from Michal Hock [1], zapping pages can be done with =
holding
>>> read mmap_sem, like what MADV_DONTNEED does. Then re-acquire write
>>> mmap_sem to manipulate vmas.
>>>=20
>> Does munmap() =3D=3D MADV_DONTNEED + munmap() ?
>=20
> Not exactly the same. So, I basically copied the page zapping used by =
munmap instead of calling MADV_DONTNEED.
>=20
>>=20
>> For example, what happens with userfaultfd in this case? Can you get =
an
>> extra #PF, which would be visible to userspace, before the munmap is
>> finished?
>>=20
>=20
> userfaultfd is handled by regular munmap path. So, no change to =
userfaultfd part.

Right. I see it now.

>=20
>>=20
>> In addition, would it be ok for the user to potentially get a zeroed =
page in
>> the time window after the MADV_DONTNEED finished removing a PTE and =
before
>> the munmap() is done?
>>=20
>=20
> This should be undefined behavior according to Michal. This has been =
discussed in  https://lwn.net/Articles/753269/.

Thanks for the reference.

Reading the man page I see: "All pages containing a part of the =
indicated
range are unmapped, and subsequent references to these pages will =
generate
SIGSEGV.=E2=80=9D

To me it sounds pretty well-defined, and this implementation does not =
follow
this definition. I would expect the man page to be updated and indicate =
that
the behavior has changed.

Regards,
Nadav=
