Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49D0C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A4C208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A4C208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933691AbeFRLsh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:48:37 -0400
Received: from muru.com ([72.249.23.125]:47716 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933134AbeFRLsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:48:36 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 95F558081;
        Mon, 18 Jun 2018 11:51:16 +0000 (UTC)
Date:   Mon, 18 Jun 2018 04:48:32 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org
Subject: Re: Charge counter on droid 4
Message-ID: <20180618114832.GR112168@atomide.com>
References: <20180615080014.GA29192@amd>
 <20180615083156.GA32102@amd>
 <20180618065827.GN112168@atomide.com>
 <20180618074023.GA16955@amd>
 <20180618082858.GO112168@atomide.com>
 <20180618093459.GA21391@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180618093459.GA21391@amd>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180618 09:37]:
> On Mon 2018-06-18 01:28:58, Tony Lindgren wrote:
> > * Pavel Machek <pavel@ucw.cz> [180618 07:43]:
> > > 
> > > So... there are mA, mAh values. Those come from hardware, and I
> > > believe we should keep them.
> > > 
> > > But there are also mW, mWh values, which are synthetic. Userland can
> > > compute them from mV, mA values... and it is confusing that kernel
> > > provides them. (My tendency was to start computing these synthetic
> > > values in userland, to compare them with "real hardware" values from
> > > kernel. But then I looked at kernel implementation, and realized they
> > > are synthetic, tooo...)
> > 
> > Hmm mWh value is based on the hardware sampled shunt
> > values and number of samples gathered between the
> > two readings. I'd rather call the calculated values
> > based on userland reading mV and mA values "synthetic" :)
> 
> As far as I know, shunt resistors provide you with current (mA) not
> power (mW) measurement... and cpcap-battery computes power_now as
> voltage * current. I'd rather have kernel tell me "hardware can't
> measure power" and do "voltage*current" computation in userspace.

Yup you are correct the hardware samples mA and we still need
to calculate mW based on the voltage.

But considering it works and seems to match the power supply
provided average power consumption numbers pretty well and at
least I'm using it.. What is your reasoning for removing such
a usable interface?

Regards,

Tony
