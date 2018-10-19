Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3289ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EDBF21476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EDBF21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codemonkey.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbeJSVxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 17:53:20 -0400
Received: from scorn.kernelslacker.org ([45.56.101.199]:54586 "EHLO
        scorn.kernelslacker.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbeJSVxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 17:53:19 -0400
Received: from [2601:196:4600:5b90:ae9e:17ff:feb7:72ca] (helo=wopr.kernelslacker.org)
        by scorn.kernelslacker.org with esmtp (Exim 4.89)
        (envelope-from <davej@codemonkey.org.uk>)
        id 1gDV7I-0000wi-RP; Fri, 19 Oct 2018 09:47:04 -0400
Received: by wopr.kernelslacker.org (Postfix, from userid 1026)
        id 78E8356028D; Fri, 19 Oct 2018 09:47:04 -0400 (EDT)
Date:   Fri, 19 Oct 2018 09:47:04 -0400
From:   Dave Jones <davej@codemonkey.org.uk>
To:     Meelis Roos <mroos@linux.ee>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        davem@davemloft.net
Subject: Re: netconsole warning in 4.19.0-rc7
Message-ID: <20181019134704.ky2vqeij6m77qrpg@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
        Meelis Roos <mroos@linux.ee>, Cong Wang <xiyou.wangcong@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        davem@davemloft.net
References: <e0611057-1b5b-9990-b9fa-060a9b5eba40@linux.ee>
 <CAM_iQpU0+LVwgMea32KQWf8z6Bp1VTmWOGnWNwNSmV0PZzf_ew@mail.gmail.com>
 <20181017034047.nrhstc3b4wzevnri@codemonkey.org.uk>
 <20181017035038.czaqown24rnjn2pw@codemonkey.org.uk>
 <fc91f629-8b91-c8c6-3c62-ffb400588597@linux.ee>
 <20181018145922.ytqxvdihp3iqounl@codemonkey.org.uk>
 <ddc5fea8-6c66-d096-57bb-c86a3771fec4@linux.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddc5fea8-6c66-d096-57bb-c86a3771fec4@linux.ee>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 12:51:38PM +0300, Meelis Roos wrote:
 > >   > > I took another look at that error path. Turns out this is all we need I
 > >   > > think..
 > >   >
 > >   > With this patch applied on top of 4.19-rc8, I stll get the warning:
 > >   >
 > >   > [   13.722919] WARNING: CPU: 0 PID: 0 at kernel/softirq.c:168 __local_bh_enable_ip+0x2e/0x44
 > > 
 > > It's going to be a couple days before I get chance to get back to this.
 > > Did the previous patch in this thread (without the _bh) fare any better?
 > 
 > Tried it with rcu_read_unlock() instead, still the same.

Ok, this is going to take more time than I have.  DaveM, do you want
to revert 6fe9487892b32cb1c8b8b0d552ed7222a527fe30, or do you want a
patch doing the same ?

That'll bring back the rcu warning, but fewer people were complaining
about that than this new issue..

	Dave

