Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752738AbeCDNB6 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 08:01:58 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:41977 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752566AbeCDNB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 08:01:56 -0500
X-Google-Smtp-Source: AG47ELsylacARrQXChMq6Xqvvf7BkB/2oPtPLARPJjN428bQ+4nPCDTGDW9XBuP89MjrfBn/TpWReg==
Date: Sun, 4 Mar 2018 22:01:51 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: "Qixuan.Wu" <qixuan.wu@linux.alibaba.com>
Cc: Petr Mladek <pmladek@suse.com>, Jan Kara <jack@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: Would you help to tell why async printk solution was not taken
 to upstream kernel ?
Message-ID: <20180304130151.GA483@tigerII.localdomain>
References: <1eb584e2-a479-46dd-8a25-820da7a34e85.qixuan.wu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1eb584e2-a479-46dd-8a25-820da7a34e85.qixuan.wu@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc-ing Steven

On (03/04/18 20:10), Qixuan.Wu wrote:
>    Hi Sergey, petr, and Jan,
>      I find you wrote a patch set of "[PATCH v12 0/3] printk: Make printk()
>    completely async"(https://lkml.org/lkml/2016/5/13/275), and many people
>    have reviewd. But I did not see them be taken to upstream kernel. Would
>    you please help to tell me the reason ? Is it just only because of the
>    LOG_CONT scenario (4th patch) ?

Hello,

	Thanks for your email, we desperately need more feedback from
people who are facing printk() related issues. While, certainly, I'm not
happy to hear that printk() causes troubles on your side.

	Regarding the async printk patch set. It's still "work in
progress", and probably will take some time (due to various reasons,
LOG_CONT is not one of them).

>      Anyway, now we also face the same problem, many CPU are printking at
>    the same time, but the poor one takes the lock and printk to console for
>    long time. Would you please help to tell does anybody are writing some
>    solution and try to fix this ?

	Yes. 4.16 has Steven's patch which tweaks printk() in a very smart
way and addresses some of the issues printk() has. If you can't test 4.16
(quite possible), then the commits you'd want to take a look at are
(Linus's tree):

 dbdda842fe96f89  printk: Add console owner and waiter logic to load balance console writes
 c162d5b4338d72d  printk: Hide console waiter logic into helpers
 fd5f7cde1b85d4c  printk: Never set console_may_schedule in console_trylock()
 c14376de3a1befa  printk: Wake klogd when passing console_lock owner

If you can backport those, test and tell us about your experience - would be
great and very much appreciated.

	-ss
