Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932523AbeDWR6s (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 13:58:48 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:50340 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932271AbeDWR6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 13:58:44 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH] Bluetooth: use wait_event API instead of open-coding it
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180419152937.13515-1-john@metanate.com>
Date: Mon, 23 Apr 2018 19:58:41 +0200
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
        ML netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <343B67B0-5FE7-4113-8725-202AC0C8BA8A@holtmann.org>
References: <20180419152937.13515-1-john@metanate.com>
To: John Keeping <john@metanate.com>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

> I've seen timeout errors from HCI commands where it looks like
> schedule_timeout() has returned immediately; additional logging for the
> error case gives:
> 
> 	req_status=1 req_result=0 remaining=10000 jiffies
> 
> so the device is still in state HCI_REQ_PEND and the value returned by
> schedule_timeout() is the same as the original timeout (HCI_INIT_TIMEOUT
> on a system with HZ=1000).
> 
> Use wait_event_interruptible_timeout() instead of open-coding similar
> behaviour which is subject to the spurious failure described above.
> 
> Signed-off-by: John Keeping <john@metanate.com>
> ---
> I saw problems with the -rt patchset on 4.9 and I'm not convinced that
> it's Bluetooth at fault for the problem described above, but I think
> this is a nice cleanup even if it's not a bug fix.
> 
> net/bluetooth/hci_request.c | 30 +++++++-----------------------
> 1 file changed, 7 insertions(+), 23 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
