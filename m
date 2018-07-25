Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E6CC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C1320843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C1320843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbeGYOnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 10:43:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50582 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728425AbeGYOnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 10:43:06 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 04AA77721D;
        Wed, 25 Jul 2018 13:31:25 +0000 (UTC)
Received: from redhat.com (ovpn-121-228.rdu2.redhat.com [10.10.121.228])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1429110FFE4D;
        Wed, 25 Jul 2018 13:31:15 +0000 (UTC)
Date:   Wed, 25 Jul 2018 16:31:08 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
        elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
        jasowang@redhat.com, benh@kernel.crashing.org, mpe@ellerman.id.au,
        hch@infradead.org, linuxram@us.ibm.com, haren@linux.vnet.ibm.com,
        paulus@samba.org, srikar@linux.vnet.ibm.com
Subject: Re: [RFC 4/4] virtio: Add platform specific DMA API translation for
 virito devices
Message-ID: <20180725162951-mutt-send-email-mst@kernel.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180720035941.6844-5-khandual@linux.vnet.ibm.com>
 <20180720160550-mutt-send-email-mst@kernel.org>
 <3dd36d8e-3bc8-91ba-cf6d-939495439d2c@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dd36d8e-3bc8-91ba-cf6d-939495439d2c@linux.vnet.ibm.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 25 Jul 2018 13:31:25 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 25 Jul 2018 13:31:25 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 07:46:09AM +0530, Anshuman Khandual wrote:
> There is a redundant definition of virtio_has_iommu_quirk in the tools
> directory (tools/virtio/linux/virtio_config.h) which does not seem to
> be used any where. I guess that can be removed without problem.

It's there just to make tools/virtio build.
Try
	make -C tools/virtio/
In fact I see there's a missing definition for
dma_rmb/dma_wmb there, I'll post a patch.

-- 
MST
