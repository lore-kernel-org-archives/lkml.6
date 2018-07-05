Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1635FC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23AA23FB3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=crashcourse.ca header.i=@crashcourse.ca header.b="EDOJC15v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C23AA23FB3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=crashcourse.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753907AbeGEVrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 17:47:08 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:35754 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753785AbeGEVrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 17:47:00 -0400
X-Greylist: delayed 1333 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Jul 2018 17:46:59 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pnhC4y+idfUdvO68cr0mjTZas3wxNzQRmDn/2gXgykI=; b=EDOJC15v0QCMEkh3z1KXRy6xl
        uQQIXYhr4/7880nAIoQk2/y/ELDA8XoJPDv0kSPkk4gHfkSzb3mwDEZUS7ftfGGKyORnpQksYT8kG
        3WYBjCtUAqzysGOx7LUF1gXj/sQ/65cJDxnw6tLqZR7GyzFsMYxW/paothZhHnBCeEBIskniyMJVq
        Fv44oP3hywbZnVau0HNoPSmBmi1BltYQFiO9fqcrjj0u3JXRelHt349XkScLKVWM+pSSPdiyB5Gnc
        jF7m4n3Iwp33G8zAZsF54qMZwTVOH5eoZC5JNQCiGkjjvpfBvyo8o4METiMYVd8lG8vUkP76uXLcN
        WezgoYazg==;
Received: from [72.27.142.46] (port=60734 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fbBk0-00AMSD-Te; Thu, 05 Jul 2018 17:24:43 -0400
Date:   Thu, 5 Jul 2018 16:24:16 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Rob Herring <robh@kernel.org>
cc:     alanx.chiang@intel.com, linux-i2c@vger.kernel.org,
        andy.yeh@intel.com, sakari.ailus@linux.intel.com,
        andriy.shevchenko@linux.intel.com, andriy.shevchenko@intel.com,
        rajmohan.mani@intel.com, andy.shevchenko@gmail.com,
        tfiga@chromium.org, jcliang@chromium.org, brgl@bgdev.pl,
        mark.rutland@arm.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RESEND PATCH v4 1/2] dt-bindings: at24: Add address-width
 property
In-Reply-To: <20180705212204.GA10449@rob-hp-laptop>
Message-ID: <alpine.LFD.2.21.1807051623400.12206@localhost.localdomain>
References: <1530522740-2798-1-git-send-email-alanx.chiang@intel.com> <1530522740-2798-2-git-send-email-alanx.chiang@intel.com> <20180705212204.GA10449@rob-hp-laptop>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jul 2018, Rob Herring wrote:

> On Mon, Jul 02, 2018 at 05:12:19PM +0800, alanx.chiang@intel.com wrote:
> > From: Alan Chiang <alanx.chiang@intel.com>
> >
> > The AT24 series chips use 8-bit address by default. If some
> > chips would like to support more than 8 bits, the at24 driver
> > should be added the compatible field for specfic chips.
> >
> > Provide a flexible way to determine the addressing bits through
> > address-width in this patch.
> >
> > Signed-off-by: Alan Chiang <alanx.chiang@intel.com>
> > Signed-off-by: Andy Yeh <andy.yeh@intel.com>
> > Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> >
> > ---
> > since v1:
> > -- Remove the address-width field in the example.
> > since v2:
> > -- Remove redundant space.
> > since v3:
> > -- Add Acked-by.
> >
> > ---
> >  Documentation/devicetree/bindings/eeprom/at24.txt | 2 ++
> >  1 file changed, 2 insertions(+)
>
> Reviewed-by: Rob Herring <robh@kernel.org>

  "... should be added the compatible field ..."??

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
