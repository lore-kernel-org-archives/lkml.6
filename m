Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C27AC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C29BD21477
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMUVtVK6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C29BD21477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbeJRXT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 19:19:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727370AbeJRXT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 19:19:27 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C1F220869;
        Thu, 18 Oct 2018 15:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539875879;
        bh=ZrYuu+lwI3LQK3VPVoLJj7umg3GZAFSUs4txNn9KuV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XMUVtVK67lSD/3bpw0sHGiL9eYbTft3uO1VMBMaUXEQ09CWk8vk3A+FucmYB8vFz5
         jt9vNb1F5mHxpE+UF5ADbdp0xatyN50/VW7uy+G29b3Zv9NAUiWFNCpHVQmqnYfDmI
         iZOiI6qlFNdEl4P6lFTtwESFTV/3qubQIUYH1c2I=
Date:   Thu, 18 Oct 2018 17:17:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     stable@vger.kernel.org, Felipe Balbi <balbi@ti.com>,
        Stephen Warren <swarren@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: Re: [PATCH stable v4.4+] usb: gadget: serial: fix oops when data
 rx'd after close
Message-ID: <20181018151756.GA10600@kroah.com>
References: <1539872900-13011-1-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539872900-13011-1-git-send-email-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 04:28:20PM +0200, Krzysztof Kozlowski wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> commit daa35bd95634a2a2d72d1049c93576a02711cb1a upstream
> 
> When the gadget serial device has no associated TTY, do not pass any
> received data into the TTY layer for processing; simply drop it instead.
> This prevents the TTY layer from calling back into the gadget serial
> driver, which will then crash in e.g. gs_write_room() due to lack of
> gadget serial device to TTY association (i.e. a NULL pointer dereference).
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Now queued up, thanks.

greg k-h
