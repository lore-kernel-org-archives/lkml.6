Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616B3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED312075C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfBTOO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:14:28 -0500
Received: from mga03.intel.com ([134.134.136.65]:47660 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbfBTOO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:14:28 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 06:14:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,391,1544515200"; 
   d="scan'208";a="148382001"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 20 Feb 2019 06:14:24 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 20 Feb 2019 16:14:23 +0200
Date:   Wed, 20 Feb 2019 16:14:23 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Nikolaus Voss <nv@vosn.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] usb: typec: tps6598x: handle block writes separately
 with plain-I2C adapters
Message-ID: <20190220141423.GC5054@kuha.fi.intel.com>
References: <20180425142209.30745-1-heikki.krogerus@linux.intel.com>
 <20190220110017.BFA344CE86@mail.steuer-voss.de>
 <20190220125731.02E274CFE0@mail.steuer-voss.de>
 <20190220133036.GB5054@kuha.fi.intel.com>
 <alpine.DEB.2.20.1902201434200.6572@fox.voss.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1902201434200.6572@fox.voss.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 02:38:47PM +0100, Nikolaus Voss wrote:
> On Wed, 20 Feb 2019, Heikki Krogerus wrote:
> > On Wed, Feb 20, 2019 at 01:57:30PM +0100, Nikolaus Voss wrote:
> > > Commit 1a2f474d328f handles block _reads_ separately with plain-I2C
> > > adapters, but the problem described with regmap-i2c not handling
> > > SMBus block transfers (i.e. read and writes) correctly also exists
> > > with writes.
> > > 
> > > As workaround, this patch adds a block write function the same way
> > > 1a2f474d328f adds a block read function.
> > > 
> > > Fixes: 1a2f474d328f ("usb: typec: tps6598x: handle block reads separately with plain-I2C adapters")
> > > Fixes: 0a4c005bd171 ("usb: typec: driver for TI TPS6598x USB Power Delivery controllers")
> > > Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> > 
> > You are missing a "from" line with address that matches your SoB
> > address.
> 
> That's because I currently cannot send patch mails from my company account
> as our MTA breaks diffs.

I understand, but you can have a separate "From line" in your patch,
i.e. you send the patch using one address, and have an extra "From
line" (outside of the mail header) with another address.

That other From line will be interpreted as the author address, and
it should match your SoB address.


Try something like this in a branch where this patch is the HEAD:

        % export MY_COMMIT=$(git show -s --pretty=%h HEAD)
        % git reset HEAD^
        % GIT_COMMITTER_IDENT='Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>' \
          GIT_AUTHOR_IDENT='Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>' \
          git commit -a -C $MY_COMMIT

Then:

        % git format-patch HEAD^
        % git send-email ...

thanks,

-- 
heikki
