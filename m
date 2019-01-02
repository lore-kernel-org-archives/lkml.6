Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0CBC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FB521903
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbfABP73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 10:59:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40794 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729119AbfABP73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 10:59:29 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x02FxDYp133365
        for <linux-kernel@vger.kernel.org>; Wed, 2 Jan 2019 10:59:28 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2prwpaftwh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 10:59:28 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Wed, 2 Jan 2019 15:59:25 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 2 Jan 2019 15:59:21 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x02FxKck58654824
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Jan 2019 15:59:20 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D8F911C05B;
        Wed,  2 Jan 2019 15:59:20 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 487C211C04A;
        Wed,  2 Jan 2019 15:59:20 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.118])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  2 Jan 2019 15:59:20 +0000 (GMT)
Date:   Wed, 2 Jan 2019 16:59:19 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     "Wang, Wei W" <wei.w.wang@intel.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "dgilbert@redhat.com" <dgilbert@redhat.com>
Subject: Re: [virtio-dev] RE: [PATCH v1 0/2] Virtio: fix some vq allocation
 issues
In-Reply-To: <20190102142338.15bfe876.cohuck@redhat.com>
References: <1545963986-11280-1-git-send-email-wei.w.wang@intel.com>
        <c6746307-fae5-7652-af8d-19f560fc31d9@de.ibm.com>
        <286AC319A985734F985F78AFA26841F73DEEA8E9@shsmsx102.ccr.corp.intel.com>
        <20181230070600.512bbb8b@oc2783563651>
        <286AC319A985734F985F78AFA26841F73DEEC8DF@shsmsx102.ccr.corp.intel.com>
        <20190101004019.7f20aafa@oc2783563651>
        <20190102105314.0b4e2485.cohuck@redhat.com>
        <20190102142338.15bfe876.cohuck@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19010215-0012-0000-0000-000002E0896C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010215-0013-0000-0000-00002117466E
Message-Id: <20190102165919.0cd9365a@oc2783563651>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-02_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901020144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2019 14:23:38 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed, 2 Jan 2019 10:53:14 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > On Tue, 1 Jan 2019 00:40:19 +0100
> > Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > > As I said, at the moment I don't have a preference regarding the fix,
> > > partly because I'm not sure if "reading config inside the handler" is OK
> > > or not. Maybe Connie or Michael can help us here. I'm however sure that
> > > commit 86a5597 "virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT"
> > > breaks virtio-balloon with the ccw transport (i.e. effectively breaks 
> > > virtio-balloon on s390): it used to work before and does not work
> > > after.  
> > 
> > Yes, that's unfortunate.
> > 
> > > 
> > > AFAICT tweaking the balloon code may be simpler than tweaking the
> > > virtio-ccw (transport code). ccw_io_helper() relies on getting
> > > an interrupt when the issued IO is done. If virtio-ccw is buggy, it
> > > needs to be fixed, but I'm not sure it is.  
> > 
> > I would not call virtio-ccw buggy, but it has some constraints that
> > virtio-pci apparently doesn't have (and which did not show up so far;
> > e.g. virtio-blk schedules a work item on config change, so there's no
> > deadlock there.)
> > 
> > One way to get out of that constraint (don't interact with the config
> > space directly in the config changed handler) would be to schedule a
> > work item in virtio-ccw that calls virtio_config_changed() for the
> > device. My understanding is that delaying the notification to a work
> > queue would be fine.
> 
> Unfortunately, calling virtio_config_changed() from a work item is not
> enough: That function takes the config_lock, and the virtio-ccw code to
> get the config both needs to allocate some memory and call schedule :/
> 
> The best option really seems to be
> - have virtio-balloon move the handling of the config change onto a
>   workqueue or something like that, and
> - document that you cannot read/write the virtio config space from an
>   atomic context
> 
> Unless someone has a better idea?
> 

I wonder, would making config_lock a mutex suffice?

I've already hinted that a virtio-balloon side fix is probably the
simpler variant. 

I agree, let's fix the regression first, and think about wether to teach
virtio-ccw to allow config manipulation from virtio_config_changed() or
not later.

Regards,
Halil



