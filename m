Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C8FECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 16:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AFFD20849
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 16:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AFFD20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbeGURPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 13:15:25 -0400
Received: from smtprelay0002.hostedemail.com ([216.40.44.2]:46197 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727876AbeGURPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 13:15:25 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 5795D100E86C2;
        Sat, 21 Jul 2018 16:22:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: music50_1268f36d0fa62
X-Filterd-Recvd-Size: 2384
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Sat, 21 Jul 2018 16:22:06 +0000 (UTC)
Message-ID: <070dda6dd3b140ef5f6dbc965d7f8c1af934ec96.camel@perches.com>
Subject: Re: [PATCH 1/4] iio: adc: xilinx: Rename 'channels' variable name
 to 'iio_xadc_channels'
From:   Joe Perches <joe@perches.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Manish Narani <manish.narani@xilinx.com>, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        anirudh@xilinx.com, sgoud@xilinx.com
Date:   Sat, 21 Jul 2018 09:22:05 -0700
In-Reply-To: <20180721171828.55395acc@archlinux>
References: <1531912331-26431-1-git-send-email-manish.narani@xilinx.com>
         <1531912331-26431-2-git-send-email-manish.narani@xilinx.com>
         <d2c3ddfd-91da-e500-7b58-917d2da1d540@metafoo.de>
         <7c4ee0db-ac33-b093-4dbb-1742fb029012@xilinx.com>
         <20180721171828.55395acc@archlinux>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-07-21 at 17:18 +0100, Jonathan Cameron wrote:
> On Thu, 19 Jul 2018 10:22:07 +0200
> Michal Simek <michal.simek@xilinx.com> wrote:
> 
> > On 18.7.2018 13:18, Lars-Peter Clausen wrote:
> > > On 07/18/2018 01:12 PM, Manish Narani wrote:  
> > > > This patch fix the following checkpatch warning in xadc driver.
> > > > - Reusing the krealloc arg is almost always a bug.
> > > > 
> > > > Renamed the 'channels' variable as 'iio_xadc_channels' to fix the above
> > > > warning.
> > > >  
> > > 
> > > This is a bug in checkpatch and should be fixed in checkpatch. The code is
> > > not actually re-using the parameter. channels and xadc_channels are
> > > independent variables, just checkpatch somehow does not realize this.  
> > 
> > I think it should be fine to have this patch in tree. Change in commit
> > message to reflect this should be enough. But that's just view.
> 
> Let's wait and see if Joe has time to take a look at this.  Might be better
> to fix checkpatch if it's not too hard!

I submitted a proposed patch.
I believe it works.

https://patchwork.kernel.org/patch/10533011/

