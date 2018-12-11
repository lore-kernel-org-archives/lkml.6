Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245C3C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9FB32054F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIukEUKZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9FB32054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbeLKOhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:37:01 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42762 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbeLKOgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:36:54 -0500
Received: by mail-ed1-f65.google.com with SMTP id j6so12678230edp.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 06:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=S/g9WzuepKrGjZ3FyujhVHFRFZqU1/968Qo9jj0M818=;
        b=YIukEUKZHuRSeF+foqMkCLLs+HwuxUx21sMVg3HTHvdRTyOHe/ICzmcF3FUdHmvknC
         wzns9l73PF2eILS9dEvyLGjLYe7kVl75nJjEjlmuYzeN2ybZqoT0MW9hvs7Mf+ty8hr+
         vwhmkLG57AEZQ6pLsVjFs0z+tWY6puA1hjCLGsdzLVwaON+YMLMdvW2QsmugaFN9sLAU
         JleC8SGHT9A8983MLbHd76jHePMR2PMGh0MoQgG492d8PcqKCoivc72tcf4slNxLyrDD
         eXTMDMWQnowJZbGABwS9GBVvliD9IkaLee5mxt7yuSKOeCosQBZEFpnrLTzTNafuRBcS
         E4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=S/g9WzuepKrGjZ3FyujhVHFRFZqU1/968Qo9jj0M818=;
        b=iVnXps+V7TJDvle7XNvuRPSI3x5gT6tWuDATXeK7fZ3/HgXqFvrOWf35m3yCbVnbAT
         eEH96miNwtVTYkZ90U9YXPwpbaCDbg9bx4ah1X3RRMNrzIn0O7HIfZkqwtbKsSCrzbw/
         ORAMUSfzNds5vgjNVWib1aSAJ8Y+lLomx+M6GU13QSSHldnMC8mdz2zRnhsd2KHrVJAS
         8xzXCIFeLyB2YbSuDNDy1d6vjLamUbfHW7LPzujn0D/eQ0I+JoXQO3be/sT4dZRh8dND
         ifnnB4sQQvWJ2++5ccp4RJh7JBrnN8zj64+06rWuWvBvqJo1em20sucOyg14iTyUj0GC
         CtEg==
X-Gm-Message-State: AA+aEWZl5Dcax2mCX5TsQ/MVMuXKdpM5d64K1Kndd0hPrNOMJOybDvCy
        52m75+RGsqm5/VNioTDugIXlCIe2
X-Google-Smtp-Source: AFSGD/UNKD0STlW/SA9HBbZ1Fj8kQNGFOHk+DSFzcHjUbYUi1VFWo+tpCS4fpM6MWg7Lz+99LWp2WA==
X-Received: by 2002:a50:d759:: with SMTP id i25mr15640833edj.75.1544539012575;
        Tue, 11 Dec 2018 06:36:52 -0800 (PST)
Received: from dell.be.48ers.dk (d51A5BC31.access.telenet.be. [81.165.188.49])
        by smtp.gmail.com with ESMTPSA id t22-v6sm2244656ejl.58.2018.12.11.06.36.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 06:36:51 -0800 (PST)
Received: from peko by dell.be.48ers.dk with local (Exim 4.89)
        (envelope-from <peter@korsgaard.com>)
        id 1gWj9X-0003ig-DF; Tue, 11 Dec 2018 15:36:51 +0100
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "firmware: dmi_scan: Use lowercase letters for UUID"
References: <20181205211351.5309-1-peter@korsgaard.com>
        <1544086444.5492.1.camel@suse.com> <87a7ljyppx.fsf@dell.be.48ers.dk>
        <1544092087.5492.3.camel@suse.com> <878t1264lf.fsf@dell.be.48ers.dk>
        <87efaotgi1.fsf@dell.be.48ers.dk> <1544536167.5269.7.camel@suse.com>
Date:   Tue, 11 Dec 2018 15:36:51 +0100
In-Reply-To: <1544536167.5269.7.camel@suse.com> (Jean Delvare's message of
        "Tue, 11 Dec 2018 14:49:27 +0100")
Message-ID: <87a7lct9j0.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jean" == Jean Delvare <jdelvare@suse.com> writes:

 > On Tue, 2018-12-11 at 13:06 +0100, Peter Korsgaard wrote:
 >> > > > > > "Peter" == Peter Korsgaard <peter@korsgaard.com> writes:
 >> 
 >> Hi Jean,
 >> 
 >> >> Look, you can imagine that I was perfectly aware of what I was doing
 >> >> when I made that change, and that I pondered the decision carefully at
 >> >> that time. And my decision was that the change should be made. As far
 >> >> as I'm concerned, this ship has sailed already, sorry.
 >> 
 >> > Sorry, what is the perceived risk of reverting this change? Just the
 >> > minor inconsistency between the dmidecode and sysfs output? As stated
 >> > above, the RFC requires conforming parsers to handle upper case as well.
 >> 
 >> I would appreciate if you could explain what risk you see from reverting
 >> this change?

 > The exact same risk that you are complaining about, for a different
 > pair of kernel versions. You cannot at the same time argue that the
 > change should not have been done back then, and ask for same change to
 > be done again now.

With that kind of catch-22 logic, no regressions can ever be fixed. This
change was part of 4.17, released 6 months ago, whereas the previous
behaviour has existed for an order of magnitude longer.

While it is true that there is a chance that somebody may rely on the
new behaviour, it is likely to be significantly smaller than the chance
that someone relied on the previous behaviour (E.G. the breakage in my
software is proof of at least one such instance). Given that 4.19 has
only recently become a LTS kernel and distibutions with 4.17+ are only
getting released now (Fedora 29, Ubuntu 18.10) chances are that more
people will be affected in the future.

But you are right, we should do the revert as soon as possible, before
people start relying on this new behaviour.

I can extend the commit message with a reference to RFC4122 if you
prefer that over my "the change was purely cosmetical" wording?

-- 
Bye, Peter Korsgaard
