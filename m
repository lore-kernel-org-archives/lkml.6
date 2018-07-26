Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7BAC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951CC20647
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vnOS1UOc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951CC20647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388854AbeGZShL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 14:37:11 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38550 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730085AbeGZShL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 14:37:11 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6QHJ75Y027739
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 17:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=CEaYXm+XgcxY+5Gn8GAz42oEpnrWeOCO743XgToFKyw=;
 b=vnOS1UOcz0khT9TBDiMVOQR1Ax/WL3K31TkwfToixbRjbWvjR/0MQBJ50VhYlAdSw1ed
 jv+GzG9GJZPSfz5E7T1c5li9177Zf/xAymK1kb4OhvppwCEAtmbI7s9BHT+mFGqyaWRV
 l8HCOthi+sMp4MovqlfakCerwnjngTSVjKyqa231RlVVZAk3zPuv3A/fHw8AoHdeWePS
 vVVy6nuSmL1u/T7n6LtID1MjtNJTJvWLgOUkEqSnc50ws7XJxQbGInn06S4GVX3Phjqq
 yzFeMFTBUSEr7+hj3mdUKJsKBO9fiVwsHMAv7IZgRuaJnbc9BqL0RREf4T93hqsSoiRe GA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2kbwfq42am-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 17:19:25 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6QHJNkv021297
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 17:19:23 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6QHJNt0009197
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 17:19:23 GMT
Received: from mail-oi0-f46.google.com (/209.85.218.46)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Jul 2018 10:19:23 -0700
Received: by mail-oi0-f46.google.com with SMTP id k81-v6so4304753oib.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 10:19:23 -0700 (PDT)
X-Gm-Message-State: AOUpUlEeXyV41T6JfzbHfPgFmo0BYW/TZwF9hmKXLjHYcIcxHd2lKEhs
        m38eJcFqA4PQ88LXyaZPCeTvhVTIyNRN0q3VuDo=
X-Google-Smtp-Source: AAOMgpd657icl0KgJcbAukoKGOm3AxSaHESwDqQAy0aaTnnns4MukHb0fOpFSA+S5Yu2J49THrvAibRmna8pZjrkAdE=
X-Received: by 2002:aca:db09:: with SMTP id s9-v6mr3037422oig.339.1532625562767;
 Thu, 26 Jul 2018 10:19:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180725220144.11531-1-osalvador@techadventures.net>
 <20180725220144.11531-3-osalvador@techadventures.net> <20180726080500.GX28386@dhcp22.suse.cz>
 <20180726081215.GC22028@techadventures.net> <20180726151420.uigttpoclcka6h4h@xakep.localdomain>
 <20180726164304.GP28386@dhcp22.suse.cz>
In-Reply-To: <20180726164304.GP28386@dhcp22.suse.cz>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Thu, 26 Jul 2018 13:18:46 -0400
X-Gmail-Original-Message-ID: <CAGM2reatUAekg=e9FQM1-UVLOSBKb74-FYo7FcPqO_WaR7AmOQ@mail.gmail.com>
Message-ID: <CAGM2reatUAekg=e9FQM1-UVLOSBKb74-FYo7FcPqO_WaR7AmOQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] mm: access zone->node via zone_to_nid() and zone_set_nid()
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=739
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807260178
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > OpenGrok was used to find places where zone->node is accessed. A public one
> > is available here: http://src.illumos.org/source/
>
> I assume that tool uses some pattern matching or similar so steps to use
> the tool to get your results would be more helpful. This is basically
> the same thing as coccinelle generated patches.

OpenGrok is very easy to use, it is source browser, similar to cscope
except obviously you can't edit the browsed code. I could have used
cscope just as well here.

Pavel
