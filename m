Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A97C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F88F20835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F88F20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbeHaCi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:38:28 -0400
Received: from smtprelay0016.hostedemail.com ([216.40.44.16]:47910 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727088AbeHaCi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:38:28 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id D13F7182CF66E;
        Thu, 30 Aug 2018 22:34:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: skin66_406a045b9e162
X-Filterd-Recvd-Size: 3174
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Thu, 30 Aug 2018 22:34:02 +0000 (UTC)
Message-ID: <56ff743b826b618cee60608160f2e798c5968871.camel@perches.com>
Subject: Re: [PATCH 01/21] staging:rtl8192u: Rename AdvCoding - Style
From:   Joe Perches <joe@perches.com>
To:     John Whitmore <arigead@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     John Whitmore <johnfwhitmore@gmail.com>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org
Date:   Thu, 30 Aug 2018 15:34:01 -0700
In-Reply-To: <20180829215508.GA16451@xux707-tw>
References: <20180829203547.15650-1-johnfwhitmore@gmail.com>
         <20180829203547.15650-2-johnfwhitmore@gmail.com>
         <b621a12258c3f0d0a9fcb61ac454af4822814e67.camel@perches.com>
         <e302edd8-4b00-8c28-8375-2a781877f019@lwfinger.net>
         <20180829215508.GA16451@xux707-tw>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-29 at 22:55 +0100, John Whitmore wrote:
> On Wed, Aug 29, 2018 at 04:21:54PM -0500, Larry Finger wrote:
> > On 08/29/2018 04:14 PM, Joe Perches wrote:
[]
> > > Perhaps support for the chipset could be converted to use
> > > mac80211 and moved into the directory with the other realtek
> > > drivers in drivers/net/wireless/realtek/rtl8xxxu/...
[]
> > All the Realtek USB devices should be added to rtl8xxxu, not merely moved
> > into that directory. Jes Sorensen created a well-designed driver the is
> > structured to permit addition of different initialization routines, etc.
> > That said, the conversion will not be easy. In addition, it will require
> > having your hands on a real device - a requirement that I cannot meet for
> > the RTL8192U.
[]
> > Oops... it probably doesn't look like it, at the moment, but 'actual code
> changes to this driver' was where I'm hoping to get to. There's a lot of
> stuff in the header files, including member variables, which are not used
> in the code. I was hoping to strip these out incrementally to minimise
> the amount of source code that has to be understood. I'm not familiar
> with the overall network, or 80211, subsystem architecture, but it's hard
> to see why this driver has it's own private ieee80211.h file.

That's true and the reason why this code should
eventually be deleted if possible and its functionality
integrated into the existing realtek/rtl8xxxxu code.

> I must try and get my hands on the device in question. 

That'd be good, though likely this device is obsolete.
Good luck finding one.

> Thank ye for your comments, and sorry for the "somewhat useful" changes
> to date, but doing these changes is letting me get the hang of this code,
> which I refuse to comment on because there are probably guidelines on using
> naughty language on here. ;)

Feel free.

The one look I took at any existing multi-platform realtek
code with all the #ifdefs made me not want look at it again.

https://github.com/hadess/rtl8723bs/

I said a naughty under my breath too.
