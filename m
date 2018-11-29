Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4069C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE7920863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dk259SPO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE7920863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbeK2XmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 18:42:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:53420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbeK2XmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 18:42:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ABB52081B;
        Thu, 29 Nov 2018 12:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543495012;
        bh=VsfZkchUMhlDO01dl5MRypyaEK5mFOQCoDKoYdE2GbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dk259SPOckSblkqlHaOXipgvqgQwC6hVkmn+tzs1N2Nb7xTan1xqT94GjUg3mvGs7
         PATotPx9PaR/+Nq50b298aFXfRqtCuIqnJjN68ReVSSXk0dZFPXhm5k5PGwnsmKIk+
         vK6PL92UlqhxskpnbYJZiZpmKX5oNIelMuI0lP5s=
Date:   Thu, 29 Nov 2018 13:36:50 +0100
From:   gregkh <gregkh@linuxfoundation.org>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     David Miller <davem@davemloft.net>, mkubecek@suse.cz,
        Networking <netdev@vger.kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        rweikusat@mobileactivedefense.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ltp@lists.linux.it, Cyril Hrubis <chrubis@suse.cz>,
        junchi.chen@intel.com, Dmitry Vyukov <dvyukov@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: RFC: changed error code when binding unix socket twice
Message-ID: <20181129123650.GI3149@kroah.com>
References: <20170630073448.GA9546@unicorn.suse.cz>
 <20180831111436.GA23780@dell5510>
 <CAK8P3a2yfZKMtE16DNCjZBOQ1R5=uXD16k43eJ=najJBh7H85Q@mail.gmail.com>
 <20181029163331.GA31059@dell5510>
 <CAK8P3a1q32spcF445Zhw-KMXG2VwFZuMw5C1sYFk3qLXz3HB5w@mail.gmail.com>
 <20181107155644.GA29531@dell5510>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107155644.GA29531@dell5510>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 04:56:44PM +0100, Petr Vorel wrote:
> Hi
> 
> > I forgot that 4.1 has ended a while ago. Greg also sometimes still takes patches
> > for 3.18, so that might be a candidate aside from 3.18
> 
> Gregkh, David, does it make sense to you to merge commit 0fb44559ffd6 ("af_unix:
> move unix_mknod() out of bindlock") to 3.18? If yes, please do so.

Now queued up, thanks.

greg k-h
