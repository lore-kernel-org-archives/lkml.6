Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A7CC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419D22146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsjGuitG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 419D22146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbeK3TLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:11:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:37500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726459AbeK3TLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:11:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E3782082F;
        Fri, 30 Nov 2018 08:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543565007;
        bh=/Asf/zKwWasAS/jaJYg4eSd5/7c//y+v5sfoo4Qakf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VsjGuitG/fc9tCAF/hrM2e/m9sLo/ZGs4kNLl6qhSIzFaYSlsURLoVL61A4CXzGU1
         0jBjqm2Bh7hNFM70oNTw54j5XK3QluORd2HZ6yJ1NLDsqBAtdj59slkv1r61mktAqT
         BYLJuAGthRYJHBbFAofImjtcbO1VX1WcLX4mOBkM=
Date:   Fri, 30 Nov 2018 09:03:24 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Schmauss, Erik" <erik.schmauss@intel.com>
Cc:     Jean Delvare <jdelvare@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jean-Marc Lenoir <archlinux@jihemel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 4.14 044/100] ACPICA: AML interpreter: add region
 addresses in global list during initialization
Message-ID: <20181130080324.GA25557@kroah.com>
References: <20181129140058.768942700@linuxfoundation.org>
 <20181129140102.870510957@linuxfoundation.org>
 <1543502726.10991.13.camel@suse.de>
 <20181129150115.GA22451@kroah.com>
 <CF6A88132359CE47947DB4C6E1709ED53C551AF7@ORSMSX122.amr.corp.intel.com>
 <20181129192136.GA13749@kroah.com>
 <20181129203425.63544638@endymion>
 <CF6A88132359CE47947DB4C6E1709ED53C551B2B@ORSMSX122.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED53C551B2B@ORSMSX122.amr.corp.intel.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 07:36:40PM +0000, Schmauss, Erik wrote:
> 
> 
> > -----Original Message-----
> > From: Jean Delvare [mailto:jdelvare@suse.de]
> > Sent: Thursday, November 29, 2018 11:34 AM
> > To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Schmauss, Erik <erik.schmauss@intel.com>; linux-
> > kernel@vger.kernel.org; stable@vger.kernel.org; Jean-Marc Lenoir
> > <archlinux@jihemel.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>
> > Subject: Re: [PATCH 4.14 044/100] ACPICA: AML interpreter: add region
> > addresses in global list during initialization
> > 
> > On Thu, 29 Nov 2018 20:21:37 +0100, Greg Kroah-Hartman wrote:
> > > On Thu, Nov 29, 2018 at 06:56:40PM +0000, Schmauss, Erik wrote:
> > > > This should only apply to 4.17 or later. I unintentionally put all
> > > > applicable so please drop this for all 4.16 or earlier. I've learned
> > > > my lesson and I'll put the correct tags from now on :-)
> > >
> > > Ok, now dropped from 4.14, thanks.
> > 
> > Should be dropped from 4.9 and 4.4 too... if it was not clear.
> 
> Yes, it should,

oops, sorry about that, now dropped from the 4.9 and 4.4 queues as well.

greg k-h
