Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55E5C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B25D72087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbfAHSe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:34:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41128 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728587AbfAHSez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:34:55 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x08IXvpZ015966
        for <linux-kernel@vger.kernel.org>; Tue, 8 Jan 2019 13:34:54 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pvy4t6stt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 13:34:54 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Tue, 8 Jan 2019 18:34:52 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 8 Jan 2019 18:34:49 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x08IYmDX57868526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Jan 2019 18:34:48 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BE06AE045;
        Tue,  8 Jan 2019 18:34:48 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5660AE051;
        Tue,  8 Jan 2019 18:34:47 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.86])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Jan 2019 18:34:47 +0000 (GMT)
Date:   Tue, 8 Jan 2019 19:34:46 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Michael Mueller <mimu@linux.ibm.com>
Cc:     KVM Mailing List <kvm@vger.kernel.org>,
        Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v5 13/15] KVM: s390: add function
 process_gib_alert_list()
In-Reply-To: <7e4a5077-00f0-3a0f-e21a-5bbc2fa14b70@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
        <20181219191756.57973-14-mimu@linux.ibm.com>
        <20190108135919.18048dd4@oc2783563651>
        <7e4a5077-00f0-3a0f-e21a-5bbc2fa14b70@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19010818-0012-0000-0000-000002E411D0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010818-0013-0000-0000-0000211B1FE2
Message-Id: <20190108193446.1d547106@oc2783563651>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-08_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901080148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2019 16:21:17 +0100
Michael Mueller <mimu@linux.ibm.com> wrote:

> >> +			gisa->next_alert = origin;
> >> +			kvm = container_of(gisa, struct sie_page2, gisa)->kvm;
> >> +			/* Kick suitable vcpus */
> >> +			__floating_airqs_kick(kvm);  
> > 
> > We may finish handling the alerted gisa with iam not set e.g.
> > via some vcpus kicked but ipm still dirty and some vcpus still in wait,
> > or?  
> 
> My above mentioned change to the routine identifying the vcpus to kick
> will select one vcpu for each ISC pending if possible (depends on the
> number of idle vcpus and their respective interruption masks and the
> pending ISCs).
> 
> That does not exclude the principle scenario that maybe only one vcpu
> is kicked and multiple ISCs are pending (ipm still dirty) although
> have never observed this with a Linux guest.
> 

IMHO we have to differentiate between the general case and between what
can happen with current or historical Linux guests.

Regarding Linux guests, I'm under the impression each version was quite
there. I says so, also because I have a reasonable amount of confidence
in your testing.

> What I was trying to avoid was a kind of busy loop running in addition
> to the kicked vcpus monitoring the IPM state for resource utilization
> reasons.
> 

Got it. I think we need a clean switch-over (between our
code makes sure the no pending interrupts are going to get stalled in
spite of waiting vcpus that could take them, and between we are good now
and if we are not good any more we will get an alert) nevertheless. 

> > 
> >  From the comments it seems we speculate on being in a safe state, as
> > these are supposed to return to wait or stop soon-ish, and we will set
> > iam then (See <MARK A>). I don't quite understand.  
> 
> 
> Yes, the next vcpu going idle shall restore the IAM or process the
> top ISC pending if the iomask (GCR) allows. vcpus are not allowed to go 
> in disabled wait (IO int disabled by PSW). If all vcpus always (for
> some time) mask a specific ISC the guest does not want to get 
> interrupted for that ISC but will as soon a running vcpu will open
> the mask again.
> 

My understanding on the guarantees we can provide based on the fact that
we kicked some vcpus is still lacking. Maybe let us discuss this offline.

> > 
> > According to my current understanding we might end up loosing initiative
> > in this scenario. Or am I wrong?  
> 
> I currently don't have proof for you being wrong but have not observed
> the situation yet.


See above. Proving that no irq's can get substantially delayed
needlessly (where needlessly means, there is a vcpu in wait state that
could take the irq) would be a proof enough that I'm wrong. Let's
make this discussion more efficient by utilizing co-location to cut
down the RTT.

Regards,
Halil

