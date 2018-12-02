Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C44C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8E320892
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELt5wVQM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8E320892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbeLBUTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 15:19:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:57908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbeLBUTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 15:19:44 -0500
Received: from localhost (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 720A7206B7;
        Sun,  2 Dec 2018 20:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543781981;
        bh=KVEuoduhQ63J647sZc0DXo7xJAkvRQoX8ARFzl2A1Z4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ELt5wVQMsyekX9AV4h8PQv2Q2UwZsmc/d6K3fCK9X7P/bGZKAGF6cGIinQGv7vwPs
         p2OQmBgh32RtbGzyL/7CqrXeYQliJ/XNLCf+YTRAwZhyYr8Cq5EQlpvrl6WezNAE6i
         eA1y3meXAUYBDbdLQN4CkDXh1b2hdTjixIHrrA5A=
Date:   Sun, 2 Dec 2018 15:19:36 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Tigran Aivazian <aivazian.tigran@gmail.com>
Cc:     gregkh@linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+71c6b5d68e91149fc8a4@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH 4.19.6] BFS: static inode bitmap and extra sanity checking
Message-ID: <20181202201936.GA235790@sasha-vm>
References: <20181129135921.231283053@linuxfoundation.org>
 <20181129135922.602882966@linuxfoundation.org>
 <CAK+_RLmVyVzL3G6++xOxfyEqEHL=bfZZx_Yj-TFNf5a7_oUoXw@mail.gmail.com>
 <20181129160722.GA31919@kroah.com>
 <CAK+_RLnbpu+nYsr8sVpHBVUcATDbqQoeH=+tu=tK1EKTHk6L9A@mail.gmail.com>
 <20181129171038.GA4651@kroah.com>
 <CAK+_RLk4cxamNasZyvLRunR23CTR-fASvF3=Ryt9WGeFoBVtqQ@mail.gmail.com>
 <CAK+_RLmt0ba_ARo+SrOGJph-SPn3kBRybRqncki=Oqz1TcF21Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAK+_RLmt0ba_ARo+SrOGJph-SPn3kBRybRqncki=Oqz1TcF21Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2018 at 06:57:10PM +0000, Tigran Aivazian wrote:
>Hello,
>
>Please find a patch attached which contains the following changes:
>
>1. Simplifies inode bitmap allocation by making it static.
>2. Supersedes the changes to BFS that went into 4.19.6 with stronger checking.
>3. Other changes are trivial (like whitespace cleanup, warning messages etc).
>
>Fully tested under 4.19.6 kernel.

No part of this patch is upstream yet. We can't take anything that is
not in Linus's tree.

It should also not contain anything that isn't strictly a fix, that
means no whitespace cleanups and such. Please break it into multiple
patches when you send it upstream.

--
Thanks,
Sasha
