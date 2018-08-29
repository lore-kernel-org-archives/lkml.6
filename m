Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857DFC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E48205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iBJXHrsf";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UY/w9u6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E48205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbeH2TSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 15:18:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60640 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbeH2TSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 15:18:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1C6F06044E; Wed, 29 Aug 2018 15:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535556048;
        bh=74FzjhQYDLXeqiIvtoRf5NqPnRVyy42NAMxEXaFlWPw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=iBJXHrsf8rQ+fznOqQWF1xS0Tvax8o9G67kKpylUzx4L0jTgcNqrmNU4vP/p2wyn4
         23wNwjIJoKPpn0riIdMFJNAnVUHV88/Kobcww5dPso8vMWEVejiChOG2+H/20oax09
         i3CTaG2o1qNnSN5otUSi5CL7MMsPsEzGGrByx588=
Received: from purkki.adurom.net (purkki.adurom.net [80.68.90.206])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 47F7760388;
        Wed, 29 Aug 2018 15:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535556047;
        bh=74FzjhQYDLXeqiIvtoRf5NqPnRVyy42NAMxEXaFlWPw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=UY/w9u6H6RipeuZhk7SxiSkmNepW+qAWB9TmFmjm3ppLkoRiHgFsrTExlfYMEiclP
         n1WYoZEg82Y99POh7/69qm63Tjat2nFyRHeKJQ5gx8rikmcvXbI9ZpkaHoM/jDwisF
         lWCgY4oqRivfC35L+ZMhfltXl3xq3CpKZ1SrFIpw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 47F7760388
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Dave Young <dyoung@redhat.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Intel Wireless 8265/8275 (rev 78) issue
References: <20180829065442.GA3488@dhcp-128-65.nay.redhat.com>
Date:   Wed, 29 Aug 2018 18:20:44 +0300
In-Reply-To: <20180829065442.GA3488@dhcp-128-65.nay.redhat.com> (Dave Young's
        message of "Wed, 29 Aug 2018 14:54:42 +0800")
Message-ID: <87bm9ltd0z.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Young <dyoung@redhat.com> writes:

> Not sure if this is a known issue, I'm seeing this with latest mainline
> kernel on Fedora rawhide.
>
> The wireless networking is not stable, I can not access network any more after
> downloading some big files or just browsing some web pages about some
> time.  I do not see this when I work in office.  So this maybe relate to
> wireless router.
>
> "Can not access network" means ping timeout, can not open web pages etc.
> But the wireless connection looks normal at least from the
> NetworkManager icon it is still connected.
>
> The router I used at home is an old ASUS WL520gc.  I can confirm I can
> reproduce this with another ASUA router WL-500gP v2 
>
> My laptop model is Thinkpad T480s.  It is painful I can only use
> wireless,  any hints how to make it work will be appreciated!

Not everyone use Fedora so providing info which kernel versions work and
which don't would help. Does Fedora usually add their own patches/hacks
to kernel or is it a stock release from kernel.org? Also have you
verified that this isn't a problem in user space, for example by
downgrading the kernel to an older version?

-- 
Kalle Valo
