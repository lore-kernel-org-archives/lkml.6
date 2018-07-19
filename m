Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5CFC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510E720684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1PgFFeS2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 510E720684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731798AbeGSOBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:01:52 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:49596 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730899AbeGSOBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:01:52 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6JDIiaT027202
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 13:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=E1Onz20iGN36Z7fo2MEp/+BR2pDFQIulIhxmvq52TrQ=;
 b=1PgFFeS27hFGwI7G5dS0So5vmockL2zxC9HRhV1cB1rooYO41pZ1bcEZ0epkWY4fkvJ5
 +w085L4DT4SqYaSU9FGNThaWfzxXg6mzbT9iy6rspbZGhR+G7WWAOznR07IShCdxjVLT
 QN1yDqC0XcvEay38ab+Id0j9hjmVkPSyfuPio7ZljtPLR4W4XZIyqAYXsDaaiE0vDwsr
 rI4z18ni/OzZJfEviUD94urmxFsvTYGGxhxci+0MYq4xQcr4xt4PJ7+itW1DaIxauAkr
 fueKTVA2fia5E75MLDIk3TtobdNmy4nTBOw4PVLW+76oPht71+J5uiVmPva1idN1fydu WA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2k7a3tagr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 13:18:44 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6JDIha3027518
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 13:18:43 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6JDIhfM018108
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 13:18:43 GMT
Received: from mail-oi0-f44.google.com (/209.85.218.44)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Jul 2018 06:18:43 -0700
Received: by mail-oi0-f44.google.com with SMTP id w126-v6so15421444oie.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 06:18:42 -0700 (PDT)
X-Gm-Message-State: AOUpUlHahlvfbN8wVVJcov9tgpkpaw2y5fMTwLBo5RJg+fCa69klJ4ue
        xdai5y6XqtyLdpsPcX2WmoqzCviDfp+oj/sSrDI=
X-Google-Smtp-Source: AAOMgpcx855++Fi1KOndiv7sM7PZU18l9Nj/kP7CFrirIRAYSjjf+t9UCKBRUwQN3G7t+vmkZLI39bqc80N1DKTFVGc=
X-Received: by 2002:aca:edc1:: with SMTP id l184-v6mr10014060oih.65.1532006322387;
 Thu, 19 Jul 2018 06:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180718124722.9872-1-osalvador@techadventures.net>
 <20180718124722.9872-2-osalvador@techadventures.net> <20180718141150.imiyuust5txfmfvw@xakep.localdomain>
 <20180719121902.GB8750@techadventures.net>
In-Reply-To: <20180719121902.GB8750@techadventures.net>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Thu, 19 Jul 2018 09:18:06 -0400
X-Gmail-Original-Message-ID: <CAGM2reaQkRDYvMsH=nVa=ZZTwAcqEE=omn6ma3=y8N7=UX=65g@mail.gmail.com>
Message-ID: <CAGM2reaQkRDYvMsH=nVa=ZZTwAcqEE=omn6ma3=y8N7=UX=65g@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm/page_alloc: Move ifdefery out of free_area_init_core
To:     osalvador@techadventures.net
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>, iamjoonsoo.kim@lge.com,
        aaron.lu@intel.com, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        osalvador@suse.de
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8958 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=833
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807190143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 > +             zone_set_nid(nid);
>
> This should be:
>
> zone_set_nid(zone, nid);
>
> I fixed it up in your patch, I hope that is ok.

Yes, thank you. I fixed this when compile tested this patch, but must
have forgotten to regenerate the patch before sending it.

Thank you,
Pavel

>
> Thanks
> --
> Oscar Salvador
> SUSE L3
>
