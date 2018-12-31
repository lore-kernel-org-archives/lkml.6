Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDA2C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 23:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 960EB21720
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 23:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbeLaXka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 18:40:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41016 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727737AbeLaXka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 18:40:30 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBVNYHOW144256
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 18:40:28 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pqs5vxsff-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 18:40:28 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Mon, 31 Dec 2018 23:40:26 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 31 Dec 2018 23:40:23 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBVNeMYu41681090
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Dec 2018 23:40:22 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 310EF5204F;
        Mon, 31 Dec 2018 23:40:22 +0000 (GMT)
Received: from oc2783563651 (unknown [9.145.12.226])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9EC9C52052;
        Mon, 31 Dec 2018 23:40:21 +0000 (GMT)
Date:   Tue, 1 Jan 2019 00:40:19 +0100
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
Subject: Re: [virtio-dev] RE: [PATCH v1 0/2] Virtio: fix some vq allocation
 issues
In-Reply-To: <286AC319A985734F985F78AFA26841F73DEEC8DF@shsmsx102.ccr.corp.intel.com>
References: <1545963986-11280-1-git-send-email-wei.w.wang@intel.com>
        <c6746307-fae5-7652-af8d-19f560fc31d9@de.ibm.com>
        <286AC319A985734F985F78AFA26841F73DEEA8E9@shsmsx102.ccr.corp.intel.com>
        <20181230070600.512bbb8b@oc2783563651>
        <286AC319A985734F985F78AFA26841F73DEEC8DF@shsmsx102.ccr.corp.intel.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18123123-0016-0000-0000-0000023D5C3D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18123123-0017-0000-0000-00003296AEB4
Message-Id: <20190101004019.7f20aafa@oc2783563651>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-31_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812310198
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Dec 2018 06:03:51 +0000
"Wang, Wei W" <wei.w.wang@intel.com> wrote:

> On Sunday, December 30, 2018 2:06 PM, Halil Pasic wrote:
> > 
> > I guess you are the first one trying to read virtio config from within interrupt
> > context. AFAICT this never worked.
> 
> I'm not sure about "never worked". It seems to work well with virtio-pci.
> But looking forward to hearing a solid reason why reading config inside
> the handler is forbidden (if that's true).

By "never worked" I meant "never worked with virtio-ccw". Sorry
about the misunderstanding. Seems I've also failed to convey that I don't
know if reading config inside the handler is forbidden or not. So please
don't expect me providing the solid reasons you are looking forward to.

> 
> > About what happens. The apidoc of ccw_device_start() says it needs to be
> > called with the ccw device lock held, so ccw_io_helper() tries to take it (since
> > forever I guess). OTOH do_cio_interrupt() takes the subchannel lock and
> > io_subchannel_initialize_dev() makes the ccw device lock be the subchannel
> > lock. That means when one tries to get virtio config form within a cio
> > interrupt context we deadlock, because we try to take a lock we already have.
> > 
> > That said, I don't think this limitation is by design (i.e. intended).
> > Maybe Connie can help us with that question. AFAIK we have nothing
> > documented regarding this (neither that can nor can't).
> > 
> > Obviously, there are multiple ways around this problem, and at the moment
> > I can't tell which would be my preferred one.
> 
> Yes, it's also not difficult to tweak the virtio-balloon code to avoid that issue.
> But if that's just an issue with ccw itself, I think it's better to tweak ccw and
> remain virtio-balloon unchanged.
> 

As I said, at the moment I don't have a preference regarding the fix,
partly because I'm not sure if "reading config inside the handler" is OK
or not. Maybe Connie or Michael can help us here. I'm however sure that
commit 86a5597 "virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT"
breaks virtio-balloon with the ccw transport (i.e. effectively breaks 
virtio-balloon on s390): it used to work before and does not work
after.

AFAICT tweaking the balloon code may be simpler than tweaking the
virtio-ccw (transport code). ccw_io_helper() relies on getting
an interrupt when the issued IO is done. If virtio-ccw is buggy, it
needs to be fixed, but I'm not sure it is.

Regards,
Halil

 

