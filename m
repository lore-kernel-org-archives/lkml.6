Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B176EC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677B12089B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TMUOW1a2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677B12089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932910AbeGIWzF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:55:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55332 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752112AbeGIWzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:55:04 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w69MslaG003097
        for <linux-kernel@vger.kernel.org>; Mon, 9 Jul 2018 22:55:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=mX3HR9mqguaeWWV80Z0LF+pGt98FYRFrhUN3uD3dBmA=;
 b=TMUOW1a21KJrPdrIEWCnn+FetZCye56NFw9jcxSy34YM5q4p8L/KNIcyzuaY5fxs8K5N
 ONDA9ixEx0Qaf+/Ohf4tIVlbmrUDYa+cB0FeEz0dFy/cghwNcctr/TdzQvUnRx6XESAd
 /pWw0zINusV4Igjowls//fSkgVtVCMJbbrMGnYaM+w1GDQUbSupnkEQcU9kRzg7l5AbO
 0l7Jr7LCKKseElhf+VVs7DGquuvqtORccB2ldjJKxM91Z7Fme+bFhzVay6FG/s0HC4Rg
 B5CzBTcd/irNJpbtYRjlfvusrPW928AUokm1e7/yrItOqCbBNbh7WLAiBD6g1FcHnQSq Hg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2k2p7v7g6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 22:55:03 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w69Mt2Bk008992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 9 Jul 2018 22:55:02 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w69Mt2DI023295
        for <linux-kernel@vger.kernel.org>; Mon, 9 Jul 2018 22:55:02 GMT
Received: from mail-oi0-f51.google.com (/209.85.218.51)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Jul 2018 15:55:02 -0700
Received: by mail-oi0-f51.google.com with SMTP id q11-v6so13457249oic.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 15:55:02 -0700 (PDT)
X-Gm-Message-State: APt69E2tq29OzdKdLYwxr5ReU9zN2OlL7GXuF6w+Z9Bbu6lEXiJpFRg4
        psvbA/mNJ+xrkb6m1UC0sgC8JuNUUTNRYqzlLrE=
X-Google-Smtp-Source: AAOMgpcSXaVOQ2+OHEHk2mmnprCdOipgLXD5Crm5wn4PCCddkPbc1Yooz6X3cwnxe3VMYXR+ZI1xR0tjyoeiUCpcuFM=
X-Received: by 2002:aca:3bc2:: with SMTP id i185-v6mr7697234oia.156.1531176901569;
 Mon, 09 Jul 2018 15:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180709175312.11155-1-pasha.tatashin@oracle.com> <20180709142928.c8af4a1ddf80c407fe66b224@linux-foundation.org>
In-Reply-To: <20180709142928.c8af4a1ddf80c407fe66b224@linux-foundation.org>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Mon, 9 Jul 2018 18:54:25 -0400
X-Gmail-Original-Message-ID: <CAGM2reaB-jtqg1fhHZtopUy0N5dwMr4yF3iWFViLEFjbBqD_AA@mail.gmail.com>
Message-ID: <CAGM2reaB-jtqg1fhHZtopUy0N5dwMr4yF3iWFViLEFjbBqD_AA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] sparse_init rewrite
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
        rientjes@google.com, mingo@kernel.org, osalvador@techadventures.net
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8949 signatures=668705
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807090258
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 5:29 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon,  9 Jul 2018 13:53:09 -0400 Pavel Tatashin <pasha.tatashin@oracle.com> wrote:
>
> > In sparse_init() we allocate two large buffers to temporary hold usemap and
> > memmap for the whole machine. However, we can avoid doing that if we
> > changed sparse_init() to operated on per-node bases instead of doing it on
> > the whole machine beforehand.
> >
> > As shown by Baoquan
> > http://lkml.kernel.org/r/20180628062857.29658-1-bhe@redhat.com
> >
> > The buffers are large enough to cause machine stop to boot on small memory
> > systems.
> >
> > These patches should be applied on top of Baoquan's work, as
> > CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER is removed in that work.
> >
> > For the ease of review, I split this work so the first patch only adds new
> > interfaces, the second patch enables them, and removes the old ones.
>
> This clashes pretty significantly with patches from Baoquan and Oscar:
>
> mm-sparse-make-sparse_init_one_section-void-and-remove-check.patch
> mm-sparse-make-sparse_init_one_section-void-and-remove-check-fix.patch
> mm-sparse-make-sparse_init_one_section-void-and-remove-check-fix-2.patch
> mm-sparse-add-a-static-variable-nr_present_sections.patch
> mm-sparsemem-defer-the-ms-section_mem_map-clearing.patch
> mm-sparse-add-a-new-parameter-data_unit_size-for-alloc_usemap_and_memmap.patch
>
> Is there duplication of intent here?  Any thoughts on the
> prioritization of these efforts?

Hi Andrew,

In the cover letter I wrote that these should be applied on top of
Baoquan's patches. His work fixes a bug by making temporary buffers
smaller on smaller machines, and also starts the sparse_init cleaning
process by getting rid of CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER. My
patches remove those buffers entirely. However, if my patches
conflict, I should resend based on mm-tree as Baoquan's patches are
already in and probably were slightly modified compared to what I have
locally, which I took from the mailing list.

Pavel
