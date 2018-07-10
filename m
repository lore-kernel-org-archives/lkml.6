Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4218C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC77520881
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC77520881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751258AbeGJG3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 02:29:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56894 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbeGJG3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 02:29:11 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A1AACCB0;
        Tue, 10 Jul 2018 06:29:10 +0000 (UTC)
Date:   Tue, 10 Jul 2018 08:29:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sujeev Dias <sdias@codeaurora.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Tony Truong <truong@codeaurora.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>
Subject: Re: [PATCH v2 3/7] mhi_bus: core: add support for data transfer
Message-ID: <20180710062907.GB892@kroah.com>
References: <1524795811-21399-1-git-send-email-sdias@codeaurora.org>
 <1531166894-30984-1-git-send-email-sdias@codeaurora.org>
 <1531166894-30984-4-git-send-email-sdias@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531166894-30984-4-git-send-email-sdias@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 01:08:10PM -0700, Sujeev Dias wrote:
> +static void mhi_add_ring_element(struct mhi_controller *mhi_cntrl,
> +				 struct mhi_ring *ring)
> +{
> +	ring->wp += ring->el_size;
> +	if (ring->wp >= (ring->base + ring->len))
> +		ring->wp = ring->base;
> +	/* smp update */
> +	smp_wmb();

Why do this?  You need to comment the heck out of odd stuff like this.

Also, why are you using your own ring buffer code?  What's wrong with
the code that is in the kernel already for this type of thing?

thanks,

greg k-h
