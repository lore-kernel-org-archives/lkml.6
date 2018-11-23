Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A8CC43610
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6EBF20824
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihdrkh53"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6EBF20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389047AbeKXGp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 01:45:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:43512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729224AbeKXGp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 01:45:57 -0500
Received: from localhost (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A292120685;
        Fri, 23 Nov 2018 20:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543003215;
        bh=8kFuR1xOVf4eq01hQGad9loy8KNQH2qbCLwRVUJh0A8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ihdrkh53pQZg8CbZfZhZEyNkSnCiI+XRgh8cxDB5bJfn4c7DrAdg4zYc9yntL2Vi4
         vHkBc3ybEXnFy7MkZLLEClm5a1MBu2sKmTYmpNVkz7tMyrmCOWtyJQVWnSg41HhWaP
         zYQkIFUPGdrY4z2exkNP2a8QTeGzlgAL3BFuLQxU=
Date:   Fri, 23 Nov 2018 15:00:11 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        linux-parisc@vger.kernel.org, stable@kernel.org,
        stable@vger.kernel.org
Subject: Re: [for-next][PATCH 08/18] parisc: function_graph: Simplify with
 function_graph_entry()
Message-ID: <20181123200011.GM1917@sasha-vm>
References: <20181122003332.500796758@goodmis.org>
 <20181123073033.2083020863@mail.kernel.org>
 <511cb47a-a1bd-bb5d-69ec-0836c6b5abfe@gmx.de>
 <20181123121253.278146b4@vmware.local.home>
 <20181123183415.GB1917@sasha-vm>
 <20181123142617.3d3972ca@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181123142617.3d3972ca@vmware.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 02:26:17PM -0500, Steven Rostedt wrote:
>On Fri, 23 Nov 2018 13:34:15 -0500
>Sasha Levin <sashal@kernel.org> wrote:
>
>> Does this mean that someone (Steve) will send a backport of this to all
>> relevant stable trees? Right now it looks like the series will randomly
>> apply on a mix of trees, which can't be good.
>
>Nope. I stated that in my 0 patch.

That's not good though, if you don't intend for them to be automagically
backported to stable trees by Greg, then they shouldn't be tagged at all
and if someone is interested then he can provide a backport.

What will happen with these is that once Greg's scripts process Linus's
tree he'll end up with this patch series inconsistently backported to
stable trees, which is not what you want here.

Sure, we can wait for the "added to the xyz stable tree" mails and
object then, but why risk breaking the trees?

--
Thanks.
Sasha
