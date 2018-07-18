Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8F8ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C2E2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PvXFxq/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C2E2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730996AbeGRPNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 11:13:18 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34504 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730383AbeGRPNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 11:13:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6IEXbPN142548
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 14:35:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=rhCDXo6KYD4IOUvxkVxDlvRpBudWJ8ct9v+0zTzY7kw=;
 b=PvXFxq/uwI1bDyMwI8u6GE8ZaXYEg0uzyEk+zEvJD0Ind20uweNuUXKk+1NLtZnbzMCs
 4wKYxRk+KDxdrmGQZqRoWw4jQHdd/v2G7okx/o8SiAiQn/konQGk68r0qTIlLylwh2O2
 BpLDntgCfI+liqaTevuPebTVn07ntDwcPzmFxMWivVuYXnAjjmPfet3p/ei/yfvPtLLJ
 tS6WsmqpVgmLEOoppIzOPx1ZBCMTiSzLCojkyKHGEDYVjQFslRnXH4VsDyiQzPgYKczg
 Ri1PfNKYX5ULx5Lz+306+Vd8CD5w3eDUyKPcoqCLxHaVvqLA02hLDIXCvh44GBSp/tGf vg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2k9yjghwu4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 14:35:04 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6IEZ3fl001446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 14:35:03 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6IEZ3b1021679
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 14:35:03 GMT
Received: from mail-oi0-f51.google.com (/209.85.218.51)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Jul 2018 14:35:03 +0000
Received: by mail-oi0-f51.google.com with SMTP id q11-v6so9163823oic.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 07:35:03 -0700 (PDT)
X-Gm-Message-State: AOUpUlF4Kllebl/39Y7vFExqr1TOcJ4LIOKQ6y9iqG3d5OHgceUdf+zU
        flK+9wMUyp7RVQ8rkFjUZ6q7cZH7143uNR20qTI=
X-Google-Smtp-Source: AAOMgpcZlVL4Udz7VMZn9D1NYMjS9KUbQ8ow//C9dif3LM3BdIrNZCRhpqiVEKQIRpLfVEXf2IXvlxemSc5RlPxf1cQ=
X-Received: by 2002:a54:4f88:: with SMTP id g8-v6mr7042583oiy.191.1531924495286;
 Wed, 18 Jul 2018 07:34:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180718124722.9872-1-osalvador@techadventures.net> <20180718124722.9872-4-osalvador@techadventures.net>
In-Reply-To: <20180718124722.9872-4-osalvador@techadventures.net>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Wed, 18 Jul 2018 10:34:19 -0400
X-Gmail-Original-Message-ID: <CAGM2reY8ODmr=u4bsCrdEX3f-c6NkSuKuEcXowRy=SkuMppjiw@mail.gmail.com>
Message-ID: <CAGM2reY8ODmr=u4bsCrdEX3f-c6NkSuKuEcXowRy=SkuMppjiw@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm/page_alloc: Split context in free_area_init_node
To:     osalvador@techadventures.net
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>, iamjoonsoo.kim@lge.com,
        aaron.lu@intel.com, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        osalvador@suse.de
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8958 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=10 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=828
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807180164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 8:47 AM <osalvador@techadventures.net> wrote:
>
> From: Oscar Salvador <osalvador@suse.de>
>
> If free_area_init_node gets called from memhotplug code,
> we do not need to call calculate_node_totalpages(),
> as the node has no pages.

I am not positive this is safe. Some pgdat fields in
calculate_node_totalpages() are set. Even if those fields are always
set to zeros, pgdat may be reused (i.e. node went offline and later
came back online), so we might still need to set those fields to
zeroes.

Pavel
