Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752043AbeC2UXQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 16:23:16 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:49486 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751205AbeC2UXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 16:23:14 -0400
Date: Thu, 29 Mar 2018 16:23:12 -0400 (EDT)
Message-Id: <20180329.162312.1243047104828828329.davem@davemloft.net>
To: mst@redhat.com
Cc: jasowang@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vhost: validate log when IOTLB is enabled
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180329154803-mutt-send-email-mst@kernel.org>
References: <1522310404-8486-1-git-send-email-jasowang@redhat.com>
        <20180329154803-mutt-send-email-mst@kernel.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Thu, 29 Mar 2018 15:48:22 +0300

> On Thu, Mar 29, 2018 at 04:00:04PM +0800, Jason Wang wrote:
>> Vq log_base is the userspace address of bitmap which has nothing to do
>> with IOTLB. So it needs to be validated unconditionally otherwise we
>> may try use 0 as log_base which may lead to pin pages that will lead
>> unexpected result (e.g trigger BUG_ON() in set_bit_to_user()).
>> 
>> Fixes: 6b1e6cc7855b0 ("vhost: new device IOTLB API")
>> Reported-by: syzbot+6304bf97ef436580fede@syzkaller.appspotmail.com
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> stable material I guess.

Applied and queued up for -stable.
