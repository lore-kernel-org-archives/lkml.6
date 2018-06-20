Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FA1C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 21:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD772083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 21:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U2aMex46"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CD772083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933660AbeFTVa6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 17:30:58 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50124 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933326AbeFTVa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 17:30:56 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5KLQDsB067011
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 21:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=Dy9i5bpgX+9vpFIAGc/eGOrAZP9RdoDvYS1mMu7JWLQ=;
 b=U2aMex46jUlMr/R52nAehHL26krB6BhkILzD2ac/ScDZ4JYBpyBKJkGFdKKtjTMCHojo
 073QXWHDORexxCJ78iY4yLq2hOCWQbDmEiYjEMn1PJmO+5FWwufZvQvSxbLO9WhZ6/yO
 F+rWB2VXY6dT5Wiki8CIb7HMDaTUaSBT9fkZMb0AcZcl3G56mLvqynUjavQa9QkXPiyX
 7Dm86wQEEiLOw0T5Y+UiDEuBcdQNpscvbZNfgzLYoYxGSnEQDpdM+J7ABDgVqt9ic3IW
 FwQxboY9S6mMJmRyylwF+gNnwqUfF76d0fnWzcsM8sr2Gj6uJi7sneeeIZHUfZxiL+PG og== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2jmtgwxadf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 21:30:55 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5KLUs4E026104
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 21:30:54 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5KLUsBE002204
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 21:30:54 GMT
Received: from mail-oi0-f49.google.com (/209.85.218.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Jun 2018 14:30:53 -0700
Received: by mail-oi0-f49.google.com with SMTP id e8-v6so983769oii.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 14:30:53 -0700 (PDT)
X-Gm-Message-State: APt69E32JwW7wsBAxu19D+jrDYG21wOycWngnZkMP4BuJ9bhlZX45I81
        q/jT2VF6TROz/bi4ZMLfzXZtUosEu7dM6OULS+4=
X-Google-Smtp-Source: ADUXVKID44pyGVEXLg0ujFwV4pTLqVzJHk40b0Rsai2s6wL4m01kK1iMRIq/UTgBTrQuRlGA0W3U3esverAahYnWAFs=
X-Received: by 2002:aca:e5d2:: with SMTP id c201-v6mr13472081oih.191.1529530253307;
 Wed, 20 Jun 2018 14:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180615174204.30581-1-pasha.tatashin@oracle.com>
 <20180615174204.30581-8-pasha.tatashin@oracle.com> <alpine.DEB.2.21.1806192335390.10546@nanos.tec.linutronix.de>
 <20180620091532.GK2476@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1806201231030.10546@nanos.tec.linutronix.de>
 <20180620123208.GN2476@hirez.programming.kicks-ass.net>
In-Reply-To: <20180620123208.GN2476@hirez.programming.kicks-ass.net>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Wed, 20 Jun 2018 17:30:17 -0400
X-Gmail-Original-Message-ID: <CAGM2reZjKxiG+7P65=-sV7PdN_UepGT5QipWFScZ+TpAfDHQqQ@mail.gmail.com>
Message-ID: <CAGM2reZjKxiG+7P65=-sV7PdN_UepGT5QipWFScZ+TpAfDHQqQ@mail.gmail.com>
Subject: Re: [PATCH v10 7/7] x86/tsc: use tsc early
To:     peterz@infradead.org
Cc:     tglx@linutronix.de, Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com,
        prarit@redhat.com, feng.tang@intel.com,
        Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8930 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=659
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806200231
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

> That said; flipping static keys early isn't hard. We should call
> jump_label_init() early, because we want the entries sorted and the
> key->entries link set. It will also replace the GENERIC_NOP5_ATOMIC
> thing, which means we need to also do arch_init_ideal_nop() early, but
> since that is pure CPUID based that should be doable.
>
> And then something like the below could be used.

I like the idea of making static branches available early, as it can
be used in more places
during boot.

However, that should be part of a separate project, and a follow up
cleanup can be done
to places that benefit from it. Such as tsc.c and perhaps sched.c
might benefit as well.

Thank you,
Pavel
