Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753170AbeCFCx4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 21:53:56 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:44563 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752866AbeCFCxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 21:53:55 -0500
X-Google-Smtp-Source: AG47ELtqLCfALdbVYWhp/BihaH6aCqFBxizbKCZtdjAdbZSrBohY3N4KqMmUIft9h/i37QbMK8G1Ng==
Date: Tue, 6 Mar 2018 11:53:50 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "Qixuan.Wu" <qixuan.wu@linux.alibaba.com>,
        linux-kernel-owner <linux-kernel-owner@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>, Jan Kara <jack@suse.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "chenggang.qin" <chenggang.qin@linux.alibaba.com>,
        caijingxian <caijingxian@linux.alibaba.com>,
        "yuanliang.wyl" <yuanliang.wyl@alibaba-inc.com>
Subject: Re: Would you help to tell why async printk solution was not taken
 to upstream kernel ?
Message-ID: <20180306025350.GD6713@jagdpanzerIV>
References: <1eb584e2-a479-46dd-8a25-820da7a34e85.qixuan.wu@linux.alibaba.com>
 <20180304130151.GA483@tigerII.localdomain>
 <af2c3824-c122-4496-a876-9b03af60c429.qixuan.wu@linux.alibaba.com>
 <20180304104324.6bbbaa53@gandalf.local.home>
 <20180305021416.GA6202@jagdpanzerIV>
 <20180305154524.2056b773@gandalf.local.home>
 <20180306020026.GB6713@jagdpanzerIV>
 <20180305214701.7434d030@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305214701.7434d030@gandalf.local.home>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/05/18 21:47), Steven Rostedt wrote:
[..]
> At this moment all watchdogs are working fine. And the continuing will
> be done as if it was the first printk. No lockup eminent.
> 
[..]

> So basically, the CPU is just printing what that CPU is printing. It
> only becomes an issue if the system has an issue (one CPU spamming
> printk). Which is another bug.
>
[..]

> Which is another issue as well. But this is due to issues with printk
> having issues, and is a different category of bug.
> 
> #2 and #3 are more recursive bugs and not a "printk locks up due to
> other CPUs" kind of bug.

Yes. My point was that "CPU can print one full buffer max" is not
guaranteed and not exactly true. There are ways for CPUs to break
that O(logbuf) boundary.

	-ss
