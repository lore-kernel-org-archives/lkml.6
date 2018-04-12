Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752637AbeDLGkd convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 02:40:33 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:56096 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751993AbeDLGkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 02:40:32 -0400
From: Richard Weinberger <richard@nod.at>
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com
Subject: Re: [PATCH] um: Fix return value of start_idle_thread
Date: Thu, 12 Apr 2018 08:40:30 +0200
Message-ID: <9086376.yYHLv4WMPf@blindfold>
In-Reply-To: <20180329204559.14113-1-richard@nod.at>
References: <20180329204559.14113-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 29. März 2018, 22:45:59 CEST schrieb Richard Weinberger:
> While the function will never returns, gcc will warns.
> Add a return statement to make gcc happy.
> Before f44f1e7da7c8 we never noticed because gcc knows that longjmp does
> not return.
> 
> arch/um/os-Linux/skas/process.c: In function ‘start_idle_thread’:
> arch/um/os-Linux/skas/process.c:613:1: warning: control reaches end of non-void function [-Wreturn-type]
> 
> Fixes: f44f1e7da7c8 ("um: Avoid longjmp/setjmp symbol clashes with libpthread.a")
> Signed-off-by: Richard Weinberger <richard@nod.at>

Applied.

Thanks,
//richard
