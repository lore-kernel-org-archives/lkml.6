Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924F0C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58EED20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544612377;
	bh=Qt3UUgdRd9PJvUcKgWacYx8pX01WX7ZCIyWAVDYDrB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vR2HEG2oNkAgWfqUlNZ/u9Tit8LyEMdHjfwwhQOvYrkgZsAKTjn8NEElBWJ8DWfTX
	 auP/M0uYIV0MPpiHQXos5B91kMwCRkRQzBHxoj15QeXIyOVjOrtTcPFAKNqh962xzQ
	 S1m+Z1KfISVTOzpXmyUquOzR3fedaDAETlV/KWzY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58EED20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbeLLK7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:59:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:39546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbeLLK7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:59:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13DD42086D;
        Wed, 12 Dec 2018 10:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544612374;
        bh=Qt3UUgdRd9PJvUcKgWacYx8pX01WX7ZCIyWAVDYDrB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o//z8GHRHv2jpG3K+kJ7LI/mez4t+5lHp3mBALXmXiXf1WApfkoNOm+QEX7WGk+vZ
         YiNhZ89i+mRH5QfD8NcWGKC2B0+y0UsjbTWtZW5lyETOm/VnbhfUA1WhlYpjgkw5DC
         qUmRuuGhBM+1BKQR7ppFMC5cLna2UW9yhJYaC4Kk=
Date:   Wed, 12 Dec 2018 11:59:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     robh+dt@kernel.org, arnd@arndb.de, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        bkumar@qti.qualcomm.com, thierry.escande@linaro.org
Subject: Re: [PATCH v2 6/6] misc: fastrpc: Add support for compat ioctls
Message-ID: <20181212105932.GA1990@kroah.com>
References: <20181207163513.16412-1-srinivas.kandagatla@linaro.org>
 <20181207163513.16412-7-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207163513.16412-7-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 04:35:13PM +0000, Srinivas Kandagatla wrote:
> This patch adds support for compat ioctl from 32 bits userland to
> Qualcomm fastrpc driver.

Ick, why?

Why not just fix up your ioctl structures to not need that at all?  For
new code being added to the kernel, there's no excuse to have to have
compat structures anymore, just make your api sane and all should be
fine.

What prevents you from doing that and requiring compat support?

thanks,

greg k-h
