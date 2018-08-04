Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424E2C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 16:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC03B217CD
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 16:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="DgAbyfh8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC03B217CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbeHDSX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 14:23:26 -0400
Received: from imap.thunk.org ([74.207.234.97]:37572 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727788AbeHDSX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 14:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=IFMoixiTCQw0hSTWrxKp8kT6byCt9H6gEhDcDQM//Vk=; b=DgAbyfh8A/Pn4IhWT/kGtJQgzF
        9IHWm3OUg/YpQdw2InXrskMeI/YmaXN2RsGZuj+rEhWJQsdjUmqen9Asu9/jSIvIh1w1nBAobm7Xn
        IeO5J/zFMm50ANryOpg7wF4U2Jd1W9QOheQ46BgIGA44lYStGP6x+g5b5VShR67GWt70=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1flzJe-0000Pz-HU; Sat, 04 Aug 2018 16:22:06 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9CD3B7A64C9; Sat,  4 Aug 2018 12:22:05 -0400 (EDT)
Date:   Sat, 4 Aug 2018 12:22:05 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Zdenek Kabelac <zkabelac@redhat.com>
Cc:     Mike Snitzer <snitzer@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, dm-devel@redhat.com,
        Ilya Dryomov <idryomov@gmail.com>, wgh@torlan.ru
Subject: Re: [dm-devel] LVM snapshot broke between 4.14 and 4.16
Message-ID: <20180804162205.GB4461@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, dm-devel@redhat.com,
        Ilya Dryomov <idryomov@gmail.com>, wgh@torlan.ru
References: <d76415de-2056-c7d6-cc88-b896deaa8ead@torlan.ru>
 <1ec0a220-d5b0-1c27-e63b-c4d3f4ce9d77@torlan.ru>
 <CA+55aFyPVQ5-gA93irsaxPC9BNQxnGWrDDHPMUYai2kxKiaKWQ@mail.gmail.com>
 <b2bbd8ec-ac5b-fa8a-d3f7-8615d87f73c3@redhat.com>
 <CA+55aFwWZX=CXmWDTkDGb36kf12XmTehmQjbiMPCqCRG2hi9kw@mail.gmail.com>
 <20180803185431.GB3258@redhat.com>
 <CA+55aFwDEY7B6OMh5xL2wc8BRj1KkzBHggNowAjbsWfma6H5Zg@mail.gmail.com>
 <20180803193037.GA4581@redhat.com>
 <20180804052033.GA4461@thunk.org>
 <102c2d75-f768-a649-52c3-bac6f0ca738d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <102c2d75-f768-a649-52c3-bac6f0ca738d@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04, 2018 at 10:36:50AM +0200, Zdenek Kabelac wrote:
> dm-snapshost has really outdated design - it's been useful in the old age
> where megabyte was hell lot of space.
> 
> Nowadays, when users do need to handle snapshots in multi gigabyte sizes and
> moreover have number of snapshots from the same volume taken over the time,
> want to take snapshot of snapshot of snapshot, the old snapshot simple kills
> all the performance, uses tons of resources and becomes serious bottleneck
> of your system and has lots of usability limitation.

Fair enough.  I don't think I would consider that makes dm-snapshot a
"steaming pile".  For me, protection against data loss is Job One.

> That's where  thin provisioning will shine....

The dm-thin development might want to take a look at what's currently
in Documentation/device-mapper/thin-privisioning.txt:

   Status
   ======

   These targets are very much still in the EXPERIMENTAL state.  Please
   do not yet rely on them in production.  But do experiment and offer us
   feedback.  Different use cases will have different performance
   characteristics, for example due to fragmentation of the data volume.

   If you find this software is not performing as expected please mail
   dm-devel@redhat.com with details and we'll try our best to improve
   things for you.

   Userspace tools for checking and repairing the metadata are under
   development.

Saying that dm-snapshot is a steaming pile and dm-thin is what
everyone should use doesn't seem to be consistent with the above.

Cheers,

					- Ted
