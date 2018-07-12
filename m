Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA8CC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA712208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:31:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA712208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbeGLMki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:40:38 -0400
Received: from 14.mo6.mail-out.ovh.net ([46.105.56.113]:59589 "EHLO
        14.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbeGLMki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:40:38 -0400
X-Greylist: delayed 1204 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Jul 2018 08:40:38 EDT
Received: from player738.ha.ovh.net (unknown [10.109.120.75])
        by mo6.mail-out.ovh.net (Postfix) with ESMTP id 9786B16A9DD
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 13:55:26 +0200 (CEST)
Received: from bahia.lan (lns-bzn-46-82-253-208-248.adsl.proxad.net [82.253.208.248])
        (Authenticated sender: groug@kaod.org)
        by player738.ha.ovh.net (Postfix) with ESMTPSA id 56ECE13DD;
        Thu, 12 Jul 2018 13:55:11 +0200 (CEST)
Date:   Thu, 12 Jul 2018 13:55:10 +0200
From:   Greg Kurz <groug@kaod.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        linux-kernel@vger.kernel.org, Ron Minnich <rminnich@sandia.gov>,
        linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: [V9fs-developer] [PATCH v2 1/6] 9p: Fix comment on smp_wmb
Message-ID: <20180712135510.17149f73@bahia.lan>
In-Reply-To: <20180711210225.19730-2-willy@infradead.org>
References: <20180711210225.19730-1-willy@infradead.org>
        <20180711210225.19730-2-willy@infradead.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 4732720260589197637
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtiedrgeekgdegjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 14:02:20 -0700
Matthew Wilcox <willy@infradead.org> wrote:

> The previous comment misled me into thinking the barrier wasn't needed
> at all.
> 
> Signed-off-by: Matthew Wilcox <willy@infradead.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  net/9p/client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/9p/client.c b/net/9p/client.c
> index 18c5271910dc..999eceb8af98 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -447,7 +447,7 @@ void p9_client_cb(struct p9_client *c, struct p9_req_t *req, int status)
>  
>  	/*
>  	 * This barrier is needed to make sure any change made to req before
> -	 * the other thread wakes up will indeed be seen by the waiting side.
> +	 * the status change is visible to another thread
>  	 */
>  	smp_wmb();
>  	req->status = status;

