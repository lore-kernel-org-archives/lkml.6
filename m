Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C764C282C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 06:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A0D621473
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 06:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfA0Gtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 01:49:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57258 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726085AbfA0Gti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 01:49:38 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0R6hmHD001094
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 01:49:37 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q95q22xpd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 01:49:37 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Sun, 27 Jan 2019 06:49:35 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 27 Jan 2019 06:49:31 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0R6nUtL46072060
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 27 Jan 2019 06:49:31 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1B3C11C058;
        Sun, 27 Jan 2019 06:49:30 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63E9811C04A;
        Sun, 27 Jan 2019 06:49:30 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.103])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 27 Jan 2019 06:49:30 +0000 (GMT)
Date:   Sun, 27 Jan 2019 08:49:28 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ogabbay@habana.ai
Subject: Re: [PATCH 05/15] habanalabs: add command buffer module
References: <20190123000057.31477-1-oded.gabbay@gmail.com>
 <20190123000057.31477-6-oded.gabbay@gmail.com>
 <20190123122827.GC4747@rapoport-lnx>
 <CAFCwf10C0XxT4fHZ9eE0o48kFS7Cxcn9FgTfAzWOHOM=Vrk=Fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf10C0XxT4fHZ9eE0o48kFS7Cxcn9FgTfAzWOHOM=Vrk=Fg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19012706-0028-0000-0000-0000033EAA32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012706-0029-0000-0000-000023FBF306
Message-Id: <20190127064928.GB16853@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-27_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901270057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 11:47:03PM +0200, Oded Gabbay wrote:
> On Wed, Jan 23, 2019 at 2:28 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >
> > On Wed, Jan 23, 2019 at 02:00:47AM +0200, Oded Gabbay wrote:
> > > This patch adds the CB module, which allows the user to create and
> > > destroy CBs and to map them to the user's process address-space.
> >
> > Can you please spell "command buffer" at least first time it's mentioned?
> fixed
> >
> > > A command buffer is a memory blocks that reside in DMA-able address-space
> > > and is physically contiguous so it can be accessed by the device without
> > > MMU translation. The command buffer memory is allocated using the
> > > coherent DMA API.
> > >
> > > When creating a new CB, the IOCTL returns a handle of it, and the
> > > user-space process needs to use that handle to mmap the buffer to get a VA
> > > in the user's address-space.
> > >
> > > Before destroying (freeing) a CB, the user must unmap the CB's VA using the
> > > CB handle.
> > >
> > > Each CB has a reference counter, which tracks its usage in command
> > > submissions and also its mmaps (only a single mmap is allowed).
> > >
> > > The driver maintains a pool of pre-allocated CBs in order to reduce
> > > latency during command submissions. In case the pool is empty, the driver
> > > will go to the slow-path of allocating a new CB, i.e. calling
> > > dma_alloc_coherent.
> > >
> > > Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> > > ---
> > >  drivers/misc/habanalabs/Makefile           |   3 +-
> > >  drivers/misc/habanalabs/command_buffer.c   | 414 +++++++++++++++++++++
> > >  drivers/misc/habanalabs/device.c           |  43 ++-
> > >  drivers/misc/habanalabs/goya/goya.c        |  28 ++
> > >  drivers/misc/habanalabs/habanalabs.h       |  95 ++++-
> > >  drivers/misc/habanalabs/habanalabs_drv.c   |   2 +
> > >  drivers/misc/habanalabs/habanalabs_ioctl.c | 102 +++++
> > >  include/uapi/misc/habanalabs.h             |  62 +++
> > >  8 files changed, 746 insertions(+), 3 deletions(-)
> > >  create mode 100644 drivers/misc/habanalabs/command_buffer.c
> > >  create mode 100644 drivers/misc/habanalabs/habanalabs_ioctl.c
> > >  create mode 100644 include/uapi/misc/habanalabs.h

[ ... ]

