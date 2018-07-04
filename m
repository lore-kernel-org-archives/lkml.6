Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F18AC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13CF221473
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TZ0W/7Eb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13CF221473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753117AbeGDQnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:43:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37618 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752197AbeGDQmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=q8t15RxvK2uZrRI4y5F8RDpsY3PWSWtMVZ44ZaRsdg8=; b=TZ0W/7EbjCk25hRoHbhXWr28F
        OZbSvCSTKeOYwi9p9iu0IfJpxUcX3XoIEeQQY3B9hLyDZIkoXzzrFSqPmGDRUaWXAabpGLccwoD9a
        y26ReEkAFHxoTKXDs9JHc125rVR4FcSpw/Wyy2I+X6C4kqRJ6d7qLIFB3wmNqD5CF2glNdHUWol8U
        DlxkKtF8thrxFclPb/8B1DGhuaNACH357Zlg9m2OB4m8jHU+rYhGTdMCt+HC4+E/1xGVfRe2at+0h
        boaNurrlOBx7rD2yNTi4LbqdTbMLCIthTnJ2wPLamX3hJQ7iyhsu0IB3DDjq/1j0KTMYsvSmKOnja
        x2AKwkI0Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fakr9-000840-ED; Wed, 04 Jul 2018 16:42:15 +0000
Date:   Wed, 4 Jul 2018 09:42:15 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     eric@anholt.net, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, svptas.linux@gmail.com,
        brajeswar.linux@gmail.com, sabyasachi.linux@gmail.com,
        ajitn.linux@gmail.com
Subject: Re: [PATCH v2] gpu: drm: v3d: use new return type vm_fault_t
Message-ID: <20180704164215.GA4583@bombadil.infradead.org>
References: <20180704145556.GA11036@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704145556.GA11036@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 08:25:57PM +0530, Souptick Joarder wrote:
> Convert v3d_gem_fault to return vm_fault_t
> 
> Instead of converting an errno into a vm_fault_t ourselves, use
> vmf_insert_mixed() which returns a vm_fault_t directly.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Reviewed-by: Matthew Wilcox <willy@infradead.org>
