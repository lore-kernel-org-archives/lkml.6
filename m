Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755375AbeDTOkd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:40:33 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:44518 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755297AbeDTOkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:40:22 -0400
Date: Fri, 20 Apr 2018 10:40:20 -0400 (EDT)
Message-Id: <20180420.104020.570006839387571888.davem@davemloft.net>
To: bjorn.andersson@linaro.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, clew@codeaurora.org
Subject: Re: [PATCH] net: qrtr: Expose tunneling endpoint to user space
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180419050346.17054-1-bjorn.andersson@linaro.org>
References: <20180419050346.17054-1-bjorn.andersson@linaro.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>
Date: Wed, 18 Apr 2018 22:03:46 -0700

> +struct qrtr_tun {
> +	struct qrtr_endpoint ep;
> +
> +	struct mutex queue_lock;
> +	struct sk_buff_head queue;
> +	wait_queue_head_t readq;
> +};

The queue lock is surperfluous.  sk_buff_head and all of the helpers you
are using does it's own locking.  So you are essentially using two sets
of locks to protect the same object.
