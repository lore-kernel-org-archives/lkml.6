Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0CAC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62BED2081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62BED2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbeK2W2b convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 17:28:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38436 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726949AbeK2W2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 17:28:31 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wATBIrld133938
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 06:23:28 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p2f49r65b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 06:23:28 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 29 Nov 2018 11:23:25 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 29 Nov 2018 11:23:23 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wATBNM8B40435726
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Nov 2018 11:23:22 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4850A4053;
        Thu, 29 Nov 2018 11:23:22 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7721EA4040;
        Thu, 29 Nov 2018 11:23:22 +0000 (GMT)
Received: from osiris (unknown [9.152.212.95])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 29 Nov 2018 11:23:22 +0000 (GMT)
Date:   Thu, 29 Nov 2018 12:23:21 +0100
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
In-Reply-To: <alpine.DEB.2.21.1811281526430.1532@nanos.tec.linutronix.de>
X-TM-AS-GCONF: 00
x-cbid: 18112911-4275-0000-0000-000002E882C5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112911-4276-0000-0000-000037F5C6DA
Message-Id: <20181129112321.GB3449@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-29_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811290099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 03:32:45PM +0100, Thomas Gleixner wrote:
> Heiko,
> 
> On Tue, 27 Nov 2018, Heiko Carstens wrote:
> 
> > with the glibc self-tests I was able to trigger the "this should not
> > happen" warning ;) below on s390 (with panic_on_warn=1 set). It looks
> > like it is hardly reproducible.
> 
> Any idea which self-test triggered that?
> 
> > This one happened with commit d146194f31c9 for compiling the kernel.
> > Config can be re-created with "make ARCH=s390 performance_defconfig".
> 
> Which is not really helpful for people who do not own a s390. And no, I
> don't want one unless IBM pays the power bill as well :)
> 
> > [  649.596938] WARNING: CPU: 0 PID: 58886 at kernel/futex.c:1418 do_futex+0xa9a/0xc50
> > [  649.596946] Kernel panic - not syncing: panic_on_warn set ...
> > [  649.596951] CPU: 0 PID: 58886 Comm: ld64.so.1 Not tainted 4.20.0-20181125.rc3.git0.d146194f31c9.300.fc29.s390x+git #1
> 
> That's ld64.so.1. Weird, but what do I know about glibc self tests.
> 
> I still fail to see how that can happen, but I usually page out the futex
> horrors immediately. I'll keep staring at the code...

I looked into the system dumps, and if I didn't screw up, then the
command line for both occurrences was

/root/glibc-build/nptl/tst-robustpi8

And indeed, if I run only this test case in an endless loop and do
some parallel work (like kernel compile) it currently seems to be
possible to reproduce the warning:

while true; do time ./testrun.sh nptl/tst-robustpi8 --direct ; done

within the build directory of glibc (2.28).

See
https://sourceware.org/git/?p=glibc.git;a=blob;f=nptl/tst-robustpi8.c;h=cbea3d6d77abb00be05ec7b466d8339c26dd2efb;hb=3c03baca37fdcb52c3881e653ca392bba7a99c2b

which includes this one:

https://sourceware.org/git/?p=glibc.git;a=blob;f=nptl/tst-robust8.c;h=9c636250d4cb0bcd6d802910e8f9ea31568bb73f;hb=3c03baca37fdcb52c3881e653ca392bba7a99c2b

