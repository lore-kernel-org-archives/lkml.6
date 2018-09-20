Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF244C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD4821532
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:18:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD4821532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732340AbeIUCDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:03:48 -0400
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:36028 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726128AbeIUCDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:03:48 -0400
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk [IPv6:2001:1bc8:1a6:d3d5::80:2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id 6C1BB634C7F;
        Thu, 20 Sep 2018 23:18:34 +0300 (EEST)
Received: from sakke by valkosipuli.localdomain with local (Exim 4.89)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1g35PG-0000TZ-7J; Thu, 20 Sep 2018 23:18:34 +0300
Date:   Thu, 20 Sep 2018 23:18:34 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>
Subject: Re: [PATCH v2 4/4] [media] ad5820: Add support for of-autoload
Message-ID: <20180920201833.2d2skjn7fkrbdsqx@valkosipuli.retiisi.org.uk>
References: <20180920161912.17063-4-ricardo.ribalda@gmail.com>
 <20180920183151.2933-1-ricardo.ribalda@gmail.com>
 <2401971.XiI38RXFgU@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2401971.XiI38RXFgU@avalon>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Thu, Sep 20, 2018 at 11:10:23PM +0300, Laurent Pinchart wrote:
> > +MODULE_DEVICE_TABLE(of, ad5820_of_table);
> > +
> >  static SIMPLE_DEV_PM_OPS(ad5820_pm, ad5820_suspend, ad5820_resume);
> > 
> >  static struct i2c_driver ad5820_i2c_driver = {
> >  	.driver		= {
> >  		.name	= AD5820_NAME,
> >  		.pm	= &ad5820_pm,
> > +		.of_match_table = ad5820_of_table,
> 
> As the driver doesn't depend on CONFIG_OF, would it make sense to use 
> of_config_ptr() (and to compile the of table conditionally on CONFIG_OF) ?

You get ACPI support as a bonus if you don't use of_config_ptr(). :-) Other
changes could be needed but this enables probing the driver for a device.

In this case the probability of anyone using this device on an ACPI system
could be pretty low though.

-- 
Regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi
