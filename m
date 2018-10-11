Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C499C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A442085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvZpHFVp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A442085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeJKSLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 14:11:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:38954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbeJKSLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 14:11:46 -0400
Received: from localhost (unknown [178.228.10.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9387D20841;
        Thu, 11 Oct 2018 10:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539254705;
        bh=pwqiRpO23P4LIUp4qRLJl1Yam6bwGSIKZyYijbcnAz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jvZpHFVpkbIoOe1NGiWarTBbtAAX26lg3j+3gGZAn26k2QHGf6CBIo3OcZfjxss6Z
         8dJiP4J0ARRoNrKiGsDfXo8DpmUK1nrq6jSnGIJKS2hQK/oQScYJeq1HhUB5yUF09i
         VJLYLXb8uICh5aNLdMiwCo1WT1LlFb2UmoF3coi4=
Date:   Thu, 11 Oct 2018 12:45:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     tj@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, len.brown@intel.com,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org
Subject: Re: [workqueue/driver-core PATCH v2 4/5] driver core: Attach devices
 on CPU local to device node
Message-ID: <20181011104501.GA30183@kroah.com>
References: <20181010230435.10609.77825.stgit@localhost.localdomain>
 <20181010230836.10609.73485.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010230836.10609.73485.stgit@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 04:08:40PM -0700, Alexander Duyck wrote:
> This change makes it so that we call the asynchronous probe routines on a
> CPU local to the device node. By doing this we should be able to improve
> our initialization time significantly as we can avoid having to access the
> device from a remote node which may introduce higher latency.

This is nice in theory, but what kind of real numbers does this show?
There's a lot of added complexity here, and what is the benifit?

Benchmarks or bootcharts that we can see would be great to have, thanks.

greg k-h
