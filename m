Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E844DFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E8120870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KR/LBK6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E8120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbeG3RVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:21:45 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42432 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbeG3RVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:21:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6UFiHAo067008
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 15:46:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=btQoPOstpS8oPRDEn68m4N9FLAKsJ3gx97ZqPSrvg60=;
 b=KR/LBK6GTqFf3QK5o7jhFVV87gbMqRWs30v6UT7Ey+4aZ1I2HjmQUEPnyGAD3Q1oCQ9E
 VYuD/l+OFbvWnkb5rJ/rbCg1MK58LlYkbXyPPLXiozF+Gf6eU/T7pngiu/HyUoCcEBPL
 n4ugUOzTMuD2Z2mQUDhxC9wCIE5L9SKzhTgS1D6KX/18hkxUfyW2qX5jjb2M963+StF4
 itu/B+A3Y/Y/b7N1z9RJbYamdOPffZe+sxtH8SlH96szxp1MgUl11Z7Lz4DFE1Fa0mVb
 6DJB1R49DczY2si14iESOWqDhi9j0CJ42+38uhlCGWwHNgBMNGJwRkgV1tv1TyT/cbyj cg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2kgh4pw2s1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 15:46:10 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6UFk7YS006269
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 15:46:08 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6UFk7vD003026
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 15:46:07 GMT
Received: from mail-oi0-f54.google.com (/209.85.218.54)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Jul 2018 08:46:07 -0700
Received: by mail-oi0-f54.google.com with SMTP id b15-v6so22080626oib.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 08:46:07 -0700 (PDT)
X-Gm-Message-State: AOUpUlENji85YxQG33PTmk3S9WhOiap/h28+TuP+GKW4tVsbgBBUCUL/
        6+qGyg37MSM6BfjJNeRgbnIqadDyRk5qr22lu+4=
X-Google-Smtp-Source: AAOMgpc2DvLW/vcK2rVWN5ZnOn/c5N8c6Ax6AzSCbxklFC9c7vdWPyjVEVbbQwBw0NzmJnjBmDOEm2ONKwgeNpQXxZQ=
X-Received: by 2002:aca:edc1:: with SMTP id l184-v6mr17170879oih.65.1532965567126;
 Mon, 30 Jul 2018 08:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180727165454.27292-1-david@redhat.com> <20180730113029.GM24267@dhcp22.suse.cz>
 <6cc416e7-522c-a67e-2706-f37aadff084f@redhat.com> <20180730120529.GN24267@dhcp22.suse.cz>
 <7b58af7b-5187-2c76-b458-b0f49875a1fc@redhat.com> <CAGM2reahiWj5LFq1npRpwK2k-4K-L9hr3AHUV9uYcmT2s3Bnuw@mail.gmail.com>
 <56e97799-fbe1-9546-46ab-a9b8ee8794e0@redhat.com> <20180730141058.GV24267@dhcp22.suse.cz>
 <80641d1a-72fe-26b2-7927-98fcac5e5d71@redhat.com> <20180730145035.GY24267@dhcp22.suse.cz>
 <0be90c23-e5a0-2628-c671-9923d8e45b0a@redhat.com>
In-Reply-To: <0be90c23-e5a0-2628-c671-9923d8e45b0a@redhat.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Mon, 30 Jul 2018 11:45:31 -0400
X-Gmail-Original-Message-ID: <CAGM2rebjVFpeWKV1wx5=3f6=Tx6h5qT9jszacGpB9pEcYKO1FA@mail.gmail.com>
Message-ID: <CAGM2rebjVFpeWKV1wx5=3f6=Tx6h5qT9jszacGpB9pEcYKO1FA@mail.gmail.com>
Subject: Re: [PATCH v1] mm: inititalize struct pages when adding a section
To:     david@redhat.com
Cc:     mhocko@kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, gregkh@linuxfoundation.org,
        mingo@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        dan.j.williams@intel.com, jack@suse.cz, mawilcox@microsoft.com,
        jglisse@redhat.com, Souptick Joarder <jrdr.linux@gmail.com>,
        kirill.shutemov@linux.intel.com, Vlastimil Babka <vbabka@suse.cz>,
        osalvador@techadventures.net, yasu.isimatu@gmail.com,
        malat@debian.org, Mel Gorman <mgorman@suse.de>,
        iamjoonsoo.kim@lge.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8969 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=880
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807300172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> So i guess we agree that the right fix for this is to not touch struct
> pages when removing memory, correct?

Yes in my opinion that would be the correct fix.

Thank you,
Pavel

>
> --
>
> Thanks,
>
> David / dhildenb
>
