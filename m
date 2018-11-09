Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D53CC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 00:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 214FE2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 00:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZjmUqDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 214FE2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbeKIKAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 05:00:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:43320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727076AbeKIKAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 05:00:08 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64B7F2086C;
        Fri,  9 Nov 2018 00:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541722924;
        bh=k2LIrz+XhigLTuud+Mb+H0q64Wb1C41W0hwl2wsMxuw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aZjmUqDVFfRrD3c6kRbKjcJICE9FCaWIiUkIPnVRaHPyF8sWq4Tk9nRJIKTyLUxUc
         +OTwooVXe/u5+/7Bcqw72FXhzNcUiQhc5bYKRd5OlEYGR2cr1SttQmiOpSia/VWKwo
         3VTEPA8EBjJJYKX4nceZ/Y1lQqOXSasg6yk73nps=
Date:   Thu, 8 Nov 2018 16:22:03 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     dsterba@suse.cz, linux-kernel@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 026/114] btrfs: cleaner_kthread() doesnt need
 explicit freeze
Message-ID: <20181109002203.GB7382@kroah.com>
References: <20181108215059.051093652@linuxfoundation.org>
 <20181108215101.483013816@linuxfoundation.org>
 <20181108232809.GI24115@suse.cz>
 <20181109000438.GB14882@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109000438.GB14882@sasha-vm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 07:04:38PM -0500, Sasha Levin wrote:
> On Fri, Nov 09, 2018 at 12:28:10AM +0100, David Sterba wrote:
> > On Thu, Nov 08, 2018 at 01:50:41PM -0800, Greg Kroah-Hartman wrote:
> > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > > [ Upstream commit 838fe1887765f4cc679febea60d87d2a06bd300e ]
> > 
> > Please check the discussion under
> > 
> > https://lore.kernel.org/lkml/20181025141705.213937-8-sashal@kernel.org/
> > 
> > Jiri's reply:
> > 
> > "This patch just removes pointless try_to_freeze(), that's guaranteed
> > not to do anything and return immediately, as the btrfs kthread is not
> > freezable.  So I don't think it's needed in stable; the semantics is
> > equivalent before and after."
> > 
> > Sasha was fine with dropping the patch from stable candidates and this
> > has not changed. Thanks.
> 
> Indeed, I thought I dropped it but I see that I didn't. My bad, sorry.

I've now dropped this.  David, thanks for letting us know.

greg k-h
