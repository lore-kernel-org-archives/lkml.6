Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F38EC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B2F22087A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B2F22087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbeIYPER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:04:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52578 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbeIYPEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:04:16 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6F88E10F8;
        Tue, 25 Sep 2018 08:57:45 +0000 (UTC)
Date:   Tue, 25 Sep 2018 10:57:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     SZ Lin =?utf-8?B?KOael+S4iuaZuik=?= <sz.lin@moxa.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        stable <stable@vger.kernel.org>, paul.burton@imgtec.com,
        jason@lakedaemon.net, marc.zyngier@arm.com, tglx@linutronix.de,
        linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 4.9 111/111] MIPS: VDSO: Drop gic_get_usm_range() usage
Message-ID: <20180925085742.GB22609@kroah.com>
References: <20180924113103.337261320@linuxfoundation.org>
 <20180924113116.349047480@linuxfoundation.org>
 <20180925013548.GA28493@roeck-us.net>
 <CAFk6z8PzPo9Uza_pwxo=tm9nWWgax2GJMktUmYu_1QrJGJpy6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFk6z8PzPo9Uza_pwxo=tm9nWWgax2GJMktUmYu_1QrJGJpy6A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 11:38:16AM +0800, SZ Lin (林上智) wrote:
> Hi,
> 
> Guenter Roeck <linux@roeck-us.net> 於 2018年9月25日 週二 上午9:36寫道：
> >
> > On Mon, Sep 24, 2018 at 01:53:18PM +0200, Greg Kroah-Hartman wrote:
> > > 4.9-stable review patch.  If anyone has any objections, please let me know.
> > >
> >
> > This patch breaks v4.4.y and v4.9.y builds.
> > It includes asm/mips-cps.h which doesn't exist in those releases.
> 
> I am sorry for my fault, thanks for your report.
> 
> Since the patch b025d51873d5fe6 "MIPS: CM: Specify register size when
> generating accessors" which created asm/mips-cps.h is not a bug-fixed
> patch, hence I will not backport this header.
> 
> Hi Greg,
> 
> Could you please help to revert this commit? This commit was intended
> to fix dependency of 70d7783 "MIPS: VDSO: Match data page cache
> colouring when D$ aliases", but I saw 70d7783 was merged before this
> commit; therefore, I don't think it is necessary to keep this commit.
> 
> I apology for any inconvenience caused, and I will be more careful next time.

Now dropped from the 4.4 and 4.9 queues, thanks.

greg k-h
