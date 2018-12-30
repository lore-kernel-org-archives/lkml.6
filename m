Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00EDC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 06:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D87213F2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 06:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbeL3GGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 01:06:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41124 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725970AbeL3GGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 01:06:12 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBU63cSq047525
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 01:06:10 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pppx925ww-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 01:06:10 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Sun, 30 Dec 2018 06:06:08 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 30 Dec 2018 06:06:04 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBU663jm54198462
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 30 Dec 2018 06:06:03 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0842842041;
        Sun, 30 Dec 2018 06:06:03 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78D454203F;
        Sun, 30 Dec 2018 06:06:02 +0000 (GMT)
Received: from oc2783563651 (unknown [9.145.191.140])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 30 Dec 2018 06:06:02 +0000 (GMT)
Date:   Sun, 30 Dec 2018 07:06:00 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     "Wang, Wei W" <wei.w.wang@intel.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "dgilbert@redhat.com" <dgilbert@redhat.com>
Subject: Re: [PATCH v1 0/2] Virtio: fix some vq allocation issues
In-Reply-To: <286AC319A985734F985F78AFA26841F73DEEA8E9@shsmsx102.ccr.corp.intel.com>
References: <1545963986-11280-1-git-send-email-wei.w.wang@intel.com>
        <c6746307-fae5-7652-af8d-19f560fc31d9@de.ibm.com>
        <286AC319A985734F985F78AFA26841F73DEEA8E9@shsmsx102.ccr.corp.intel.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18123006-0020-0000-0000-000002FDE517
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18123006-0021-0000-0000-0000214E1CB0
Message-Id: <20181230070600.512bbb8b@oc2783563651>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-30_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812300057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2018 02:45:49 +0000
"Wang, Wei W" <wei.w.wang@intel.com> wrote:

> On Friday, December 28, 2018 3:57 PM, Christian Borntraeger wrote:
> > On 28.12.2018 03:26, Wei Wang wrote:
> > > Some vqs don't need to be allocated when the related feature bits are
> > > disabled. Callers notice the vq allocation layer by setting the
> > > related names[i] to be NULL.
> > >
> > > This patch series fixes the find_vqs implementations to handle this case.
> > 
> > So the random crashes during boot are gone.
> > What still does not work is actually using the balloon.
> > 
> > So in the qemu monitor using lets say "balloon 1000"  will hang the guest.
> > Seems to be a deadlock in the virtio-ccw code.  We seem to call the config
> > code in the interrupt handler.
> 
> Yes. It reads a config register from the interrupt handler. Do you know why ccw doesn't support it and has some internal lock that caused the deadlock issue?
>  
> Best,
> Wei

I guess you are the first one trying to read virtio config from within
interrupt context. AFAICT this never worked.

About what happens. The apidoc of ccw_device_start() says it needs to be
called with the ccw device lock held, so ccw_io_helper() tries to take
it (since forever I guess). OTOH do_cio_interrupt() takes the subchannel
lock and io_subchannel_initialize_dev() makes the ccw device lock be the
subchannel lock. That means when one tries to get virtio config form
within a cio interrupt context we deadlock, because we try to take a lock
we already have.

That said, I don't think this limitation is by design (i.e. intended).
Maybe Connie can help us with that question. AFAIK we have nothing
documented regarding this (neither that can nor can't).

Obviously, there are multiple ways around this problem, and at the
moment I can't tell which would be my preferred one.

Regards,
Halil



