Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B79C65BAF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 024792082B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544108831;
	bh=OpCzWsqX9tX007GE8P36ROkrbCwkGPVXtTiMyqsVQAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CBhA9dmSr/jhA4t331TOMhih79O4lPm+aABPPZNlwn0RKsP5AJkMmaQMLfYM4p+S7
	 k4R1MN1w2D9U15CeR5Vw4d69zbnALHH952C9EL4GiUgd8n2/8xtwI1wbqczHu8FBRo
	 qoR6F3Qlo38vRqVLMmRcOMXbPQdYh3UCRJ2by6Z0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 024792082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbeLFPHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:07:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:34434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbeLFPHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:07:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9943320700;
        Thu,  6 Dec 2018 15:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544108829;
        bh=OpCzWsqX9tX007GE8P36ROkrbCwkGPVXtTiMyqsVQAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x0+cGB2Mz6UdddWbxu0rLFtKtvs2P0psCB8jfBUeQh+z7eOZ1O6JgEFST/Bwyg4MI
         t1xySyX7JoFbLt73a0hhAt5UcyNX91i7EQ5aSqT6GfvaeBTguBKMUU7TAjumc3YuJq
         I4v8eCi7xs8BfIUUX4THRW5XP4kOGz0lVYHAy7ck=
Date:   Thu, 6 Dec 2018 16:07:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peter Rajnoha <prajnoha@redhat.com>
Cc:     rafael@kernel.org, jeyu@kernel.org, linux-kernel@vger.kernel.org,
        msekleta@redhat.com
Subject: Re: [PATCH 2/2] kobject: add kernel/uevent_features sysfs file
Message-ID: <20181206150706.GA6417@kroah.com>
References: <20181205112745.12276-1-prajnoha@redhat.com>
 <20181205112745.12276-3-prajnoha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205112745.12276-3-prajnoha@redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 12:27:45PM +0100, Peter Rajnoha wrote:
> We can use extended format when writing /sys/.../uevent files to
> generate synthetic uevents, introduced with commit f36776fafbaa
> ("kobject: support passing in variables for synthetic uevents").
> 
> Before using this extended format, we need to know if it's supported
> and kernel version check may not be appropriate in all cases - there
> are possible differences from upstream kernel in distributions with
> backports.
> 
> This patch adds /sys/kernel/uevent_features file which currently lists
> 'synthargs' string to denote that the kernel is able to recognize the
> extended synthetic uevent arguments. Userspace can easily check for
> the feature then.

No Documentation/ABI/ update for your new sysfs file?  Not good, I can't
take this patch without that :(

greg k-h
