Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C34C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 332D120882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 332D120882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbeIMNsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 09:48:01 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:53881 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbeIMNsB (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 13 Sep 2018 09:48:01 -0400
Received: from linux-l9pv.suse (unknown.telstraglobal.net [134.159.103.118])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Thu, 13 Sep 2018 10:39:27 +0200
Date:   Thu, 13 Sep 2018 16:39:16 +0800
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
Subject: Re: [PATCH 1/5] PM / hibernate: Create snapshot keys handler
Message-ID: <20180913083916.GE3593@linux-l9pv.suse>
References: <20180912142337.21955-1-jlee@suse.com>
 <20180912142337.21955-2-jlee@suse.com>
 <b3dd8655-c394-ed62-1efc-8295a95bb7fb@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3dd8655-c394-ed62-1efc-8295a95bb7fb@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Wed, Sep 12, 2018 at 09:27:27AM -0700, Randy Dunlap wrote:
> Hi,
> 
> On 9/12/18 7:23 AM, Lee, Chun-Yi wrote:
> > diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> > index 3a6c2f87699e..7c5c30149dbc 100644
> > --- a/kernel/power/Kconfig
> > +++ b/kernel/power/Kconfig
> > @@ -76,6 +76,20 @@ config HIBERNATION
> >  
> >  	  For more information take a look at <file:Documentation/power/swsusp.txt>.
> >  
> > +config HIBERNATION_ENC_AUTH
> > + 	bool "Hibernation encryption and authentication"
> > + 	depends on HIBERNATION
> > + 	depends on TRUSTED_KEYS
> > +	select CRYPTO_AES
> > + 	select CRYPTO_HMAC
> > + 	select CRYPTO_SHA512
> > + 	help
> > +	  This option will encrypt and authenticate the memory snapshot image
> > +	  of hibernation. It prevents that the snapshot image be arbitrary
> 
> 	                                                         arbitrarily
> 
> > +	  modified. User can use TPMs trusted key or user defined key as the
> 
> 	            The user
> or	            A user can use the TPM's trusted key
>

Thanks for your review! I will update it in next version.

Joey Lee 
