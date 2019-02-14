Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0005EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B60B4222D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550139057;
	bh=EBjUZpJdZWEJEaVxO8er91cZ6EYhd9lex18vFaOjnmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bJVqR7Q6d7/TitvX2z2707By7aSFmR50eU/21XFme1gmjYNKfc2F0XCYcrz3+Uyxl
	 aZqbEEw9Qk3sCYTTJ1excibXgJHCzpSCL1EiEhVyehtjbwpQcNTorIB7h/xpEmsVkq
	 QNkwOiCpRFsPvbhLXTF1GVNRJTcXas9d8PvHQwsg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406410AbfBNKK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:10:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:49290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726337AbfBNKK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:10:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B2D0222D2;
        Thu, 14 Feb 2019 10:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550139055;
        bh=EBjUZpJdZWEJEaVxO8er91cZ6EYhd9lex18vFaOjnmk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XjeAORgOmo7EN1jlK87q1L942CCF7e1MnwP8pJA22bs1JUBQv9KQayBxzJJ3dN3o0
         TU63+wXjFfNvXP1BgVXD7v6XagTxVUCr/kz7ZOV2sXVoTgqMDcUv334KMEejTv19A8
         EI/RI8JRAWMSMiHMcmBjT722OxgZOtQDOJBcaqqk=
Date:   Thu, 14 Feb 2019 11:10:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Chen Yu <chenyu56@huawei.com>, Jun Li <jun.li@nxp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/9] device connection: Add support for device graphs
Message-ID: <20190214101043.GA4316@kroah.com>
References: <20190213074557.66028-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213074557.66028-1-heikki.krogerus@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 10:45:48AM +0300, Heikki Krogerus wrote:
> Hi,
> 
> This is the third version of my proposal to add device graph parsing
> to the device connection API. There was only one problem reported in
> v2 by Jun - kernel-doc entry was missing for the new fwnode member in
> struct usb_role_switch_desc - and it's now fixed.
> 
> The second version of the series:
> https://lkml.org/lkml/2019/1/30/622
> 
> The commit message from v1:
> 
> This series adds support for OF and ACPI device graph parsing to the
> device connection API.
> 
> Handling the graph is straightforward, but because I'm adding that
> fwnode member to struct device_connection, I had to make sure all the
> existing users consider it.
> 
> The plan is to only support matching with fwnode in the future, so no
> more device name matching. The software fwnodes that we now have in
> kernel should make that possible, once we add support for references
> to them.
> 
> The original RFC:
> https://lkml.org/lkml/2018/10/24/619

All now merged, thanks.

greg k-h
