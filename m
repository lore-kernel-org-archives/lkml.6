Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFA9C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C074220673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RSB8fxWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C074220673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731855AbeGZQxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 12:53:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44738 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731573AbeGZQxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 12:53:37 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6QFY0x3141060
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 15:36:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=7ZPrtUT9OlPvyicZWBPgelAZ1/WDcWWakHL3xXXdBr0=;
 b=RSB8fxWzF6FngV5ARiuGW5hlasuBhtFC6RGoLXhJqE3fo6qDM8C3208smrLIbJkJ5UCt
 DpN3+PfrPLcYdtN3uhVkd3lRcEKUR/Ycse4K1dOIxFwneHx1gktuqMF1EJTTNXPRix3+
 fu0X/a+fQX+X6X4bjkQ0tjrAzRY27yo5ThT2Mv63B1zjh4WArngA0KpgJo3t1lk4z7u1
 CCKk22ytWX3Ef37gPDLoM453/g0V01rFNrIp1jIdd5Ip5+A6I0vdFX8wzgqjubjhIBI/
 OmbCI55vL92+0clhiyw9EnnP6tIcYjZVk9V2dJmHm5SHV+kV5lFNhDyKu7Dwhw5qomS5 CA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2kbwfq3mmw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 15:36:13 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6QFaDaR011629
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 15:36:13 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6QFaCTX032438
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 15:36:12 GMT
Received: from mail-oi0-f44.google.com (/209.85.218.44)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Jul 2018 08:36:12 -0700
Received: by mail-oi0-f44.google.com with SMTP id d189-v6so3699584oib.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 08:36:12 -0700 (PDT)
X-Gm-Message-State: AOUpUlG9K2ns59t5QxbkHX6BtmXJi8MaTN2WpA8s9atEvdMMMJFKBjLK
        maQoQdDavuvVQBdQa4mjE5cMtx1qIvDSvoPj9T4=
X-Google-Smtp-Source: AAOMgpfmRd0wm/rofzMJL+arSRmHNyH04MqKOa63JSVTjRTdcB+eAl18uPHgPSPPd/c2IsW1YK6X6JOuTubbqnhCxAA=
X-Received: by 2002:aca:3bc2:: with SMTP id i185-v6mr2653737oia.156.1532619371977;
 Thu, 26 Jul 2018 08:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180725220144.11531-1-osalvador@techadventures.net>
 <20180725220144.11531-5-osalvador@techadventures.net> <20180726081200.GY28386@dhcp22.suse.cz>
In-Reply-To: <20180726081200.GY28386@dhcp22.suse.cz>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Thu, 26 Jul 2018 11:35:35 -0400
X-Gmail-Original-Message-ID: <CAGM2rebcp=S+WN3owDWVSa3_6QqLzs=qbOFs76rhsxuepQ1ALw@mail.gmail.com>
Message-ID: <CAGM2rebcp=S+WN3owDWVSa3_6QqLzs=qbOFs76rhsxuepQ1ALw@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] mm/page_alloc: Move initialization of node and
 zones to an own function
To:     mhocko@kernel.org
Cc:     osalvador@techadventures.net,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, mgorman@techsingularity.net,
        aaron.lu@intel.com, iamjoonsoo.kim@lge.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, dan.j.williams@intel.com,
        osalvador@suse.de
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8965 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=10 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=931
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807260162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, this looks definitely better. I will have to check that all the
> required state is initialized properly. Considering the above
> explanation I would simply fold the follow up patch into this one. It is
> not so large it would get hard to review and you would make it clear why
> the work is done.

I will review this work, once Oscar combines patches 4 & 5 as Michal suggested.


>
> > +/*
> > + * Set up the zone data structures:
> > + *   - mark all pages reserved
> > + *   - mark all memory queues empty
> > + *   - clear the memory bitmaps
> > + *
> > + * NOTE: pgdat should get zeroed by caller.
> > + * NOTE: this function is only called during early init.
> > + */
> > +static void __paginginit free_area_init_core(struct pglist_data *pgdat)
>
> now that this function is called only from the early init code we can
> make it s@__paginginit@__init@ AFAICS.

True, in patch 5. Also, zone_init_internals() should be marked as __paginginit.

Thank you,
Pavel
