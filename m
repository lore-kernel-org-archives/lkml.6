Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB5DC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 05:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1108220C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 05:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="UQqNx021";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mo27AR6U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1108220C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbeIXLRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 07:17:44 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59693 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725982AbeIXLRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 07:17:44 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 6EAD32118B;
        Mon, 24 Sep 2018 01:17:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 24 Sep 2018 01:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=D4QHL1rnIN1hqHFRtQdFaY/s+jC6Yp+ljqo0XPXuT7g=; b=UQqNx021
        DS3UoHXNGx4xFC94Tc5tTarTfa1aQIh+FgGokku1jFNctKxU4IeyzhbjqB5Rm3+0
        xfk93Srh04ni0S8aGbNkm+v7fxtWrqTrNbanTspv/SO7cFv/zpwCQ5PUmdMUz7fu
        uZ9wnkBIVuubgKaXtGpZmwz0bX1n9r5tIwqz7ibJG2cwddklDsPVZU+1Wunw/6pe
        N8aZS5HWUx2iIjWJSpqU0Cmd3LkSne2c35c/756kgfPM9l0M75KZNMiIlfooJuEc
        ZLp8L64p7wK3B3Qe+hLaPaslxJMctd8QDtgzrKWSHjZYbWaE59ggK6rBF1vhXnyF
        ZRrkDXAEM6CySQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=D4QHL1rnIN1hqHFRtQdFaY/s+jC6Y
        p+ljqo0XPXuT7g=; b=Mo27AR6U5s86gHTte07du8jVHQ8+p+4p8mk40LaPpS+p/
        VgIe8DOtoAy3/wJa/r4wgTVJs9vwar+3wASn+XP7OAh5CyGYdP3sJNviakcLszO0
        CU9+514OI+qMODuLkJyy0Ac98y8yAn60Hmdi8t6hka32T8CBXzhlVjZqbc4K27m5
        HyzSrwYOr6s8bQ95GXNM3aQ2vIrtD+NxMQz54ynrqQC4MgCYBhpXD12aKWVKkrRD
        2uN13rgdCI+d1AKF4MbpEB7UzTqMat/ZTtOqhp4iv5yDw1Lg6uh1ycCP81RLSZYM
        3velattL+PwQ1PzlF11AjklF4gWzeLo5057OtAXWw==
X-ME-Proxy: <xmx:Y3OoW8o13usl7ksCxhy3gKLnej0aL8EOHPcB5gqlK1Q2gy3RmEkCIQ>
    <xmx:Y3OoW9NwEkIvm5OCmTnNWcZKr06r1mGGnibojgaIc9-aL2jT9VwOvA>
    <xmx:Y3OoW9yp24ihEFy26eOR2xMH5KsbobhXGeU91sERN0KNk2WwdLZUuQ>
    <xmx:Y3OoW2swNKx-UTohp49oUxSgAH3UMd-qwg4Q1dDjpjHs8KD-YzUrig>
    <xmx:Y3OoW24N8_C6wKherk44591pX4-bOcsddG7ugFpknEZBupfGE9Tpbw>
    <xmx:ZHOoW5Sn8LbSukJUD54hp-888is7gtOcuuEoNm6ssoidZFLzg3ZV3A>
X-ME-Sender: <xms:Y3OoWwxlT7AxIKyTQqhvuq6EfrzRwmwITQ9W8ie_WPuVM0el7BqOWg>
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.messagingengine.com (Postfix) with ESMTPA id D714D102D2;
        Mon, 24 Sep 2018 01:17:22 -0400 (EDT)
Date:   Mon, 24 Sep 2018 07:17:21 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Henrik Austad <henrik@austad.us>,
        Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: linux-next: manual merge of the staging tree with the jc_docs
 tree
Message-ID: <20180924051721.GA1974@kroah.com>
References: <20180924125016.0f813c15@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924125016.0f813c15@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 12:50:16PM +1000, Stephen Rothwell wrote:
> Hi Greg,
> 
> Today's linux-next merge of the staging tree got a conflict in:
> 
>   Documentation/filesystems/00-INDEX
> 
> between commit:
> 
>   a7ddcea58ae2 ("Drop all 00-INDEX files from Documentation/")
> 
> from the jc_docs tree and commit:
> 
>   a779df303b05 ("Documentation: filesystems: remove reminiscences of POHMELFS")
> 
> from the staging tree.
> 
> I fixed it up (I just removed the file) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Resolution looks good, thanks!

greg k-h
