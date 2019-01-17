Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAACC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08693205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbfAQP7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:59:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43474 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725882AbfAQP7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 10:59:07 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0HFwmYb076121
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 10:59:06 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q2tejq15e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 10:59:06 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 17 Jan 2019 15:59:04 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 17 Jan 2019 15:59:02 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0HFx1Q764684224
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Jan 2019 15:59:01 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B24E5204E;
        Thu, 17 Jan 2019 15:59:01 +0000 (GMT)
Received: from osiris (unknown [9.152.212.95])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 0E1035204F;
        Thu, 17 Jan 2019 15:59:01 +0000 (GMT)
Date:   Thu, 17 Jan 2019 16:58:59 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stefan Liebler <stli@linux.ibm.com>
Subject: Re: [GIT PULL] timer fix
References: <20181221123453.GA102366@gmail.com>
 <20181223192926.GA3728@osiris>
 <20190117095102.GA88466@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20190117095102.GA88466@gmail.com>
X-TM-AS-GCONF: 00
x-cbid: 19011715-0012-0000-0000-000002E95B46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011715-0013-0000-0000-000021207834
Message-Id: <20190117155859.GE18351@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-17_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=685 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901170115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 10:51:02AM +0100, Ingo Molnar wrote:
> 
> * Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> 
> > > -	if (timr->it_requeue_pending == info->si_sys_private) {
> > > +	if (timr->it_interval && timr->it_requeue_pending == info->si_sys_private) {
> > >  		timr->kclock->timer_rearm(timr);
> > 
> > FWIW, with this patch the vanilla glibc 2.28 self tests
> > rt/tst-cputimer1, rt/tst-cputimer2, and rt/tst-cputimer3
> > start to fail on s390:
...
> > I haven't looked any further into this, just reporting.. otherwise the
> > test systems seem to be healthy.
> 
> Could you please check whether the top commit in tip:timers/urgent fixes 
> it:
>   93ad0fc088c5: posix-cpu-timers: Unbreak timer rearming

Yes, the test cases don't fail anymore. Thanks!

A general question: since I reported this already last year, was the
bug report not usable? I understand that x-mas holidays were in
between, just wondering if new "glibc test case" fails are worth to be
reported like I did.

