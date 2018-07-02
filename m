Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C95C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 02:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CBE21A57
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 02:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FfXGFrpv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26CBE21A57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933028AbeGBCnw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 22:43:52 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39182 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753057AbeGBCnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 22:43:49 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w622dkEq130820
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 02:43:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=xdjdWALLK0oyxEtJ/Nllig3o2f/wSY9YycgKHE+uFh4=;
 b=FfXGFrpvrwEo6BI+Zlsf4D5elRDrIBC22Qn2PRhCpwnx8SCPEC5sBcwYvT1l8d+XXkwR
 zh5h9SevBKGTvHJNLspSDlMeFpiC6OuOW6tiBDrQqHJLyTai1Ra5e8Tj4JIMGqKYzGyH
 HErJmnG+ADBnSP8HnHxY4ubcbGzaMo+vHXoWpp5/QkQgC+9P9JD3MGwFygbhUtv9gLd9
 HAj0R4SvtxxtCxs+J0QlVk5DvObhAjIUVN5IEGStJywoS6F6Eg8faoUnaZKpQQSv2ItB
 rD8qKXz5vNMQld8hr0+eK2gRx/I0uHnnib8YAW0hz5zzW2avI99jOrXQJ4sfbqMvR10J wQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2jx1tntkua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 02:43:48 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w622hkDf015342
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 02:43:46 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w622hkGO021913
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 02:43:46 GMT
Received: from mail-oi0-f51.google.com (/209.85.218.51)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 01 Jul 2018 19:43:46 -0700
Received: by mail-oi0-f51.google.com with SMTP id r16-v6so13121190oie.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 19:43:45 -0700 (PDT)
X-Gm-Message-State: APt69E0R8STD1gSyHLrmeKlmCIvTWPfoY530TxpfgtErIZWNcqdzBAmq
        bYe6nCywOnI5fW2IOQ/tgMVtZHBpG9zCEsbrHzU=
X-Google-Smtp-Source: AAOMgpcrnSoQeAX7w4SAytAxbWugMh3KA3aGfcO564PQEff+IRtbMwegwWp8AVNuNpElkfsGLAy+8ueVxXgaGTA85YI=
X-Received: by 2002:aca:e5d2:: with SMTP id c201-v6mr14549642oih.191.1530499425739;
 Sun, 01 Jul 2018 19:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180702020417.21281-1-pasha.tatashin@oracle.com>
 <20180702020417.21281-2-pasha.tatashin@oracle.com> <20180702021121.GL3223@MiWiFi-R3L-srv>
 <CAGM2rebY1_-3hvp_+kqF==nLawC0FN6Q1J5X5pm5qxHdDJzjiQ@mail.gmail.com> <20180702023130.GM3223@MiWiFi-R3L-srv>
In-Reply-To: <20180702023130.GM3223@MiWiFi-R3L-srv>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Sun, 1 Jul 2018 22:43:09 -0400
X-Gmail-Original-Message-ID: <CAGM2rebUsJ2r-2F38Vv13zbaEPPgTn0w6H3j6fpg0WVa9wB6Uw@mail.gmail.com>
Message-ID: <CAGM2rebUsJ2r-2F38Vv13zbaEPPgTn0w6H3j6fpg0WVa9wB6Uw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm/sparse: add sparse_init_nid()
To:     bhe@redhat.com
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kirill.shutemov@linux.intel.com, Michal Hocko <mhocko@suse.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        dan.j.williams@intel.com, jack@suse.cz, jglisse@redhat.com,
        Souptick Joarder <jrdr.linux@gmail.com>,
        gregkh@linuxfoundation.org, Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@gmail.com>, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org, osalvador@techadventures.net
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8941 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=869
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807020030
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 1, 2018 at 10:31 PM Baoquan He <bhe@redhat.com> wrote:
>
> On 07/01/18 at 10:18pm, Pavel Tatashin wrote:
> > > Here, I think it might be not right to jump to 'failed' directly if one
> > > section of the node failed to populate memmap. I think the original code
> > > is only skipping the section which memmap failed to populate by marking
> > > it as not present with "ms->section_mem_map = 0".
> > >
> >
> > Hi Baoquan,
> >
> > Thank you for a careful review. This is an intended change compared to
> > the original code. Because we operate per-node now, if we fail to
> > allocate a single section, in this node, it means we also will fail to
> > allocate all the consequent sections in the same node and no need to
> > check them anymore. In the original code we could not simply bailout,
> > because we still might have valid entries in the following nodes.
> > Similarly, sparse_init() will call sparse_init_nid() for the next node
> > even if previous node failed to setup all the memory.
>
> Hmm, say the node we are handling is node5, and there are 100 sections.
> If you allocate memmap for section at one time, you have succeeded to
> handle for the first 99 sections, now the 100th failed, so you will mark
> all sections on node5 as not present. And the allocation failure is only
> for single section memmap allocation case.

No, unless I am missing something, that's not how code works:

463                 if (!map) {
464                         pr_err("%s: memory map backing failed.
Some memory will not be available.",
465                                __func__);
466                         pnum_begin = pnum;
467                         goto failed;
468                 }

476 failed:
477         /* We failed to allocate, mark all the following pnums as
not present */
478         for_each_present_section_nr(pnum_begin, pnum) {

We continue from the pnum that failed as we set pnum_begin to pnum,
and mark all the consequent sections as not-present.

The only change compared to the original code is that once we found an
empty pnum we stop checking the consequent pnums in this node, as we
know they are empty as well, because there is no more memory in this
node to allocate from.

Pavel
