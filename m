Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751721AbeECKCs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 06:02:48 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48131 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751141AbeECKCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 06:02:43 -0400
Date: Thu, 3 May 2018 12:02:41 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: dwmw2@infradead.org,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
Subject: Re: [PATCH v2] mtd: chips: Replace printk() with pr_*()
Message-ID: <20180503120241.4b2d5010@bbrezillon>
In-Reply-To: <20180324163145.GA472@seema-Inspiron-15-3567>
References: <20180324163145.GA472@seema-Inspiron-15-3567>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Mar 2018 22:01:45 +0530
Arushi Singhal <arushisinghal19971997@gmail.com> wrote:

> Using pr_<loglevel>() is more concise than printk(KERN_<LOGLEVEL>).
> This patch:
> * Replace printks having a log level with the appropriate
> pr_*() macros.
> * Indent the code where possible.
> * Remove periods from messages.
> 
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> ---
> changes:
> Before printk() is changes to dev_*macro(), but it was not good idea
> because mtd->dev is only initialized after mtd_device_register() is called.
> 
>  drivers/mtd/chips/cfi_cmdset_0001.c | 130 +++++++++++++++++++-----------------

I see printk(KERN_ ...) in other files inside this directory. This
should be fixed too.
