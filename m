Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0A3C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 03:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3CC821871
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 03:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfAEDct convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 22:32:49 -0500
Received: from mga09.intel.com ([134.134.136.24]:43595 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfAEDcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 22:32:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jan 2019 19:32:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,441,1539673200"; 
   d="scan'208";a="107101009"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga008.jf.intel.com with ESMTP; 04 Jan 2019 19:32:47 -0800
Received: from fmsmsx118.amr.corp.intel.com (10.18.116.18) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 4 Jan 2019 19:32:47 -0800
Received: from shsmsx154.ccr.corp.intel.com (10.239.6.54) by
 fmsmsx118.amr.corp.intel.com (10.18.116.18) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 4 Jan 2019 19:32:46 -0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.63]) by
 SHSMSX154.ccr.corp.intel.com ([169.254.7.46]) with mapi id 14.03.0415.000;
 Sat, 5 Jan 2019 11:32:45 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
        "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "dgilbert@redhat.com" <dgilbert@redhat.com>
Subject: RE: [PATCH v2 1/2] virtio-balloon: tweak config_changed
 implementation
Thread-Topic: [PATCH v2 1/2] virtio-balloon: tweak config_changed
 implementation
Thread-Index: AQHUpAGvzs2A3WVI4UiI2vF1n+DznaWeuqmAgAFHRSA=
Date:   Sat, 5 Jan 2019 03:32:44 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73DEF57A3@shsmsx102.ccr.corp.intel.com>
References: <1546585913-34804-1-git-send-email-wei.w.wang@intel.com>
 <1546585913-34804-2-git-send-email-wei.w.wang@intel.com>
 <20190104103213-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190104103213-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiM2QxNWQ3MmItOGMyYS00NDIwLTllNjctM2Q2YWY3ODM5Zjg0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoic2dJbUVYWmxLNTZJY3VUcmg5elpsQ1VxbWJGaDZ4MWpYOW9NVGVkYmc5RWYrSDVtSitENldDRk5OWDVNT1l5TiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, January 4, 2019 11:45 PM, Michael S. Tsirkin wrote:
> >  struct virtio_balloon {
> >  	struct virtio_device *vdev;
> >  	struct virtqueue *inflate_vq, *deflate_vq, *stats_vq, *free_page_vq;
> > @@ -77,6 +81,8 @@ struct virtio_balloon {
> >  	/* Prevent updating balloon when it is being canceled. */
> >  	spinlock_t stop_update_lock;
> >  	bool stop_update;
> > +	/* Bitmap to indicate if reading the related config fields are needed
> */
> > +	unsigned long config_read_bitmap;
> >
> >  	/* The list of allocated free pages, waiting to be given back to mm */
> >  	struct list_head free_page_list;
> 
> It seems that you never initialize this bitmap. Probably harmless here but
> generally using uninitialized memory isn't good.

We've used kzalloc to allocate the vb struct, so it's already 0-initialized :)

> > +
> >  static int send_free_pages(struct virtio_balloon *vb)  {
> >  	int err;
> > @@ -620,6 +630,7 @@ static int send_free_pages(struct virtio_balloon *vb)
> >  		 * stop the reporting.
> >  		 */
> >  		cmd_id_active = virtio32_to_cpu(vb->vdev, vb-
> >cmd_id_active);
> > +		virtio_balloon_read_cmd_id_received(vb);
 

[1]


> >  		if (cmd_id_active != vb->cmd_id_received)
> >  			break;
> >
> > @@ -637,11 +648,9 @@ static int send_free_pages(struct virtio_balloon
> *vb)
> >  	return 0;
> >  }
> >
> > -static void report_free_page_func(struct work_struct *work)
> > +static void virtio_balloon_report_free_page(struct virtio_balloon
> > +*vb)
> >  {
> >  	int err;
> > -	struct virtio_balloon *vb = container_of(work, struct virtio_balloon,
> > -						 report_free_page_work);
> >  	struct device *dev = &vb->vdev->dev;
> >
> >  	/* Start by sending the received cmd id to host with an outbuf. */
> > @@ -659,6 +668,22 @@ static void report_free_page_func(struct
> work_struct *work)
> >  		dev_err(dev, "Failed to send a stop id, err = %d\n", err);  }
> >
> > +static void report_free_page_func(struct work_struct *work) {
> > +	struct virtio_balloon *vb = container_of(work, struct virtio_balloon,
> > +						 report_free_page_work);
> > +
> > +	virtio_balloon_read_cmd_id_received(vb);
> 
> This will not achieve what you are trying to do, which is cancel reporting if it's
> in progress.
> 
> You need to re-read each time you compare to cmd_id_active.

Yes, already did, please see [1] above


> An API similar to
> 	u32 virtio_balloon_cmd_id_received(vb)
> seems to be called for, and I would rename cmd_id_received to
> cmd_id_received_cache to make sure we caught all users.
> 

I'm not sure about adding "cache" here, cmd_id_received refers to the cmd id
that the driver just received from the device. There is one called "cmd_id_active" which
is the one that the driver is actively using. 
So cmd_id_received is already a "cache" to " cmd_id_active " in some sense.

Best,
Wei
