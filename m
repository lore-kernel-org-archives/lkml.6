Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBCDC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 07:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2183620866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 07:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544771557;
	bh=jACemZVSrWb6/oD6nSYZ8j4L6iNL26g4phG2KVlIr8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T7qZmVWjv9JtC5kHmmhP+lwvQXc1LGx/dffMrvYTbjqX8Q/0Dr8o2Z/SHNAbSUyrR
	 TEM1DUm4sBQ1wNrGkfPXv84INcj2r/4Wmkkd1kcYHgrC1/9Hn3M8dwAdeQmOZv6e2H
	 O2X0TKwGJ6/vOIkz622EPJvOtOzYJy2ctQ320Moo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2183620866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbeLNHMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 02:12:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:46138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbeLNHMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 02:12:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD0F320645;
        Fri, 14 Dec 2018 07:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544771555;
        bh=jACemZVSrWb6/oD6nSYZ8j4L6iNL26g4phG2KVlIr8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PsWiaV6957gqL7it94MSHMOkJAANDG+QUhV+hWkjeb5S5ZHqx6JgAwDuurLkCw48g
         7ghuY14XX3ki9iiCBoN72UqbQGLRkUaa5MxKlo+qdI9zPgnutAqBv4e+w6+qd6uPlm
         0iiGdLLqCS0gCbBuX4/3QJ7hSw9be1UxqLloZgec=
Date:   Fri, 14 Dec 2018 08:12:32 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Rick Macklem <rmacklem@uoguelph.ca>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 051/118] flexfiles: use per-mirror specified stateid
 for IO
Message-ID: <20181214071232.GA31355@kroah.com>
References: <20181211151644.216668863@linuxfoundation.org>
 <20181211151646.307760274@linuxfoundation.org>
 <922713302.5303567.1544554167994.JavaMail.zimbra@desy.de>
 <20181212070614.GB20333@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212070614.GB20333@kroah.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 08:06:14AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Dec 11, 2018 at 07:49:27PM +0100, Mkrtchyan, Tigran wrote:
> > 
> > 
> > Hi Greg,
> > 
> > Thanks for pushing this into sable as well. However, I think patch makes more sense
> > with 320f35b7bf8cccf1997ca3126843535e1b95e9c4
> 
> I need an ack from the nfs maintainer before I can do that...

Ah nevermind, now queued up, it looks sane.

thanks,

greg k-h
