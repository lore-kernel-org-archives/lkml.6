Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77B2EA0873
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 748CB2124D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="diTFXIZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 748CB2124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbeGLR4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:56:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48780 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbeGLR4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:56:13 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6CHhZbp030359;
        Thu, 12 Jul 2018 17:45:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=hwJEdEES9x7Fka9+z2w50MfbeuL1Jw957SHjqlMD0uA=;
 b=diTFXIZEf7FxhsRJaFpSmm3Y1MS10DKOp9FlntzLVXo9RMImKx9nSz22dzSSvs8JYqVc
 hp3W18jJ77SNHz37F+KdGpvE3hSsLIKOUPhKHbxk3/DAe8Hw/Kd1b7osso1Rd4C137Gd
 IRA0tYCfiQyuWgRJU4YSQkxoWeI62pYZWWrd72am8Eq+vNqnSaVeO7rJwjIY5ywjj/mq
 RpdZ91Ty/u0eOIeA2HywVsCspzSRjxXyZVguYiQWkRDgOP9v+Im9GrgzBpwTPM2ga+Eg
 9ZNfTQn1JMcdydYAE3cF+ET2LRvKf78lic8RE5r4eZw3Nteu1IJrnxjmrgS9yKLE4Q5Z /Q== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2k2p7vmry1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 17:45:37 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6CHjaFF027943
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 17:45:36 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6CHjag0028898;
        Thu, 12 Jul 2018 17:45:36 GMT
Received: from mail-oi0-f51.google.com (/209.85.218.51)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Jul 2018 10:45:35 -0700
Received: by mail-oi0-f51.google.com with SMTP id y207-v6so57345891oie.13;
        Thu, 12 Jul 2018 10:45:35 -0700 (PDT)
X-Gm-Message-State: AOUpUlHGaSFuROdtdqF4HHviRVHXNpMl/jyOeFRZsMeNV5w+vapRV8oE
        bvWP5d3VVrkmTYH+uFt+9dGpJrrwQ5EdEVHGU5E=
X-Google-Smtp-Source: AAOMgpeXzkt+/qvGw/QQ7B9FS+v0WSZ0jgKCyjp735+gnmgHKzdqfdrnCHalZcJdtQwTIxflf1trmpgWYOv7xz5S43A=
X-Received: by 2002:aca:3bc2:: with SMTP id i185-v6mr3648614oia.156.1531417535646;
 Thu, 12 Jul 2018 10:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <1531416305.6480.24.camel@abdul.in.ibm.com>
In-Reply-To: <1531416305.6480.24.camel@abdul.in.ibm.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Thu, 12 Jul 2018 13:44:59 -0400
X-Gmail-Original-Message-ID: <CAGM2rebtisZda0kqhg0u92fTDxC+=zMNNgKFBLH38osphk0fdA@mail.gmail.com>
Message-ID: <CAGM2rebtisZda0kqhg0u92fTDxC+=zMNNgKFBLH38osphk0fdA@mail.gmail.com>
Subject: Re: [next-20180711][Oops] linux-next kernel boot is broken on powerpc
To:     abdhalee@linux.vnet.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-next@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, mpe@ellerman.id.au,
        sachinp@linux.vnet.ibm.com, venkatb3@in.ibm.com,
        manvanth@linux.vnet.ibm.com, sim@linux.vnet.ibm.com,
        Michal Hocko <mhocko@suse.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        aneesh.kumar@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8951 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=10 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=863
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807120187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Related commit could be one of below ? I see lots of patches related to mm and could not bisect
>
> 5479976fda7d3ab23ba0a4eb4d60b296eb88b866 mm: page_alloc: restore memblock_next_valid_pfn() on arm/arm64
> 41619b27b5696e7e5ef76d9c692dd7342c1ad7eb mm-drop-vm_bug_on-from-__get_free_pages-fix
> 531bbe6bd2721f4b66cdb0f5cf5ac14612fa1419 mm: drop VM_BUG_ON from __get_free_pages
> 479350dd1a35f8bfb2534697e5ca68ee8a6e8dea mm, page_alloc: actually ignore mempolicies for high priority allocations
> 088018f6fe571444caaeb16e84c9f24f22dfc8b0 mm: skip invalid pages block at a time in zero_resv_unresv()

Looks like:
0ba29a108979 mm/sparse: Remove CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER

This patch is going to be reverted from linux-next. Abdul, please
verify that issue is gone once  you revert this patch.

Thank you,
Pavel
