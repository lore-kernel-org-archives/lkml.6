Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935EEC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 452FD22B45
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KlkgnNws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 452FD22B45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752961AbeGBUca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:32:30 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43368 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752580AbeGBUc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:32:26 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w62KSbes113472
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 20:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=hKz8wFeSDXWEQ8Unk01ap3CKQcncs6OoZfU/bdAVC6o=;
 b=KlkgnNwsXcCA8btEdc+lPDwOVFTzIdqCsNyLAUPXHyxPV4o+suOsHPfutrBlZZVDLOw4
 4DIAv39lZTM2SU0Yu9J8eFugeFzIlUCZjKgaPEyN5ZlPGx9syRvNoEckt1Ltas9Xrixp
 YVoNjlXZzHBnpX8DTjKP/avoMxYw2O+DjVlIaNJmOW4mPo7GIBOBZwUWqbZSFfJfHnY2
 TiBw9pLg1bKYgDcuLOXUrlBlzTSFvZq7YyN3kDvFJhXXF9RF5bVBUmci0b1gQ/HKqVOS
 oiFwQkLe3OM7JRkGMuf6TwelTJ+VfwN1lYMYrLrdRFKTSygtDCoquQz03+REzzV6Ybeb 1g== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2jwyccp475-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 20:32:25 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w62KWOf7014801
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 20:32:24 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w62KWOZB028230
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 20:32:24 GMT
Received: from mail-oi0-f45.google.com (/209.85.218.45)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Jul 2018 13:32:24 -0700
Received: by mail-oi0-f45.google.com with SMTP id b15-v6so4664835oib.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 13:32:24 -0700 (PDT)
X-Gm-Message-State: APt69E2nh7UZLWGW/43Cu+VKwFNuTCIRRaPNWr+UAGS621x1r1joxCJf
        D5cOMlPgByYGkpTb8YNzWE90+gsrraVehEMje9g=
X-Google-Smtp-Source: AAOMgpdpDc+oGac7ltfTN4iDhgn0eiILF8x+WlzIwX5vCGtEgKiqHRiet/y/bzS0G1O8t3qBwfFsC2a/1qLFJ0MwVA8=
X-Received: by 2002:a54:4f88:: with SMTP id g8-v6mr3570493oiy.191.1530563544478;
 Mon, 02 Jul 2018 13:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180607100256.GA9129@hori1.linux.bs1.fc.nec.co.jp>
 <20180613054107.GA5329@hori1.linux.bs1.fc.nec.co.jp> <20180613090700.GG13364@dhcp22.suse.cz>
 <20180614051618.GB17860@hori1.linux.bs1.fc.nec.co.jp> <20180614053859.GA9863@techadventures.net>
 <20180614063454.GA32419@hori1.linux.bs1.fc.nec.co.jp> <20180614213033.GA19374@techadventures.net>
 <20180615010927.GC1196@hori1.linux.bs1.fc.nec.co.jp> <20180615072947.GB23273@hori1.linux.bs1.fc.nec.co.jp>
 <20180615084142.GE24039@dhcp22.suse.cz> <20180615140000.44tht4f3ek3lh2u2@xakep.localdomain>
 <20180618163616.52645949a8e4a0f73819fd62@linux-foundation.org>
 <CAGM2reZ6PTYw3NivSCO5WMCrYGJH_-piz8TtYgpwLWT=SnBGYA@mail.gmail.com> <20180702132830.9ee21727cae72a5d52e3052d@linux-foundation.org>
In-Reply-To: <20180702132830.9ee21727cae72a5d52e3052d@linux-foundation.org>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Mon, 2 Jul 2018 16:31:48 -0400
X-Gmail-Original-Message-ID: <CAGM2reaUHFX63ZKiiDhXriUmtLAxH3QOePbm7mGkRMgjNXtTXQ@mail.gmail.com>
Message-ID: <CAGM2reaUHFX63ZKiiDhXriUmtLAxH3QOePbm7mGkRMgjNXtTXQ@mail.gmail.com>
Subject: Re: [PATCH v3] x86/e820: put !E820_TYPE_RAM regions into memblock.reserved
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     mhocko@kernel.org, n-horiguchi@ah.jp.nec.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        osalvador@techadventures.net, osalvador@suse.de,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        willy@infradead.org, LKML <linux-kernel@vger.kernel.org>,
        mingo@kernel.org, dan.j.williams@intel.com, ying.huang@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8942 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=233
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807020229
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> http://ozlabs.org/~akpm/mmots/broken-out/mm-skip-invalid-pages-block-at-a-time-in-zero_resv_unresv.patch
> has been in -mm since Jun 18, so all is well.

Ah missed it. Thank you.

Pavel
