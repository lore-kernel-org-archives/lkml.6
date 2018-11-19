Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4225C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786D72080C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="QxRpRLyr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 786D72080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732144AbeKTKNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 05:13:08 -0500
Received: from imap.thunk.org ([74.207.234.97]:54380 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727583AbeKTKNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 05:13:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Ael0izyb6injiRpOvRaspckUDWtdFagaQgon+O+fIsY=; b=QxRpRLyr6k4Nrvi/UN3ZCl17bk
        p+O69pWrZYmDNOBybjUC1j/VbDo5/c58Yi/eMxHGYQxwbTLrVxVEdaoMPzzq7z8megEIOxW8/tBTa
        5NSZVrcyK3KmuZKQ+tm8LRYD+UVRoRSAH4yVxQx805pEAP/I0UtEUs41l6Yt+sVgUeyI=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gOtFn-0002eN-Fp; Mon, 19 Nov 2018 23:46:55 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7F5EE7A046D; Mon, 19 Nov 2018 18:46:54 -0500 (EST)
Date:   Mon, 19 Nov 2018 18:46:54 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     AIAMUZZ <muzafsh.113@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Magic Sysrq key option ... What is the option to record the boot
 logs to my hard disk before i issue a reboot command ?
Message-ID: <20181119234654.GD17374@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Randy Dunlap <rdunlap@infradead.org>,
        AIAMUZZ <muzafsh.113@gmail.com>, linux-kernel@vger.kernel.org
References: <CAC_t1uu7DDwA6do9sXnNhjcY4T=Q5PhmP2JtejSJ+FfpwJkaeg@mail.gmail.com>
 <20181119184803.GB19377@thunk.org>
 <e901d13d-68e7-c9be-96d6-9f49d3a44ceb@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e901d13d-68e7-c9be-96d6-9f49d3a44ceb@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 11:31:21AM -0800, Randy Dunlap wrote:
> 
> Yes, all of that.
> Having some kind of pstore on x86 would be wonderful.
> 
> kexec/kdump used to be an option also.  I haven't tried it lately.

Sure, but kexec/kdump won't work to debug a boot failure during early
boot.  You need to be able to get the root file system mounted at the
very least, and usually kexec/kdump doesn't get set up until the init
scripts are running.

Fortunately, usually only kernel developers need to debug early boot
failures, and most of us can usually use serial consoles (for those of
us who can't just cheat and use VM's.  :-)

       	     	  	    	       - Ted
