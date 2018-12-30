Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6BAC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 11:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA7E20866
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 11:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="cwV7lJh+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbeL3Lej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 06:34:39 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50228 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeL3Lej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 06:34:39 -0500
Received: by mail-wm1-f68.google.com with SMTP id n190so21913573wmd.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 03:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=c9KG5owWNPdBn7AYfRPUjZUIbVn9OuA4tUdeEItY8O0=;
        b=cwV7lJh+uu+lBmMsGzTiHe8Dua3oPYrf8GrPFCzERh0uYKWKGLGxaN0+VoXreglmac
         GKAQu+O74pE/JfAgrDp9Swxb9wZsBKNlQmWsbGx82cmqas9WnRoFtc22gzyH4jJ95HUg
         eQEaZ2dJ7GX//QTdp3ZcwVz38xdLm/uRonC00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c9KG5owWNPdBn7AYfRPUjZUIbVn9OuA4tUdeEItY8O0=;
        b=V4E6yWhyEq7y6eYCpCa5DX2nVCvhshOd9vgReh4w6QoT3lI9fzm9cCHBO44LMNOWd+
         nojXZJqKlS4EBa1QsKJr9JRU4Z+TIeGbfuKWeBhKaXFeSZP5S6PE0/72Lv5ozcpAsFTQ
         VdsO6p6an/uoGMYq+gkSS+QnfZ+TpjA+IwC+g2cEWTUUEmG41NIanBayI1Yqx185DBBo
         Fh4DjGQZoTh2pT8zY1ulUJF7aKJU3JIg2cERCaYLPwZWHYolW+6H7VIlXi3nwmffreCW
         IA+sSl8GrehylHxWLboEn0maIFGTbVK8VpLqQAmZytSMDGda2qzVT3rGsQnCiqt9dbB+
         oZpA==
X-Gm-Message-State: AJcUukfggYi+j5K79d+ek+1P1t9xFADj4QuiU10kitO34+Xxj61K7Dzh
        Ncs3Of7jwRAQtmPlwEvFNnidmA==
X-Google-Smtp-Source: AFSGD/WVmzgrSvK1o/cJ/pp2K0c9Eia6iFElRw3v2y/hTMYG844kU4Bf0qagyJ3NedF0Aelt1LHi4g==
X-Received: by 2002:a1c:ce0e:: with SMTP id e14mr27605907wmg.53.1546169677565;
        Sun, 30 Dec 2018 03:34:37 -0800 (PST)
Received: from [192.168.0.107] (95-42-17-99.ip.btc-net.bg. [95.42.17.99])
        by smtp.gmail.com with ESMTPSA id d11sm2028951wrw.25.2018.12.30.03.34.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Dec 2018 03:34:35 -0800 (PST)
Subject: Re: general protection fault in fdb_find_rcu
To:     syzbot <syzbot+017b1f61c82a1c3e7efd@syzkaller.appspotmail.com>,
        bridge@lists.linux-foundation.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        roopa@cumulusnetworks.com, syzkaller-bugs@googlegroups.com
References: <0000000000004e8a91057e355803@google.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <663bc6d0-f6ec-796d-54bb-b9afa3c0bce1@cumulusnetworks.com>
Date:   Sun, 30 Dec 2018 13:34:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <0000000000004e8a91057e355803@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/12/2018 06:01, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    90cadbbf341d Merge git://git.kernel.org/pub/scm/linux/kern..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1745c69b400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9d41c8529d7e7362
> dashboard link: https://syzkaller.appspot.com/bug?extid=017b1f61c82a1c3e7efd
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15babaab400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c6142d400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+017b1f61c82a1c3e7efd@syzkaller.appspotmail.com
> 

Ah yes, good catch. We've missed this obvious bug during the review.
A patch is on its way, just need to run a few tests.

Cheers,
 Nik

