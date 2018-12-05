Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FA4C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D9320659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOziZV5J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D9320659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbeLEKSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:18:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:52752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbeLEKSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:18:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DF10204FD;
        Wed,  5 Dec 2018 10:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544005132;
        bh=+4aT/rpDACoEaZicprqpR9RZZuKkXTrma59ffViM8zs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sOziZV5J6YLAgc8s+EtjM0UNa9pjgcpGeSkpeNUIbRkMLBLNE9ePvGsSOHp9YbIik
         6Ryx7ljbWAXLU8VbH06LnN+qHihiBKjNawgRKe8qd2NAhpfIA7d+yRFcsUxmPZvxWD
         aVfOzt+gWnRi7jvDsKuPMLL/2mdMc0/lFpuUAEEI=
Date:   Wed, 5 Dec 2018 11:18:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-usb@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>,
        Florian Zumbiehl <florz@florz.de>
Subject: Re: [PATCH] USB: serial: console: fix reported terminal settings
Message-ID: <20181205101850.GA736@kroah.com>
References: <20181204155904.GC18087@localhost>
 <20181204160036.24625-1-johan@kernel.org>
 <20181204161518.GA17941@kroah.com>
 <20181204163155.GD18087@localhost>
 <4e395eb4-739a-05df-e14d-e32f9cfefdd3@linux.intel.com>
 <20181205095049.GA15689@localhost>
 <20181205100545.GA23483@kroah.com>
 <20181205101020.GB15689@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205101020.GB15689@localhost>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 11:10:20AM +0100, Johan Hovold wrote:
> On Wed, Dec 05, 2018 at 11:05:45AM +0100, Greg Kroah-Hartman wrote:
> > On Wed, Dec 05, 2018 at 10:50:49AM +0100, Johan Hovold wrote:
> 
> > > Note that the changes to tty are trivial; I'm just renaming and
> > > exporting an existing helper.
> > 
> > Yeah, I have no objections to them.  We can take them in my usb tree.
> 
> Thanks. Can I add your ack to the patch as well?

Please do:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
