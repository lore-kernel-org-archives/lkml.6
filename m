Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A55FC10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A31021852
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551201784;
	bh=LTWMQqkQl0iKrJeoGry9xGq8NjwxZS9sdbrZs552ewE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zdTKQyDSDrNAgvhezDGA1/VinI9yiXRdjOHwmgTfak26eSti9zbqaJ4BpOFFnhTsc
	 MBwH8dynR/x0Hx+PnzMB1YVBVAaaCWFxxswFGPa3d9cACeKbY8n7oQNejm2hu1Fx9n
	 X6h8zjvHv3lVrhNcQkXG8U/RCZRN9RyJS1Gdx1T8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbfBZRXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:23:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:60924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbfBZRXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 12:23:02 -0500
Received: from localhost (unknown [171.61.89.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 179CB21848;
        Tue, 26 Feb 2019 17:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551201781;
        bh=LTWMQqkQl0iKrJeoGry9xGq8NjwxZS9sdbrZs552ewE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PCAXM1U5WUbHdPE1HhsnX4pC/0zLD1ojixYJXtFeZE/UYELiGO822MnW3No5CMAh/
         zNDucVG4HdgnD517nKbZQsJuRO0ZFubt0Uo+odREOhE0LulgyHGLg664YbK8EBYEUe
         8IYSvdnS2bcevWM+rnx/FhU8ap67a71HU/eSP4WM=
Date:   Tue, 26 Feb 2019 22:52:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: linux-next: manual merge of the slave-dma tree with Linus' tree
Message-ID: <20190226172253.GT31146@vkoul-mobl>
References: <20190226152417.29e1f3ed@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226152417.29e1f3ed@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-02-19, 15:24, Stephen Rothwell wrote:
> Hi Vinod,
> 
> Today's linux-next merge of the slave-dma tree got a conflict in:
> 
>   drivers/dma/dmatest.c
> 
> between commit:
> 
>   6454368a804c ("dmaengine: dmatest: Abort test in case of mapping error")
> 
> from Linus' tree and commit:
> 
>   361deb7243d2 ("dmaengine: dmatest: wrap src & dst data into a struct")
> 
> from the slave-dma tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks for the fix, this seems fine to me. Also, in this case that Linus
so let me see how to ease it :)

> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc drivers/dma/dmatest.c
> index 6511928b4cdf,50221d467d86..000000000000
> --- a/drivers/dma/dmatest.c
> +++ b/drivers/dma/dmatest.c
> @@@ -708,12 -726,14 +726,12 @@@ static int dmatest_func(void *data
>   
>   			um->addr[i] = dma_map_page(dev->dev, pg, pg_off,
>   						   um->len, DMA_TO_DEVICE);
> - 			srcs[i] = um->addr[i] + src_off;
> + 			srcs[i] = um->addr[i] + src->off;
>   			ret = dma_mapping_error(dev->dev, um->addr[i]);
>   			if (ret) {
>  -				dmaengine_unmap_put(um);
>   				result("src mapping error", total_tests,
> - 				       src_off, dst_off, len, ret);
> + 				       src->off, dst->off, len, ret);
>  -				failed_tests++;
>  -				continue;
>  +				goto error_unmap_continue;
>   			}
>   			um->to_cnt++;
>   		}
> @@@ -728,9 -748,11 +746,9 @@@
>   					       DMA_BIDIRECTIONAL);
>   			ret = dma_mapping_error(dev->dev, dsts[i]);
>   			if (ret) {
>  -				dmaengine_unmap_put(um);
>   				result("dst mapping error", total_tests,
> - 				       src_off, dst_off, len, ret);
> + 				       src->off, dst->off, len, ret);
>  -				failed_tests++;
>  -				continue;
>  +				goto error_unmap_continue;
>   			}
>   			um->bidi_cnt++;
>   		}
> @@@ -758,10 -780,12 +776,10 @@@
>   		}
>   
>   		if (!tx) {
> - 			result("prep error", total_tests, src_off,
> - 			       dst_off, len, ret);
>  -			dmaengine_unmap_put(um);
> + 			result("prep error", total_tests, src->off,
> + 			       dst->off, len, ret);
>   			msleep(100);
>  -			failed_tests++;
>  -			continue;
>  +			goto error_unmap_continue;
>   		}
>   
>   		done->done = false;
> @@@ -770,10 -794,12 +788,10 @@@
>   		cookie = tx->tx_submit(tx);
>   
>   		if (dma_submit_error(cookie)) {
> - 			result("submit error", total_tests, src_off,
> - 			       dst_off, len, ret);
>  -			dmaengine_unmap_put(um);
> + 			result("submit error", total_tests, src->off,
> + 			       dst->off, len, ret);
>   			msleep(100);
>  -			failed_tests++;
>  -			continue;
>  +			goto error_unmap_continue;
>   		}
>   		dma_async_issue_pending(chan);
>   
> @@@ -782,23 -808,25 +800,23 @@@
>   
>   		status = dma_async_is_tx_complete(chan, cookie, NULL, NULL);
>   
>  -		dmaengine_unmap_put(um);
>  -
>   		if (!done->done) {
> - 			result("test timed out", total_tests, src_off, dst_off,
> + 			result("test timed out", total_tests, src->off, dst->off,
>   			       len, 0);
>  -			failed_tests++;
>  -			continue;
>  +			goto error_unmap_continue;
>   		} else if (status != DMA_COMPLETE) {
>   			result(status == DMA_ERROR ?
>   			       "completion error status" :
> - 			       "completion busy status", total_tests, src_off,
> - 			       dst_off, len, ret);
> + 			       "completion busy status", total_tests, src->off,
> + 			       dst->off, len, ret);
>  -			failed_tests++;
>  -			continue;
>  +			goto error_unmap_continue;
>   		}
>   
>  +		dmaengine_unmap_put(um);
>  +
>   		if (params->noverify) {
> - 			verbose_result("test passed", total_tests, src_off,
> - 				       dst_off, len, 0);
> + 			verbose_result("test passed", total_tests, src->off,
> + 				       dst->off, len, 0);
>   			continue;
>   		}
>   
> @@@ -833,15 -861,9 +851,15 @@@
>   			       len, error_count);
>   			failed_tests++;
>   		} else {
> - 			verbose_result("test passed", total_tests, src_off,
> - 				       dst_off, len, 0);
> + 			verbose_result("test passed", total_tests, src->off,
> + 				       dst->off, len, 0);
>   		}
>  +
>  +		continue;
>  +
>  +error_unmap_continue:
>  +		dmaengine_unmap_put(um);
>  +		failed_tests++;
>   	}
>   	ktime = ktime_sub(ktime_get(), ktime);
>   	ktime = ktime_sub(ktime, comparetime);



-- 
~Vinod
