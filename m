Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbeFAImn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 04:42:43 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:31600 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbeFAImj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 04:42:39 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180601084237epoutp040117d55900a8fb2cc101d12a9d6a4e8e~z-LX67NDt0259502595epoutp04F
X-AuditID: b6c32a4a-abdff70000001139-52-5b1106fc3178
Mime-Version: 1.0
Subject: Re: [PATCH 2/2] printk: make sure to print log on console.
Reply-To: v.narang@samsung.com
From: Vaneet Narang <v.narang@samsung.com>
To: Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
CC: Maninder Singh <maninder1.s@samsung.com>,
        "sergey.senozhatsky@gmail.com" <sergey.senozhatsky@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>,
        PANKAJ MISHRA <pankaj.m@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20180601044050.GA5687@jagdpanzerIV>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180601084236epcms5p5063cd250524f105a334d8d553302ab51@epcms5p5>
Date: Fri, 01 Jun 2018 14:12:36 +0530
X-CMS-MailID: 20180601084236epcms5p5063cd250524f105a334d8d553302ab51
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnk+LIzCtJLcpLzFFi42LZdlhTXfcPm2C0wa6TMhYXd6daXN41h83i
        8Pw2Fot7b7YyWfx//JXVYl/HAyaLRxMmMVms/fyY3YHDY+esu+weLftusXv0bVnF6LF+y1UW
        j8+b5AJYo1JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0y
        c4BOUVIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKkUbGhrpGRqY6xkZAWnTWCsjU6CShNSM
        EzsfMhbM4q+4f/Q4awNjE08XIyeHhICJROOdg8xdjFwcQgK7GSV2LfnE2MXIwcErICjxd4cw
        SI2wgLPEss4/7CC2kICcxPEbuxkh4joSJ+atAStnE9CS+NgSDhIWEYiROHqulRnEZhZYzSTx
        pssKYhWvxIz2pywQtrTE9uVbwcZwChhKLHyyDyouKnFz9Vt2GPv9sfmMELaIROu9s8wQtqDE
        g5+7oeIyEt+/9rOCnCAhUC7RudkV5BMJgQ5Gid7DG5kgaswlzp+cD9bLK+Ar0bp3HVgvi4Cq
        xIP+72wQvS4S7YfKIE6Wl9j+dg4zSJhZQFNi/S59iDCfRO/vJ0wwn+yYB2MrSZw7uJMNwpaQ
        eNI5E+pKD4kbjRfZIAG7n0li4cnLLBMY5WchwnYWkm2zELYtYGRexSiZWlCcm55abFpglJda
        rlecmFtcmpeul5yfu4kRnAi1vHYwLjvnc4hRgINRiYdX4wt/tBBrYllxZe4hRgkOZiUR3ill
        QCHelMTKqtSi/Pii0pzU4kOMpkBvT2SWEk3OBybpvJJ4Q1MjMzMDSwNTYwszQyVx3h/XBaKF
        BNITS1KzU1MLUotg+pg4OKUaGPd+fjA10zS9Lr39AOM2g8r3B4OCJgQwfFRdUsQiuver3I8V
        fr93Tz0/nUffZWGXpesHB46TDxKbKtjM1u9vD3o57VP5+rprEzcfm/32yq+itzYWBkeW9vi8
        07o4sTrqW88dM3kuP+c5x3KmqIuzclQpmb4p8M0WX+9h9fiE9cOvKs4Fjx+nBCuxFGckGmox
        FxUnAgDyaeH3mgMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180531102246epcas5p2f1cbc6ff217172e12e2f78bb88eb4a7e
References: <20180601044050.GA5687@jagdpanzerIV>
        <20180531102246epcas5p2f1cbc6ff217172e12e2f78bb88eb4a7e~zs5h59tMh2250222502epcas5p2S@epcas5p2.samsung.com>
        <20180531105215.GF477@jagdpanzerIV>
        <20180531122112.bfeqtmwpl2qc67a5@pathway.suse.cz>
        <CGME20180531102246epcas5p2f1cbc6ff217172e12e2f78bb88eb4a7e@epcms5p5>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

>> but the problem is real.
>
>Yep, could be. But not exactly the way it is described in the commit
>messages and the patch does not fully address the problem.
>
>The patch assumes that all those events happen sequentially. While
>in reality they can happen in parallel on different CPUs.
>
>Example:
>
> CPU0     CPU1
>
> set console verbose
>
> dump_backtrace()
> {
>  // for (;;)  print frames
>  printk("%pS\n", frame0);
>  printk("%pS\n", frame1);
>  printk("%pS\n", frame2);
>  printk("%pS\n", frame3);
>  ...    console_loglevel = CONSOLE_LOGLEVEL_SILENT;
>  printk("%pS\n", frame12);
>  printk("%pS\n", frame13);
> }
>

This is not printk issue, its printk usage issue. User need to handle this part using some protection.

What we highlighted is issue related to printk, Where usage is correct 
but still printk can miss some logs due to printk design of asynchronous printing.


>Part of backtrace or the entire backtrace will be missed, because
>we read the global console_loglevel. The problem is still there.
>
>> The console handling is asynchronous even without the kthread.
>> The current console_lock owner is responsible for handling messages
>> also from other CPUs.
>
>A nitpick: that's another thing to improve in the commit message, because
>   I don't see that console_silent() race in the upstream kernel. We even
>   don't have any users of console_silent() function. The only thing that
>   ever sets console_loglevel to CONSOLE_LOGLEVEL_SILENT is
>   kernel/debug/kdb/kdb_io.c
>

Issue is not related to console_silent() user, Issue is with dynamic console log level handling.
Which can be done using dmesg as well.
For example:
dmesg -n 7 
"Run some scenario to capture all the kernel logs"
dmesg -n 1

I may end up not getting all the logs if my console flush is slow & 
dmesg -n 1 got excuted before flush .


Thanks & Regards,
Vaneet Narang
