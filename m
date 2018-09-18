Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5B3C04ABA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938EA214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 938EA214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbeIRTKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:10:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37970 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbeIRTKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:10:41 -0400
Received: from localhost (unknown [147.67.4.98])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 59A4D74;
        Tue, 18 Sep 2018 13:38:02 +0000 (UTC)
Date:   Tue, 18 Sep 2018 15:37:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Anton Vasilyev <vasilyev@ispras.ru>
Cc:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH v2] tty: rocket: Fix possible buffer overwrite on
 register_PCI
Message-ID: <20180918133759.GA20312@kroah.com>
References: <20180802150201.316e3361@alans-desktop>
 <20180806141057.7105-1-vasilyev@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806141057.7105-1-vasilyev@ispras.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 05:10:57PM +0300, Anton Vasilyev wrote:
> If number of isa and pci boards exceed NUM_BOARDS on the path
> rp_init()->init_PCI()->register_PCI() then buffer overwrite occurs
> in register_PCI() on assign rcktpt_io_addr[i].
> 
> The patch adds check on upper bound for index of registered
> board in register_PCI.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
> ---
> v2: do not enable device which will not be managed by driver.
> Based on Alan's comment.

This patch doesn't apply to my tree at all :(

Can you rebase and resend?

thanks,

greg k-h
