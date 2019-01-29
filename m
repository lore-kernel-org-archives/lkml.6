Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0A4C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23BEF2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfA2NXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:23:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39578 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725601AbfA2NXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 08:23:13 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0TDJpTt188282
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 08:23:11 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qaqhegh6w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 08:23:11 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Tue, 29 Jan 2019 13:23:09 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 29 Jan 2019 13:23:06 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0TDN6SG16187564
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Jan 2019 13:23:06 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28DB04204F;
        Tue, 29 Jan 2019 13:23:05 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB0FE42049;
        Tue, 29 Jan 2019 13:23:04 +0000 (GMT)
Received: from osiris (unknown [9.152.212.95])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 29 Jan 2019 13:23:04 +0000 (GMT)
Date:   Tue, 29 Jan 2019 14:23:03 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org,
        Stefan Liebler <stli@linux.ibm.com>,
        Sebastian Sewior <bigeasy@linutronix.de>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggered
References: <alpine.DEB.2.21.1811281526430.1532@nanos.tec.linutronix.de>
 <20181129112321.GB3449@osiris>
 <20190128134410.GA28485@hirez.programming.kicks-ass.net>
 <20190128135804.GB28878@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1901281650310.1582@nanos.tec.linutronix.de>
 <20190129090108.GA26906@osiris>
 <alpine.DEB.2.21.1901291012330.1669@nanos.tec.linutronix.de>
 <20190129102409.GB26906@osiris>
 <20190129103557.GF28485@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1901291402410.1513@nanos.tec.linutronix.de>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1901291402410.1513@nanos.tec.linutronix.de>
X-TM-AS-GCONF: 00
x-cbid: 19012913-0008-0000-0000-000002B7763C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012913-0009-0000-0000-00002223B8F4
Message-Id: <20190129132303.GE26906@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-29_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901290101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 02:03:01PM +0100, Thomas Gleixner wrote:
> On Tue, 29 Jan 2019, Peter Zijlstra wrote:
> 
> > On Tue, Jan 29, 2019 at 11:24:09AM +0100, Heiko Carstens wrote:
> > 
> > > Yes, sure. However ;) I reproduced the above with v5.0-rc4 + your
> > > patch. And now I am trying to reproduce with linux-next 20190129 +
> > > your patch and it doesn't trigger. Did I miss a patch which is only in
> > > linux-next which could fix this?
> > > 
> > 
> > I'm forever confused on what patch is where; but -ESRCH makes me thing
> > maybe you lost this one:
> > 
> > ---
> > 
> > commit da791a667536bf8322042e38ca85d55a78d3c273
> > Author: Thomas Gleixner <tglx@linutronix.de>
> > Date:   Mon Dec 10 14:35:14 2018 +0100
> 
> That's in Linus tree already ...

Yes, for some reason it's hardly reproducible now. It did hit once
after an hour, but (of course) without tracing enabled... still
trying.

