Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E48C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20BB520C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20BB520C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeIMNpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 09:45:53 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:58527 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbeIMNpx (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 13 Sep 2018 09:45:53 -0400
Received: from linux-l9pv.suse (unknown.telstraglobal.net [134.159.103.118])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Thu, 13 Sep 2018 10:37:20 +0200
Date:   Thu, 13 Sep 2018 16:37:09 +0800
From:   joeyli <jlee@suse.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: Re: [PATCH 5/5] PM / hibernate: An option to request that snapshot
 image must be authenticated
Message-ID: <20180913083709.GD3593@linux-l9pv.suse>
References: <20180912142337.21955-1-jlee@suse.com>
 <20180912142337.21955-6-jlee@suse.com>
 <0ee402c0-bd0e-ea84-9def-f6355b83b4f5@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ee402c0-bd0e-ea84-9def-f6355b83b4f5@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy, 

On Wed, Sep 12, 2018 at 09:24:38AM -0700, Randy Dunlap wrote:
> Hi,
> 
> On 9/12/18 7:23 AM, Lee, Chun-Yi wrote:
> > diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> > index 7c5c30149dbc..3c998fd6dc4c 100644
> > --- a/kernel/power/Kconfig
> > +++ b/kernel/power/Kconfig
> > @@ -90,6 +90,17 @@ config HIBERNATION_ENC_AUTH
> >  	  master key of hibernation. The TPM trusted key depends on TPM. The
> >  	  security of user defined key relies on user space.
> >  
> > +config HIBERNATION_ENC_AUTH_FORCE
> > +	bool "Require hibernate snapshot image to be validly signed"
> > +	depends on HIBERNATION_ENC_AUTH
> > +	help
> > +	  This option will prevent that a snapshot image without (valid)
> > +	  signature be restored. Without this option, a unauthenticated
> 
> 	                                              an
> 
> > +	  snapshot image can be restored but the restored kernel will be
> > +	  tainted. Which also means that the hibernation can be triggered
> 
> s/Which/This/
> 
> or like this:
> 	  tainted, which also
>

Thanks for your review and suggestion! I will update the description in
next version.

Regards
Joey Lee
