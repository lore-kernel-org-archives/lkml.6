Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA303C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FE4208EB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73FE4208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391904AbeHPSWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 14:22:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52974 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387805AbeHPSWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 14:22:00 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0A86E3EE;
        Thu, 16 Aug 2018 15:22:49 +0000 (UTC)
Date:   Thu, 16 Aug 2018 17:22:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        stable <stable@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Seth Heasley <seth.heasley@intel.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Song liwei <liwei.song@windriver.com>
Subject: Re: [PATCH V2] i2c: ismt: fix wrong device address when unmap the
 data buffer
Message-ID: <20180816152242.GJ10648@kroah.com>
References: <1497329993-197698-1-git-send-email-liwei.song@windriver.com>
 <CAJwJo6aAGS3vB-F889zmDJjtU3xGLd=twbVVC=DydXYufKEwPQ@mail.gmail.com>
 <CAHp75VfTzzZoDGaBfnW4NKiU-2Ds6wgQtyUu22mZKwLK2a4rcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfTzzZoDGaBfnW4NKiU-2Ds6wgQtyUu22mZKwLK2a4rcQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 12:25:48PM +0300, Andy Shevchenko wrote:
> On Wed, Aug 15, 2018 at 5:26 AM, Dmitry Safonov <0x7f454c46@gmail.com> wrote:
> > +Cc: stable
> >
> > Hi Greg, JFI:
> > This one has hit a couple of times on autotests on v4.9 stable.
> > The fix for BUG() is trivial, so probably worth to ship it to v4.9/v4.4/v3.18.
> >
> 
> JFYI:
> 
> commit 17e83549e199d89aace7788a9f11c108671eecf5
> Author: Liwei Song <liwei.song@windriver.com>
> Date:   Tue Jun 13 00:59:53 2017 -0400
> 
>    i2c: ismt: fix wrong device address when unmap the data buffer

Thanks, that helped :)

greg k-h
