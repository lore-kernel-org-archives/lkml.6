Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B102C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57DA32077B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760257;
	bh=2n8F/OS3RWgvDUXrDfCpSBupJJM0jMRgIqXNZ1s4CPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rresqPjuWyv4D3zWf0n1AkNVsteG1HxfvjZclVcNMiqJy4z9LjkC1mPQkFIEUmZ5I
	 dpn6NlRg3QnUrNn1uZafsTCdvmk2sOtOsS88gCpWklBw/mMuzgeIrnom+150BH6OWM
	 ZoMby9i0GifxeEcoBtGVNTeaR8PyeMFhI1pfat/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbfBUOoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:44:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:40354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729224AbfBUOoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:44:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38B9B20700;
        Thu, 21 Feb 2019 14:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550760251;
        bh=2n8F/OS3RWgvDUXrDfCpSBupJJM0jMRgIqXNZ1s4CPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jzUWeRzp11I5T3dWTTWBIN8UdtXvVfeI7OfJKmCGXhPH881hdbEvxFgTN/mnvHmiR
         JqhSYrawbmq/dk8ddosWJ5sJ/iaGI1kA+eYRYz/wuP2aIIN6e/201iFlwvtA09oK59
         88pNmkj0W1tLS3HFbhDt7b+iPXoJxhJUvmPdPc3M=
Date:   Thu, 21 Feb 2019 15:42:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 7/7] stm class: Prevent division by zero
Message-ID: <20190221144231.GC9283@kroah.com>
References: <20190221134959.15121-1-alexander.shishkin@linux.intel.com>
 <20190221134959.15121-8-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221134959.15121-8-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 03:49:59PM +0200, Alexander Shishkin wrote:
> Using STP_POLICY_ID_SET ioctl command with dummy_stm device, or any STM
> device that supplies zero mmio channel size, will trigger a division by
> zero bug in the kernel.
> 
> Prevent this by disallowing channel widths other than 1 for such devices.
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>

Fixes: tag?

stable?

