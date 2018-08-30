Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC86FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 05:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA272082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 05:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA272082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=coelho.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbeH3Jzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 05:55:55 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:45156 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725904AbeH3Jzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 05:55:55 -0400
Received: from 91-156-4-241.elisa-laajakaista.fi ([91.156.4.241] helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <luca@coelho.fi>)
        id 1fvFvR-0004UY-Fn; Thu, 30 Aug 2018 08:55:26 +0300
Message-ID: <fa12a23813cf096e217eac27835ed416ca0d1632.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Dave Young <dyoung@redhat.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxwifi@intel.com
Date:   Thu, 30 Aug 2018 08:55:24 +0300
In-Reply-To: <20180830050632.GB2307@dhcp-128-65.nay.redhat.com>
References: <20180829065442.GA3488@dhcp-128-65.nay.redhat.com>
         <6bb91f750e8d37d45da3c2cf1e7e5fc5d453ee8c.camel@coelho.fi>
         <20180830050632.GB2307@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 91.156.4.241
X-SA-Exim-Mail-From: luca@coelho.fi
Subject: Re: Intel Wireless 8265/8275 (rev 78) issue
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on farmhouse.coelho.fi)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-30 at 13:06 +0800, Dave Young wrote:
> On 08/30/18 at 07:15am, Luca Coelho wrote:
> > On Wed, 2018-08-29 at 14:54 +0800, Dave Young wrote:
> > > [   74.123114] wlp61s0: authenticate with 00:1f:c6:82:0a:57
> > > [   74.126099] wlp61s0: send auth to 00:1f:c6:82:0a:57 (try 1/3)
> > > [   74.139740] wlp61s0: authenticated
> > > [   74.140142] iwlwifi 0000:3d:00.0 wlp61s0: disabling HE/HT/VHT due to WEP/TKIP use
> > > [   74.140146] iwlwifi 0000:3d:00.0 wlp61s0: disabling HT as WMM/QoS is not supported by the AP
> > > [   74.140149] iwlwifi 0000:3d:00.0 wlp61s0: disabling VHT as WMM/QoS is not supported by the AP
> > 
> > Your AP seems to be configured to use WEP or TKIP, which is not allowed
> > by IEEE802.11n, so we disable all the higher rates, as you can see
> > here.  It should still work, but you will only get very basic rates
> > (i.e. slow).
> 
> Luka, thanks for the suggestion,  moved AP to use WPA2-personal + AES.
> seems I got only two features disabled this time:
> [   20.949347] iwlwifi 0000:3d:00.0 wlp61s0: disabling HT as WMM/QoS is not supported by the AP
> [   20.949351] iwlwifi 0000:3d:00.0 wlp61s0: disabling VHT as WMM/QoS is not supported by the AP
> [   20.949622] wlp61s0: associate with 00:1f:c6:82:0a:57 (try 1/3)

There are many interoperability problems with old 11n APs that either
support a draft version of the specs or simply have bugs in their
implementations of the 11n specs.  When we detect these problems, we
disable 11n rates, so connectivity will be slower, but it will at least
remain connected.  This seems to be the case with your AP. :(


> > > [ 2521.068469] wlp61s0: deauthenticating from 00:1f:c6:82:0a:57 by local choice (Reason: 3=DEAUTH_LEAVING)
> > 
> > Other than that I can't really see what is going on, except that
> > something is deciding to disconnect here...
> > 
> > So, first thing I'd suggest would be to try to reconfigure your AP to
> > use something else than WEP or TKIP, just to see if it improves in any
> > way.
> 
> Will observe if it works or not. BTW, my old laptop Thinkpad T440s works
> well with the same AP.

I hope it improves.  If not, we should debug it further.  It's a good
thing not to use WEP and TKIP anyway, because they're not very secure
anyway.


> > And BTW, is this a regression in recent kernels or has this always
> > happened to you with this laptop/AP combination?
> 
> From my observation it just always happen, but hmm not 100% sure..

Okay, so we don't have enough information on this.  It doesn't matter. 
What is the NIC on your old T440s?

--
Cheers,
Luca.

