Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEC0C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 05:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744842650E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 05:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOKaLRVG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 744842650E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751298AbeFZFM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 01:12:27 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:44354 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750907AbeFZFM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 01:12:26 -0400
Received: by mail-pg0-f67.google.com with SMTP id b10-v6so3419728pgq.11;
        Mon, 25 Jun 2018 22:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uAKIHZXZYbRAAW53/5saTrZnS9wXHK6GV5lLJrJ8egI=;
        b=oOKaLRVGSbiUliqpHWcRTXdhAxsxW6lVWYT9xkwhJrIJWcmFvHwS6Yzhs8c+IMxNLq
         h5lVD+t3LN9CeEYd00wOVvh4gJQbCX8KfBB8gTxENQbLGroPdy+uSbbJuJp1UcpdLZE/
         AewUOR+v7Q5pbYuMnYAqJBAOsMjHgewuzHCiP5Cr71qdU2h9Mq3pahaoFrkZyFNZWrip
         Kkh736KsoTkZDqM/3wqtVadj2/vuv7TAkz3jF0CuvZEWNFNmz95pd44EYvZ9q+KzLZRE
         OWIPMFJSNq9ZoFNY0UFqZeHhBWOkvNeexBoY+gB3UFUOJTtErX88fZeL6XMN7MInDjk1
         h3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uAKIHZXZYbRAAW53/5saTrZnS9wXHK6GV5lLJrJ8egI=;
        b=ADagpomIOBgrBelf7MR/MZhj7VNnz4/TGNGMygQfvaIEBv098y/g1xfcnyJQ9PMDRp
         TJLeYCAESn9iFbCz7uojPtzIuJWIMGj1HkFcOThOhvJr23ifalEo3Ku8hjeJxrlfVdSC
         Abr7/nfIn1V9P7FCFlO5EZ1rtto4Ryp3QuhihLnlnK15Vz6Uo85Nw8MrIX/UkNSDpPc5
         ZLb7WJSaPvHqAsBDwJ750gwwNyYuJciOkRRwRZKKWh7sANi9N7Ksw1jJIVkq3xFQz3XD
         mhsWLUlZo+54hVi01bxrzPmMCfBJCoSOhGyLDVqLnnqi53jpAGlGEJda7lloSd/pOzgD
         xijQ==
X-Gm-Message-State: APt69E3n5Hj2UvhOOgGjMq4BGxz7laLxXpjGn4ixpe0m6p+kOvd7xApf
        IKpJjZTHlXwLdOuMp009e9o=
X-Google-Smtp-Source: AAOMgpcb0Bb60hFV4J+ddluGpTnefidwSyuTFiOIdI43ZjyyvjW4zXfZ6VX769rAZM9wklgcAy+y2g==
X-Received: by 2002:a65:5246:: with SMTP id q6-v6mr29506pgp.152.1529989945510;
        Mon, 25 Jun 2018 22:12:25 -0700 (PDT)
Received: from localhost ([175.223.48.122])
        by smtp.gmail.com with ESMTPSA id q10-v6sm964782pfj.7.2018.06.25.22.12.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 22:12:24 -0700 (PDT)
Date:   Tue, 26 Jun 2018 14:12:21 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-wireless@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+d29d18215e477cfbfbdd@syzkaller.appspotmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] NFC: llcp: fix nfc_llcp_send_ui_frame() lockup
Message-ID: <20180626051221.GC31439@jagdpanzerIV>
References: <20180626044119.30118-1-sergey.senozhatsky@gmail.com>
 <CACT4Y+ZvLqzEwXgdB25MrmAS_j2_HsS8NFaJaMojzMV3prXypg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZvLqzEwXgdB25MrmAS_j2_HsS8NFaJaMojzMV3prXypg@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/26/18 07:07), Dmitry Vyukov wrote:
[..]
> >  #include <net/nfc/nfc.h>
> > @@ -755,7 +756,8 @@ int nfc_llcp_send_ui_frame(struct nfc_llcp_sock *sock, u8 ssap, u8 dsap,
> >                 pdu = nfc_alloc_send_skb(sock->dev, &sock->sk, MSG_DONTWAIT,
> >                                          frag_len + LLCP_HEADER_SIZE, &err);
> >                 if (pdu == NULL) {
> > -                       pr_err("Could not allocate PDU\n");
> > +                       pr_err_ratelimited("Could not allocate PDU\n");
> > +                       cond_resched();
> >                         continue;
> >                 }
> 
> 
> But this thread is still in an infinite (unkillable?) loop? If yes, we
> are waiting for the next syzbot report ;)

The loop is still infinite, correct, but we have a preemption point now.
Sure, net people can come with a much better solution, I'll be happy to
scratch my patch.

	-ss
