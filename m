Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0590AC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 05:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8DD021738
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 05:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NpKKOH5n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfAJFxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 00:53:39 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:34345 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbfAJFxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 00:53:39 -0500
Received: by mail-yb1-f194.google.com with SMTP id w186so3094319ybg.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 21:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vLElFRyIcUvvx4RziwEI+XY+P+q4djNY2jdC1xfWvCw=;
        b=NpKKOH5nook8Z9YjK7LypJawLMCyczbGcAVgjM8C6EsG0sOmoTTejfx4YEcpZnB0IU
         ILOZcfMzvVbJSco7xqeIy7JNO0FJhnQjfa8fTWK5o3usgSiELfTgJ7X8INpiXMtBlT4s
         L2RFedJEJcHmL5PHDmezhFBmWhdnqVSpfgjoad8q7CkQHfOfRBbs6YtcHzHBSHYzikF1
         oKIS/0UDrCZFASYZcqfivHOIcPa1n3A5E+7Vi+TLsbLDgnFrYERMClRe9ZspMRFxVm6o
         a6UVjf+qNWv0VHZAcbn36UxbYm8cTjlGBQnP42vPR9CQ90Io+2Vbd0VOGR9zefeEJQ7I
         kDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vLElFRyIcUvvx4RziwEI+XY+P+q4djNY2jdC1xfWvCw=;
        b=JwjTRTNVN8qK+gZ/5aEfPhGNkoTYFx7d3nn+MkP+UkB9y1JQheBy9OBl6U6z6fWz4/
         kgeAkKucRqbQDZZQe31JIkLWni8rnACTfsm9f1SyAMzn4+s6lPzq8QplThF6zMcIBMvp
         3qrfZGBP9BrqkZWIfMZo1s4U5uFu7dNBS/LW2qklPToAcvf2qp1Bqq66D2x8zIvBUksn
         BOGQHXl7JTXZkstyJytvm5C/PO6iiJvzmXDT5bRtkZX5ywtSvMza39OMWmlR5XtIkjiJ
         M6JGEhHAia3Un7wVZlSfHRp5crX/IYDoV2kQInK4h+ouAMv4YrlFPK5UGpS3LwHpQSHj
         0BFg==
X-Gm-Message-State: AJcUukdxlLw0lCzCvilyDAhKEYkoMBXTAuC8vxZdxP8yuHKTAxfuWOvj
        lvZZU4NWQYxIJ5De87zHi4dZPYW++cInlzP4SMWyPQ==
X-Google-Smtp-Source: ALg8bN4W+igM6CnjW3opAi59a6C+JT4U1TFKQig0J4U+HZJnkbSg7EFR2Wzo2cG4MS8OhaUDE7TQMFKxgfebUGpjnNU=
X-Received: by 2002:a25:ca08:: with SMTP id a8mr8323890ybg.127.1547099617584;
 Wed, 09 Jan 2019 21:53:37 -0800 (PST)
MIME-Version: 1.0
References: <CAA85sZt=Q4b_tn_vDx3g1ap7GNrXsHQk7Jki1T+zPbqVot90jg@mail.gmail.com>
In-Reply-To: <CAA85sZt=Q4b_tn_vDx3g1ap7GNrXsHQk7Jki1T+zPbqVot90jg@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 9 Jan 2019 21:53:26 -0800
Message-ID: <CANn89iLkciYGn7GyKc2QitSjjTms58_GKFqjOJ=6G8wEFi=SJA@mail.gmail.com>
Subject: Re: [BUG] moving fq back to clock monotonic breaks my setup
To:     ian.kumlien@gmail.com, netdev <netdev@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 4:48 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
>
> Hi,
>
> Just been trough ~5+ hours of bisecting and eventually actually found
> the culprit =)
>
> commit fb420d5d91c1274d5966917725e71f27ed092a85 (refs/bisect/bad)
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Fri Sep 28 10:28:44 2018 -0700
>
>     tcp/fq: move back to CLOCK_MONOTONIC
>
> [--8<--]
>
> So this might be because my setup might be "odd".
>
> Basically I have a firewall with four nics that uses two of those nics
> to handle my normal
> internet connection (firewall/MASQ/NAT) and the other two are assigned
> to one bridge each.
>
> The firewall is also my local caching DNS server and DHCP server,
> which is also used by the VM:s...
> But with 4.20 DHCP replies disappeared before entering the bridge - i
> couldn't even see them in
> tcpdump! (all nics are ixgbe on a atom soc)
>
> I'm currently running a kernel with that patch reversed but I'm also
> wondering about possible ways
> forward since I'm reverting a fix from someone else...

I suggest you use netdev@ mailing list instead of lkml

Then, we probably need to clear skb->tstamp in more paths (you are
mentioning bridge ...)

See commit 8203e2d844d34af247a151d8ebd68553a6e91785 for reference.

Can you try :

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 5372e2042adfe20d3cd039c29057535b2413be61..bd4fa141420c92a44716bd93fcd8aa3d3310203a
100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -53,6 +53,7 @@ int br_dev_queue_push_xmit(struct net *net, struct
sock *sk, struct sk_buff *skb
                skb_set_network_header(skb, depth);
        }

+       skb->tstamp = 0;
        dev_queue_xmit(skb);

        return 0;

Thanks.
