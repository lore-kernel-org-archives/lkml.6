Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751735AbeBZSuH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 13:50:07 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:45614 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751670AbeBZSuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 13:50:06 -0500
Date: Mon, 26 Feb 2018 13:50:04 -0500 (EST)
Message-Id: <20180226.135004.744356947488629833.davem@davemloft.net>
To: jasowang@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mst@redhat.com,
        sergei.shtylyov@cogentembedded.com, christoffer.dall@linaro.org,
        brouer@redhat.com
Subject: Re: [PATCH V4 net 1/3] Revert "tuntap: add missing xdp flush"
From: David Miller <davem@davemloft.net>
In-Reply-To: <1519443146-9089-1-git-send-email-jasowang@redhat.com>
References: <1519443146-9089-1-git-send-email-jasowang@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>
Date: Sat, 24 Feb 2018 11:32:24 +0800

> This reverts commit 762c330d670e3d4b795cf7a8d761866fdd1eef49. The
> reason is we try to batch packets for devmap which causes calling
> xdp_do_flush() in the process context. Simply disabling preemption
> may not work since process may move among processors which lead
> xdp_do_flush() to miss some flushes on some processors.
> 
> So simply revert the patch, a follow-up patch will add the xdp flush
> correctly.
> 
> Reported-by: Christoffer Dall <christoffer.dall@linaro.org>
> Fixes: 762c330d670e ("tuntap: add missing xdp flush")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied.
