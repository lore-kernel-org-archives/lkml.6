Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D03AC6778C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA620253DD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WPYt6kOB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA620253DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932776AbeGBB41 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 21:56:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59450 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932102AbeGBB4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 21:56:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w621sCFr070057
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 01:56:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=dqdRpM1rc3sc/hri3YTxZRe5+KxN0rtSSMvCbcMrMAg=;
 b=WPYt6kOBCqOdWOhB+MmwlqOAVvlZgRyTHo1thjAuqm83Ql1tsTGGjLUwamNvzByBNJw6
 agfMZPbhRC1qRu5M4HtZnR3m8D9gorIh0wxZsMsUnn8qIi0EYi1nUX29BkxFxiChsUNJ
 MS7NVzhGeBbKMypIXsczr+nh+L01A64umBwqBisX5BWIirmD6W2GLgziCv5fn/6KzdcD
 6ZHOILPppZn2r7gwArStSX8hUNMwBSxvM6Du9VCEwo8mF3GHNAL9il/gKjkYdyB64UgM
 NUKicCC3F5ENpgiDjljkbfsjR5TPn8trKQ2I4HfZR+gzkhWhTX0xSaVrQkit6WPXk9In SQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2jx2gptgkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 01:56:25 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w621uO5h011736
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 01:56:24 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w621uOoY027638
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 01:56:24 GMT
Received: from mail-oi0-f41.google.com (/209.85.218.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 01 Jul 2018 18:56:24 -0700
Received: by mail-oi0-f41.google.com with SMTP id v8-v6so13490195oie.5
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 18:56:24 -0700 (PDT)
X-Gm-Message-State: APt69E1aOe0Co6VO7kd0akE1qPhjN3m+fcTEqBFuIMOZcxQnovvSeUVS
        9V6px/QdQXBJMuj2V2gbkauBbgIZ0ZWNcuMk8/A=
X-Google-Smtp-Source: AAOMgpc3Iy1zxNKbOsBvIm9kSevLpy77tEgTi0E9rrwrawdGFGhJ6QlyGBOuWydt1dwopwMrqcIGTNvsDiBdAgTb5yY=
X-Received: by 2002:aca:3b09:: with SMTP id i9-v6mr14524833oia.156.1530496583928;
 Sun, 01 Jul 2018 18:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180630030944.9335-1-pasha.tatashin@oracle.com>
 <20180630030944.9335-3-pasha.tatashin@oracle.com> <20180702013918.GJ3223@MiWiFi-R3L-srv>
 <CAGM2reYRYNOe0nweMrSxLZ_RRQbu500iSRKWrbO4_CzyWTEtjQ@mail.gmail.com> <20180702015211.GK3223@MiWiFi-R3L-srv>
In-Reply-To: <20180702015211.GK3223@MiWiFi-R3L-srv>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Sun, 1 Jul 2018 21:55:47 -0400
X-Gmail-Original-Message-ID: <CAGM2reYQaz0qr8nvHrSG_Vw_raR-d7cQeH=rZyC1nrTKfFhZ-g@mail.gmail.com>
Message-ID: <CAGM2reYQaz0qr8nvHrSG_Vw_raR-d7cQeH=rZyC1nrTKfFhZ-g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm/sparse: start using sparse_init_nid(), and
 remove old code
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
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=794
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807020021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Yes, if they are equal at 501, 'continue' to for loop. If nid is not
> equal to nid_begin, we execute sparse_init_nid(), here should it be that
> nid_begin is the current node, nid is next node?

Nevermind, I forgot about the continue, I will fix it. Thank you again!

Pavel
