Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C021C43612
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C78420859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389514AbfAOTvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 14:51:07 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:57589 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728745AbfAOTvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 14:51:06 -0500
Received: from oxbsltgw35.schlund.de ([212.227.220.134]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MF45G-1gU2Gf1HnU-00FUB6; Tue, 15 Jan 2019 20:50:49 +0100
Date:   Tue, 15 Jan 2019 20:50:48 +0100 (CET)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     mlangsdo@redhat.com, suzuki.poulose@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, julien.thierry@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        steven.price@arm.com, ykaukab@suse.de, dave.martin@arm.com,
        shankerd@codeaurora.org
Message-ID: <884332236.499392.1547581848222@email.ionos.de>
In-Reply-To: <20190109235544.2992426-1-jeremy.linton@arm.com>
References: <20190109235544.2992426-1-jeremy.linton@arm.com>
Subject: Re: [PATCH v3 0/7] arm64: add system vulnerability sysfs entries
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:+elgm5XkOyevwG1T38e8l8G5/xrYrE/AXpRfEqSejzcD3j/tTTm
 garzisnzmfWhuxI9fmnIaajQLlzVYnxMcO0AY2FF/dKlnZWh9hutuKR7EBAd5hDw9DTCpLn
 fegPCon/vjdIEUSvcermSZENwTiBYEUuxAB5t5NyMAcfz/i33PfK1qt4Y4EkI78xYypQ+H3
 GtqHjWakuhlgJsx6ww4hg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b3DnGGu1+C4=:2UWRM59ehu+mczGkpaQ3gd
 YHNZRq6Ct/0hKTjTli1v+A8LPw0c30Kh95XHcwWYROUOAmnfsZ2BnZBAxLQvZExdNGs/ie1Me
 njQEdv0/0FKimYnpl038AWAUEmxJzfOp63L2myVPKKCrND208EEkpIYJ0/MRXC7bFpXP74TAb
 UljjRH/QShwgZT9/cUd3uS7T5njU50hWUDbEPGk4eMojWfsgvHDagyI1Vh/JlKO/kOpAgnZKh
 +FT3GtB7Zr1eOxso6VjbakG1jcYEEkl0ojW5qFExKFXmzYm7FfzbgA15xL57BoIdJVUMMdVaZ
 B75tK9ZrLjB5TsqTyEHPOsKGehDDTX0wDXgSbw4PQ4GAv27Mg2F5tLbMrDu9nWbyJqwjjn6Gt
 nwXs+Q3kC1kaqRk+tZkd3DY0jgjH4rEcd9E+FbdE0HyHDjsKz5Ygv8Wz35xlEZlzDrhXPkc2l
 gkHAkxukLR8/SeyFKPv09KCnScMhxLabVS8SdN7fQ2DyD/KgOOMNxnGZn11kaTVfNc6gnK596
 MIBxMPzid1S/+97Da9LyMKeZaaxFuduxvuHzG40m0RmSVEVhyTR/rQbMGr7Uilx9V+E3RuxG3
 fMiUUZ+xgaXEvBP1Lf86N7PFNJNhJ6HN2Z+oPQHD0xfIUS1BMQ6Zthx+CT/p+/XFn7/tLDew1
 l/S+yY8vn8pq37+eliX2oKIdKiAWBjZnr7nFWJtKC/om9m6YetHgNjXIQw2EaX+UbTVF/cCTM
 tI2leT43NDgQMr6FGvf4WP1XNNuV/YVgKadlfOeq/rLQyoJpLhjCXWZDA08=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeremy,

> Jeremy Linton <jeremy.linton@arm.com> hat am 10. Januar 2019 um 00:55 geschrieben:
> 
> 
> Arm64 machines should be displaying a human readable
> vulnerability status to speculative execution attacks in
> /sys/devices/system/cpu/vulnerabilities 
> 
> This series enables that behavior by providing the expected
> functions. Those functions expose the cpu errata and feature
> states, as well as whether firmware is responding appropriately
> to display the overall machine status. This means that in a
> heterogeneous machine we will only claim the machine is mitigated
> or safe if we are confident all booted cores are safe or
> mitigated.
> 

i applied this v3 series and Marc's v2 series.

Now i'm getting the following on a Raspberry Pi 3 B+ :

meltdown:Not affected
spec_store_bypass:Not affected
spectre_v1:Mitigation: __user pointer sanitization

So the entries l1tf and spectre_v2 disappeared.

Stefan
