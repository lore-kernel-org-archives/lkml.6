Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754587AbeEaKwW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 06:52:22 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44410 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754464AbeEaKwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 06:52:20 -0400
X-Google-Smtp-Source: ADUXVKLqRxsSxSaiJz/EE5T0q7Z0Vg/PMqX3mA8JjUivjwcOJJMljZYP4+3Mw+sqCNRZeVN93045dw==
Date: Thu, 31 May 2018 19:52:15 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Maninder Singh <maninder1.s@samsung.com>
Cc: pmladek@suse.com, sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, a.sahrawat@samsung.com,
        pankaj.m@samsung.com, v.narang@samsung.com
Subject: Re: [PATCH 2/2] printk: make sure to print log on console.
Message-ID: <20180531105215.GF477@jagdpanzerIV>
References: <CGME20180531102246epcas5p2f1cbc6ff217172e12e2f78bb88eb4a7e@epcas5p2.samsung.com>
 <20180531102246epcas5p2f1cbc6ff217172e12e2f78bb88eb4a7e~zs5h59tMh2250222502epcas5p2S@epcas5p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531102246epcas5p2f1cbc6ff217172e12e2f78bb88eb4a7e~zs5h59tMh2250222502epcas5p2S@epcas5p2.samsung.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/31/18 15:49), Maninder Singh wrote:
> 
> This patch make sure printing of log if loglevel at time of storing
> log is greater than current console loglevel.
> 
> @why
> In case of async printk, printk thread can miss logs because it checks
> current log level at time of console_unlock.

Upstream printk has no printing kthread. And we also run
printk()->console_unlock() with disabled preemption.

	-ss
