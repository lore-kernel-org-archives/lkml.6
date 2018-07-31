Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C90DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CFFD20841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ezjDAtVK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFFD20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732458AbeGaQfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:35:15 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33758 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732268AbeGaQfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:35:14 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6VEsVpv085465
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 14:54:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=vxDTuMf+oRKOxK/ZxtcYPwBiaj2XGGWxZep/1od9TOk=;
 b=ezjDAtVKons4ZArpeJLgPlbnTboSIZNa471mQ21aulfl6k4bohFOhqja0rowDpznUtD5
 HgyVjlWpt7OJzUDQ946//gQnnNyUSQMQZqZ9AEQ+vwahBcEsu7Yx650mVRCN2XvTqiu/
 grjvwe9hrRnOd082F//yPpxNAJT4W3tCflJWei/PrP52NJk9AhPaffmFReFj8GCICDVW
 tVRkuGh04bRUxoUfJMM/X/HPtkSt9v1WzvA5TVZV+RUCLiz8O8PXM0K0VvuUyqVqwfDT
 U70LMbb8e4gYwjgY9OiNJD+ihDVvfPP/j4ji7JxEwi1tsgTRivaaRz3RNnhZ7D2gp0Et CQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2kgfwt1exg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 14:54:31 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6VEsTVb032095
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 14:54:29 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6VEsSU9028609
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 14:54:29 GMT
Received: from mail-oi0-f46.google.com (/209.85.218.46)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 31 Jul 2018 07:54:28 -0700
Received: by mail-oi0-f46.google.com with SMTP id n84-v6so28441585oib.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 07:54:28 -0700 (PDT)
X-Gm-Message-State: AOUpUlHjUQgsrXX6eUJ1OTvg+TPKKdKRrfwmeIcSy+6Ga1sX92KnEYiB
        aLnlsgOymyi29X8WpadOcKuCfT3+MbT1gM5a57s=
X-Google-Smtp-Source: AAOMgpe/yOYsnOqv6gwoV7RrBvgAysrWoswrySP9VqR2xcWp2qSc4y5abk5xnPemQ9l9wqAsUkNo02Geaz7bCChlI7Q=
X-Received: by 2002:aca:da88:: with SMTP id r130-v6mr23440363oig.163.1533048868474;
 Tue, 31 Jul 2018 07:54:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180731124504.27582-1-osalvador@techadventures.net>
 <CAGM2rebds=A5m1ZB1LtD7oxMzM9gjVQvm-QibHjEENmXViw5eA@mail.gmail.com>
 <20180731144157.GA1499@techadventures.net> <20180731144545.fh5syvwcecgvqul6@xakep.localdomain>
 <20180731145125.GB1499@techadventures.net>
In-Reply-To: <20180731145125.GB1499@techadventures.net>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Tue, 31 Jul 2018 10:53:52 -0400
X-Gmail-Original-Message-ID: <CAGM2reZSZHdWECr8-7pj6j=CtjWVF2oKC9SwHhMuOsDkigdzgA@mail.gmail.com>
Message-ID: <CAGM2reZSZHdWECr8-7pj6j=CtjWVF2oKC9SwHhMuOsDkigdzgA@mail.gmail.com>
Subject: Re: [PATCH] mm: make __paginginit based on CONFIG_MEMORY_HOTPLUG
To:     osalvador@techadventures.net
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kirill.shutemov@linux.intel.com, iamjoonsoo.kim@lge.com,
        Mel Gorman <mgorman@suse.de>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, osalvador@suse.de
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8970 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=424
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807310138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thats correct on arches where no sparsemem setup_usemap() will not be
freed up. It is a tiny function, just a few instructions. Not a big
deal.

Pavel
On Tue, Jul 31, 2018 at 10:51 AM Oscar Salvador
<osalvador@techadventures.net> wrote:
>
> On Tue, Jul 31, 2018 at 10:45:45AM -0400, Pavel Tatashin wrote:
> > Here the patch would look like this:
> >
> > From e640b32dbd329bba5a785cc60050d5d7e1ca18ce Mon Sep 17 00:00:00 2001
> > From: Pavel Tatashin <pasha.tatashin@oracle.com>
> > Date: Tue, 31 Jul 2018 10:37:44 -0400
> > Subject: [PATCH] mm: remove __paginginit
> >
> > __paginginit is the same thing as __meminit except for platforms without
> > sparsemem, there it is defined as __init.
> >
> > Remove __paginginit and use __meminit. Use __ref in one single function
> > that merges __meminit and __init sections: setup_usemap().
> >
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
>
> Uhm, I am probably missing something, but with this change, the functions will not be freed up
> while freeing init memory, right?
>
> Thanks
> --
> Oscar Salvador
> SUSE L3
>
