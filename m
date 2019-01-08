Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF53C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 622E820850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbfAHNg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:36:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59072 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727941AbfAHNgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:36:25 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x08DYSG8013525
        for <linux-kernel@vger.kernel.org>; Tue, 8 Jan 2019 08:36:23 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pvthbr78y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 08:36:22 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Tue, 8 Jan 2019 13:36:20 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 8 Jan 2019 13:36:17 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x08DaFNJ32768008
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Jan 2019 13:36:15 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 656D14C058;
        Tue,  8 Jan 2019 13:36:15 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0AFFF4C050;
        Tue,  8 Jan 2019 13:36:15 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.86])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Jan 2019 13:36:14 +0000 (GMT)
Date:   Tue, 8 Jan 2019 14:36:13 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Michael Mueller <mimu@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        KVM Mailing List <kvm@vger.kernel.org>,
        Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v5 10/15] KVM: s390: add functions to (un)register GISC
 with GISA
In-Reply-To: <20190108113444.56e76f13.cohuck@redhat.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
        <20181219191756.57973-11-mimu@linux.ibm.com>
        <bd1a6082-cb73-5ef7-f2b6-8cbd7d8c7136@linux.ibm.com>
        <20190104141836.0ca98a77.cohuck@redhat.com>
        <b001fc9b-c174-644f-a9fa-e60ff5b4aa58@linux.ibm.com>
        <20190108113444.56e76f13.cohuck@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19010813-0028-0000-0000-00000335F4D6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010813-0029-0000-0000-000023F30226
Message-Id: <20190108143613.2ca1a9d3@oc2783563651>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-08_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=650 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901080112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2019 11:34:44 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> > >>    
> > >>> +	spin_unlock(&kvm->arch.iam_ref_lock);
> > >>> +
> > >>> +	return gib->nisc;
> > >>> +}
> > >>> +EXPORT_SYMBOL_GPL(kvm_s390_gisc_register);
> > >>> +
> > >>> +int kvm_s390_gisc_unregister(struct kvm *kvm, u32 gisc)
> > >>> +{
> > >>> +	int rc = 0;
> > >>> +
> > >>> +	if (!kvm->arch.gib_in_use)
> > >>> +		return -ENODEV;
> > >>> +	if (gisc > MAX_ISC)
> > >>> +		return -ERANGE;
> > >>> +
> > >>> +	spin_lock(&kvm->arch.iam_ref_lock);
> > >>> +	if (kvm->arch.iam_ref_count[gisc] == 0) {
> > >>> +		rc = -EINVAL;
> > >>> +		goto out;
> > >>> +	}
> > >>> +	kvm->arch.iam_ref_count[gisc]--;
> > >>> +	if (kvm->arch.iam_ref_count[gisc] == 0) {
> > >>> +		kvm->arch.iam &= ~(0x80 >> gisc);
> > >>> +		set_iam(kvm->arch.gisa, kvm->arch.iam);    
> > > 
> > > Any chance of this function failing here? If yes, would there be any
> > > implications?    
> > 
> > It is the same here.  
> 
> I'm not sure that I follow: This is the reverse operation
> (unregistering the gisc). Can we rely on get_ipm() to do any fixup
> later? Is that a problem for the caller?

IMHO gib alerts are all about not loosing initiative. I.e. avoiding
substantially delayed delivery of interrupts due to vCPUs in wait
state.

Thus we must avoid letting go before setting up stuff (gisa.iam under
consideration of gisa ipm, gisa.next_alert, and gib.alert_list_origin)
so that we can react on the next interrupt (if necessary).

On the other hand, getting more gisa alerts than necessary is not
fatal -- better avoided if not too much hassle of course.

Bottom line is, while it may be critical that the IAM changes implied
by register take place immediately, unregister is a different story.

Regards,
Halil

> 
> Apologies if I sound confused (well, that's because I probably am);
> this is hard to review without access to the hardware specification.

