Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8979AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AEE2206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLysX9pa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AEE2206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeK2M7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 07:59:39 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36652 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbeK2M7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 07:59:38 -0500
Received: by mail-pl1-f195.google.com with SMTP id g9so190668plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 17:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qr2QPBN9+M8D2nnxo3IU9qM3RYncx0uOQsj+iud9jRI=;
        b=YLysX9paHUXy9XjK+BSv7kTipiJz4t6JthFPfNa8Pyyk293p+zn2LwBa3eqaYlALcA
         AisYSGvMDHzhs3ymlSkl7vcJ6SbeHUTrRbkJDWyL7zn9WOk+ZCQkAZfunEK4fZi54lhs
         EiVkuD3NH0e+85QhIaNOzFlTJDC6gVyOkZ/bgh5tDWuHdKABXjrDzZz7aMJEVzQuXCgz
         hIw+/dXOeluBiGRBGsbccXZG6g6XamJjnlmWYFhyHkc/L2Ol2WMCy0s/sW+ucxNY4Vot
         Vz2QNztID/g0VqSXmIMkWdAEg0O9tNxMZTRM3wYd2fRC9HeDH9TbrFbvxvBW7l8TuSiw
         I0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qr2QPBN9+M8D2nnxo3IU9qM3RYncx0uOQsj+iud9jRI=;
        b=qvWrEVWIsvfyayYuqY6DudZBBG+vX1o3VjI3E0WmK6c+bagfHeSvk4TiXrLARy/BU7
         QnmeDwjgyazFnBYaNA16ZGY4c6//fYZp5Sz9Ytla7M+N377bzNskTHUvqNC0TkxXKie7
         y+yPqx3peNq7YOFeeaHPeorNAxUP73rTdFXqTTdwZUZExhhD9MGi+jlL/9cH6XDZNa5P
         mnE5seZm5+k3A3Pdq+HZQuUAcSm7MiYARqwFmw8ZqLwViynNoqLiu0kmgHs7fck1Fmt4
         AzYdjvAdg87p30/5oqUvcoikAyVnXD8TTSSI+tgWKMn3g6421DbSWewiF5zpN3nrHdpm
         5dHw==
X-Gm-Message-State: AA+aEWZlDiI9yIljEXJm5RhTFs4jE3i1nFVk6v/XrICuym5wUIPGDoOg
        E8NgIg73+/AUjYkoyF1wxGvoiSLFcBE=
X-Google-Smtp-Source: AFSGD/X7XuXujziPs7H8ReoekbVfE1/vLjQLJThUbUdYvycDZ+yR1aqaOM4NQITvGsMT94AoyIO6ug==
X-Received: by 2002:a17:902:d905:: with SMTP id c5mr38400712plz.43.1543456558844;
        Wed, 28 Nov 2018 17:55:58 -0800 (PST)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id t87sm325524pfk.122.2018.11.28.17.55.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 17:55:57 -0800 (PST)
Date:   Thu, 29 Nov 2018 10:55:54 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH v3 7/7] zram: writeback throttle
Message-ID: <20181129015554.GC77327@google.com>
References: <20181127055429.251614-1-minchan@kernel.org>
 <20181127055429.251614-8-minchan@kernel.org>
 <20181128154141.d67b70957bc4833d9f0d6635@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128154141.d67b70957bc4833d9f0d6635@linux-foundation.org>
User-Agent: Mutt/1.10.1+60 (6df12dc1) (2018-08-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 03:41:41PM -0800, Andrew Morton wrote:
> On Tue, 27 Nov 2018 14:54:29 +0900 Minchan Kim <minchan@kernel.org> wrote:
> 
> > On small memory system, there are lots of write IO so if we use
> > flash device as swap, there would be serious flash wearout.
> > To overcome the problem, system developers need to design write
> > limitation strategy to guarantee flash health for entire product life.
> > 
> > This patch creates a new konb "writeback_limit" on zram. With that,
> > if current writeback IO count(/sys/block/zramX/io_stat) excceds

						   bd_stat
		
> > the limitation, zram stops further writeback until admin can reset
> > the limit.
> 
> I'm not really understanding this.  Does this only refer to suspending
> the idle page writeback feature?  Not all zram writeback, surely?

It aims for all zram writeback.

> 
> I don't think the documentation gives an administrator sufficient
> information to effectively use the feature.  Some additional discussion
> would help.  What sort of values should it be set to and why?
> 
> And what is the default setting?  And why?

Default setting is 0 so there is no limitation because we couldn't
expect user's workload of zram.

> 
> And the limit isn't persistent across reboots which makes me wonder
> whether the overall feature is particularly valuable?

Good point.
Keeping the value in persisten across reboot is userspace's role.

I will add this for admin
"
You could know how many of write happens since the system boot
via /sys/block/zramX/bd_stat's bd_writes.
If your backing device has wearout concern, you could limit the
writing via /sys/block/zramX/writeback_limit.

For instance, if the vaule you read bd_writes is 200, you could
set 300 to writeback_limit so upcomding 100 write be only allowed.
If you set the writeback_limit to lower value than current
bd_writes's value, zram allow further writeback without limit.

The value will reset when your system reboot so keeping how many
write happn until now across reboot is user's job.
"

