Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24E2C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9925620C03
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="itWuCJce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9925620C03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934327AbeGCRXi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:23:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52166 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934295AbeGCRXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:23:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w63HNUtE184986
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jul 2018 17:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=KB0kVcN2+vfhDaecoqYEyrk7Vrhc2806tNrL0U77vyU=;
 b=itWuCJce6HZjbVoTd2dxsaX1tCiU7F+b92WFa8GDIi6RbC9PeXZVj2L5MYNtEZ9QlC+m
 WzXpdMGUf5cIdKgc9iIRaTsCapXxlLo57ONv4tyqBgCQkAvXwvOf7yebwzlUvrYIDWYH
 u6gKyNWnWlEJAArnTwOqnd5nG5RpTIQ3I8g1sVo2/rH+y9No9lTmlvpdIGg/s6Ww+E14
 iBsVD8ZmDzhBsmboZl/YvT3EO+ninoYaoaB7phmpTVTq8XOkmZvcyzSh182eamv8NKEu
 nlKIrWf+Ltm1akiYuWu21m1o28tYXzo7SLrfvuUxRtySKku6AjkLsig7g7ewhAGtexge 6w== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2jx2gq1fq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 17:23:30 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w63HNTXQ022224
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jul 2018 17:23:29 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w63HNS9W009119
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jul 2018 17:23:29 GMT
Received: from mail-oi0-f49.google.com (/209.85.218.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Jul 2018 10:23:28 -0700
Received: by mail-oi0-f49.google.com with SMTP id k81-v6so5366096oib.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 10:23:28 -0700 (PDT)
X-Gm-Message-State: APt69E3QsMdIEwH0MXfFv0D5ZEJPGfgbD0Cc/W4zjph3+eRSAbOBsh30
        iQngMJfziVPfM67LO4DGKHfdGcplclkcjwFSR/4=
X-Google-Smtp-Source: AAOMgpfoeo6rzdhj+42YjzMyANaKdBWGKQCak+xrU0+MD7O+mPOA8W1An9TJYXWXuDhQbMIwyaAcmefy6Ozun05Gf8w=
X-Received: by 2002:aca:db0a:: with SMTP id s10-v6mr23120733oig.339.1530638608445;
 Tue, 03 Jul 2018 10:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <1530637506-1256-1-git-send-email-rppt@linux.vnet.ibm.com>
In-Reply-To: <1530637506-1256-1-git-send-email-rppt@linux.vnet.ibm.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Tue, 3 Jul 2018 13:22:52 -0400
X-Gmail-Original-Message-ID: <CAGM2reZ1RWcUT67cTGcyB6UzUftyMyG7GTfp=XjNo5CN2=c_bg@mail.gmail.com>
Message-ID: <CAGM2reZ1RWcUT67cTGcyB6UzUftyMyG7GTfp=XjNo5CN2=c_bg@mail.gmail.com>
Subject: Re: [PATCH] mm/memblock: replace u64 with phys_addr_t where appropriate
To:     rppt@linux.vnet.ibm.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, mhocko@kernel.org,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8943 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=10 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=549
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807030198
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 1:05 PM Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
>
> Most functions in memblock already use phys_addr_t to represent a physical
> address with __memblock_free_late() being an exception.
>
> This patch replaces u64 with phys_addr_t in __memblock_free_late() and
> switches several format strings from %llx to %pa to avoid casting from
> phys_addr_t to u64.
>
> CC: Michal Hocko <mhocko@kernel.org>
> CC: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

Looks good.

Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>

One minor thing that I would like to change in memblock.c is the
useage phys_addr_t for size. I understand the reasoning behind this
choice, but could we do something like:

typedef phys_addr_t phys_size_t;
It would be similar to resource_size_t. I just think the code and
function prototypes would look better with proper typing.

Thank you,
Pavel
