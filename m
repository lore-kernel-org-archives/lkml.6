Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F12C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C79C2612A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kGgYFMeU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C79C2612A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754651AbeF0PG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:06:59 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:51238 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752014AbeF0PG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:06:56 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5RF49GI177293;
        Wed, 27 Jun 2018 15:06:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=94DYSWv1/45axAhWRyUQ1It+if0i4ECTkU8AEGw5xyw=;
 b=kGgYFMeU3ZKcGiqSmAefxZPkFb8vy8xZf7sVGc1QPLvaBXuZ+dFcUWkKjByqNJ4/1P/R
 Q0tJt6qe9hBUXhFhhgS4bqNr97C6npnyM+0it0UPaVmASo+ReLQBDriYYkH4MI2YWDto
 23kqZXxsipqOwbn/Y+CrDAR2RMyLCt8UFeVlSs5EfDJxKJKpFTVdoUTJIMyVvGXDTxEY
 zu5MP4SZY6jdaJxH1wXXsVLZncFY7DueTQRY5R9lgMn2tij65HQcaUbWYjtIV0s+vlBA
 LUHiBSouHyMv/KOZ0jyyATesNMOapMlL/MOpp9N8Wo6VKRqnE2lW5VviLkQh17ZRnIX0 LQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2jukmtwbwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jun 2018 15:06:55 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5RF6ppH002677
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jun 2018 15:06:51 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5RF6pIb018640;
        Wed, 27 Jun 2018 15:06:51 GMT
Received: from mail-oi0-f42.google.com (/209.85.218.42)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Jun 2018 08:06:50 -0700
Received: by mail-oi0-f42.google.com with SMTP id r16-v6so1662525oie.3;
        Wed, 27 Jun 2018 08:06:50 -0700 (PDT)
X-Gm-Message-State: APt69E1N80EXuwoZCT4cbS0FTjTmFuxk2RfNVlZBUQw3Yzjke8iZnWaN
        OqyapDTn9xuCZsc1t1flg9d8k+7vnYvBbc4Myk0=
X-Google-Smtp-Source: AAOMgpe4qf/1MSs71xDwa5OezbaumLsB27/2YvbiXGmsbpGi3kx4ura/CSqTu0ZOzF+LwMeej5Dxf4rzxy1GxOqfsUI=
X-Received: by 2002:aca:bcd4:: with SMTP id m203-v6mr3572308oif.163.1530112010188;
 Wed, 27 Jun 2018 08:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180626204152.fyb5wzdduif2h5sg@dhcppc10> <20180627071925.GA32348@dhcp22.suse.cz>
 <CAGM2reaQYYrAP1mAWw4tV9+9z1pmnu5kOJj_g-O-kadqYrkx3w@mail.gmail.com> <20180627133843.rqzlfrn4sabftkn4@dhcppc10>
In-Reply-To: <20180627133843.rqzlfrn4sabftkn4@dhcppc10>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Wed, 27 Jun 2018 11:06:14 -0400
X-Gmail-Original-Message-ID: <CAGM2rebOhcpzzzoqmSfGNz5UdSCs4athvp8nQVm0TqdtaonCeA@mail.gmail.com>
Message-ID: <CAGM2rebOhcpzzzoqmSfGNz5UdSCs4athvp8nQVm0TqdtaonCeA@mail.gmail.com>
Subject: Re: Kernel crash after "mm: initialize pages on demand during boot"
To:     herton@redhat.com
Cc:     mhocko@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Miles Chen <miles.chen@mediatek.com>,
        Paul Burton <paul.burton@mips.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-mm@vger.kernel.org, aquini@redhat.com, lwoodman@redhat.com,
        n-horiguchi@ah.jp.nec.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8936 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=469
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806270165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 10:15 AM Herton R. Krzesinski <herton@redhat.com> wrote:
> Thanks, I'll try it. It'll probably work since I tried memory_reserve
> but "hacking" it at e820__register_nosave_regions, anyway I'll confirm
> it here.

If it works, please send the new "Reserved but unavailable" value from dmesg:
[    0.000000] Reserved but unavailable: 103 pages

Thank you,
Pavel
