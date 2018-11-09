Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBC6C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B439F20827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0HG9J/Ya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B439F20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbeKIU4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:56:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:39978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727532AbeKIU4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:56:15 -0500
Received: from localhost (71-6-98-120.static-ip.telepacific.net [71.6.98.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3296D20827;
        Fri,  9 Nov 2018 11:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541762165;
        bh=UqAi6IvdpTAxbpp+GwLrPqvOm++9VvFLh1BDJNAvcR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0HG9J/YaC0SyVFckei/oV0UcNvwsRQ8L6JHxbFTYrw5QjngZIwF1nUY4hSlbMr/2x
         CypUK0hjfySpQSwG+6Ck+Db8ct2gC6b0j/kmDxxhAngnsD+zk5dqVvGOrQ5nkBnmyt
         wl/Jtt0A/iPRn91yPLSBK/xhk0PulLlvROtNTSZM=
Date:   Fri, 9 Nov 2018 03:16:04 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Adrian Bunk <bunk@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        "Chiang, AlanX" <alanx.chiang@intel.com>,
        "Yeh, Andy" <andy.yeh@intel.com>, sashal@kernel.org
Subject: Re: [PATCH 4.14 01/31] eeprom: at24: Add support for address-width
 property
Message-ID: <20181109111604.GB26335@kroah.com>
References: <20181108215129.641434673@linuxfoundation.org>
 <20181108215129.753982396@linuxfoundation.org>
 <CAMRc=MdckdCj=dwn8J6Y5O1gPPykGrzK50td24_iFOa-MwEEJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdckdCj=dwn8J6Y5O1gPPykGrzK50td24_iFOa-MwEEJQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 08:48:32AM +0100, Bartosz Golaszewski wrote:
> czw., 8 lis 2018 o 23:08 Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> napisał(a):
> >
> > 4.14-stable review patch.  If anyone has any objections, please let me know.
> >
> 
> Hi Greg,
> 
> this looks like a new feature, not a fix. Are you sure this should go
> into the stable branch?

Adrian Bunk asked for it to be included as he said it was a good "quirk"
support for some hardware enablement issues.

If you think it should be dropped, I'll be glad to do so, but it seems
harmless to me.

thanks,

greg k-h
