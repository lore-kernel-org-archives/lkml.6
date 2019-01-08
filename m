Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848E9C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E7A20827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbfAHOYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:24:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60750 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727662AbfAHOYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:24:07 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x08EJgLn080107
        for <linux-kernel@vger.kernel.org>; Tue, 8 Jan 2019 09:24:06 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pvtkw2hn7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 09:24:05 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Tue, 8 Jan 2019 14:24:03 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 8 Jan 2019 14:24:00 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x08ENwhB32374968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Jan 2019 14:23:59 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D057B52051;
        Tue,  8 Jan 2019 14:23:58 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.86])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 732A152050;
        Tue,  8 Jan 2019 14:23:58 +0000 (GMT)
Date:   Tue, 8 Jan 2019 15:23:57 +0100
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
In-Reply-To: <20190108144135.3fe5c23b.cohuck@redhat.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
        <20181219191756.57973-11-mimu@linux.ibm.com>
        <bd1a6082-cb73-5ef7-f2b6-8cbd7d8c7136@linux.ibm.com>
        <20190104141836.0ca98a77.cohuck@redhat.com>
        <b001fc9b-c174-644f-a9fa-e60ff5b4aa58@linux.ibm.com>
        <20190108113444.56e76f13.cohuck@redhat.com>
        <20190108143613.2ca1a9d3@oc2783563651>
        <20190108144135.3fe5c23b.cohuck@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19010814-0016-0000-0000-00000241FEF0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010814-0017-0000-0000-0000329C12F9
Message-Id: <20190108152357.39fea477@oc2783563651>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-08_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901080118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2019 14:41:35 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Tue, 8 Jan 2019 14:36:13 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > On Tue, 8 Jan 2019 11:34:44 +0100
> > Cornelia Huck <cohuck@redhat.com> wrote:
> > 
> > > > >>      
> > > > >>> +	spin_unlock(&kvm->arch.iam_ref_lock);
> > > > >>> +
> > > > >>> +	return gib->nisc;
> > > > >>> +}
> > > > >>> +EXPORT_SYMBOL_GPL(kvm_s390_gisc_register);
> > > > >>> +
> > > > >>> +int kvm_s390_gisc_unregister(struct kvm *kvm, u32 gisc)
> > > > >>> +{
> > > > >>> +	int rc = 0;
> > > > >>> +
> > > > >>> +	if (!kvm->arch.gib_in_use)
> > > > >>> +		return -ENODEV;
> > > > >>> +	if (gisc > MAX_ISC)
> > > > >>> +		return -ERANGE;
> > > > >>> +
> > > > >>> +	spin_lock(&kvm->arch.iam_ref_lock);
> > > > >>> +	if (kvm->arch.iam_ref_count[gisc] == 0) {
> > > > >>> +		rc = -EINVAL;
> > > > >>> +		goto out;
> > > > >>> +	}
> > > > >>> +	kvm->arch.iam_ref_count[gisc]--;
> > > > >>> +	if (kvm->arch.iam_ref_count[gisc] == 0) {
> > > > >>> +		kvm->arch.iam &= ~(0x80 >> gisc);
> > > > >>> +		set_iam(kvm->arch.gisa, kvm->arch.iam);      
> > > > > 
> > > > > Any chance of this function failing here? If yes, would there be any
> > > > > implications?      
> > > > 
> > > > It is the same here.    
> > > 
> > > I'm not sure that I follow: This is the reverse operation
> > > (unregistering the gisc). Can we rely on get_ipm() to do any fixup
> > > later? Is that a problem for the caller?  
> > 
> > IMHO gib alerts are all about not loosing initiative. I.e. avoiding
> > substantially delayed delivery of interrupts due to vCPUs in wait
> > state.
> > 
> > Thus we must avoid letting go before setting up stuff (gisa.iam under
> > consideration of gisa ipm, gisa.next_alert, and gib.alert_list_origin)
> > so that we can react on the next interrupt (if necessary).
> > 
> > On the other hand, getting more gisa alerts than necessary is not
> > fatal -- better avoided if not too much hassle of course.
> 
> Yes, unless the caller does not expect any more alerts after
> unregistering (I guess that's what you're saying?)

Just to make sure, the caller, which I guess would probably be some
sort of a driver, does not process the alerts. It is kvm that does.

But you are right, the properties of unregister need do be considered in
the cleanup code (e.g. resets). Sure, we must avoid the
process_gib_alert_list() (which is common, i.e. ain't tied to any
VM) poking dead GISAs. Frankly, I've my hands full with the normal
operation scenario, and I did not pay much attention to the cleanup yet. 

> 
> > 
> > Bottom line is, while it may be critical that the IAM changes implied
> > by register take place immediately, unregister is a different story.
> 
> It does feel a bit weird, though. But maybe I just have trouble
> grasping the design :/
> 

You are on the only one. I have extreme difficulties following some of
the discussion here -- despite of the fact that I have quite some
confidence in my understanding of the GISA/GIB architecture.

Regards,
Halil

