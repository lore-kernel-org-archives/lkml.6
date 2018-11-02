Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F610C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364E92082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 364E92082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbeKCFq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 01:46:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45562 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbeKCFq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 01:46:56 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E53454DD49;
        Fri,  2 Nov 2018 20:38:20 +0000 (UTC)
Received: from redhat.com (ovpn-124-238.rdu2.redhat.com [10.10.124.238])
        by smtp.corp.redhat.com (Postfix) with SMTP id 35337450E;
        Fri,  2 Nov 2018 20:38:20 +0000 (UTC)
Date:   Fri, 2 Nov 2018 16:38:19 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Vitaly Mayatskih <v.mayatskih@gmail.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Add vhost_blk driver
Message-ID: <20181102163809-mutt-send-email-mst@kernel.org>
References: <20181102182123.29420-1-v.mayatskih@gmail.com>
 <20181102182123.29420-2-v.mayatskih@gmail.com>
 <20181102142645-mutt-send-email-mst@kernel.org>
 <CAGF4SLj0TtW_kP935UdqswjT9qaznh_BR7sxW2ALozy7yTJ8vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGF4SLj0TtW_kP935UdqswjT9qaznh_BR7sxW2ALozy7yTJ8vg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 02 Nov 2018 20:38:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 03:24:13PM -0400, Vitaly Mayatskih wrote:
> On Fri, Nov 2, 2018 at 2:36 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> 
> > > +     if (type == VIRTIO_BLK_T_GET_ID) {
> > > +             char s[] = "vhost_blk";
> >
> > Isn't this supposed to return the serial #?
> 
> Yes, that gets a bit tricky here... Disk serial number is specified in
> QEMU command line parameters, so it needs to be passed to vhost_blk
> when qemu attaches the disk backend. That can be done (now? in a
> following incremental patch?).

I'add an ioctl now.

> Also other vhost work does the same with GET_ID, if that's matter.
> 
> I'll fix the rest, thanks for review!
> 
> -- 
> wbr, Vitaly
