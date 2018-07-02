Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FDAC6778C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A0BD254B5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GRu9SfUm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A0BD254B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932838AbeGBBrT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 21:47:19 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:59082 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932477AbeGBBrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 21:47:16 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w621ivoW092960
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 01:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=y8XvfoLQxeCtX3IAjo4PNYBj7Ynlit0T2YPyfqfqn38=;
 b=GRu9SfUmS4pwuHyZmolCvbSqihWraICc4XNQUlxbHYDoT5W7KZq9sZViKwZVoljnq2FM
 8rxcX0sVbeU3LpFC2afFML2LEU/ZlDSaOzHfdvfPxgDlW8XBOe5FSuNjXjzP2sG/aD5E
 mIwk/O8Za+ZWMzcmew+a6HW2ZuxoWCKGKycjTIui3ykZU602AODvqLaYYSsER9kLJXZM
 Y78PoAHHrILRhF/UJ6jB8Fi7PJ9GzpfYn8OiNTXRbyV5bakAHBOB9gWz99Wdk3TYwkL1
 O0BgNNp7LkYClNYBHCaUsHkaXT1GTTM5Dl/TFd86/CIa0iPkaz2otR0wX+5GWWCJjXFg sw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2jwyccjpaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 01:47:15 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w621lDHl003072
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 01:47:13 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w621lDqO028847
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 01:47:13 GMT
Received: from mail-oi0-f41.google.com (/209.85.218.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 01 Jul 2018 18:47:13 -0700
Received: by mail-oi0-f41.google.com with SMTP id k81-v6so13471677oib.4
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 18:47:12 -0700 (PDT)
X-Gm-Message-State: APt69E2tspvC/Hbq3l3skU+fzQ8Nz7Z9MKIVtxkL+SR/9Xc7oshzPRgz
        DC5Vi5W+EZgBdIsiK7eiuTPsq1RIBLp8p6It2Po=
X-Google-Smtp-Source: AAOMgpdN5263eeCYGP9XBpzJcOAglb3luyfv8/V3USba2Hu6vg2627MSJq2VE7BmRupD2o37Wfn0rueLMIPDLaYSS1M=
X-Received: by 2002:aca:e5d2:: with SMTP id c201-v6mr14396746oih.191.1530496032380;
 Sun, 01 Jul 2018 18:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180630030944.9335-1-pasha.tatashin@oracle.com>
 <20180630030944.9335-3-pasha.tatashin@oracle.com> <20180702013918.GJ3223@MiWiFi-R3L-srv>
In-Reply-To: <20180702013918.GJ3223@MiWiFi-R3L-srv>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Sun, 1 Jul 2018 21:46:36 -0400
X-Gmail-Original-Message-ID: <CAGM2reYRYNOe0nweMrSxLZ_RRQbu500iSRKWrbO4_CzyWTEtjQ@mail.gmail.com>
Message-ID: <CAGM2reYRYNOe0nweMrSxLZ_RRQbu500iSRKWrbO4_CzyWTEtjQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm/sparse: start using sparse_init_nid(), and
 remove old code
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
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=887
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807020019
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

                         ~~~
> Here, node id passed to sparse_init_nid() should be 'nid_begin', but not
> 'nid'. When you found out the current section's 'nid' is diferent than
> 'nid_begin', handle node 'nid_begin', then start to next node 'nid'.

Thank you for reviewing this work. Here nid equals to nid_begin:

See, "if" at 501, and this call is at 505.

492 void __init sparse_init(void)
493 {
494         unsigned long pnum_begin = first_present_section_nr();
495         int nid_begin = sparse_early_nid(__nr_to_section(pnum_begin));
496         unsigned long pnum_end, map_count = 1;
497
498         for_each_present_section_nr(pnum_begin + 1, pnum_end) {
499                 int nid = sparse_early_nid(__nr_to_section(pnum_end));
500
501                 if (nid == nid_begin) {
502                         map_count++;
503                         continue;
504                 }
505                 sparse_init_nid(nid, pnum_begin, pnum_end, map_count);
506                 nid_begin = nid;
507                 pnum_begin = pnum_end;
508                 map_count = 1;
509         }
510         sparse_init_nid(nid_begin, pnum_begin, pnum_end, map_count);
511         vmemmap_populate_print_last();
512 }

Thank you,
Pavel
