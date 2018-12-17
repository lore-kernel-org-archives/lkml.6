Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D4AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285B5214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545079977;
	bh=8LWhVz+Yb1CrH3rOQHrMD35H6seqWMzFqLjGr11hK3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mA4XIE1BBsoUOBKsAxaQBGQDkqILvEo0tGMrMXHnDMLRWBhjRn6f+P2JbTSNe3ZSq
	 e0VGzvU/yFZl203pgFRoOiiuZdhsBa9jQJLNRV2FarmmsuE8YQhaMLyTLYdizUvtdu
	 OJaOaGGIKq+jcwSVq9GLybTgS8Weaz3g3rMaEbTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387926AbeLQUw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 15:52:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:44690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbeLQUwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 15:52:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CBDE20874;
        Mon, 17 Dec 2018 20:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545079974;
        bh=8LWhVz+Yb1CrH3rOQHrMD35H6seqWMzFqLjGr11hK3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sVuRIwp75fiXTOWBcJ89XXrRxZNpXtLeWLHlfpSPeGqVCNcChs1DfoNSftIC0N05i
         stwKsPsPUKsVzTNfLMtRiXEMEWxQ7xFUOYlI5v7LSaDZleu46gyn/HgxVz1Ne67+DF
         g1zPtHs4/3uFm0I+Jr67dezefMX/uHGno8YKkKkM=
Date:   Mon, 17 Dec 2018 21:52:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/88] 4.4.168-stable review
Message-ID: <20181217205251.GA22973@kroah.com>
References: <20181214115702.151309521@linuxfoundation.org>
 <dfd49bfd-359a-7f5e-8332-5e6ad6da21cd@roeck-us.net>
 <20181215080729.GG10074@kroah.com>
 <c5862b36-beae-4810-fb33-4b646e96378b@roeck-us.net>
 <1545004693.19315.66.camel@codethink.co.uk>
 <20181217090533.GA12938@kroah.com>
 <ca64083a-158f-7faf-d6e7-566336ad03d0@roeck-us.net>
 <20181217190834.GB13773@kroah.com>
 <20181217201209.GC29585@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217201209.GC29585@roeck-us.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 12:12:09PM -0800, Guenter Roeck wrote:
> On Mon, Dec 17, 2018 at 08:08:34PM +0100, Greg Kroah-Hartman wrote:
> > > 
> > > v4.4.167-89-g9c558d7fe359 seemed to be happy. v4.4.167-89-g50a0280f2f7e
> > > replaced it and will take a while.
> > 
> > If I read your site right, it passed everything except one qemu test?
> > Is that normal?
> > 
> 
> Kind of. I was playing with that specific build, swapping out the root file
> system, and that was broken for a bit. I restarted the test, but for all
> practial purposes the build is fine.

Wonderful, thanks for letting me know.

greg k-h
