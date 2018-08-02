Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7B9C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C148208DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:03:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C148208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbeHBJxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 05:53:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37752 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbeHBJw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 05:52:59 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EDE5FC9B;
        Thu,  2 Aug 2018 08:03:00 +0000 (UTC)
Date:   Thu, 2 Aug 2018 10:02:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jheng-Jhong Wu <goodwater.wu@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: mt29f_spinand: fix memory leak while
 programming pages
Message-ID: <20180802080258.GA13222@kroah.com>
References: <1533116658-14924-1-git-send-email-goodwater.wu@gmail.com>
 <1533196290-9669-1-git-send-email-goodwater.wu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533196290-9669-1-git-send-email-goodwater.wu@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 03:51:30PM +0800, Jheng-Jhong Wu wrote:
> In spinand_program_page(), it uses devm_kzalloc() to allocate memory to
> wbuf dynamically if internal ECC is on, but it doesn't free memory
> allocated to wbuf at the end of this function. Before the spinand device
> is removed and frees memory automatically, programming pages may run many
> times. This leads to a memory leak issue when internal ECC is on.

How is this a memory leak?  The memory will be freed when the struct
device is removed from the system.  How did you test that there was a
leak?

> Changelog:
> 
> v2:
> - use kzalloc()/kfree() to replace devm_kzalloc()/devm_kfree()
> - add some descriptions to commit message

this changelog goes below the --- line.

thanks,

greg k-h
