Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015B9C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 01:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91FD120856
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 01:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R02dLmt8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91FD120856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388572AbeGYC3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 22:29:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39502 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388420AbeGYC3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 22:29:05 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6P1JH9O154095
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 01:19:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=31x20a6kd5ukTj3NWOTNexqTl8nWWBmSCyUfbXPtzqg=;
 b=R02dLmt8SmUGuyMMXUEECDQQijK0xHp2XB7ObmZBOBIe0g+ip3WoTxjWb+vaVt1hclfS
 RNqXALAmXF3A5Va35aA/PmCc2jFxeOq5Djgkxw9Sp810j3+exg1HSj328EyTNF56e2hC
 Qxpzo6HztBnoqwYxTJwlKOPncMOYjafg2MWqmGQufgKamNs1m4QP3dSrq6hjp8k4F3m3
 qtVS3AwpsUV9AMcW4hXmNwFEpd2Rk1O5uL3M11jy4UqPiE8nez4ueqiZTxaeBuOMchoU
 izFJTUo1RQZNvP2Z01JpGRM3zZbYrsQpr+ojM7Gibv7uqu5GMJXYaAUonBsj5AMBUUmd JQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2kbwfpuby5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 01:19:53 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6P1JqhB018290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 01:19:52 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6P1JqiJ030691
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 01:19:52 GMT
Received: from mail-oi0-f42.google.com (/209.85.218.42)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 24 Jul 2018 18:19:52 -0700
Received: by mail-oi0-f42.google.com with SMTP id d189-v6so10979841oib.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 18:19:52 -0700 (PDT)
X-Gm-Message-State: AOUpUlGy5Ygh/xHmBjE4pEKcjzgIxUKZhn7uq0KG6ZW4wkfMdoKjAGZQ
        J/52vl9h3W1lMUkOu0pPl71yzIU51ysLjn7mC4c=
X-Google-Smtp-Source: AAOMgpdMTX7uW4G5i47bfXKR3TuxdOGY3B541duayW0ZeKMqJbApW2L8woLJuqruZdYVYuIhaeMMF5hp0B+2kM8TqEc=
X-Received: by 2002:aca:da88:: with SMTP id r130-v6mr1294196oig.163.1532481592122;
 Tue, 24 Jul 2018 18:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180724235520.10200-1-pasha.tatashin@oracle.com>
 <20180724235520.10200-3-pasha.tatashin@oracle.com> <20180724181218.13a1ed1d7a3e9a37e35707a9@linux-foundation.org>
In-Reply-To: <20180724181218.13a1ed1d7a3e9a37e35707a9@linux-foundation.org>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Tue, 24 Jul 2018 21:19:11 -0400
X-Gmail-Original-Message-ID: <CAGM2reb9CLpq1cqPLVqYXEfUqBtCt4V0OL_F=CKCyJXqV88NcQ@mail.gmail.com>
Message-ID: <CAGM2reb9CLpq1cqPLVqYXEfUqBtCt4V0OL_F=CKCyJXqV88NcQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: calculate deferred pages after skipping mirrored memory
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kirill.shutemov@linux.intel.com, Michal Hocko <mhocko@suse.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        dan.j.williams@intel.com, jack@suse.cz, jglisse@redhat.com,
        Souptick Joarder <jrdr.linux@gmail.com>, bhe@redhat.com,
        gregkh@linuxfoundation.org, Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@gmail.com>, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org,
        osalvador@techadventures.net, abdhalee@linux.vnet.ibm.com,
        mpe@ellerman.id.au
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8964 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=782
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807250012
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 9:12 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 24 Jul 2018 19:55:19 -0400 Pavel Tatashin <pasha.tatashin@oracle.com> wrote:
>
> > update_defer_init() should be called only when struct page is about to be
> > initialized. Because it counts number of initialized struct pages, but
> > there we may skip struct pages if there is some mirrored memory.
>
> What are the runtime effects of this error?

I found this bug by reading the code. The effect is that fewer than
expected struct pages are initialized early in boot, and it is
possible that in some corner cases we may fail to boot when mirrored
pages are used. The deferred on demand code should somewhat mitigate
this. But, this still brings some inconsistencies compared to when
booting without mirrored pages, so it is better to fix.

Pavel
