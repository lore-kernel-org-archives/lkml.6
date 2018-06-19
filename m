Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005EEC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B167E20652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B167E20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mielke.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966478AbeFSN77 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:59:59 -0400
Received: from nimbus1.mmprivatehosting.com ([54.208.90.49]:54092 "EHLO
        nimbus1.mmprivatehosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966111AbeFSN76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:59:58 -0400
X-Greylist: delayed 461 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jun 2018 09:59:58 EDT
Received: from localhost (localhost [127.0.0.1])
        by nimbus1.mmprivatehosting.com (Postfix) with ESMTP id 9472860028;
        Tue, 19 Jun 2018 13:52:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at mmprivatehosting.com
Received: from dave.mielke.cc (CPEc8be196b689f-CMac202ebc50a0.cpe.net.cable.rogers.com [174.115.138.203])
        (Authenticated sender: relay@dave.mielke.cc)
        by nimbus1.mmprivatehosting.com (Postfix) with ESMTPA;
        Tue, 19 Jun 2018 13:52:15 +0000 (UTC)
Received: from beta.private.mielke.cc (beta.private.mielke.cc [192.168.0.2])
        by dave.mielke.cc (Postfix) with ESMTPS id 726794A0;
        Tue, 19 Jun 2018 09:52:15 -0400 (EDT)
Received: from beta.private.mielke.cc (localhost [127.0.0.1])
        by beta.private.mielke.cc (8.15.2/8.15.2) with ESMTP id w5JDqFeL003308;
        Tue, 19 Jun 2018 09:52:15 -0400
Received: (from dave@localhost)
        by beta.private.mielke.cc (8.15.2/8.15.2/Submit) id w5JDqDde003306;
        Tue, 19 Jun 2018 09:52:13 -0400
Date:   Tue, 19 Jun 2018 09:52:13 -0400
From:   Dave Mielke <Dave@mielke.cc>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     Nicolas Pitre <nicolas.pitre@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] have the vt console preserve unicode characters
Message-ID: <20180619135213.GB2563@beta.private.mielke.cc>
References: <20180617190706.14614-1-nicolas.pitre@linaro.org>
 <20180619130953.bxil552igfkckjmr@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619130953.bxil552igfkckjmr@angband.pl>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[quoted lines by Adam Borowski on 2018/06/19 at 15:09 +0200]

>You're thinking small.  That 256 possible values for Braille are easily
>encodable within the 512-glyph space (256 char + stolen fg brightness bit,
>another CGA peculiarity).  

Not at all. We braille users, especially when working with languages other than
English, need more than 256 non-braille characters. Even for those who can live
with just 256 non-braille characters, it's still a major pain having to come up
with a usable braille-capable font for every needed 256 non-braille characters
set. I can assure you, as an actual braille user, that the limitation has been
a very long-standing problem and it's a great relief that it's finally been
resolved.

-- 
I believe the Bible to be the very Word of God: http://Mielke.cc/bible/
Dave Mielke            | 2213 Fox Crescent | WebHome: http://Mielke.cc/
EMail: Dave@Mielke.cc  | Ottawa, Ontario   | Twitter: @Dave_Mielke
Phone: +1 613 726 0014 | Canada  K2A 1H7   |
