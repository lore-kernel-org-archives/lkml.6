Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC29EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02582184A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545222895;
	bh=YNrlsVWNs28u2gBc6ZgNHOvvVEPr3DqB0zLs/8iadW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Rwcag8OQR1GpbueOisVZfvM0RqD0qNIoyXHlDqrErSwfTafVMtiRiVr34+NyGporC
	 4r1Y3FzNE4xxWtuLYFzyaKlcu5hcY28GDNfPmHgE+iy7I/I9ub6nQa1ZI4OMJrJ6hG
	 dpyI7vJGxKwJjZuztl0PwWctZU8+ejHFKytwVzGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbeLSMey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 07:34:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:49930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729618AbeLSMey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 07:34:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 330652133F;
        Wed, 19 Dec 2018 12:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545222893;
        bh=YNrlsVWNs28u2gBc6ZgNHOvvVEPr3DqB0zLs/8iadW4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wRmj0nO2daiwC26DFYGCzv17mg9rb0DN92W1ZBjRzU/XlDnStAo9XWRJv5ZBcs2fl
         ybla2Li9VdaFmkWGD7dxZAo2zcI/0wIvo22SSjkFtD15gVN+AEDVOwSgCQY3JXmfEd
         dHn9YMT3z8GObP60NIaAXB3eN4tKIEHtkCGnlziI=
Date:   Wed, 19 Dec 2018 13:34:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 1/3] stm class: Fix a module refcount leak in policy
 creation error path
Message-ID: <20181219123451.GA20670@kroah.com>
References: <20181214155347.75722-1-alexander.shishkin@linux.intel.com>
 <20181214155347.75722-2-alexander.shishkin@linux.intel.com>
 <20181219084914.GA28855@kroah.com>
 <87sgyteo4y.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgyteo4y.fsf@ashishki-desk.ger.corp.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 01:45:17PM +0200, Alexander Shishkin wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > On Fri, Dec 14, 2018 at 05:53:45PM +0200, Alexander Shishkin wrote:
> >> Commit ccddbbf4ef27 ("stm class: Introduce framing protocol drivers")
> >
> > I don't see that commit id in Linus's tree, are you sure it is correct?
> 
> No, I messed it up somehow. Sorry about that. The real commit is
> c7fd62bc69d0. Fixed version follows. Let me know if I should re-send the
> whole thing.

Please resend all of the patches.

thanks,

greg k-h
