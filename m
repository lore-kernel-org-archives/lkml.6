Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946780AbeCBQIF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:08:05 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40948 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1423191AbeCBQID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:08:03 -0500
Date: Fri, 2 Mar 2018 17:07:58 +0100
From: Jesper Dangaard Brouer <brouer@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        john.fastabend@gmail.com, brouer@redhat.com
Subject: Re: [PATCH net V2] virtio-net: re enable XDP_REDIRECT for mergeable
 buffer
Message-ID: <20180302170758.332600d6@redhat.com>
In-Reply-To: <1519982954-14360-1-git-send-email-jasowang@redhat.com>
References: <1519982954-14360-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  2 Mar 2018 17:29:14 +0800
Jason Wang <jasowang@redhat.com> wrote:

> XDP_REDIRECT support for mergeable buffer was removed since commit
> 7324f5399b06 ("virtio_net: disable XDP_REDIRECT in receive_mergeable()
> case"). This is because we don't reserve enough tailroom for struct
> skb_shared_info which breaks XDP assumption. So this patch fixes this
> by reserving enough tailroom and using fixed size of rx buffer.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> Changes from V1:
> - do not add duplicated tracepoint when redirection fails

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

I gave it a quick spin on my testlab, and cpumap seems to
work/not-crash now (if I managed to turn back config to
receive_mergeable() correctly ;-)).

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
