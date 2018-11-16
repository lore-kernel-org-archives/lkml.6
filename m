Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951A3C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E3042086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="ybb4rWfw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E3042086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390083AbeKQDtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 22:49:33 -0500
Received: from imap.thunk.org ([74.207.234.97]:39976 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729036AbeKQDtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 22:49:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=a3wvockeyFdBCdANJ0FWpvxXKlsz8M9B+g9hKXIk5ik=; b=ybb4rWfwKs+x0CtNS/ANm6jcZm
        HlkLi9pgSmluEAPnzeRE6ZNBgZPMyKUPI7VRGf7yd66lt7peGGZpbOqvNIJz7YMTDMb/hun1XkgqT
        kDj2F+7o9A7dLUhdvNwXGvmoo4xKJG7HbEVGKSaxHdcoBCqoFMDRSfHvX+rE8myiKCkU=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gNi24-0004sq-KD; Fri, 16 Nov 2018 17:35:52 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3A5C47A47B5; Fri, 16 Nov 2018 12:35:51 -0500 (EST)
Date:   Fri, 16 Nov 2018 12:35:51 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/3] SG_IO command filtering via sysfs
Message-ID: <20181116173551.GG20617@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@infradead.org>
References: <1541867733-7836-1-git-send-email-pbonzini@redhat.com>
 <20181110190521.GA2627@thunk.org>
 <566bc821-f12a-f7c1-e7c7-99092807ee27@redhat.com>
 <20181111141426.GA7377@thunk.org>
 <98fe5cf7-722a-37d6-156d-842e8812e430@redhat.com>
 <1542328654.100259.18.camel@acm.org>
 <c819493c-2a45-4911-8879-310c910ee42a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c819493c-2a45-4911-8879-310c910ee42a@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 08:01:29AM +0100, Paolo Bonzini wrote:
> On 16/11/18 01:37, Bart Van Assche wrote:
> > All user space interfaces in the Linux kernel for storage that I'm familiar
> > with not only allow configuration of parameters but also make it easy to
> > query which parameters have been configured. The existing sysfs and configfs
> > interfaces demonstrate this. Using BPF to configure SG/IO access has a
> > significant disadvantage, namely that it is very hard to figure out what has
> > been configured. Figuring out what has been configured namely requires
> > disassembling BPF. I'm not sure anyone will be enthusiast about this.
> 
> Well, that's a problem with BPF in general.  With great power comes
> great obscurability.

You can also make the same complaint about kernel modules; that it's
impossible to figure exactly what a kernel modules does without
disassembling them.  However, you can a one-line description of what
it does using modinfo:

% modinfo async_pq
filename:       /lib/modules/4.19.0-00022-g831156939ae8/kernel/crypto/async_tx/async_pq.ko
license:        GPL
description:    asynchronous raid6 syndrome generation/validation
srcversion:     529102C736C4FED181C15A8
depends:        raid6_pq,async_tx,async_xor
retpoline:      Y
intree:         Y
name:           async_pq
vermagic:       4.19.0-00022-g831156939ae8 SMP mod_unload modversions 

					       - Ted
