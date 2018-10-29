Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867E1C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4574420870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RH1cNrr6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4574420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbeJ3CfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:35:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbeJ3CfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:35:00 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A63A22080A;
        Mon, 29 Oct 2018 17:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540835121;
        bh=9jnjpqdkmmVYhR3OAGNlh5vZeGI0JEtXyDuBjW7V8Mo=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=RH1cNrr6/ZIX16Xnu+QqUzhA8CgGl5woC2RaCEXF5RnLf+4E/w+C4TsqpzUHUGx2R
         IoseNSEycNUxPcrlEAbh10/UY1UgEAIy1vuV1mNDG90whR4r9lag1mXwL94szAOLDC
         0w6uHMxy6xZCeE78jMiOv0aWQo2SPiwIoLgzyrKw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Dean Wallace <duffydack73@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181025232517.ywnw54qibemosjws@picard>
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        stable@vger.kernel.org, Johannes Stezenbach <js@sig21.net>,
        Carlo Caione <carlo@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20181025232517.ywnw54qibemosjws@picard>
Message-ID: <154083512089.98144.9141070901932719147@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: Regression found (Stop-marking-clocks-as-CLK_IS_CRITICAL)
Date:   Mon, 29 Oct 2018 10:45:20 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dean Wallace (2018-10-25 16:25:17)
> I have found a regression in 4.18.15 that means I lose sound on my old
> Toshiba Chromebook 2 (Swanky).  My system details are:-
> =

> Toshiba Chromebook (Swanky)
> MrChromebox UEFI coreboot
> Arch Linux running latest alsa/pulseaudio
> =

> Upgraded kernel from 4.18.14 to 4.18.15 and lost all sound output.  By
> output I mean, the card is still detected, the module loaded, all apps
> showing sound is being playing, but no actual audible sound comes
> through.  Upgraded to 4.18.16 same issue.
> =

> Dug around and found Upstream commit 648e921888ad96ea3dc922739e96716ad322=
5d7f
> clk: x86: Stop marking clocks as CLK_IS_CRITICAL
> "This commit removes the CLK_IS_CRITICAL marking, fixing Cherry Trail
> devices not being able to reach S0i3 greatly decreasing their battery
> drain when suspended."
> =

> I reverted it and compiled 4.18.16 and have sound back again.  Could
> this be looked into, with possibility of fix.
> =


Thanks for the bug report. I'm adding some people involved in the commit
you mention is causing audio regressions. The best plan is to probably
revert the commit from the 4.18 linux stable tree. Or there may be
another patch missing that would be useful to make this backported patch
work. Hopefully Hans or Andy knows.

