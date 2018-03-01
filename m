Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966838AbeCAJQO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:16:14 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58280 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966601AbeCAJQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:16:01 -0500
Date: Thu, 1 Mar 2018 10:15:53 +0100
From: Jesper Dangaard Brouer <brouer@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        john.fastabend@gmail.com, brouer@redhat.com
Subject: Re: [PATCH net-next 2/2] virtio-net: simplify XDP handling in small
 buffer
Message-ID: <20180301101553.55c4c6bd@redhat.com>
In-Reply-To: <dbbfd899-fb7e-c039-5c9a-0f3b6ce34b78@redhat.com>
References: <1519874345-10235-1-git-send-email-jasowang@redhat.com>
        <1519874345-10235-3-git-send-email-jasowang@redhat.com>
        <20180301090206.04e13a71@redhat.com>
        <dbbfd899-fb7e-c039-5c9a-0f3b6ce34b78@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2018 16:49:24 +0800
Jason Wang <jasowang@redhat.com> wrote:

> > 2. This can easily cause out-of-order packets.  
> 
> I may miss something, but it looks to me packets were still delivered
> in order? Or you mean the packets that was dropped by cpumap?

No. Packets can now travel two code paths to the egress device. (1) XDP
native via ndp_xdp_xmit via direct delivery into a lockfree/dedicated
TX queue, (2) via normal network stack which can involve being queue in
a qdisc.  Do you see the possibility of the reorder now?

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
