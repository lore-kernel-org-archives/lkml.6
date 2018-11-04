Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB7AC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 11:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F7120685
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 11:57:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F7120685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729475AbeKDVM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 16:12:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729293AbeKDVM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 16:12:27 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 70B3B81DE9;
        Sun,  4 Nov 2018 11:57:43 +0000 (UTC)
Received: from dhcp-4-67.tlv.redhat.com (dhcp-4-67.tlv.redhat.com [10.35.4.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 02D745C26E;
        Sun,  4 Nov 2018 11:57:38 +0000 (UTC)
Message-ID: <bf92bdb6dcb0e94014b3e1ffc8acce260a3df61e.camel@redhat.com>
Subject: Re: [PATCH 0/1] vhost: add vhost_blk driver
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vitaly Mayatskikh <v.mayatskih@gmail.com>,
        "Michael S . Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 04 Nov 2018 13:57:37 +0200
In-Reply-To: <20181102182123.29420-1-v.mayatskih@gmail.com>
References: <20181102182123.29420-1-v.mayatskih@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Sun, 04 Nov 2018 11:57:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-02 at 18:21 +0000, Vitaly Mayatskikh wrote:
> vhost_blk is a host-side kernel mode accelerator for virtio-blk. The
> driver allows VM to reach a near bare-metal disk performance. See IOPS
> numbers below (fio --rw=randread --bs=4k).
> 
> This implementation uses kiocb interface. It is slightly slower than
> going directly through bio, but is simpler and also works with disk
> images placed on a file system.
> 
> # fio num-jobs
> # A: bare metal over block
> # B: bare metal over file
> # C: virtio-blk over block
> # D: virtio-blk over file
> # E: vhost-blk bio over block
> # F: vhost-blk kiocb over block
> # G: vhost-blk kiocb over file
> #
> #  A     B     C    D    E     F     G
> 

Hi!
I am also working in this area, and so I am very intersted in this driver.

> 1  171k  151k  148k 151k 195k  187k  175k
If I understand correctly this is fio --numjobs=1?
It looks like you are getting better that native performance over bare metal in
E,F,G (vhost-blk cases in fact). Is this correct?

Could you share the full fio command line you have used?
Which IO device did you use for the test? NVME?
Which system (cpu model/number of cores/etc) did you test on?

Best regards,
      Maxim Levitsky


