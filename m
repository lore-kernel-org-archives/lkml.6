Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4F7C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E9720862
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sfq/GwEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92E9720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732467AbeGaRya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 13:54:30 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35790 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbeGaRya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 13:54:30 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6VG3uxs144246
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 16:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=IcI8ibE+Ha5Pd5oNHyYIBCp6EXyQSgkTDgReWWpWI8s=;
 b=Sfq/GwEaoNTLD4H3dD92rSJBnj+ol6526saD925mOOB7rg1XiDpGaXRnPCCBT0iJ+0Cd
 ffLtH1JAnI9jCzw06Ja8oZa7IuAc66zrYemjluq9e/jfgw2NeEE4sHVDwbYNJwHypS2T
 C+/2KbZsD/uyUy6h6jrPDB2YvOI3whOIFbd0R0oRcD8gHz62BkMJkBllXDF4s/jLBUwK
 V8y+WRhItQyXDMLvrumMIYKtS84lYgdYNcbFUO7iWNFNzGspGDD6eGXDmbB1sOMgQYSj
 eDg0qIVTolcPUSdBGSiuLxuxpuyjdS1k/zh0NrNlwwaoEroglo1+tc+kV1tRBL9Ng6Im ag== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2kgfwt1uq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 16:13:27 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6VGDQmv008533
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 16:13:26 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6VGDP0U005280
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 16:13:26 GMT
Received: from mail-oi0-f54.google.com (/209.85.218.54)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 31 Jul 2018 09:13:25 -0700
Received: by mail-oi0-f54.google.com with SMTP id n84-v6so28959639oib.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 09:13:25 -0700 (PDT)
X-Gm-Message-State: AOUpUlFUzkxkMaORxGuVdvKNo5TsnFCkGIV7chp9XqHCvg2oHph6Vt5k
        lahGouwHsfmi2qwYCw4nxozaWCo2iTa3ysBLoKk=
X-Google-Smtp-Source: AAOMgpey84GHmeg5uG6SqHYGoed/6FsuNXBvHN8ADytCFeD5rxZcuw+tfo74ujIlXZ8Dwo8uYPBbHPESdQxuuCK2ZCU=
X-Received: by 2002:aca:b541:: with SMTP id e62-v6mr24993842oif.136.1533053604934;
 Tue, 31 Jul 2018 09:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180730101757.28058-1-osalvador@techadventures.net>
 <20180730101757.28058-5-osalvador@techadventures.net> <20180731101752.GA473@techadventures.net>
In-Reply-To: <20180731101752.GA473@techadventures.net>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Tue, 31 Jul 2018 12:12:49 -0400
X-Gmail-Original-Message-ID: <CAGM2reade9+=5+qoCkmYrtMxDnQzoAi3u0nnHV-K5_iFmnOXmA@mail.gmail.com>
Message-ID: <CAGM2reade9+=5+qoCkmYrtMxDnQzoAi3u0nnHV-K5_iFmnOXmA@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] mm/page_alloc: Introduce free_area_init_core_hotplug
To:     osalvador@techadventures.net
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>, mgorman@techsingularity.net,
        aaron.lu@intel.com, iamjoonsoo.kim@lge.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, dan.j.williams@intel.com,
        david@redhat.com, osalvador@suse.de
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8970 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=10 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=869
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807310148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 6:17 AM Oscar Salvador
<osalvador@techadventures.net> wrote:
>
> On Mon, Jul 30, 2018 at 12:17:57PM +0200, osalvador@techadventures.net wrote:
> > From: Oscar Salvador <osalvador@suse.de>
> ...
> > Also, since free_area_init_core/free_area_init_node will now only get called during early init, let us replace
> > __paginginit with __init, so their code gets freed up.
> >
> > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> > Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
>
> Andrew, could you please fold the following cleanup into this patch?
> thanks
>
> Pavel, since this has your Reviewed-by, are you ok with the following on top?

Yes, Looks good to me.

Thank you,
Pavel
