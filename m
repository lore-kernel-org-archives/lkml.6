Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E796C6778C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 03:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B2A2553F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 03:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CCZz2kiP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B2A2553F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933282AbeGBDFm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 23:05:42 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37192 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932281AbeGBDFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 23:05:41 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6235VRd113369
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 03:05:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=1cQzL5FNjvHpTtfMNl4qKFhK4JiVzWAyyor7+dgMEqE=;
 b=CCZz2kiPj2piUYLBm+hoV6UB0s9Eqhk9F0FfqVDzxo1rSCq+wFXSW2jvNMV2t3ICgq7/
 ux4/bkiwmgdFCtFGonq1+pP3UqJIu+Kulj0qC4MOU325SWiExadyQw2jdkPhCOidljFE
 2PID6koFPLjcYyLWdFHTjE2oosMGuzNBA3UVLiB1oNHQYWWGAHVpQqOf02UKNSx1gHw8
 NRzZoO0nPBDoGB4d1sUBRlnPRDm+ZLqNg8EI9G3XbU7yqtvV71qQLw23UI+/QcghEwsg
 qbBaWciIveoTamqa6plydCWcyYZUxCzbjdLfZ3p/k57BAPZvfznZGfz88sTzhhHZuyrY yQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2jx2gptkhu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 03:05:40 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6235e6L020952
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 03:05:40 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6235dQI007777
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 03:05:39 GMT
Received: from mail-oi0-f48.google.com (/209.85.218.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 01 Jul 2018 20:05:39 -0700
Received: by mail-oi0-f48.google.com with SMTP id i12-v6so9271956oik.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 20:05:39 -0700 (PDT)
X-Gm-Message-State: APt69E0JzfHTlz5p6GvspUCy9ctopK1Ohui6GrMo9WN4dcnrArSRLTo8
        A0sfjB3+ZvFOBe40r3R+WI9XA+nmAACpFrR19QE=
X-Google-Smtp-Source: AAOMgpc0rj/U7rXrEYyPRYwoCtpASM6xtwBvkLlMH9Kpf8y6JE7ZLiEc/xIKTiA+0BgX2/8k03EoeBGqkBkrwDBe1UI=
X-Received: by 2002:aca:e5d2:: with SMTP id c201-v6mr14609358oih.191.1530500739177;
 Sun, 01 Jul 2018 20:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180702020417.21281-1-pasha.tatashin@oracle.com>
 <20180702020417.21281-2-pasha.tatashin@oracle.com> <20180702025632.GO3223@MiWiFi-R3L-srv>
In-Reply-To: <20180702025632.GO3223@MiWiFi-R3L-srv>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Sun, 1 Jul 2018 23:05:03 -0400
X-Gmail-Original-Message-ID: <CAGM2reZhB_J4WECCDcnTSuFrN1mdCshWhmiXNnZ1=Wuyxxjb7w@mail.gmail.com>
Message-ID: <CAGM2reZhB_J4WECCDcnTSuFrN1mdCshWhmiXNnZ1=Wuyxxjb7w@mail.gmail.com>
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
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=725
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807020035
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +     if (!usemap) {
> > +             pr_err("%s: usemap allocation failed", __func__);
>
> Wondering if we can provide more useful information for better debugging
> if failed. E.g here tell on what nid the usemap allocation failed.
>
> > +                                                pnum, nid);
> > +             if (!map) {
> > +                     pr_err("%s: memory map backing failed. Some memory will not be available.",
> > +                            __func__);
> And here tell nid and the memory section nr failed.

Sure, I will wait for more comments, if any, and add more info to the
error messages in the next revision.

Thank you,
Pavel
