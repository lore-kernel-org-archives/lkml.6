Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1970C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22BA217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548178190;
	bh=sbgZCcdD2tPGpQxIIJ55oPv2mE5wCH9Q5S3xyIBBwjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MnUCDadHY5V9t4SLpkvM51M4cE25jQYXwid6d73GVEKpm2XEfHn9LalgdieL9r0Us
	 EIeyh4Xo9XD3s19Zifn4aaWKq5fg85C+bO19LCdWpXETHPuxbZ5Tfch4rGo2+G9/e8
	 tT1AgFY5+gInexAhcan77BVU+WPpB3aGXoXbwu2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfAVR3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 12:29:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:53258 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726127AbfAVR3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 12:29:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 355CEB0B7;
        Tue, 22 Jan 2019 17:29:46 +0000 (UTC)
Date:   Tue, 22 Jan 2019 18:29:44 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Laura Abbott <labbott@redhat.com>, linux-mm@kvack.org
Subject: Re: [PATCH] mm: no need to check return value of debugfs_create
 functions
Message-ID: <20190122172944.GL4087@dhcp22.suse.cz>
References: <20190122152151.16139-14-gregkh@linuxfoundation.org>
 <20190122153102.GJ4087@dhcp22.suse.cz>
 <20190122155255.GA20142@kroah.com>
 <20190122160701.GK4087@dhcp22.suse.cz>
 <20190122162749.GA22841@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122162749.GA22841@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-01-19 17:27:49, Greg KH wrote:
> On Tue, Jan 22, 2019 at 05:07:01PM +0100, Michal Hocko wrote:
[...]
> > sounds like a poor design goal to me but not mine code to maintain so...
> 
> The design goal was to make it as simple as possible to use, and that
> includes "you do not care about the return value".  Now we do have to
> return a value because some people need that for when they want to make
> a subdirectory, or remove the file later on, otherwise I would have just
> had everything be a void return function :)

I suspect that you are making assumptions which might change in the
future and this whole mess will be unfixable. But whatever I do not care
about debugfs at all.
-- 
Michal Hocko
SUSE Labs
