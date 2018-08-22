Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D28BC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 19:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E634A2098B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 19:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="NIx0MQUh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DAQ5wlpT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E634A2098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbeHVWhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 18:37:03 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51629 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727844AbeHVWhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 18:37:02 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 7E67F2202D;
        Wed, 22 Aug 2018 15:10:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 22 Aug 2018 15:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=AUVPUB5tuhTA8MiFEJWTVwjoErieBseO6muomaAvl/4=; b=NIx0MQUh
        88aGwbm4txqJ/JP55twkm+dYBCu2NbdHsNLIOxpo71M4fnH0M9XuyJgFCcyWUfcr
        THXegZoJ0/Uf02RbSXh16vKdHhxx5dbn597juaAk+HmgFLIV3VyC948Dp1FkO5ff
        1yZ+iXA/3oQLdAgIPY2Moo9ODYSADO1vsVRsppGmOVPLml68TQp9IbZBCcGjksz4
        RM/PgXUFDfWaW6kLstxHuvJkMCslM3OJjlf01eua/ODNBrKGkIrR4KscsJFH0SsL
        6HyeuI+naPgLKb4euclxg+xZizxm/BgnF2v55vdM9E2QjtCiB41SCU7TGyYy4e2s
        sM6V00QaNyMG9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=AUVPUB5tuhTA8MiFEJWTVwjoErieB
        seO6muomaAvl/4=; b=DAQ5wlpTKb/GY0kUApfGSmpjNpn0YxGiaLErP0zpPS0Sf
        g7yyD2AxbBZEhoZsNvKjdh7WBu+GXYmaUCOl3W6/Oi2EycRrmGM8BXPRG28ab9jB
        51qJFt/h2dPsBmUwqU4RH/wQUTLhTNdyS7AFa0K7Nx15jZNjuJ2g/5rKVUWYjN0i
        8EVwWN0NNDGORQhaKMsDmAEJ+r7aa4vOg1QVNn2ufb9R6Cnu/Qe4HIPmlUGv9IYC
        pSvYCwbPrfjl6nYIev97RO654FVHp2nNZ1CTffZ9NNsjzmumjxNXwHArHkORqcxV
        H8hn6MxQvZytq+V6+/zYE/34+cibdAc+ar5mpOnbw==
X-ME-Proxy: <xmx:PLV9WyLt0ubvccAkEM9YrbeaxJyfbPvc_Un_PFdj-8puiL-YDZlwfg>
    <xmx:PLV9Wx53uY-Hhlk6Lhop3cQOwBy4oKHCgTn_vPfQfj9biMXtZS1WKw>
    <xmx:PLV9WxTSFor2PX40EhKWOgpb9MbXmyxBuhxCQHgd-wOfmucov7a49g>
    <xmx:PLV9WxtseEjYTULjl-fi09dgY3-zp4gXsaMUG3LiyJFBgFQf3ZGmQA>
    <xmx:PLV9W9T0CqtxU5W7cIuevVp-t89pJgRx5WpD9PPSUTfxdaRNp1UaCQ>
    <xmx:PbV9W0tg_b35mKfnwZGijRSP7ftHJhOacvSUQQ8fuDskrkH8k0EgZg>
X-ME-Sender: <xms:PLV9WzszRyPLFWk1XgYvDk3iTjBVixx6cSF2ledo7Dgjd-2-Ktutdg>
Received: from localhost (5355525a.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.messagingengine.com (Postfix) with ESMTPA id 94F4EE47C7;
        Wed, 22 Aug 2018 15:10:51 -0400 (EDT)
Date:   Wed, 22 Aug 2018 21:10:48 +0200
From:   Greg KH <greg@kroah.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Lucas De Marchi <lucas.demarchi@profusion.mobi>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Jessica Yu <jeyu@kernel.org>,
        Chih-Wei Huang <cwhuang@linux.org.tw>,
        stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: please revert commit ce8556cca6 "kbuild: verify that $DEPMOD is
 installed" introduced in v4.18.4.
Message-ID: <20180822191048.GA6916@kroah.com>
References: <490A46D5-834E-46A9-9106-A31F94344F99@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <490A46D5-834E-46A9-9106-A31F94344F99@goldelico.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 08:53:46PM +0200, H. Nikolaus Schaller wrote:
> This patch requires that /sbin/depmod is installed and installable on
> the build host.
> 
> But not all build hosts for cross compiling Linux are Linux systems
> and are able to provide a working port of depmod, especially at the
> file patch /sbin/depmod.
> 
> I use, for example, a Darwin system to cross compile Linux and I run
> depmod -a on the embedded system once, after installing a new Linux
> kernel there.
> 
> I have no problem with seeing a warning, but aborting the build process
> is IMHO a bad idea since the previous behaviour didn't harm many people
> as far as I see. Probably 99% of people compiling Linux kernels do that
> on Linux and 99% of those have depmod installed for optimal operation of
> their build host. So IMHO printing the warning is good enough.

It needs to be reverted in Linus's tree first before I can revert it in
the stable tree(s).

thanks,

greg k-h
