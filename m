Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAA2C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA81B20882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbfA3X6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:58:33 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:41957 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfA3X6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:58:32 -0500
Received: from 79.184.255.169.ipv4.supernova.orange.pl (79.184.255.169) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 930af231af1bdc1f; Thu, 31 Jan 2019 00:58:30 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org
Subject: Re: [PATCH] device property: Fix the length used in PROPERTY_ENTRY_STRING
Date:   Thu, 31 Jan 2019 00:57:25 +0100
Message-ID: <18032182.68aDI8Qzvt@aspire.rjw.lan>
In-Reply-To: <20190125143205.GP9224@smile.fi.intel.com>
References: <20190123144416.51859-1-heikki.krogerus@linux.intel.com> <20190125143205.GP9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, January 25, 2019 3:32:05 PM CET Andy Shevchenko wrote:
> On Wed, Jan 23, 2019 at 05:44:16PM +0300, Heikki Krogerus wrote:
> > With string type property entries we need to use
> > sizeof(const char *) instead of the number of characters as
> > the length of the entry.
> > 
> > If the string was shorter then sizeof(const char *),
> > attempts to read it would have failed with -EOVERFLOW. The
> > problem has been hidden because all build-in string
> > properties have had a string longer then 8 characters until
> > now.
> > 
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> > Fixes: a85f42047533 ("device property: helper macros for property entry creation")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > ---
> >  include/linux/property.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/property.h b/include/linux/property.h
> > index 3789ec755fb6..65d3420dd5d1 100644
> > --- a/include/linux/property.h
> > +++ b/include/linux/property.h
> > @@ -258,7 +258,7 @@ struct property_entry {
> >  #define PROPERTY_ENTRY_STRING(_name_, _val_)		\
> >  (struct property_entry) {				\
> >  	.name = _name_,					\
> > -	.length = sizeof(_val_),			\
> > +	.length = sizeof(const char *),			\
> >  	.type = DEV_PROP_STRING,			\
> >  	{ .value = { .str = _val_ } },			\
> >  }
> 
> 

Patch applied, thanks!


