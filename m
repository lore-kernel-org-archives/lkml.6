Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753097AbeCFDQt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 22:16:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:58452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752756AbeCFDQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 22:16:48 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65273206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 5 Mar 2018 22:16:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: "Qixuan.Wu" <qixuan.wu@linux.alibaba.com>,
        linux-kernel-owner <linux-kernel-owner@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>, Jan Kara <jack@suse.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "chenggang.qin" <chenggang.qin@linux.alibaba.com>,
        caijingxian <caijingxian@linux.alibaba.com>,
        "yuanliang.wyl" <yuanliang.wyl@alibaba-inc.com>
Subject: Re: Would you help to tell why async printk solution was not taken
 to upstream kernel ?
Message-ID: <20180305221644.6946fa99@gandalf.local.home>
In-Reply-To: <20180306025350.GD6713@jagdpanzerIV>
References: <1eb584e2-a479-46dd-8a25-820da7a34e85.qixuan.wu@linux.alibaba.com>
        <20180304130151.GA483@tigerII.localdomain>
        <af2c3824-c122-4496-a876-9b03af60c429.qixuan.wu@linux.alibaba.com>
        <20180304104324.6bbbaa53@gandalf.local.home>
        <20180305021416.GA6202@jagdpanzerIV>
        <20180305154524.2056b773@gandalf.local.home>
        <20180306020026.GB6713@jagdpanzerIV>
        <20180305214701.7434d030@gandalf.local.home>
        <20180306025350.GD6713@jagdpanzerIV>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Mar 2018 11:53:50 +0900
Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:


> Yes. My point was that "CPU can print one full buffer max" is not
> guaranteed and not exactly true. There are ways for CPUs to break
> that O(logbuf) boundary.

Yes, when printk or the consoles have a bug, it can be greater than
O(logbuf).

-- Steve
