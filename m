Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B883C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10716214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yeb3vx5a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10716214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbeKUX6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:58:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44404 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbeKUX6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 18:58:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=E20md2x0HrARDRzba6iknG/3/1PhChI3v+zQJ1xSUJs=; b=Yeb3vx5af1jZEKO6EGKD4QFcH
        kjWBTf5kWXtRmsmM08FFfxesly7UO5NbMnbQq46wKFZK35/ooDITPZSihTg+LwE23y9HPKObXhtoa
        H6HsopIHx9ZmOAVj00GtPM3c1p7Y00K9oAj/m+doxH4Pn4wUWW8wJUOQ10p+0PzhZD7xWnMFMLEYt
        sRNwll3o76XdaM/KJWJaP8QKV4hR+7GnrCu13X2FF/ipoj3C82eo3IKIIjblZMKO1VS29mFoyOa71
        z00VNuKcjofzs06bCHM3w9KwajNOCaQUMfyLCpjTYChEYlRWXA4YlDofqo34Ohd1LjO/aspjrtKnt
        TNvJnVe6w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPSTr-0001QE-0o; Wed, 21 Nov 2018 13:23:47 +0000
Date:   Wed, 21 Nov 2018 05:23:46 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] doc:process: add links where missing
Message-ID: <20181121132346.GG3065@bombadil.infradead.org>
References: <20181121003519.12559-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121003519.12559-1-federico.vaga@vaga.pv.it>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 01:35:19AM +0100, Federico Vaga wrote:
> Some documents are refering to others without links. With this
> patch I add those missing links.

I am a neophyte to ReST, but ...

> +++ b/Documentation/dev-tools/coccinelle.rst
> @@ -4,6 +4,8 @@
>  
>  .. highlight:: none
>  
> +.. _devtools_coccinelle:
> +
>  Coccinelle
>  ==========
>  

> +++ b/Documentation/process/4.Coding.rst
> @@ -315,7 +315,8 @@ variety of potential coding problems; it can also propose fixes for those
>  problems.  Quite a few "semantic patches" for the kernel have been packaged
>  under the scripts/coccinelle directory; running "make coccicheck" will run
>  through those semantic patches and report on any problems found.  See
> -Documentation/dev-tools/coccinelle.rst for more information.
> +:ref:`Documentation/dev-tools/coccinelle.rst <devtools_coccinelle>`
> +for more information.

when I tried to do something like this yesterday, I discovered that
doing:

+.. _memory_allocation:

didn't work, and I had to do:

+.. _memory-allocation:

instead.  Also, when doing 'ref', do we want this style of ref, or do we
prefer the plain:

:ref:`devtools-coccinelle`

which is what I did yesterday.  Maybe that's why yours works with the
underscores and mine didn't?
