Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14369C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 03:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1F325860
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 03:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UmHZ9B3U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB1F325860
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932166AbeGBDEF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 23:04:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36376 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752416AbeGBDED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 23:04:03 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w62343iP112107
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 03:04:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=WyT1LAYCUI16/JRcHyYNVtgiiP2gNxgIs0W5+TLKqXw=;
 b=UmHZ9B3UJEePUGS46AyyuxLWwZ47iJ3HthBuBj90l9knsHQTKJvop77EUM+SpS4+vAIS
 /BvaU7rJLDg4yXQtv3l26halExNlSt7hTs03GM/E66lknWkjcMO0An1QYtSG+K+rBKED
 H87218z0hNihx+5iiyiFDC9/TA5HfUtbjfwUF01X8a546h7R00pB9tW/TOivlBD5TwSs
 NKQCUBAtOKDEytHCiuT6xIJNHw6wapx32xXMJZFzzCWTh7Vh9EgtCygt3KDSrqVwyQSk
 E37FXLN0yxuhj5FqWOkISlKMlFllLjbRAPcCvmCUz4rtNnAajwlj8R8ZLcEMvfulNKyx jQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2jx2gptkft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 03:04:02 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w62341nX002604
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 03:04:02 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w62341ui007356
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 03:04:01 GMT
Received: from mail-oi0-f42.google.com (/209.85.218.42)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 01 Jul 2018 20:04:01 -0700
Received: by mail-oi0-f42.google.com with SMTP id m2-v6so5725947oim.12
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 20:04:01 -0700 (PDT)
X-Gm-Message-State: APt69E1z4rlib/5igy904SI6ZO8lT3yEqUT1WyIuNUq+98fresILRSZV
        12uFnMSiFHOS5s48GKgz/VBGSYebVrUo8PXuKTw=
X-Google-Smtp-Source: AAOMgpf6b/1IiOZlC2eH0p9OKB53G5S+mIPjyOv9KbuqazOZYxpKMN6ulk3Ma3QG90Mo1bg+uzHCSs+75s4pb08uQjg=
X-Received: by 2002:aca:4784:: with SMTP id u126-v6mr14400452oia.229.1530500640719;
 Sun, 01 Jul 2018 20:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180702020417.21281-1-pasha.tatashin@oracle.com>
 <20180702020417.21281-2-pasha.tatashin@oracle.com> <20180702021121.GL3223@MiWiFi-R3L-srv>
 <CAGM2rebY1_-3hvp_+kqF==nLawC0FN6Q1J5X5pm5qxHdDJzjiQ@mail.gmail.com>
 <20180702023130.GM3223@MiWiFi-R3L-srv> <CAGM2rebUsJ2r-2F38Vv13zbaEPPgTn0w6H3j6fpg0WVa9wB6Uw@mail.gmail.com>
 <20180702025343.GN3223@MiWiFi-R3L-srv>
In-Reply-To: <20180702025343.GN3223@MiWiFi-R3L-srv>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Sun, 1 Jul 2018 23:03:24 -0400
X-Gmail-Original-Message-ID: <CAGM2reatQzroymAb8kaPKgd8sEehtScH9DAELeWpYCaNNnAU6w@mail.gmail.com>
Message-ID: <CAGM2reatQzroymAb8kaPKgd8sEehtScH9DAELeWpYCaNNnAU6w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm/sparse: add sparse_init_nid()
To:     bhe@redhat.com
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kirill.shutemov@linux.intel.com, Michal Hocko <mhocko@suse.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        dan.j.williams@intel.com, jack@suse.cz, jglisse@redhat.com,
        Souptick Joarder <jrdr.linux@gmail.com>,
        gregkh@linuxfoundation.org, Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@gmail.com>, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org, osalvador@techadventures.net
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8941 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=585
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807020035
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Ah, yes, I misunderstood it, sorry for that.
>
> Then I have only one concern, for vmemmap case, if one section doesn't
> succeed to populate its memmap, do we need to skip all the remaining
> sections in that node?

Yes, in sparse_populate_node() we have the following:

294         for (pnum = pnum_begin; map_index < map_count; pnum++) {
295                 if (!present_section_nr(pnum))
296                         continue;
297                 if (!sparse_mem_map_populate(pnum, nid, NULL))
298                         break;

So, on the first failure, we even stop trying to populate other
sections. No more memory to do so.

Pavel
