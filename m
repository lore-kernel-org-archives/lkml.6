Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50D1C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 655A12084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ecloud.org header.i=@ecloud.org header.b="RnRKreBu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 655A12084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ecloud.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbeLKUqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 15:46:46 -0500
Received: from bonobo.maple.relay.mailchannels.net ([23.83.214.22]:6734 "EHLO
        bonobo.maple.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726136AbeLKUqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 15:46:45 -0500
X-Greylist: delayed 504 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Dec 2018 15:46:45 EST
X-Sender-Id: dreamhost|x-authsender|s@ecloud.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 96D0C5C2491
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 20:38:20 +0000 (UTC)
Received: from pdx1-sub0-mail-a57.g.dreamhost.com (unknown [100.96.11.179])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 2441B5C402E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 20:38:20 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|s@ecloud.org
Received: from pdx1-sub0-mail-a57.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.16.2);
        Tue, 11 Dec 2018 20:38:20 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|s@ecloud.org
X-MailChannels-Auth-Id: dreamhost
X-Illegal-Rock: 2846a5d8404726e7_1544560700327_3110851451
X-MC-Loop-Signature: 1544560700327:4077449625
X-MC-Ingress-Time: 1544560700325
Received: from pdx1-sub0-mail-a57.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a57.g.dreamhost.com (Postfix) with ESMTP id BDD7080724
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 12:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=ecloud.org; h=date:from:to
        :subject:message-id:mime-version:content-type; s=ecloud.org; bh=
        oOrM8oxHBcYVDWSPdjNTe11dZM0=; b=RnRKreBuh/MhgRP9YkqAcD0WAiGva8xm
        ETy6ilQkhnl6ZEy3kuxKyV4GFVQDGf97DlpmTIVpGK1boK5xuXSZsW2kjaU6RsB7
        VR0tVgZ2XY4a5BWqrWVqE3yOQ/zN84fN98mmUCOIlZwySkQScq5XCOJRGaVCFOQu
        NwQkk7n22Rw=
Received: from i7.vpn (ti0007a400-2237.bb.online.no [85.164.35.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: s@ecloud.org)
        by pdx1-sub0-mail-a57.g.dreamhost.com (Postfix) with ESMTPSA id 2428F80723
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 12:38:18 -0800 (PST)
Date:   Tue, 11 Dec 2018 21:38:15 +0100
X-DH-BACKEND: pdx1-sub0-mail-a57
From:   Shawn Rutledge <s@ecloud.org>
To:     linux-kernel@vger.kernel.org
Subject: Re: Can we drop upstream Linux x32 support?
Message-ID: <20181211203812.GA14983@i7.vpn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.0 (2018-11-25)
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: 0
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtkedrudegjedgudeflecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucggtfgfnhhsuhgsshgtrhhisggvpdfftffgtefojffquffvnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfggtggufgesthdtredttdervdenucfhrhhomhepufhhrgifnhcutfhuthhlvggughgvuceoshesvggtlhhouhgurdhorhhgqeenucfkphepkeehrdduieegrdefhedrudelieenucfrrghrrghmpehmohguvgepshhmthhppdhhvghlohepihejrdhvphhnpdhinhgvthepkeehrdduieegrdefhedrudeliedprhgvthhurhhnqdhprghthhepufhhrgifnhcutfhuthhlvggughgvuceoshesvggtlhhouhgurdhorhhgqedpmhgrihhlfhhrohhmpehssegvtghlohhuugdrohhrghdpnhhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I like the idea of x32 in theory: any machine with 4GB or less of memory
for sure does not really need to waste any precious space storing 64-bit
pointers; and even if more memory is available, software that needs to
access more than 4GB per process is somewhat rare (as it should be).  I
used a laptop every day with 4GB until recently, so was generally trying to
run relatively lean software.  I have played around with the Gentoo x32
variant on another machine, just to see how that would go.  I haven't used
it for much...  but tried out some basic things; and as long as it is
powered on, it functions fine as a node in an icecream cluster, too.
The icecream statistics shown in icemon tell me that this machine seems to
be performing faster than it should be, for its age.  So I think there is
some worthwhile average speedup (without being more scientific about it).

As a Qt developer, I have some interest that Qt and Qt Quick ought to work
well on this architecture.  (When it breaks, I write up bugs like
QTBUG-52658 and QTBUG-42759.)  There is still no JIT support for QML, but
perhaps there could be (I could try, if I ever find time to learn how the
existing QML/V4 JIT works on other architectures well enough to add another
one); and meanwhile, at least the interpreter works AFAIK.  I was just
thinking of testing this again, maybe running gentoo or debian x32 on that
old 4GB laptop; so I did a quick google search, and found this thread right
away.

Linux supports a lot of rarely-used hardware and features; so as long as
the burden of supporting x32 is not too great, I'd like to put in my vote to
keep it working.  And I will keep testing from time to time and do my bit
to keep Qt working on this architecture, as long as I'm not wasting my time
(if it's going to disappear, it would be a waste of time).

I can't explain why there aren't more users, and more distros.  It seems
to me it would be a good choice for the compact or small-is-beautiful
distros, like Puppy.

(CC me on this thread if you like, since I'm not currently subscribed to LKML)

