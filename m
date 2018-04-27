Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934349AbeD0OzW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 10:55:22 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:52824 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933847AbeD0OzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 10:55:20 -0400
Date: Fri, 27 Apr 2018 10:55:18 -0400 (EDT)
Message-Id: <20180427.105518.55533156322929879.davem@davemloft.net>
To: bjorn.andersson@linaro.org
Cc: clew@codeaurora.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] net: qrtr: Expose tunneling endpoint to user space
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180423214653.10016-1-bjorn.andersson@linaro.org>
References: <20180423214653.10016-1-bjorn.andersson@linaro.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>
Date: Mon, 23 Apr 2018 14:46:53 -0700

> +	count = min_t(size_t, iov_iter_count(to), skb->len);
> +	if (copy_to_iter(skb->data, count, to) != count)
> +		count = -EFAULT;
> +
> +	kfree_skb(skb);

As noted by Chris, you should be using consume_skb() here.

Thanks.
