Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792D0C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9E6214DD
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B9E6214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=BitWizard.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbeIYWZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:25:45 -0400
Received: from cust-95-128-94-82.breedbanddelft.nl ([95.128.94.82]:44170 "EHLO
        cust-95-128-94-82.breedbanddelft.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728587AbeIYWZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:25:45 -0400
Received: by abra2.bitwizard.nl (Postfix, from userid 1000)
        id CB05513F64C; Tue, 25 Sep 2018 18:17:30 +0200 (CEST)
Date:   Tue, 25 Sep 2018 18:17:30 +0200
From:   Rogier Wolff <R.E.Wolff@BitWizard.nl>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jeff Layton <jlayton@redhat.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        =?utf-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: POSIX violation by writeback error
Message-ID: <20180925161730.GA32709@BitWizard.nl>
References: <CAJDTihx2yaR-_-9Ks1PoFcrKNZgUOoLdN-wRTTMV76Jg_dCLrw@mail.gmail.com>
 <486f6105fd4076c1af67dae7fdfe6826019f7ff4.camel@redhat.com>
 <20180925003044.239531c7@alans-desktop>
 <0662a4c5d2e164d651a6a116d06da380f317100f.camel@redhat.com>
 <20180925154627.GC2933@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925154627.GC2933@thunk.org>
Organization: BitWizard B.V.
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 11:46:27AM -0400, Theodore Y. Ts'o wrote:
> (Especially since you can get most of the functionality by
> using some naming convention for files that in the process of being
> written, and then teach some program that is regularly scanning the
> entire file system, such as updatedb(2) to nuke the files from a cron
> job.  It won't be as efficient, but it would be much easier to
> implement.)

It is MUCH easier to have a per-application cleanup job. You can run
that at boot-time. 

  #/etc/init.d/myname startup script
  rm /var/run/myname/unfinished.*

Simple things should be kept simple.

	Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
**    Delftechpark 26 2628 XH  Delft, The Netherlands. KVK: 27239233    **
*-- BitWizard writes Linux device drivers for any device you may have! --*
The plan was simple, like my brother-in-law Phil. But unlike
Phil, this plan just might work.
