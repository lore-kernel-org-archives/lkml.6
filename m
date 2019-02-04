Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6154C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824F82081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbfBDLkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 06:40:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51400 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726603AbfBDLkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 06:40:19 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x14BdkAR065173
        for <linux-kernel@vger.kernel.org>; Mon, 4 Feb 2019 06:40:18 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qejjrps1q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 06:40:17 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Mon, 4 Feb 2019 11:40:15 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 4 Feb 2019 11:40:13 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x14BeBfp65929410
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Feb 2019 11:40:11 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 841404C044;
        Mon,  4 Feb 2019 11:40:11 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30A524C046;
        Mon,  4 Feb 2019 11:40:11 +0000 (GMT)
Received: from osiris (unknown [9.152.212.95])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  4 Feb 2019 11:40:11 +0000 (GMT)
Date:   Mon, 4 Feb 2019 12:40:09 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sebastian Sewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org,
        Stefan Liebler <stli@linux.ibm.com>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggerede
References: <alpine.DEB.2.21.1901310049440.8200@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1901310117110.8200@nanos.tec.linutronix.de>
 <20190131165228.GA32680@osiris>
 <20190131170653.spnrxsiblkssleyd@linutronix.de>
 <20190201161227.GG3770@osiris>
 <alpine.DEB.2.21.1902012258290.8200@nanos.tec.linutronix.de>
 <20190202091043.GA3381@osiris>
 <alpine.DEB.2.21.1902021027060.8200@nanos.tec.linutronix.de>
 <20190202112006.GB3381@osiris>
 <alpine.DEB.2.21.1902031718170.8200@nanos.tec.linutronix.de>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902031718170.8200@nanos.tec.linutronix.de>
X-TM-AS-GCONF: 00
x-cbid: 19020411-0012-0000-0000-000002F102E8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020411-0013-0000-0000-000021285951
Message-Id: <20190204114009.GA3687@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-04_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=994 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902040094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 03, 2019 at 05:30:39PM +0100, Thomas Gleixner wrote:
> On Sat, 2 Feb 2019, Heiko Carstens wrote:
> > I added a barrier between those two and now the code looks like this:
> > 
> > 140:   a5 1b 00 01             oill    %r1,1
> > 144:   e3 10 a0 e0 00 24       stg     %r1,224(%r10)
> > 14a:   e5 48 a0 f0 00 00       mvghi   240(%r10),0
> > 
> > Looks like this was a one instruction race...
> 
> Fun. JFYI, I said that I reversed the stores in glibc and on my x86 test VM
> it took more than _3_ days to trigger. But the good news is, that the trace
> looks exactly like the ones you provided. So it looks we are on the right
> track.
> 
> > I'll try to reproduce with the patch below (sprinkling compiler
> > barriers just like the other files have).
> 
> Looks about right.

The test case now runs since two days without failures. So it looks like you
found the bug! Thank you for debugging this!

My glibc patch missed at lease one place where I should have added another
barrier, but the current version was good enough for the test case ;)

Stefan Liebler is kind enough to take care that this will be fixed in glibc.

Thanks!

