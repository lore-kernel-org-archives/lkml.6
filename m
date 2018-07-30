Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C2B13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C17E20892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C17E20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeG3NKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 09:10:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59964 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbeG3NKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 09:10:39 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1B57ECD7;
        Mon, 30 Jul 2018 11:36:04 +0000 (UTC)
Date:   Mon, 30 Jul 2018 13:36:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] staging: rtl8188eu: remove unused
 rtw_handle_tkip_mic_err()
Message-ID: <20180730113601.GA19435@kroah.com>
References: <20180729185447.19903-1-straube.linux@gmail.com>
 <20180729185447.19903-3-straube.linux@gmail.com>
 <20180730090216.GA19163@kroah.com>
 <9ab9ce0f-4b2b-912b-04af-736ee9f23d4e@gmail.com>
 <7f238d0f-3d65-8f43-61a0-647147ecafdc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f238d0f-3d65-8f43-61a0-647147ecafdc@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 12:09:14PM +0200, Michael Straube wrote:
> On 07/30/18 11:27, Michael Straube wrote:
> > On 07/30/18 11:02, Greg KH wrote:
> > > On Sun, Jul 29, 2018 at 08:54:43PM +0200, Michael Straube wrote:
> > > > The function rtw_handle_tkip_mic_err() is never used, so remove it.
> > > > Discovered by cppcheck.
> > > 
> > > That's a bad tool then, as this is used, and the build breaks when this
> > > patch is applied :(
> > > 
> > > I've dropped it now.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > > 
> > 
> > Hm, that's weired, I also checked with:
> > 
> > git grep -n rtw_handle_tkip_mic_err drivers/staging/rtl8188eu/
> > 
> > There were/are no uses and the driver builds and works fine here.
> > I don't see what I may have missed here. :(
> > 
> > Regards,
> > Michael
> 
> The use of rtw_handle_tkip_mic_err() was added back in commit
> 
> 69a1d98c831ec64cbfd381f5dcb6697e1445d239
> Revert "staging:r8188eu: Use lib80211 to support TKIP"
> 
> which was applied with 'Merge 4.18-rc7 into staging-next'.
> 
> That was not applied when I sent the patch yesterday,
> sorry for the trouble.

Ah, that makes more sense, sorry for the noise, I should have caught
that.

greg k-h
