Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbeCZHEX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 03:04:23 -0400
Received: from smtpbg291.qq.com ([113.108.11.223]:42656 "EHLO smtpbg291.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751449AbeCZHEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 03:04:21 -0400
X-QQ-GoodBg: 0
X-QQ-SSF: 00100000000000F0
X-QQ-FEAT: j5Y3lWpKjFZmk/6XHDUG0M5GjT+WYvBBjFHIwGaALmbQRdNJRZCh7ULmCD8iH
        GRR8Fgh9wN1YYe9vXwGRH/izZo9E+xigT6WLK3KV4EIm2T9I7ezk+srLcWHeAu0d83TEexU
        NsYD4hmgaZDMR2Rw0VQhhlCqbeyANRK8CE3SbHCQhfgvhh41XK0wLgMKNZ1yhwgR2XfXMzq
        gPj+VEX9VD6bl7LRs6zjZEX5vB6XRn6BUyDG6kNbTfK/uN7CaI3Y78aDZ4U6fPvjIQNms8+
        WRdJ0C1NL2+PrZjiu67tOnyfv34PY0nkDj9A==
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 222.92.124.153
X-QQ-STYLE: 
X-QQ-mid: bizmailfree34t1522047437t5048
From: "=?utf-8?B?6ZmI5Y2O5omN?=" <chenhc@lemote.com>
To: "=?utf-8?B?QW5kcmV3IE1vcnRvbg==?=" <akpm@linux-foundation.org>,
        "=?utf-8?B?RmFiaW8gRXN0ZXZhbQ==?=" <festevam@gmail.com>
Cc: "=?utf-8?B?VG9ueSBMaW5kZ3Jlbg==?=" <tony@atomide.com>,
        "=?utf-8?B?U3RlcGhlbiBSb3Rod2VsbA==?=" <sfr@canb.auug.org.au>,
        "=?utf-8?B?UmljaCBGZWxrZXI=?=" <dalias@libc.org>,
        "=?utf-8?B?UnVzc2VsbCBLaW5n?=" <linux@arm.linux.org.uk>,
        "=?utf-8?B?WW9zaGlub3JpIFNhdG8=?=" <ysato@users.sourceforge.jp>,
        "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>,
        "=?utf-8?B?UmFsZiBCYWVjaGxl?=" <ralf@linux-mips.org>,
        "=?utf-8?B?bGludXgtb21hcA==?=" <linux-omap@vger.kernel.org>,
        "=?utf-8?B?SmFtZXMgSG9nYW4=?=" <james.hogan@mips.com>,
        "=?utf-8?B?bW9kZXJhdGVkIGxpc3Q6QVJNL0ZSRUVTQ0FMRSBJTVggLyBNWEMgQVJNIEFSQ0hJVEVDVFVSRQ==?="
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: Regression with arm in next with stack protector
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Date: Mon, 26 Mar 2018 14:57:17 +0800
X-Priority: 3
Message-ID: <tencent_79FD53B203715FD7439C6EAB@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20180323181452.GJ5799@atomide.com>
        <CAOMZO5Bmpk4cwav-qTnNA6L16DwdDPp5LeKC-jY9=QzfVBuKSQ@mail.gmail.com>
        <20180323121530.f28dc29939d9395268911a4e@linux-foundation.org>
In-Reply-To: <20180323121530.f28dc29939d9395268911a4e@linux-foundation.org>
X-QQ-ReplyHash: 2241409752
X-QQ-SENDSIZE: 520
Feedback-ID: bizmailfree:lemote.com:qybgweb:qybgweb12
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2Q74RPO006476

Hi, Tony and Fabio,

Could you please upload your kernel binary to somewhere for me? I don't understand why some ARM boards is OK while others are broken.

Huacai
 
------------------ Original ------------------
From:  "Andrew Morton"<akpm@linux-foundation.org>;
Date:  Sat, Mar 24, 2018 03:15 AM
To:  "Fabio Estevam"<festevam@gmail.com>;
Cc:  "Tony Lindgren"<tony@atomide.com>; "Huacai Chen"<chenhc@lemote.com>; "Stephen Rothwell"<sfr@canb.auug.org.au>; "Rich Felker"<dalias@libc.org>; "Russell King"<linux@arm.linux.org.uk>; "Yoshinori Sato"<ysato@users.sourceforge.jp>; "linux-kernel"<linux-kernel@vger.kernel.org>; "Ralf Baechle"<ralf@linux-mips.org>; "linux-omap"<linux-omap@vger.kernel.org>; "James Hogan"<james.hogan@mips.com>; "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"<linux-arm-kernel@lists.infradead.org>;
Subject:  Re: Regression with arm in next with stack protector
 
On Fri, 23 Mar 2018 15:45:27 -0300 Fabio Estevam <festevam@gmail.com> wrote:

> On Fri, Mar 23, 2018 at 3:14 PM, Tony Lindgren <tony@atomide.com> wrote:
> > Hi,
> >
> > Looks like commit 5638790dadae ("zboot: fix stack protector in
> > compressed boot phase") breaks booting on arm.
> 
> Yes, almost all imx are broken in linux-next due to this commit:
> https://kernelci.org/soc/imx/job/next/kernel/next-20180323/

Thanks, I dropped it and I expect Stephen will also do that.
