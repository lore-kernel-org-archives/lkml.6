Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753281AbeCFIK4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 03:10:56 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:41852 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750730AbeCFIKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 03:10:54 -0500
X-Google-Smtp-Source: AG47ELtYq25evZXHEqWA58Tv5ZcOXOYZGHuAHW0AW+SXL6QM7OnCBXHCne+T0pFMLGAN/OzP+facTA==
Date: Tue, 6 Mar 2018 17:10:49 +0900
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
Message-ID: <20180306081049.GH6713@jagdpanzerIV>
References: <1eb584e2-a479-46dd-8a25-820da7a34e85.qixuan.wu@linux.alibaba.com>
 <20180304130151.GA483@tigerII.localdomain>
 <af2c3824-c122-4496-a876-9b03af60c429.qixuan.wu@linux.alibaba.com>
 <20180304104324.6bbbaa53@gandalf.local.home>
 <20180305021416.GA6202@jagdpanzerIV>
 <20180305154524.2056b773@gandalf.local.home>
 <20180306020026.GB6713@jagdpanzerIV>
 <20180305214701.7434d030@gandalf.local.home>
 <20180306025350.GD6713@jagdpanzerIV>
 <20180305221644.6946fa99@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305221644.6946fa99@gandalf.local.home>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/05/18 22:16), Steven Rostedt wrote:
> > Yes. My point was that "CPU can print one full buffer max" is not
> > guaranteed and not exactly true. There are ways for CPUs to break
> > that O(logbuf) boundary.
> 
> Yes, when printk or the consoles have a bug, it can be greater than
> O(logbuf).

OK. Now the question is - what is "a bug" in this case? Are those
printk-s really a bug? Consoles are very complex, with dependencies
on timers, networking, etc. having them appending more messages to
the logbuf is not very cool, but at the time the kernel does not
BUG_ON(), nor panic(); it moves on. It's printk()->console_unlock()
that turns it into lockup->panic(). Is the bug really in the consoles
then?

	-ss
