Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB41C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213A72075E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ivFK0SMn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 213A72075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933392AbeFUNj3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:39:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56166 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933161AbeFUNj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:39:26 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5LDdPwV058965
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 13:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=unxJEchK4PQQEGkuNmE0Sv0aZMMB5mi6/sArK8w3mdg=;
 b=ivFK0SMnvkJz+GeWbhAEGIBUMWauvr6e07VbdidTV/HlhV5g/5zh+jrPI0naxKQ8cSJl
 bjRrbgFt9aqjcaJk50x0VnR0gYgJMKDXT9boB7OyJ+Ik4dMkXxifrp9tH6dC0yxBQhfr
 KZzpz7Lt1JnE0YmX3DOS6Cou6MkUcL75fPwXGuKiK7pK6ik3/mjB87dnWsFv6VHvFTJE
 wvSesvD6QROlk2YqweI9GLCNQ7EB/+QONdGJfPE2CT9E7sjxe44WKxR3SX7atwb4Mv4j
 cjZe71sTZ8qqagzWu6T41VETpK8oNe13CfVRXh1ZFc51Jiw6kOL/UbkOqC6AtXpDSqmO mg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2jmu6y0rdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 13:39:25 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5LDdO5U017550
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 13:39:24 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5LDdNUj009351
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 13:39:24 GMT
Received: from mail-ot0-f180.google.com (/74.125.82.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Jun 2018 06:39:23 -0700
Received: by mail-ot0-f180.google.com with SMTP id a5-v6so3572204otf.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 06:39:23 -0700 (PDT)
X-Gm-Message-State: APt69E3I2MdcIuNyrkOwXcSjb9ZlRO+RrVZsB4veK2kOc94s/1/2bw2e
        P2Y3+Q/dtDzxrrbsyeQ5yHIrCyJVxZ4KJxfwOA0=
X-Google-Smtp-Source: ADUXVKKrxGgdDcFA7vU5ZcJj+FDqMlsgl2LYV/2MmW8oI4OcNobbSPxnzM14pU97LAOxGxZIxveyxNVPNqzBIQg9jbo=
X-Received: by 2002:a9d:2010:: with SMTP id n16-v6mr14664075ota.275.1529588363186;
 Thu, 21 Jun 2018 06:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180620212700.29178-1-pasha.tatashin@oracle.com>
 <20180620212700.29178-7-pasha.tatashin@oracle.com> <20180621055144.i65hhyqe5dofop33@shbuild888>
 <CAGM2reYethiqDLM0dRRSihvRCi24b_B=eBR05G=nWVQSL9LVww@mail.gmail.com> <20180621133041.GZ2494@hirez.programming.kicks-ass.net>
In-Reply-To: <20180621133041.GZ2494@hirez.programming.kicks-ass.net>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Thu, 21 Jun 2018 09:38:47 -0400
X-Gmail-Original-Message-ID: <CAGM2reaDaTbXF0f_2uQ6vGDvWKhwMe+dhFo-bcCDobejafasiA@mail.gmail.com>
Message-ID: <CAGM2reaDaTbXF0f_2uQ6vGDvWKhwMe+dhFo-bcCDobejafasiA@mail.gmail.com>
Subject: Re: [PATCH v11 6/6] x86/tsc: use tsc early
To:     peterz@infradead.org
Cc:     feng.tang@intel.com, Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, prarit@redhat.com,
        Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk,
        bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8930 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=505
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806210151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Bah, no, we don't make a mess first and then maybe clean it up.

OK, I will add this path to the series.

>
> Have a look at the below. The patch is a mess, but I have two sick kids
> on hands

Sorry to hear that, I hope your kids will get better soon.

> , please clean up / split where appropriate.

OK

Thank you,
Pavel
