Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D19ECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69036208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LiXdvoJK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69036208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbeJRIZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 04:25:49 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:58255 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726644AbeJRIZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 04:25:49 -0400
X-Greylist: delayed 595 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Oct 2018 04:25:49 EDT
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 679D02E5;
        Wed, 17 Oct 2018 20:17:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 17 Oct 2018 20:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=FDvUh8
        9xh8+Qqu5y2q/J9imZHclgz10URtabzOTP8dQ=; b=LiXdvoJKiECystxLLcaZvl
        VWAQ2bF7uriDFo7vHh5WdGolff+lNdieUCNdZOOt3cUYW1kc+91FXzubo2+DZ3a6
        cE1cUM8rvcmjQcmOkhFyteU5sDmJ/v4ganr3ggcmFsMMh8Q8scXyYnebcxbptAfD
        YlFjVa+7mLPCJgH9Qn8OsCMlWZOviaFy+6ug/WDF8Cn1etwwCHgfFQIPubX0Q973
        LTLadOA54PVfLyA5RjOOKpZ7FveYhvUyQYQPhzKs9KYH+QIg03Qy0AnZq8poxWpL
        Az+r5+uMdYTrw224S1hcTmd/KQ80kSb5nwiHNPmndi6X/zk0JrNItDWMlG4MXtOw
        ==
X-ME-Sender: <xms:JNHHW3I8NMKz_YFHWuMsWnddGfPqPjfW18xYBSq06wumVlTBZua2aQ>
X-ME-Proxy: <xmx:JNHHW5fJ1NYKo2AbOPoWLEl4SNhusofSrKCftHY0P0d2wk0L-3qWHQ>
    <xmx:JNHHW4bSDqxV3vQCEaLqE287N5IWcURyncjppxYB7ep7QYN_ZRfrbw>
    <xmx:JNHHWy_xtr-dWKlCb9BtKqKkFSdraGHPhh1u46kXa4gPfWldbDmg4w>
    <xmx:JNHHW8VuNJMyU7nKoD284hz3N7ZlbURTguOqPQX9pUFRRgk2NkXWWA>
    <xmx:JNHHW7eP2eh8wrbrjrrw1R1dWaiOuHevTC-1xMt9AdHm27DnbVaEqA>
    <xmx:JNHHWxfMjyv4zGmEGze_vySVlefRDIOy6aaZ8YJXGBxTnl3S3AIWbg>
Received: from localhost (ppp121-44-203-227.bras1.syd2.internode.on.net [121.44.203.227])
        by mail.messagingengine.com (Postfix) with ESMTPA id B2540E4430;
        Wed, 17 Oct 2018 20:17:39 -0400 (EDT)
Date:   Thu, 18 Oct 2018 11:17:33 +1100
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] drivers: tty: Fix kernel-docs comments
Message-ID: <20181018001733.GI9944@eros>
References: <20181016232130.728-1-tobin@kernel.org>
 <CAMuHMdUKxHhvWHpQZ=ssghsZBRa4YqTFrvYj1h8jP1bdZQEqNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUKxHhvWHpQZ=ssghsZBRa4YqTFrvYj1h8jP1bdZQEqNQ@mail.gmail.com>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 09:00:26AM +0200, Geert Uytterhoeven wrote:
> Hi Tobin,
> 
> Thanks for your series!
> 
> On Wed, Oct 17, 2018 at 1:23 AM Tobin C. Harding <tobin@kernel.org> wrote:
> > My first patch set using kernel.org email address.  I've been so careful
> > with this one I'm expecting some epic fail :)
> 
> WARNING: Missing Signed-off-by: line by nominal patch author 'Tobin C.
> Harding <me@tobin.cc>'
> 
> The From line in the body of the patch emails doesn't match the SoB.

On further investigation I do not understand this.  The patches seem to
be sent from '"Tobin C. Harding" <tobin@kernel.org>' and the SoB is the
same?  Is this perhaps caused because the name portion is the same as
the name portion of previous patches?  Is this email generated by a bot?

Any further tips much appreciated.

thanks,
Tobin.
