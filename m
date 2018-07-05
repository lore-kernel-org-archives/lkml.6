Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CBBC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC282403A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:17:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EC282403A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753664AbeGEQRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:17:00 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:40594 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753437AbeGEQQ7 (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 5 Jul 2018 12:16:59 -0400
Received: from linux-l9pv.suse (124-11-22-254.static.tfn.net.tw [124.11.22.254])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Thu, 05 Jul 2018 18:16:51 +0200
Date:   Fri, 6 Jul 2018 00:16:37 +0800
From:   joeyli <jlee@suse.com>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Borislav Petkov <bp@alien8.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3][RFC] Introduce the in-kernel hibernation encryption
Message-ID: <20180705161637.GK3628@linux-l9pv.suse>
References: <cover.1529486870.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1529486870.git.yu.c.chen@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen Yu, 

On Wed, Jun 20, 2018 at 05:39:37PM +0800, Chen Yu wrote:
> Hi,
> As security becomes more and more important, we add the in-kernel
> encryption support for hibernation.
> 
> This prototype is a trial version to implement the hibernation
> encryption in the kernel, so that the users do not have to rely
> on third-party tools to encrypt the hibernation image. The only
> dependency on user space is that, the user space should provide
> a valid key derived from passphrase to the kernel for image encryption.
> 
> There was a discussion on the mailing list on whether this key should
> be derived in kernel or in user space. And it turns out to be generating
> the key by user space is more acceptable[1]. So this patch set is divided
> into two parts:
> 1. The hibernation snapshot encryption in kernel space,
> 2. the key derivation implementation in user space.
> 
> Please refer to each patch for detail, and feel free to comment on
> this, thanks.
> 
> [1] https://www.spinics.net/lists/linux-crypto/msg33145.html
> 
> Chen Yu (3):
>   PM / Hibernate: Add helper functions for hibernation encryption
>   PM / Hibernate: Encrypt the snapshot pages before submitted to the
>     block device
>   tools: create power/crypto utility
>

I am trying this patch set.

Could you please tell me how to test the user space crypto utility with
systemd's hibernation module? 

I have a question about the salt. If the salt is saved in image header,
does that mean that kernel needs to read the image header before user
space crypto utility be launched? Otherwise user space can not get
the salt to produce key? I a bit confused about the resume process.

Thanks
Joey Lee 
