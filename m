Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801A0C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E84A218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549030874;
	bh=bpHsJjOOPNJ5T2WGoraMt9H+X7kXTxuZ4Ojr+Xj7P4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AVQ8yOD7DiuCEautMmFFsyi4lPj2P/kF3XRdDTjNWS1PIwmsSvrPUZ2BnVme2EM+l
	 11P+vMRjkAXOLM33NBYl7bO+fHWn3LycwX6A7asX7dEb5Ba4h0qSjK7mc2Ep2fWg29
	 a3tb9XWQ17GHWo4pKuH4t9W9QR5fMNoQ0iltMSq0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbfBAOVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:21:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:39198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728698AbfBAOVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 09:21:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DE92218AC;
        Fri,  1 Feb 2019 14:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549030871;
        bh=bpHsJjOOPNJ5T2WGoraMt9H+X7kXTxuZ4Ojr+Xj7P4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pJNLSiOtRa/1o73BRjxxEI0gVfjMYat0H/VTH14BPSAnNceVGC7FS2XweOeb79epp
         U4tsKTmK/NTgHGbti6xmRV3oFkg+T94cU280QJW3ia1GNMAOHm+jpVAEpYt5kVaGJS
         Y1O/+NjWz3lwiuZS9Up6wtGmbOpbjWhSxN0pEGxQ=
Date:   Fri, 1 Feb 2019 15:21:09 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     "peter@hurleysoftware.com" <peter@hurleysoftware.com>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "keun-o.park@darkmatter.ae" <keun-o.park@darkmatter.ae>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>,
        Rohit Thapliyal <r.thapliyal@samsung.com>,
        Ayush Mittal <ayush.m@samsung.com>
Subject: Re: race between flush_to_ldisc and pty_cleanup
Message-ID: <20190201142109.GA3211@kroah.com>
References: <CGME20190201133326epcms5p506416bc4ae22f600ee705f146ca1a599@epcms5p5>
 <20190201133326epcms5p506416bc4ae22f600ee705f146ca1a599@epcms5p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201133326epcms5p506416bc4ae22f600ee705f146ca1a599@epcms5p5>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 07:03:26PM +0530, Maninder Singh wrote:
> Hi,
> 
> 
> There is some race condition between tty_port_put and flush_to_ldisc
> which lead to use after free case:
> (Kernel 4.1)

Wait, 4.1 is _REALLY_ old and obsolete and broken in numerous known
places.

Can you duplicate this on 4.20, or better yet, 5.0-rc4?  Lots of tty and
ldisc fixes has gone into the tree in the past 3 1/2 years since that
kernel was released.

thanks,

greg k-h
