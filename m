Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE198C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85FB1218EA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbfBAQMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 11:12:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55792 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727897AbfBAQMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 11:12:37 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x11Fugwb022918
        for <linux-kernel@vger.kernel.org>; Fri, 1 Feb 2019 11:12:36 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qcs0sspy8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 11:12:36 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Fri, 1 Feb 2019 16:12:34 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 1 Feb 2019 16:12:31 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x11GCTNK46858470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Feb 2019 16:12:29 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84BC7A4060;
        Fri,  1 Feb 2019 16:12:29 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E9D4A4067;
        Fri,  1 Feb 2019 16:12:29 +0000 (GMT)
Received: from osiris (unknown [9.152.212.95])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  1 Feb 2019 16:12:29 +0000 (GMT)
Date:   Fri, 1 Feb 2019 17:12:27 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Sebastian Sewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org,
        Stefan Liebler <stli@linux.ibm.com>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggerede
References: <alpine.DEB.2.21.1901301428390.5537@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1901301517220.1950@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1901301853290.1622@nanos.tec.linutronix.de>
 <20190130210733.mg6aascw2gzl3oqz@linutronix.de>
 <alpine.DEB.2.21.1901302314590.8200@nanos.tec.linutronix.de>
 <20190130233557.GA4240@linux.ibm.com>
 <alpine.DEB.2.21.1901310049440.8200@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1901310117110.8200@nanos.tec.linutronix.de>
 <20190131165228.GA32680@osiris>
 <20190131170653.spnrxsiblkssleyd@linutronix.de>
MIME-Version: 1.0
In-Reply-To: <20190131170653.spnrxsiblkssleyd@linutronix.de>
X-TM-AS-GCONF: 00
x-cbid: 19020116-0020-0000-0000-000003105CCF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020116-0021-0000-0000-0000216160FB
Message-Id: <20190201161227.GG3770@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-01_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902010118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 06:06:53PM +0100, Sebastian Sewior wrote:
> On 2019-01-31 17:52:28 [+0100], Heiko Carstens wrote:
> > ...nevertheless Stefan and I looked through the lovely disassembly of
> > _pthread_mutex_lock_full() to verify if the compiler barriers are
> > actually doing what they are supposed to do. The generated code
> > however does look correct.
> > So, it must be something different.
> 
> would it make sense to use one locking function instead all three (lock,
> try-lock, timed) in the test case to figure out if this is related to
> one of the locking function?

I tried all three variants, but it seems to be close to impossible to
re-create then. I had a single fail when using only the trylock
variant, but I wouldn't say that means anything.

Only if all three variants run in parallel it seems to be quite
reliably reproducible, even though sometimes it still takes an hour.

