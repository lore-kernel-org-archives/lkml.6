Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665AEC6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F8C24564
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YGEi7OuK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F8C24564
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755308AbeF2Rsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 13:48:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40550 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755206AbeF2Rsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 13:48:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5THmjcx104316
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 17:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=ukfmZ/OIfG5FoPNIjD8F/mynhmKqnrWb7iJTGznHs7A=;
 b=YGEi7OuKSu45qNK+8GdghlbJ7dFgy3ikHGyLK94NddYJgOzyQzb8soOHv+cLlWBy3re5
 N3f4VsZ4/gXdIYr5gX67/cylpTFLIDX92thA11YLKMJetLS+EqCz3bm3DSyxMg0+3CP+
 JZZigm9c1WTvE+JRZ+XrgNADaJ+Ju6RB06y9YXfMJLz4Nm7upaLJWXvHSxSZmJr94fif
 nH/uBvEgpeGvZKM1+zVqGFzCjDC02r3GcveF2fd0TTf/S69Z+pGDF/kh7JUEvvhgxFq8
 kDk24tFboU7wtU/eTfAnzePRHOyHoZb4nS3fTMFWHVpqIzp2k2M7GFtDpp9jsx5jkZ9o yA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2jukhsqja7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 17:48:45 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5THmhv7016088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 17:48:44 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5THmhCm013575
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 17:48:43 GMT
Received: from mail-oi0-f53.google.com (/209.85.218.53)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Jun 2018 10:48:43 -0700
Received: by mail-oi0-f53.google.com with SMTP id 21-v6so9179213oip.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 10:48:43 -0700 (PDT)
X-Gm-Message-State: APt69E21/MMw0k3dFJlRz0It/CujRgdH82WYnniONFWdsD1SIxgTFisb
        wblEIgz48QZ75+hl0RAHU3+WbtzaEh5IYdZh2gA=
X-Google-Smtp-Source: AAOMgpcof1fchn23O9pF6aj6oTmvZGvBGzU3SYEiB9OwOGbZzGYVkaEj5U7kAjZyRaxaNgbZvXtoLVT2zojVhKRBkh0=
X-Received: by 2002:aca:e089:: with SMTP id x131-v6mr3620498oig.221.1530294522985;
 Fri, 29 Jun 2018 10:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180627013116.12411-1-bhe@redhat.com> <20180627013116.12411-5-bhe@redhat.com>
 <cb67381c-078c-62e6-e4c0-9ecf3de9e84d@intel.com>
In-Reply-To: <cb67381c-078c-62e6-e4c0-9ecf3de9e84d@intel.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Fri, 29 Jun 2018 13:48:06 -0400
X-Gmail-Original-Message-ID: <CAGM2rebsL_fS8XKRvN34NWiFN3Hh63ZOD8jDj8qeSOUPXcZ2fA@mail.gmail.com>
Message-ID: <CAGM2rebsL_fS8XKRvN34NWiFN3Hh63ZOD8jDj8qeSOUPXcZ2fA@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] mm/sparse: Optimize memmap allocation during sparse_init()
To:     dave.hansen@intel.com
Cc:     bhe@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, pagupta@redhat.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8939 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=536
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806290190
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +      * increase 'nr_consumed_maps' whether its allocation of memmap
> > +      * or usemap failed or not, so that after we handle the i-th
> > +      * memory section, can get memmap and usemap of (i+1)-th section
> > +      * correctly. */
>
> This makes no sense to me.  Why are we incrementing 'nr_consumed_maps'
> when we do not consume one?
>
> You say that we increment it so that things will work, but not how or
> why it makes things work.  I'm confused.

Hi Dave,

nr_consumed_maps is a local counter. map_map contains struct pages for
each section. In order to assign them to correct sections this local
counter must be incremented even when some parts of map_map are empty.

Here is example:
Node1:
map_map[0] -> Struct pages ...
map_map[1] -> NULL
Node2:
map_map[2] -> Struct pages ...

We always want to configure section from Node2 with struct pages from
Node2. Even, if there are holes in-between. The same with usemap.

Pavel
