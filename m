Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751535AbeDEVTV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 17:19:21 -0400
Received: from gate.crashing.org ([63.228.1.57]:46991 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750726AbeDEVTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 17:19:20 -0400
Message-ID: <1522963113.21446.211.camel@kernel.crashing.org>
Subject: Re: [RFC] virtio: Use DMA MAP API for devices without an IOMMU
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, robh@kernel.org, aik@ozlabs.ru,
        jasowang@redhat.com, joe@perches.com, linuxppc-dev@lists.ozlabs.org,
        elfring@users.sourceforge.net, david@gibson.dropbear.id.au
Date: Fri, 06 Apr 2018 07:18:33 +1000
In-Reply-To: <20180405213042-mutt-send-email-mst@kernel.org>
References: <20180405105631.9514-1-khandual@linux.vnet.ibm.com>
         <3e1b113b-79ca-b700-5be9-10c66d74aabe@linux.vnet.ibm.com>
         <20180405175326-mutt-send-email-mst@kernel.org>
         <1522940983.21446.205.camel@kernel.crashing.org>
         <20180405213042-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-04-05 at 21:34 +0300, Michael S. Tsirkin wrote:
> > In this specific case, because that would make qemu expect an iommu,
> > and there isn't one.
> 
> 
> I think that you can set iommu_platform in qemu without an iommu.

No I mean the platform has one but it's not desirable for it to be used
due to the performance hit.

Cheers,
Ben.
> 
> > Anshuman, you need to provide more background here. I don't have time
> > right now it's late, but explain about the fact that this is for a
> > specific type of secure VM which has only a limited pool of (insecure)
> > memory that can be shared with qemu, so all IOs need to bounce via that
> > pool, which can be achieved by using swiotlb.
> > 
> > Note: this isn't urgent, we can discuss alternative approaches, this is
> > just to start the conversation.
> > 
> > Cheers,
> > Ben.
