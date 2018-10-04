Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AD7C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5652084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C5652084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbeJDWfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:35:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51474 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727557AbeJDWfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:35:30 -0400
Received: from localhost (unknown [104.132.1.111])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E5FBB481;
        Thu,  4 Oct 2018 15:41:40 +0000 (UTC)
Date:   Thu, 4 Oct 2018 08:41:39 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     sudeep.holla@arm.com, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org, jeremy.linton@arm.com,
        linux-kernel@vger.kernel.org, vkilari@codeaurora.org
Subject: Re: [PATCH v4 1/2] drivers: base: cacheinfo: Do not populate sysfs
 for unknown cache types
Message-ID: <20181004154139.GA6921@kroah.com>
References: <1538666406-7504-1-git-send-email-jhugo@codeaurora.org>
 <1538666406-7504-2-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538666406-7504-2-git-send-email-jhugo@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 09:20:05AM -0600, Jeffrey Hugo wrote:
> If a cache has an unknown type because neither the hardware nor the
> firmware told us, an entry in the sysfs tree will be made, but the type
> file will not be present.  lscpu depends on the type file being present
> for every entry, and will error out without printing system information
> if lscpu cannot open the type file.
> 
> Presenting information about a cache without indicating its type is not
> useful, therefore if we hit a cache with an unknown type, stop populating
> sysfs so that userspace has the maximum amount of useful information.
> 
> This addresses the following lscpu error, which prevents any output.
> lscpu: cannot open /sys/devices/system/cpu/cpu0/cache/index3/type: No such
> file or directory
> 
> Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/base/cacheinfo.c | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
