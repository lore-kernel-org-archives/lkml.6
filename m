Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBB4C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 00:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E91520850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 00:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Eb3uDUv9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E91520850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937162AbeFSAuU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 20:50:20 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60530 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937043AbeFSAuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 20:50:19 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5J0mQKL035316
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 00:50:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=MHS3Xa32kI2yGvAUsXRPUKvbw1Fvkfd/oUi36r/nCS0=;
 b=Eb3uDUv9waj4Y4w2kuvnp5gT+Z8Qx+Hv0xhZcwCYr21qQEjQS52d86cMhZSryxlw+pSN
 Uh8FcjXDVdnwlrYTK/lYTZBGkDhib4jQRG8iQM0yIc6UtMY2dT+wG4bYj6Pw001e03xG
 U0QY9CnejjQI2rO4OqgrdgSWwuFdV4IAEfHh0qxo/Y3XirgvLK/aXcy4sFzSpA4NMmkM
 7bpZO7z5kq0SKAFv9rv94uckFxA2ShxnRoC7p2ykAgn74og49fWmjxkqF0o5kXukWZH3
 in4Jsp3YY3PNiwlXkxqO0iC+B6Xz59q5tKtH3yENr4Rerbet2Tr2ZNQkeiW/wYtoz5UL rw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2jmtgwp4f1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 00:50:18 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5J0oGmI004588
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 00:50:16 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5J0oGsx028505
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 00:50:16 GMT
Received: from mail-oi0-f51.google.com (/209.85.218.51)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Jun 2018 17:50:16 -0700
Received: by mail-oi0-f51.google.com with SMTP id c128-v6so16585098oig.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 17:50:16 -0700 (PDT)
X-Gm-Message-State: APt69E2tT1nIRsmWpefsaA3FpZPQkNkdnangDMpgjLgQK9nm7/BqvT1l
        hP3c8iQvvo4hn4nEEw4qPq4yV97Mb6ZY84XMaYY=
X-Google-Smtp-Source: ADUXVKITtG4y6dlChGbGpcSGP9qEiYA4fSAjW9GpYzG5jnb3o7Pg11AzOdV0YCWc0KRKYq3GPpOlDkJcnPHe3T865Do=
X-Received: by 2002:aca:56c8:: with SMTP id k191-v6mr7687824oib.221.1529369415802;
 Mon, 18 Jun 2018 17:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180607100256.GA9129@hori1.linux.bs1.fc.nec.co.jp>
 <20180613054107.GA5329@hori1.linux.bs1.fc.nec.co.jp> <20180613090700.GG13364@dhcp22.suse.cz>
 <20180614051618.GB17860@hori1.linux.bs1.fc.nec.co.jp> <20180614053859.GA9863@techadventures.net>
 <20180614063454.GA32419@hori1.linux.bs1.fc.nec.co.jp> <20180614213033.GA19374@techadventures.net>
 <20180615010927.GC1196@hori1.linux.bs1.fc.nec.co.jp> <20180615072947.GB23273@hori1.linux.bs1.fc.nec.co.jp>
 <20180615084142.GE24039@dhcp22.suse.cz> <20180615140000.44tht4f3ek3lh2u2@xakep.localdomain>
 <20180618163616.52645949a8e4a0f73819fd62@linux-foundation.org>
In-Reply-To: <20180618163616.52645949a8e4a0f73819fd62@linux-foundation.org>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Mon, 18 Jun 2018 20:49:39 -0400
X-Gmail-Original-Message-ID: <CAGM2reboodsYSbu6PPDNoFS7zWH0W1w84TCgouu0EL4sOyGbMg@mail.gmail.com>
Message-ID: <CAGM2reboodsYSbu6PPDNoFS7zWH0W1w84TCgouu0EL4sOyGbMg@mail.gmail.com>
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
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8928 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=504
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806190007
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So I expect this patch needs a cc:stable, which I'll add.
Yes.
> The optimiation patch seems less important and I'd like to hold that
> off for 4.19-rc1?
I agree, the optimization is not as important, and can wait for 4.19.
