Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D1FC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE5B2157F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBR0Q7AR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE5B2157F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbeHXQ01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 12:26:27 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33719 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbeHXQ00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 12:26:26 -0400
Received: by mail-qt0-f195.google.com with SMTP id r37-v6so9987475qtc.0;
        Fri, 24 Aug 2018 05:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CthuRImC0h1A3KRUuB2C5Dt8azhMmnaQ8d+cPx6hFCA=;
        b=kBR0Q7ARNZhrCFVn3nOBG6rD2aSdgYO1TIOjlI7XZrRPm1S44EpubhmhKPdY5YrWd6
         /+8GWx2UxrabFN4tDvWRA5ZZATPXFGnvFE6yKO0aFEhkCehCqJ+ttkmErjXLBmoCYs+B
         wKMTtYK6rHlHTv7poBi+pec3kF+wbIQP8sbeB7oTM1wMlB7sOviCIf+VkbDLGET+T/6X
         ihn0bi0jHCVLLoT1bLTwbkhLrVV4lCtH3rZuQDA+6UV7H5mNlZ7mWnIS4zBxztPgLVJg
         1Vn56dKlkhKAod48V/YfrcPCsB0+hOepZbrqr1jLVmQLBuxniu14bznR2aJYi1tnnwEr
         IQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CthuRImC0h1A3KRUuB2C5Dt8azhMmnaQ8d+cPx6hFCA=;
        b=ZL1x6jqse6zwIZjZjS5Z5xyPvbVScw/k1KVqs+6j8nHiE5MPGjDRXR1rxZOMbhMY68
         KlhK7RaDh6jGuYILu8RaRTdxJd9BqHXXOcYH5KfGzBiu9wL4q5Ues70qsvmEWG7c6jtg
         fuAnt9T9RF34VNFA/W4PItSzNJ7xkVmC8ijGjA/2/dDu46kEQIMMjw/Tb3lekVo1FTo+
         vJ56P1NwOSLyZol9N+NFZ2MlJ09w2E9SBSw8BW7NOcApnoZ6FXZj13XOh4IwRZ3f97/N
         /RXYuNQDmeZUq+1x8Xsriy9jlBfqiUkAqcu4FxhxVZVexrm94isRmAIPwgtgGYiSoS0r
         rJ5Q==
X-Gm-Message-State: APzg51CrI3y6Nxk0oIhJoHYqXm5vvMkZj3CLbvA/hoJ0+CNu7Qd/XXRV
        H3bvv6aTplC++GGHQnwrdkIN3rKhB6I=
X-Google-Smtp-Source: ANB0VdaRdeCgr3EHlqHU4FV5kOWbzvyxTPmJgOsZqlj2Gk1FV70XibfhCNdWNtssSwv9TJMiREZpLg==
X-Received: by 2002:ac8:2fa4:: with SMTP id l33-v6mr1510998qta.83.1535115113753;
        Fri, 24 Aug 2018 05:51:53 -0700 (PDT)
Received: from localhost.localdomain ([177.220.172.126])
        by smtp.gmail.com with ESMTPSA id m5-v6sm4881526qkh.30.2018.08.24.05.51.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Aug 2018 05:51:52 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 5828C180E15; Fri, 24 Aug 2018 09:51:50 -0300 (-03)
Date:   Fri, 24 Aug 2018 09:51:50 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     syzbot <syzbot+fe62a0c9aa6a85c6de16@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
        nhorman@tuxdriver.com, syzkaller-bugs@googlegroups.com,
        vyasevich@gmail.com, lucien.xin@gmail.com
Subject: Re: KASAN: use-after-free Read in sctp_transport_get_next
Message-ID: <20180824125150.GL5311@localhost.localdomain>
References: <000000000000ccaf1d0574297b6b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000ccaf1d0574297b6b@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 12:40:03AM -0700, syzbot wrote:
> CPU: 1 PID: 12694 Comm: syz-executor0 Not tainted 4.18.0+ #107
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>  print_address_description+0x6c/0x20b mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.7+0x242/0x30d mm/kasan/report.c:412
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>  sctp_transport_get_next+0x11c/0x140 net/sctp/socket.c:5008
>  sctp_transport_get_idx net/sctp/socket.c:5022 [inline]

It is iterating over transports but then also accessing the
association directly, without checking any refcnts before that.

struct sctp_transport *sctp_transport_get_next(struct net *net,
					       struct rhashtable_iter *iter)
{
	struct sctp_transport *t;

	t = rhashtable_walk_next(iter);
	for (; t; t = rhashtable_walk_next(iter)) {
		if (IS_ERR(t)) {
			if (PTR_ERR(t) == -EAGAIN)
				continue;
			break;
		}

		if (net_eq(sock_net(t->asoc->base.sk), net) &&
		    t->asoc->peer.primary_path == t)
			break;

and these t->asoc->  are risky because transport may be laying dead on
the water already, as transports are freed by RCU and associations are
not.
