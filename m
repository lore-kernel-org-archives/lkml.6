Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC5EC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D13220891
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="G3ARAcqi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KVAZGB9g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D13220891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbeG0J5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:57:12 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44435 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729420AbeG0J5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:57:11 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 092A220B78;
        Fri, 27 Jul 2018 04:36:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 27 Jul 2018 04:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=+Uy/BWNtLEwBYye8emario+yKeKsMkNf4YI/mw1mRAw=; b=G3ARAcqi
        ezTzNnSEMMXSF687fpR7NQ0StilR791HWkSGnlj2lZAqx69CTbwpIor6EJFVyBiA
        zeHWv/+7Ag5STepyDM+5FEJveB1J4HlVsT4lcshuzCcdosi9M7GwxXe9XRo/QyyN
        Ohvt+LhoDg/O8R87me0Y0Zu5GUuOJMnmYkPakzGvugqVccqjouSB5In7u5xHsB4n
        IeJF0/5a3MHMF7zv+AvmK2gLAd6GaQWCdf5FLP/6V/g0c/N3umjhjM0WlWfFXlga
        GnIqRjlYZDR6i7UpKdTv8EIKu8NPoPA0/CtdESh8NZrRAtk6shl//d7jyFk5u2zK
        AAh+csD2ZL/WaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=+Uy/BWNtLEwBYye8emario+yKeKsM
        kNf4YI/mw1mRAw=; b=KVAZGB9gU9NKrwcgbrXZCGy+a2QCHfVgTrEzEZTrcbXEb
        VLHz2j5gY/kQDRqJAVL13m9GM2AIGgHUgJEuwCaGSKR3bAZ283KNnx3qT5bG27ut
        1nFJF/IZjuWTIMl95Jc5b8G3S+ZAz/FxE1Yt2OPCg+rloVSDlYPDhOFEB7bLP4s4
        RuEaivmRaJuBxmTEVU8zQAoVn+i7BJcWin76lWgmMv1IPIusGLRcNzK5n368deYw
        v6v8EgJYsni8nOHKjhNnXrzUAJY49y5KDtZOaiKzoCUoJ8ns/qufwIjgnY0njbJF
        6G2LaIestoFUSfR1wjEdoTorZnkTEwd38kW6+prMg==
X-ME-Proxy: <xmx:hdlaW-873urtzAznAWniyPbsml7O_gZz2jfrtG3ER0SogTSUE_Cv-w>
    <xmx:hdlaW5layKLloW4I5cM6-iIrBL0taK4B3uGgXuqzOn4CO5kCf3abVA>
    <xmx:hdlaW-NUJlX4aQSujMwqYhUtvLj8h56MXfj9_zImNnSKlqLc5EGM0w>
    <xmx:hdlaW4JU2ZwqnkMZ22648_x3bGB5iULsa4a-bPaWjv0doXrYhdvxJg>
    <xmx:hdlaW5FFhuo515mgG8N2Sv9LiNg4qaTrDa9EOPOxrIL8sE__jWenFw>
    <xmx:hdlaW6bO8UP1dXw5X5cE6cvRx8EhCbvW9Lsy7mtes655BHsArm1-NQ>
X-ME-Sender: <xms:hdlaW6fq5zDGUveQkaaQVNSHCDl5e4qrzITUtR-ze_eCKCApopoUcg>
Received: from localhost (unknown [89.188.5.116])
        by mail.messagingengine.com (Postfix) with ESMTPA id D984B1025C;
        Fri, 27 Jul 2018 04:36:20 -0400 (EDT)
Date:   Fri, 27 Jul 2018 10:36:19 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Hanselmann <linux-kernel@hansmi.ch>
Subject: Re: linux-next: manual merge of the staging tree with the powerpc
 tree
Message-ID: <20180727083619.GA17942@kroah.com>
References: <20180727175911.76ed6d44@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727175911.76ed6d44@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 05:59:11PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the staging tree got a conflict in:
> 
>   MAINTAINERS
> 
> between commit:
> 
>   d69ccc00c497 ("MAINTAINERS: Remove the entry for the orphaned ams driver")
> 
> from the powerpc tree and commit:
> 
>   28d1a7ac2a0d ("iio: dac: Add AD5758 support")
> 
> from the staging tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Looks good to me, thanks!

greg k-h
