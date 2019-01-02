Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC1EC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 13:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D84218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 13:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbfABN5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 08:57:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40480 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727827AbfABN5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 08:57:02 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x02Dn4On135488
        for <linux-kernel@vger.kernel.org>; Wed, 2 Jan 2019 08:57:01 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2prwpaaqms-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 08:57:00 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Wed, 2 Jan 2019 13:56:58 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 2 Jan 2019 13:56:55 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x02DusOE60358764
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Jan 2019 13:56:54 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 412E011C054;
        Wed,  2 Jan 2019 13:56:54 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2EED11C06C;
        Wed,  2 Jan 2019 13:56:53 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.118])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  2 Jan 2019 13:56:53 +0000 (GMT)
Date:   Wed, 2 Jan 2019 14:56:52 +0100
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
In-Reply-To: <20190102105314.0b4e2485.cohuck@redhat.com>
References: <1545963986-11280-1-git-send-email-wei.w.wang@intel.com>
        <c6746307-fae5-7652-af8d-19f560fc31d9@de.ibm.com>
        <286AC319A985734F985F78AFA26841F73DEEA8E9@shsmsx102.ccr.corp.intel.com>
        <20181230070600.512bbb8b@oc2783563651>
        <286AC319A985734F985F78AFA26841F73DEEC8DF@shsmsx102.ccr.corp.intel.com>
        <20190101004019.7f20aafa@oc2783563651>
        <20190102105314.0b4e2485.cohuck@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19010213-0028-0000-0000-00000331ED50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010213-0029-0000-0000-000023EF3720
Message-Id: <20190102145652.02b1046c@oc2783563651>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-02_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901020126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2019 10:53:14 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Tue, 1 Jan 2019 00:40:19 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > On Mon, 31 Dec 2018 06:03:51 +0000
> > "Wang, Wei W" <wei.w.wang@intel.com> wrote:
> > 
> > > On Sunday, December 30, 2018 2:06 PM, Halil Pasic wrote:  
> > > > 
> > > > I guess you are the first one trying to read virtio config from within interrupt
> > > > context. AFAICT this never worked.  
> > > 
> > > I'm not sure about "never worked". It seems to work well with virtio-pci.
> > > But looking forward to hearing a solid reason why reading config inside
> > > the handler is forbidden (if that's true).  
> > 
> > By "never worked" I meant "never worked with virtio-ccw". Sorry
> > about the misunderstanding. Seems I've also failed to convey that I don't
> > know if reading config inside the handler is forbidden or not. So please
> > don't expect me providing the solid reasons you are looking forward to.
> 
> It won't work with the current code, and this is all a bit ugly :( More
> verbose explanation below.
> 
> > 
> > >   
> > > > About what happens. The apidoc of ccw_device_start() says it needs to be
> > > > called with the ccw device lock held, so ccw_io_helper() tries to take it (since
> > > > forever I guess). OTOH do_cio_interrupt() takes the subchannel lock and
> > > > io_subchannel_initialize_dev() makes the ccw device lock be the subchannel
> > > > lock. That means when one tries to get virtio config form within a cio
> > > > interrupt context we deadlock, because we try to take a lock we already have.
> > > > 
> > > > That said, I don't think this limitation is by design (i.e. intended).
> > > > Maybe Connie can help us with that question. AFAIK we have nothing
> > > > documented regarding this (neither that can nor can't).
> 
> The main problem is that channel I/O is a fundamentally asynchronous
> mechanism. As channel devices don't have the concept of config spaces
> (or some other things that virtio needs), I decided to map
> reading/writing the config space to channel commands. Starting I/O on a
> subchannel always needs the lock (to avoid races on the subchannel),
> and the asynchronous interrupt for that I/O needs the lock as well (for
> the same reason; things like the scsw contain state that you want to
> access without races). A config change also means that the subchannel
> becomes state pending (and an interrupt is made pending), so the
> subchannel lock is taken for that path as well. (Virtqueue
> notifications are handled differently on modern QEMU, but that does not
> come into play here.)
> 

Besides locking (thinking along the lines that we work around the
lock problem somehow) there is also the new PSW which masks IO
interrupts. As I said, doing something about this seems non-trivial at
least.

> > > > 
> > > > Obviously, there are multiple ways around this problem, and at the moment
> > > > I can't tell which would be my preferred one.  
> > > 
> > > Yes, it's also not difficult to tweak the virtio-balloon code to avoid that issue.
> > > But if that's just an issue with ccw itself, I think it's better to tweak ccw and
> > > remain virtio-balloon unchanged.
> > >   
> > 
> > As I said, at the moment I don't have a preference regarding the fix,
> > partly because I'm not sure if "reading config inside the handler" is OK
> > or not. Maybe Connie or Michael can help us here. I'm however sure that
> > commit 86a5597 "virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT"
> > breaks virtio-balloon with the ccw transport (i.e. effectively breaks 
> > virtio-balloon on s390): it used to work before and does not work
> > after.
> 
> Yes, that's unfortunate.
> 
> > 
> > AFAICT tweaking the balloon code may be simpler than tweaking the
> > virtio-ccw (transport code). ccw_io_helper() relies on getting
> > an interrupt when the issued IO is done. If virtio-ccw is buggy, it
> > needs to be fixed, but I'm not sure it is.
> 
> I would not call virtio-ccw buggy, but it has some constraints that
> virtio-pci apparently doesn't have (and which did not show up so far;
> e.g. virtio-blk schedules a work item on config change, so there's no
> deadlock there.)

IMHO it is an internal API design thing. From the spirit of the virtio
standard perspective  a virtio-ccw device is a ccw device, and acts like
one. We don't support new IO form ccw device interrupt handler. So that's
quite OK. OTOH we probably do want a coherent in kernel virtio
interface. And if that one needs to account for all the quirks of any
transport, that is quite ugly.

> 
> One way to get out of that constraint (don't interact with the config
> space directly in the config changed handler) would be to schedule a
> work item in virtio-ccw that calls virtio_config_changed() for the
> device. My understanding is that delaying the notification to a work
> queue would be fine.
> 

That would get us out of irq context, but I read you found other
problems.

[..]

Regards,
Halil