> > > +int hl_cb_create(struct hl_device *hdev, struct hl_cb_mgr *mgr,
> > > +                     u32 cb_size, u64 *handle, int ctx_id)
> > > +{
> > > +     struct hl_cb *cb;
> > > +     bool alloc_new_cb = true;
> > > +     int rc;
> > > +
> > > +     if (hdev->disabled) {
> > > +             dev_warn_ratelimited(hdev->dev,
> > > +                     "Device is disabled !!! Can't create new CBs\n");
> > > +             rc = -EBUSY;
> > > +             goto out_err;
> > > +     }
> > > +
> > > +     /* Minimum allocation must be PAGE SIZE */
> > > +     if (cb_size < PAGE_SIZE)
> > > +             cb_size = PAGE_SIZE;
> > > +
> > > +     if (ctx_id == HL_KERNEL_ASID_ID &&
> > > +                     cb_size <= hdev->asic_prop.cb_pool_cb_size) {
> > > +
> > > +             spin_lock(&hdev->cb_pool_lock);
> > > +             if (!list_empty(&hdev->cb_pool)) {
> > > +                     cb = list_first_entry(&hdev->cb_pool, typeof(*cb),
> > > +                                     pool_list);
> > > +                     list_del(&cb->pool_list);
> > > +                     spin_unlock(&hdev->cb_pool_lock);
> > > +                     alloc_new_cb = false;
> > > +             } else {
> > > +                     spin_unlock(&hdev->cb_pool_lock);
> > > +                     dev_warn_once(hdev->dev, "CB pool is empty\n");
> >
> > Isn't it going to be a false alarm when you allocate the cb for the first
> > time?
> Why ?
> The cb_pool list holds a list of available CBs. See hl_cb_pool_init()
> - it adds newly allocated CBs to this pool list.
> 
> if (!list_empty(&hdev->cb_pool)) {       -  this checks whether the
> pool is not empty so we can take an available CB from it. If the list
> is empty (hence the pool is empty), we print the warning.
 
Sorry if it's too much nitpicking, but why the allocation of the first cb
should be a warning? There's nothing wrong there... Maybe dev_dbg()
instead?

> > > +             }
> > > +     }
> > > +
> > > +     if (alloc_new_cb) {
> > > +             cb = hl_cb_alloc(hdev, cb_size, ctx_id);
> > > +             if (!cb) {
> > > +                     rc = -ENOMEM;
> > > +                     goto out_err;
> > > +             }
> > > +     }
> > > +
> > > +     cb->hdev = hdev;
> > > +     cb->ctx_id = ctx_id;
> > > +
> > > +     spin_lock(&mgr->cb_lock);
> > > +     rc = idr_alloc(&mgr->cb_handles, cb, 1, 0, GFP_ATOMIC);
> >
> > It seems the ID will remain dangling if the cb is reused.
> 
> I'm not sure what you mean by this comment. Reused by whom ? in how
> fashion it is reused ?
 
Sorry if I didn't explain it more clearly.
If the case the cb is reused, you anyway call idr_alloc() and overwrite the
previous value of cb->id and it never gets idr_remove()'ed

> >
> > > +     spin_unlock(&mgr->cb_lock);
> > > +
> > > +     if (rc < 0) {
> > > +             dev_err(hdev->dev, "Failed to allocate IDR for a new CB\n");
> > > +             goto release_cb;
> > > +     }
> > > +
> > > +     cb->id = rc;
> > > +
> > > +     kref_init(&cb->refcount);
> > > +     spin_lock_init(&cb->lock);
> > > +
> > > +     /*
> > > +      * idr is 32-bit so we can safely OR it with a mask that is above
> > > +      * 32 bit
> > > +      */
> > > +     *handle = cb->id | HL_MMAP_CB_MASK;
> > > +     *handle <<= PAGE_SHIFT;
> > > +
> > > +     return 0;
> > > +
> > > +release_cb:
> > > +     cb_do_release(hdev, cb);
> > > +out_err:
> > > +     *handle = 0;
> > > +
> > > +     return rc;
> > > +}
> > > +

-- 
Sincerely yours,
Mike.

