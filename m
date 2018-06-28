Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A76C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B4027399
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B4027399
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966916AbeF1Pfc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:35:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60208 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752005AbeF1Pfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:35:31 -0400
Received: from localhost (unknown [104.153.224.166])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CFFB6D14;
        Thu, 28 Jun 2018 15:35:29 +0000 (UTC)
Date:   Thu, 28 Jun 2018 22:16:17 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Simon Que <sque@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Ben Chan <benchan@chromium.org>,
        Chun-Ta Lin <itspeter@chromium.org>,
        Zhongze Hu <frankhu@chromium.org>,
        Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>
Subject: Re: [PATCH v4] drivers/staging: Gasket driver framework + Apex driver
Message-ID: <20180628131617.GA30635@kroah.com>
References: <20180620232441.204171-1-sque@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620232441.204171-1-sque@chromium.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 07:24:41PM -0400, Simon Que wrote:
> The Gasket (Google ASIC Software, Kernel Extensions, and Tools) kernel
> framework is a generic, flexible system that supports thin kernel
> drivers. Gasket kernel drivers are expected to handle opening and
> closing devices, mmap'ing BAR space as requested, a small selection of
> ioctls, and handling page table translation (covered below). Any other
> functions should be handled by userspace code.
> 
> The Gasket common module is not enough to run a device. In order to
> customize the Gasket code for a given piece of hardware, a device
> specific module must be created. At a minimum, this module must define a
> struct gasket_driver_desc containing the device-specific data for use by
> the framework; in addition, the module must declare an __init function
> that calls gasket_register_device with the module's gasket_driver_desc
> struct. Finally, the driver must define an exit function that calls
> gasket_unregister_device with the module's gasket_driver_desc struct.
> 
> One of the core assumptions of the Gasket framework is that precisely
> one process is allowed to have an open write handle to the device node
> at any given time. (That process may, once it has one write handle, open
> any number of additional write handles.) This is accomplished by
> tracking open and close data for each driver instance.
> 
> Signed-off-by: Rob Springer <rspringer@google.com>
> Signed-off-by: John Joseph <jnjoseph@google.com>
> Signed-off-by: Simon Que <sque@chromium.org>

This patch does not apply against my staging-testing tree.  Or against
4.18-rc1 either, what did you make it against?

Please rebase and resend so that I can apply it.

thanks,

greg k-h
