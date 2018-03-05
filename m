Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932723AbeCEG5I (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 01:57:08 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:60595 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932492AbeCEG5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 01:57:07 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01353;MF=qixuan.wu@linux.alibaba.com;NM=1;PH=DW;RN=10;SR=0;TI=W4_5166270_DEFAULT_0AB10131_1520231819119_o7001c53a;
Date: Mon, 05 Mar 2018 14:56:59 +0800
From: "Qixuan.Wu" <qixuan.wu@linux.alibaba.com>
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: "linux-kernel-owner" <linux-kernel-owner@vger.kernel.org>,
        "Petr Mladek" <pmladek@suse.com>, "Jan Kara" <jack@suse.cz>,
        "Sergey Senozhatsky" <sergey.senozhatsky@gmail.com>,
        "Sergey Senozhatsky" <sergey.senozhatsky.work@gmail.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "chenggang.qin" <chenggang.qin@linux.alibaba.com>,
        "caijingxian" <caijingxian@linux.alibaba.com>,
        "yuanliang.wyl" <yuanliang.wyl@alibaba-inc.com>
Reply-To: "Qixuan.Wu" <qixuan.wu@linux.alibaba.com>
Message-ID: <32058cbd-7d09-4316-afd9-c2f031a2a406.qixuan.wu@linux.alibaba.com>
Subject: =?UTF-8?B?UmU6IFdvdWxkIHlvdSBoZWxwIHRvIHRlbGwgd2h5IGFzeW5jIHByaW50ayBzb2x1dGlvbiB3?=
  =?UTF-8?B?YXMgbm90IHRha2VuIHRvIHVwc3RyZWFtIGtlcm5lbCA/?=
X-Mailer: [Alimail-Mailagent revision 948139][W4_5166270][DEFAULT][Chrome]
MIME-Version: 1.0
References: <1eb584e2-a479-46dd-8a25-820da7a34e85.qixuan.wu@linux.alibaba.com>  <20180304130151.GA483@tigerII.localdomain>      <af2c3824-c122-4496-a876-9b03af60c429.qixuan.wu@linux.alibaba.com>,<20180304104324.6bbbaa53@gandalf.local.home>
In-Reply-To: <20180304104324.6bbbaa53@gandalf.local.home>
x-aliyun-mail-creator: W4_5166270_DEFAULT_M3LTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTNfMCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzY0LjAuMzI4Mi4xNjcgU2FmYXJpLzUzNy4zNg==vN
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w256vLfO020444

Hi Steve,  

On Sun, 04 Mar 2018 23:43:23 +0800
Steven Rostedt <rostedt@goodmis.org> wrote:

> Yes, people keep bringing up this scenario.
> It would require a single burst of printks to all CPUs. And then no
> more printks after that. The last one will end up printing the entire
> buffer out the slow console. The thing is, this is a bounded time, and
> no printk will print more than one full buffer worth.

> If this is a worry, then set the timeouts for the lockup detection to
> be longer than the time it takes to print one full buffer with the
> slowest console.

Thanks for your information and suggestion. We will think of backport 
the code as per the workload, or recently, maybe we will think of disable 
ttyS0 console just for the printk. 

Thanks & Regards
Qixuan
