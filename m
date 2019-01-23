Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72591C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C0420870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfAWJYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 04:24:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55400 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727254AbfAWJYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 04:24:51 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0N9OITI121340
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 04:24:50 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q6mfj2nqy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 04:24:49 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Wed, 23 Jan 2019 09:24:47 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 23 Jan 2019 09:24:45 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0N9Ojwi25821252
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Jan 2019 09:24:45 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC48FAE045;
        Wed, 23 Jan 2019 09:24:44 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AAE65AE05D;
        Wed, 23 Jan 2019 09:24:44 +0000 (GMT)
Received: from osiris (unknown [9.152.212.95])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 23 Jan 2019 09:24:44 +0000 (GMT)
Date:   Wed, 23 Jan 2019 10:24:43 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Stefan Liebler <stli@linux.ibm.com>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggered
References: <20181127081115.GB3625@osiris>
 <alpine.DEB.2.21.1811281526430.1532@nanos.tec.linutronix.de>
 <20181129112321.GB3449@osiris>
 <20190121122131.GG4020@osiris>
 <alpine.DEB.2.21.1901211411290.1582@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1901222212490.1628@nanos.tec.linutronix.de>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1901222212490.1628@nanos.tec.linutronix.de>
X-TM-AS-GCONF: 00
x-cbid: 19012309-0016-0000-0000-0000024937D5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012309-0017-0000-0000-000032A37502
Message-Id: <20190123092443.GA3424@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901230072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 10:14:00PM +0100, Thomas Gleixner wrote:
> On Mon, 21 Jan 2019, Thomas Gleixner wrote:
> > On Mon, 21 Jan 2019, Heiko Carstens wrote:
> > 
> > > Hi Thomas,
> > > 
> > > [full quote below]
> > > 
> > > Did you have any time to look into this yet? :)
> > > 
> > > The warning is still reproducible.
> > 
> > Yeah, it's on my list of stuff which I need to take care of urgently. In
> > the next couple of days I hope...
> 
> Hmm. Doesn't
> 
>      da791a667536 ("futex: Cure exit race")
> 
> address that issue?

It doesn't look like it does. One occurrence was the one below when
using commit 7939f8beecf1 (which is post 5.0-rc2) for building the
kernel:

 WARNING: CPU: 14 PID: 23505 at kernel/futex.c:1483 do_futex+0xa9a/0xc50
 Kernel panic - not syncing: panic_on_warn set ...
 CPU: 14 PID: 23505 Comm: ld.so.1 Not tainted 5.0.0-20190116.rc2.git0.7939f8beecf1.300.fc29.s390x+git #1
 Hardware name: IBM 3906 M04 704 (LPAR)
 Call Trace:
 ([<0000000000112e60>] show_stack+0x58/0x70)
  [<0000000000a671fa>] dump_stack+0x7a/0xa8
  [<0000000000143f52>] panic+0x11a/0x2d0
  [<0000000000143db0>] __warn+0xf8/0x118
  [<0000000000a662f8>] report_bug+0xd8/0x150
  [<00000000001014ac>] do_report_trap+0xc4/0xe0
  [<0000000000101680>] illegal_op+0x138/0x150
  [<0000000000a87270>] pgm_check_handler+0x1c8/0x220
  [<00000000001e9aea>] do_futex+0xa9a/0xc50
 ([<00000000001e9c4e>] do_futex+0xbfe/0xc50)
  [<00000000001ea13c>] compat_sys_futex+0xe4/0x170
  [<0000000000a86e84>] system_call+0xd8/0x2c8

