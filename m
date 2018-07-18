Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2007ECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B4B2077B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="24Iqdwua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6B4B2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731591AbeGRCgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 22:36:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46530 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730930AbeGRCgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 22:36:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6I1xl6v152604;
        Wed, 18 Jul 2018 02:00:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=l5Zg2VRL9FKVBum96HFe/TQxn0BXx2s+t05nVc1Y6dM=;
 b=24IqdwuagdcA3MVXgIzfVcbdxIi3kGcX2bcEDN33B/zOLQbrI1p6G31X1ptytxeve01g
 yRF94LgDAgYCjeSny8cZR7r/AI0omk4mw3WHv4dhMr42dFVPjeUkOOQTzpmHBLKFwW86
 RHQCTH3ZWtMOsfwguTV/XcPo+TQdD92aeQFIu//wISCZLfihhTKS0S2IMRGZ93HJTAYt
 7hd9kx7iDFiMkhjdTqCoaXcC7X9py+T+Pk8fPaDAv2UephO+l+8Bq8MjZFvyTi1ZUkZd
 90QhSyz5Zps6CWztncRywsH1jF3Mq+laSr55MW7Ig0KNg6B0fYLMOYVsrEbRtcJAKvMd Fg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2k7a3ju27v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jul 2018 02:00:59 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6I20vMX009216
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jul 2018 02:00:58 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6I20vRp005389;
        Wed, 18 Jul 2018 02:00:57 GMT
Received: from mail-oi0-f42.google.com (/209.85.218.42)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Jul 2018 19:00:57 -0700
Received: by mail-oi0-f42.google.com with SMTP id k12-v6so5796403oiw.8;
        Tue, 17 Jul 2018 19:00:57 -0700 (PDT)
X-Gm-Message-State: AOUpUlE1uISNiJbQ133LriljZ3+djMvuafoPhWqAzksWXJIkf2tpuEhq
        7dpOE+AfWmSI5Rcn8wBVwWTyjSezlViB70oWJSo=
X-Google-Smtp-Source: AAOMgpflcqAwGefR86gjrQEojz2kOYoVR9zYofM242XyZKt/hodF4R/iqXUCvO//ElsOB5dxy4ZdcwJ7ql8fJETxhso=
X-Received: by 2002:a54:4f88:: with SMTP id g8-v6mr4635269oiy.191.1531879256698;
 Tue, 17 Jul 2018 19:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <1531416305.6480.24.camel@abdul.in.ibm.com> <CAGM2rebtisZda0kqhg0u92fTDxC+=zMNNgKFBLH38osphk0fdA@mail.gmail.com>
 <1531473191.6480.26.camel@abdul.in.ibm.com> <20180714105500.3694b93f@canb.auug.org.au>
 <1531824532.15016.30.camel@abdul.in.ibm.com>
In-Reply-To: <1531824532.15016.30.camel@abdul.in.ibm.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Tue, 17 Jul 2018 22:00:20 -0400
X-Gmail-Original-Message-ID: <CAGM2reav2giqHjUTWADWzqb-8m7AqUBJxerA1Oc+4YJhTLXrDA@mail.gmail.com>
Message-ID: <CAGM2reav2giqHjUTWADWzqb-8m7AqUBJxerA1Oc+4YJhTLXrDA@mail.gmail.com>
Subject: Re: [next-20180711][Oops] linux-next kernel boot is broken on powerpc
To:     abdhalee@linux.vnet.ibm.com
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        sachinp@linux.vnet.ibm.com, Michal Hocko <mhocko@suse.com>,
        sim@linux.vnet.ibm.com, venkatb3@in.ibm.com,
        LKML <linux-kernel@vger.kernel.org>, manvanth@linux.vnet.ibm.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-next@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8957 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=10 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807180021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 6:49 AM Abdul Haleem
<abdhalee@linux.vnet.ibm.com> wrote:
>
> On Sat, 2018-07-14 at 10:55 +1000, Stephen Rothwell wrote:
> > Hi Abdul,
> >
> > On Fri, 13 Jul 2018 14:43:11 +0530 Abdul Haleem <abdhalee@linux.vnet.ibm.com> wrote:
> > >
> > > On Thu, 2018-07-12 at 13:44 -0400, Pavel Tatashin wrote:
> > > > > Related commit could be one of below ? I see lots of patches related to mm and could not bisect
> > > > >
> > > > > 5479976fda7d3ab23ba0a4eb4d60b296eb88b866 mm: page_alloc: restore memblock_next_valid_pfn() on arm/arm64
> > > > > 41619b27b5696e7e5ef76d9c692dd7342c1ad7eb mm-drop-vm_bug_on-from-__get_free_pages-fix
> > > > > 531bbe6bd2721f4b66cdb0f5cf5ac14612fa1419 mm: drop VM_BUG_ON from __get_free_pages
> > > > > 479350dd1a35f8bfb2534697e5ca68ee8a6e8dea mm, page_alloc: actually ignore mempolicies for high priority allocations
> > > > > 088018f6fe571444caaeb16e84c9f24f22dfc8b0 mm: skip invalid pages block at a time in zero_resv_unresv()
> > > >
> > > > Looks like:
> > > > 0ba29a108979 mm/sparse: Remove CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER
> > > >
> > > > This patch is going to be reverted from linux-next. Abdul, please
> > > > verify that issue is gone once  you revert this patch.
> > >
> > > kernel booted fine when the above patch is reverted.
> >
> > And it has been removed from linux-next as of next-20180713.  (Friday
> > the 13th is not all bad :-))
>
> Hi Stephen,
>
> After reverting 0ba29a108979, our bare-metal machines boot fails with
> kernel panic, is this related ?
>
> I have attached the boot logs.

The panic happens much later in boot and looks unrelated to the
sparse_init changes.

Thank you,
Pavel
