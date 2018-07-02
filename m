Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FE0C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8B524EA8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kTXKcHH/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E8B524EA8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753096AbeGBRrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 13:47:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59390 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752067AbeGBRrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 13:47:04 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w62HiI2I164296
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 17:47:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=iDJicNXhlWReHp/6IH3IWSQ46flq9ImK8876AYI34Uc=;
 b=kTXKcHH/4uTBLxWo8jmwfDUVyRV17u/xo3vVIR24wRRiovWfxHgsGcCuP8FxPWQvglIk
 qwc9Xxm3yUhr1wCpy3o5kAAWt5nELbocsqgeBQlmGseWxIf0guJ+QUMeBXTx9XamFH9e
 5P1AEvcEJKSH/SjEuWwMSshozBEy9yCyhO0y8DyRQe1XdRosi41Gb/YiXOwe2T9DNreH
 MBrjmrJ7ZDE2UoqxD4wkNFSXVjurXimT6eOq3B8Kisd8KbliySY1vS4953MqKx6ZwClv
 hGwzCAx5Ld2i5CdA9Q13I5NbP3j/qRvBKaAwvedMRUHIzrUYPdVFGFcw5OwfGk4oVb++ jw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2jx2gpwe4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 17:47:03 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w62Hl14r001198
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 17:47:02 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w62Hl105001200
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 17:47:01 GMT
Received: from mail-oi0-f53.google.com (/209.85.218.53)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Jul 2018 10:47:01 -0700
Received: by mail-oi0-f53.google.com with SMTP id y207-v6so17926607oie.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 10:47:01 -0700 (PDT)
X-Gm-Message-State: APt69E0JJryThYueFyT7B1eiDm1/Ffb/MP4KBfrjdAmUMF8LunKiRcgf
        JN8qN43Cr9doQ8T0iMVbjw0PyoELw+ceTQPoC5Q=
X-Google-Smtp-Source: AAOMgpfVg5b7pYT35ynd+pTuSKNEiEPxGN2zU4rhanFp93mryKDc4upGAjYrVzEO5zUIYRnZKKWt9OhbDzpZtR/DvTw=
X-Received: by 2002:aca:e089:: with SMTP id x131-v6mr11159138oig.221.1530553621119;
 Mon, 02 Jul 2018 10:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180702020417.21281-1-pasha.tatashin@oracle.com> <de99ae79-8d68-e8d6-5243-085fd106e1e5@intel.com>
In-Reply-To: <de99ae79-8d68-e8d6-5243-085fd106e1e5@intel.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Mon, 2 Jul 2018 13:46:25 -0400
X-Gmail-Original-Message-ID: <CAGM2reYVkvVPgj+_upEdpjUL5noS=0ObGxnxXH3gAz+cJosEjA@mail.gmail.com>
Message-ID: <CAGM2reYVkvVPgj+_upEdpjUL5noS=0ObGxnxXH3gAz+cJosEjA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] sparse_init rewrite
To:     dave.hansen@intel.com
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kirill.shutemov@linux.intel.com, Michal Hocko <mhocko@suse.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        dan.j.williams@intel.com, jack@suse.cz, jglisse@redhat.com,
        Souptick Joarder <jrdr.linux@gmail.com>, bhe@redhat.com,
        gregkh@linuxfoundation.org, Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@gmail.com>, rientjes@google.com,
        mingo@kernel.org, osalvador@techadventures.net
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8942 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=436
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807020198
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 12:20 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 07/01/2018 07:04 PM, Pavel Tatashin wrote:
> >  include/linux/mm.h  |   9 +-
> >  mm/sparse-vmemmap.c |  44 ++++---
> >  mm/sparse.c         | 279 +++++++++++++++-----------------------------
> >  3 files changed, 125 insertions(+), 207 deletions(-)
>
> FWIW, I'm not a fan of rewrites, but this is an awful lot of code to remove.
>
> I assume from all the back-and-forth, you have another version
> forthcoming.  I'll take a close look through that one.

The removed code is a benefit, but once you review it, you will see
that it was necessary to re-write in order to get rid of the temporary
buffers. Please review the current version. The only change that is
going to be in the next version is added "nid" to pr_err() in
sparse_init_nid() for more detailed error.

Thank you,
Pavel
