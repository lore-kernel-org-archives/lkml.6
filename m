Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0FDC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B88A20811
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="EDznVmAk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EcJIPXPb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfBKHoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 02:44:08 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:49761 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725931AbfBKHoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 02:44:08 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 1A52420A70;
        Mon, 11 Feb 2019 02:44:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 11 Feb 2019 02:44:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=cJqiURh+XuO56rrklyxJb4raE/C
        RPrdex47wrzMj4E0=; b=EDznVmAklNA3g65dvwn25QxgjrjlOVJ0xWqkDWK9WmU
        DnnrxKttiyluJSHTLQvbED08pE4dBU7TEkeoyuiCeAsWyVWdmDbkl0Sfh1+Z9+jI
        qvSpvxWk7rtdG4UfQ8HewBCUN519qqdob8Qugi/0CMTL5bA39IYMpwJlIvvuNJMs
        STza09gsnWbCrOIfoGKcaTxtnisxEl5Nu23IkN7eRLKXw35Qjm3JsLXdCWjkL2hp
        ftLLa5k+jao8LvWotCvBW4zhxJthLdmjBeRtOO4Ri60zbuTqLk7mpDKbLzOGl5HO
        CR7FHdyhyY78UiFmbMkkh7sEzfFul3ffe5vn6n9AxOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=cJqiUR
        h+XuO56rrklyxJb4raE/CRPrdex47wrzMj4E0=; b=EcJIPXPb4Y6kiYV3FwWWjs
        GLyLniFBKA4I6pO7N26I5XMLy1nfp8psf2IoRH1yzIjuy9g9TFtcSkhGGG7yNu6X
        LC9URmBNboHp4Qy+bXdR3cuzx1cZHXGxTd3uOsx89UusyJ/knbE8oUFGUgBUcTgA
        80hqML5CsRFIz79ys5XTtBNbLDUAvbtszazNtW1xQRsnKlFS46aX4jgDa9VvPKcF
        pKEhJXC5Gtn8Gdk87Vv4XZxmdN+rv2czk5y1hU1eyw7SUlQJy8Ig1uv/9GVXc5Q3
        K8RTtzjloEzOwDj5848EqJafiyClXVAMNuIdLgBZakaswLBPatZdk7LVY56Aw0Sg
        ==
X-ME-Sender: <xms:xSdhXL1iX70xSpBLr_lkKkwzsCUN0UO2zPyT8E8Er_AttT0fnzdScg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrleejgdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhhtnecuuegrihhlohhuthemucef
    tddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfh
    ggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehk
    rhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrddutdejnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucevlhhushhtvghrufhiiigv
    pedt
X-ME-Proxy: <xmx:xSdhXETXdDB9fJJCSwwKcd9JJOw6xOsioN0NX-CFr6XEp6yb-rf8Ig>
    <xmx:xSdhXAjeuI4VMR7JroeIo5oFFWJJkhO81EBxUBURmBE4x3quu6ATtw>
    <xmx:xSdhXBZC74Ai7v8Jy2qXEn45j3UwKxO_q4RTKhqmAxyIRej-9vWvVg>
    <xmx:xydhXIgBsy30jadBmn3XIs5sIDR45UMTaZJDMxV8Han5qUrgrLtqIA>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1E36710311;
        Mon, 11 Feb 2019 02:44:05 -0500 (EST)
Date:   Mon, 11 Feb 2019 08:44:02 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the driver-core tree
Message-ID: <20190211074402.GA7356@kroah.com>
References: <20190211074052.2407f1e3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211074052.2407f1e3@canb.auug.org.au>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 07:40:52AM +1100, Stephen Rothwell wrote:
> Hi Greg,
> 
> In commit
> 
>   344c0152d878 ("selftests: firmware: fix verify_reqs() return value")
> 
> Fixes tag
> 
>   Fixes: a6a9be9270c87 ("selftests: firmware: return Kselftest Skip code for for skipped tests")
> 
> has these problem(s):
> 
>   - Subject does not match target commit subject

I don't understand, what is wrong with the fixes: tag here?

$ git show -s --abbrev-commit --abbrev=12 --pretty=format:"%h (\"%s\")%n" a6a9be9270c87
a6a9be9270c8 ("selftests: firmware: return Kselftest Skip code for skipped tests")

How does that not match up?

Ah, an extra "for" in there.  Luis, you need to fix up your scripts, and
not be forced to manually type in those lines :)

thanks,

greg k-h
