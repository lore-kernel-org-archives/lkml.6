Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD897C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 07:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F60320868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 07:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibGfa/0t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F60320868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbeK2Swt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 13:52:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:55570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727798AbeK2Sws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 13:52:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BED05206B6;
        Thu, 29 Nov 2018 07:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543477701;
        bh=zmJc2zmmh8cpk7lDAq9zsSnRo8f//ZkFiFxsQTZjQlc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ibGfa/0ta3D6pX27QD/QqmxKahtWYgf9nUwX3j7PUa1OOqLa7Iqiot7w1dNn/Hu8d
         9ssBHbiLZ01gpzp0JWW0uTyvNU8bVBkLjLP8z8z7/swzuoDXYqgGt4cth8GTDj4wWV
         KGwkdSMcscGl10xtne5UJXksmZ5F7WPsi/hCNOek=
Date:   Thu, 29 Nov 2018 08:48:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        will.deacon@arm.com, mark.rutland@arm.com, jolsa@redhat.com,
        namhyung@kernel.org, adrian.hunter@intel.com, ast@kernel.org,
        hpa@zytor.com, suzuki.poulosi@arm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/6] perf/core: Use ioctl to communicate driver
 configuration to kernel
Message-ID: <20181129074819.GD12347@kroah.com>
References: <1543442478-31465-1-git-send-email-mathieu.poirier@linaro.org>
 <1543442478-31465-3-git-send-email-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543442478-31465-3-git-send-email-mathieu.poirier@linaro.org>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 03:01:14PM -0700, Mathieu Poirier wrote:
> This patch adds the mechanic needed for user space to send PMU specific
> configuration to the kernel driver using an ioctl() command.  That way
> events can keep track of options that don't fit in the perf_event_attr
> structure like the selection of a CoreSight sink to use for the session.

This is what configfs is for, please use that instead of a generic "send
a string to the kernel for it to parse" type of thing.  No other driver
does this (or if they do, they should not), so this driver should not do
it as well, sorry.

greg k-h
