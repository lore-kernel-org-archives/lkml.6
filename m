Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEADC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 04:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99497264D8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 04:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leZqQJ8/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99497264D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751079AbeFZEWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 00:22:15 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35881 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750923AbeFZEWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 00:22:13 -0400
Received: by mail-pg0-f66.google.com with SMTP id m5-v6so7041108pgd.3;
        Mon, 25 Jun 2018 21:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=szF8TaYKotUnPfMK9dcCkI6FOs931Ofcy5Mcbo7b+X0=;
        b=leZqQJ8/kia35ohLpoE4Agsdz0MwafU18t7AernzByVkM+1MIS1raPjMa7d/OTkag5
         yp3rwot4VP9W1UrScKaY8gwVojDIWzUmN7lBj5MgteIa6OjHpZA0ktoZDhCiQbAJtOhT
         AKoM1/7dA/mmpME07hb7Q5GBSdRKT0SGxTyWPvt1XgdWM2bqQPGP7eVDn8C/G68CKrQu
         xTquhHgGgt2nlpl8IpIwwv2AVskeqvjgDxZjmRBlrafJRDVNLSPWqEXfrl5Y4u//1QqQ
         CW9cZEcq0CPM+qhV56tpDB5CXtDwF435K+46jfmIqWe0U5dsqVBkJDImq6Uvdxn8dwmj
         lzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=szF8TaYKotUnPfMK9dcCkI6FOs931Ofcy5Mcbo7b+X0=;
        b=Gp/C1wFvGIjIsromKOaJNoo3YI44oNY2fzKA/4aW3p8PnDKzDZfyUWp6ex2K/T8bTM
         HAIhfy57ejOXkUzjJjRU/6I/sPfxLyhdXUj3LFU6Rqsm6w218AEO2Tuytiqw2LCg7q5p
         JzfdMUmGXRv5yc2IN4RSBpxFMWssKaD4OldICv36DnX6yfaYGHmktdm50H4LxuaAzuCf
         IQOGvGZpy3hL83zArloBP7QILycGd+aV3p3/y0/LVICDh8U9c/0FiA0RgJp+SnTXwYZK
         bdTvyc1UzgVpxRTW3YFXQK5xm+XbVIjEI3QLNns7KvNKfgfioiKMfvENmZc+GyHaeFaA
         bGZQ==
X-Gm-Message-State: APt69E03XIDgltlyyZjZspt7xLdxJTxQoDuxM+2o1dfl/iS75uhNdUfO
        Uyp0cG+ala+jCW67tcfVWmg=
X-Google-Smtp-Source: ADUXVKJcm/aXC6lGzFBW/1lPK5suG3n9aiYRIm2KCQD/Ks6vI4USdNXk1ozxTTJ+k0Flh/rZJBp0eA==
X-Received: by 2002:a62:5c47:: with SMTP id q68-v6mr3640822pfb.81.1529986932845;
        Mon, 25 Jun 2018 21:22:12 -0700 (PDT)
Received: from localhost ([175.223.48.122])
        by smtp.gmail.com with ESMTPSA id f123-v6sm925536pfc.4.2018.06.25.21.22.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 21:22:11 -0700 (PDT)
Date:   Tue, 26 Jun 2018 13:22:08 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        syzbot <syzbot+d29d18215e477cfbfbdd@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, syzkaller-bugs@googlegroups.com,
        Samuel Ortiz <sameo@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: INFO: rcu detected stall in vprintk_emit
Message-ID: <20180626042208.GA31439@jagdpanzerIV>
References: <000000000000720530056f7f9b63@google.com>
 <20180626014924.GB11229@jagdpanzerIV>
 <20180625225937.43aee76c@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625225937.43aee76c@vmware.local.home>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/25/18 22:59), Steven Rostedt wrote:
> > Or ratelimited error reporting and cond_resched()
> > [that would be option B]:
> 
> I don't think this is a printk() issue per se, so I think Option B is
> the only option. You should not get stuck in an infinite loop if we run
> short on memory. Perhaps we could have an Option C which would exit
> this loop gracefully with some kind of error. But I haven't looked at
> the surrounding code to be sure if that is possible.

Agree. I like Option B - an endless loop is the root cause, at the same
time filling up logbuf with useless data is useless. Can't tell if Option C
is feasible, up to networking people.

	-ss
