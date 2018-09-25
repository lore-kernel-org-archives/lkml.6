Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66BEC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 613FC206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 613FC206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbeIYS12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:27:28 -0400
Received: from mga06.intel.com ([134.134.136.31]:9324 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727617AbeIYS11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:27:27 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 05:19:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,302,1534834800"; 
   d="scan'208";a="93070896"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 25 Sep 2018 05:19:27 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 25 Sep 2018 15:19:27 +0300
Date:   Tue, 25 Sep 2018 15:19:27 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC/PATCH 2/5] device property: introduce notion of subnodes
 for legacy boards
Message-ID: <20180925121927.GL11965@kuha.fi.intel.com>
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
 <20180917181603.125492-3-dmitry.torokhov@gmail.com>
 <20180920135348.GF11965@kuha.fi.intel.com>
 <20180921233119.GA44099@dtor-ws>
 <20180924132050.GK11965@kuha.fi.intel.com>
 <20180924184543.GB156847@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924184543.GB156847@dtor-ws>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 11:45:43AM -0700, Dmitry Torokhov wrote:
> I think we are talking about totally different use cases and that is why
> we are having hard time coming to a mutually agreeable solution. Could
> you please describe in more detail what you would like to achieve,
> and preferably show how it is described now with DT and/or ACPI, so that
> I have a better frame of reference.

Yes, of course. Sorry.

USB ports are devices that usually the USB controller drivers register
(or actually the USB core code). They are represented in both ACPI and
DT as child nodes of the controller device node. The USB connector OF
node is defined in file
Documentation/devicetree/bindings/connector/usb-connector.txt

In short, the controller drivers will request handle to a child node
that represents a port, and only after that register the actual port
device.

The drivers I'm looking at currently are the USB Type-C port
controller drivers and the port manager (in Greg's usb-next or
linux-next):

        drivers/usb/typec/tcpm/tcpci.c
        drivers/usb/typec/tcpm/fusb302.c
        drivers/usb/typec/tcpm/tcpm.c

The goal is simply to get rid of the platform data as usual, and
ideally so that we don't need any extra code in order to support the
"legacy" platforms.


Thanks,

-- 
heikki
