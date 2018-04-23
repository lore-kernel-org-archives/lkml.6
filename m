Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932648AbeDWVx2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 17:53:28 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:47575 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932291AbeDWVx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 17:53:26 -0400
X-ME-Sender: <xms:1lXeWthbE0j3eEJFUTBE3bjruBBAt-Z7cR3gZx6VeRcWQ4wRsa4JqQ>
Date: Mon, 23 Apr 2018 14:53:25 -0700
From: Andres Freund <andres@anarazel.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Always report a writeback error once
Message-ID: <20180423215325.4jek2nr7lqy4y532@alap3.anarazel.de>
References: <20180423204208.GG13383@bombadil.infradead.org>
 <20180423205730.34wvykqhefbkrtfw@alap3.anarazel.de>
 <20180423214348.GH13383@bombadil.infradead.org>
 <20180423215150.GI13383@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423215150.GI13383@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-23 14:51:50 -0700, Matthew Wilcox wrote:
> How does this look?
> 
> @@ -111,27 +111,22 @@ EXPORT_SYMBOL(errseq_set);
>   * errseq_sample() - Grab current errseq_t value.
>   * @eseq: Pointer to errseq_t to be sampled.
>   *
> - * This function allows callers to sample an errseq_t value, marking it as
> - * "seen" if required.
> + * This function allows callers to initialise their errseq_t variable.
> + * If the error has been "seen", new callers will not see an old error.
> + * If there is an unseen error in @eseq, the caller of this function will
> + * see it the next time it checks for an error.
>   *
> + * Context: Any context.
>   * Return: The current errseq value.
>   */
>  errseq_t errseq_sample(errseq_t *eseq)

LGTM.
