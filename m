Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBE9C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B342084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hvmi0O4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B342084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbeLLIHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 03:07:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50812 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeLLIHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 03:07:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qKZxiBHt9/UyuAa9T6eWhnIoKvg61vLUHkfyQ47khK0=; b=hvmi0O4o0rMocCb5KtIR7Cn1Q
        CnbKnPWZUsa4Y0KhJqTu2ipyUD6hbtW3XZ0Z5ROxM4xS+6uOOxMH4IxbWyN4UScHEnUCd29c2EC07
        AY0Pyrktifn/BTpEqV0QyC71KdsctqlnUmZryRFz87xyfTIqcxyVRzWYmCglH+FFD9f9mHAwvAcXd
        tGPa09YvBKwH1olNIQJvJ6s3+dmpnB9zMXQk8qwcmI6CNePXAHshLL4WXjE+jaiqrsurjAKM6PoxG
        fdRd8uju5M5IcGYK85pt5g+nFNrhIm8cJdEhAVA95u7jQttG4BlnCVEthY7DhHSRszFbsJHR6rure
        gdhwbJUVg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gWzXh-0005b4-2j; Wed, 12 Dec 2018 08:06:53 +0000
Date:   Wed, 12 Dec 2018 00:06:52 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ashish Mhetre <amhetre@nvidia.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net, axboe@kernel.dk,
        adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-crypto@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, vdumpa@nvidia.com,
        mmaddireddy@nvidia.com, linux-tegra@vger.kernel.org,
        Snikam@nvidia.com
Subject: Re: [PATCH] scatterlist: Update size type to support greater then
 4GB size.
Message-ID: <20181212080652.GA14877@infradead.org>
References: <1544595853-18492-1-git-send-email-amhetre@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544595853-18492-1-git-send-email-amhetre@nvidia.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scatterlist elements longer than 4GB sound odd.  Please submit it
in a series with your actual user so that we can help figuring out
if it really makes sense or if there is a better way to solve your
problem.

As is this patch will massively increase the memory usage for all users
of struct scatterlist, so you better have a really good reason.
