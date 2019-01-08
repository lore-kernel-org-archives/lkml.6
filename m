Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67BEC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC7E2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbfAHGiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 01:38:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55830 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727706AbfAHGiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 01:38:06 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x086Y1fA033223
        for <linux-kernel@vger.kernel.org>; Tue, 8 Jan 2019 01:38:05 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pvpcmh0qn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 01:38:05 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Tue, 8 Jan 2019 06:38:03 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 8 Jan 2019 06:38:00 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x086bwf957081972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Jan 2019 06:37:59 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0060AE056;
        Tue,  8 Jan 2019 06:37:58 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70354AE053;
        Tue,  8 Jan 2019 06:37:58 +0000 (GMT)
Received: from osiris (unknown [9.152.212.95])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  8 Jan 2019 06:37:58 +0000 (GMT)
Date:   Tue, 8 Jan 2019 07:37:57 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     pmorel@linux.ibm.com
Cc:     Michael Mueller <mimu@linux.ibm.com>,
        KVM Mailing List <kvm@vger.kernel.org>,
        Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v5 13/15] KVM: s390: add function process_gib_alert_list()
References: <20181219191756.57973-1-mimu@linux.ibm.com>
 <20181219191756.57973-14-mimu@linux.ibm.com>
 <645d74cf-7448-f143-c899-bdcf290dac59@linux.ibm.com>
 <ae479e60-d235-acf3-55cc-afd875644a19@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <ae479e60-d235-acf3-55cc-afd875644a19@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19010806-0028-0000-0000-00000335C09C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010806-0029-0000-0000-000023F2CC85
Message-Id: <20190108063757.GA3766@osiris>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-08_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=964 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901080052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 08:19:26PM +0100, Michael Mueller wrote:
> 
> On 03.01.19 15:43, Pierre Morel wrote:
> >On 19/12/2018 20:17, Michael Mueller wrote:
> >>This function processes the Gib Alert List (GAL). It is required
> >>to run when either a gib alert interruption has been received or
> >>a gisa that is in the alert list is cleared or dropped.
> >>
> >>The GAL is build up by millicode, when the respective ISC bit is
> >>set in the Interruption Alert Mask (IAM) and an interruption of
> >>that class is observed.
> >>
> >>Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> >>---
> >>  arch/s390/kvm/interrupt.c | 140
> >>++++++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 140 insertions(+)
> >>
> >>diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> >>index 48a93f5e5333..03e7ba4f215a 100644
> >>--- a/arch/s390/kvm/interrupt.c
> >>+++ b/arch/s390/kvm/interrupt.c
> >>@@ -2941,6 +2941,146 @@ int kvm_s390_get_irq_state(struct kvm_vcpu
> >>*vcpu, __u8 __user *buf, int len)
> >>      return n;
> >>  }
> >>  +static int __try_airqs_kick(struct kvm *kvm, u8 ipm)
> >
> >static inline ?

Why?

In general it is a good idea to leave it up to the compiler to decide
if it is worth to inline a function or not, unless you have a good
reason to force inlining.

