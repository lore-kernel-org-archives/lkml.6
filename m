Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6340AC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74F5208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FX/aQtQz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E74F5208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbeJEV6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:58:05 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35478 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbeJEV6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:58:04 -0400
Received: by mail-qk1-f195.google.com with SMTP id v68-v6so1068294qka.2;
        Fri, 05 Oct 2018 07:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0d9EFpe84FWSO06SrTvE6byMS5RJi7bikEbiiCe+uXk=;
        b=FX/aQtQzifkMDsPwEE6fWGL40nrT0cnCwcdy7pCYyHxE74ZKEkOSlQ5rOLxPQdEb4O
         ukm8vqtMQvDaZKhqquEvGaUdw9KRYvBQM/swtpS9Z7WdzJgPjuv/NkfOnYlorha0tLsO
         rhk0vXzRviybyAyrM6r/X+37YPsknIL7dkxLHQUxKtitOqoBVwOoumacaIbe3eFK0s1g
         AQk8XtT2eOyQrOcEdMrD5RzTA4f8pSrf5r81Tm20EMXnZizq3qBX17YadMm+Xs6vPFq1
         YGvsBAowaeQaL6eiX7wQRRJHg9uR+j4dijBpMf3EaZ6gzL5UUdY+UChX+/WjBP6CmNR3
         tIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0d9EFpe84FWSO06SrTvE6byMS5RJi7bikEbiiCe+uXk=;
        b=UwuWSyZF5Z7YdIKI3GjZaKmN17bAal5VIU4SelJ0SEAeMpEn5bQ0+tNMhXFCRbXvS7
         VEreCPbI6ZoWPXnu+p9PQIh4QyUDAg1fTBSEKIbutAu6kHT6lTH+aE5CgFSN+DCJH3Oo
         bRlH6InWxsYQSHyhpeAdHby/jSvYpGcNkwcQ8NCeOR9BkwO31AuPkKht7nciue5I6E9N
         RaRIGDeMi6rD467cqlz0s/SuApdQ66jgZh7aBb1TGXH9FDibZSmd/Xe8ZgydaQwEFtXQ
         dmAMGmyM0Ig0wW+0i6yNCaoY+mjy+Hr8ESNVeZVwPod8ba8Mn+CqontU9XSEt8lGTP+a
         4gvQ==
X-Gm-Message-State: ABuFfohtS0RwTKzklPeHNhqS7DRETbQHmqD6Cuqx/ckeWvNG7AhdOUuZ
        J56jfONF1/sN7HAzKNdcU866jeTV
X-Google-Smtp-Source: ACcGV604Zz7Fv4UuPGE5rVatqMqHRrDWbVpxc7aSqrvCvEiEJAYgxJvmNtMS+FP/M+Jm/WHE4kSJag==
X-Received: by 2002:ae9:e20b:: with SMTP id c11-v6mr9020106qkc.220.1538751539160;
        Fri, 05 Oct 2018 07:58:59 -0700 (PDT)
Received: from localhost.localdomain ([168.181.50.235])
        by smtp.gmail.com with ESMTPSA id 144-v6sm4102564qkk.63.2018.10.05.07.58.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 07:58:58 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 36367180EDD; Fri,  5 Oct 2018 11:58:55 -0300 (-03)
Date:   Fri, 5 Oct 2018 11:58:55 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     syzbot <syzbot+c7dd55d7aec49d48e49a@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
        nhorman@tuxdriver.com, syzkaller-bugs@googlegroups.com,
        vyasevich@gmail.com
Subject: Re: KASAN: use-after-free Read in sctp_id2assoc
Message-ID: <20181005145855.GB6761@localhost.localdomain>
References: <0000000000007e767d05776336da@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000007e767d05776336da@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 01:48:03AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    4e6d47206c32 tls: Add support for inplace records encryption
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13834b81400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e569aa5632ebd436
> dashboard link: https://syzkaller.appspot.com/bug?extid=c7dd55d7aec49d48e49a
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+c7dd55d7aec49d48e49a@syzkaller.appspotmail.com
> 
> netlink: 'syz-executor1': attribute type 1 has an invalid length.
> ==================================================================
> BUG: KASAN: use-after-free in sctp_id2assoc+0x3a7/0x3e0
> net/sctp/socket.c:276
> Read of size 8 at addr ffff880195b3eb20 by task syz-executor2/15454
> 
> CPU: 1 PID: 15454 Comm: syz-executor2 Not tainted 4.19.0-rc5+ #242
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
>  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>  sctp_id2assoc+0x3a7/0x3e0 net/sctp/socket.c:276

I'm not seeing yet how this could happen.
All sockopts here are serialized by sock_lock.
do_peeloff here would create another socket, but the issue was
triggered before that.
The same function that freed this memory, also removes the entry from
idr mapping, so this entry shouldn't be there anymore.

I have only two theories so far:
- an issue with IDR/RCU.
- something else happened that just the call stacks are not revealing.

