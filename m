Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751076AbeDMP1Q (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 11:27:16 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:43614 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbeDMP1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 11:27:14 -0400
Date: Fri, 13 Apr 2018 11:27:12 -0400 (EDT)
Message-Id: <20180413.112712.74483562688980325.davem@davemloft.net>
To: jasowang@redhat.com
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ktaka@nii.ac.jp,
        daniel@iogearbox.net
Subject: Re: [PATCH net] virtio-net: add missing virtqueue kick when
 flushing packets
From: David Miller <davem@davemloft.net>
In-Reply-To: <1523602705-5155-1-git-send-email-jasowang@redhat.com>
References: <1523602705-5155-1-git-send-email-jasowang@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Apr 2018 14:58:25 +0800

> We tends to batch submitting packets during XDP_TX. This requires to
> kick virtqueue after a batch, we tried to do it through
> xdp_do_flush_map() which only makes sense for devmap not XDP_TX. So
> explicitly kick the virtqueue in this case.
> 
> Reported-by: Kimitoshi Takahashi <ktaka@nii.ac.jp>
> Tested-by: Kimitoshi Takahashi <ktaka@nii.ac.jp>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Fixes: 186b3c998c50 ("virtio-net: support XDP_REDIRECT")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied and queued up for -stable, thanks Jason.
