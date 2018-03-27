Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751185AbeC0IjH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 04:39:07 -0400
Received: from SMTPBG252.QQ.COM ([183.60.52.105]:50866 "EHLO smtpbg252.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750918AbeC0IjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 04:39:04 -0400
X-QQ-GoodBg: 0
X-QQ-SSF: 00100000000000F0
X-QQ-FEAT: jfJxHuYZxOAHS8jCwHJeEcdSCoGebqi9uHNfsC4/R0SE3VPvNmXI2P27BDusX
        o/eQx39ntgqlMfdsDQs6LChsN9dMAhZwvbAWzkGKURpEcVEK+RbN7dP8rca4FCSN3goZuSk
        ptaR8ITqoBow6A1l8qyAqX3trFxZ1wrScUKVGWhWMgy6fHpmlvVJybZ3wGckCJppYAZmOUR
        is/sCNPuqzOA8+lnYR9+KJkko9pNzhmsfhg1IM31QnfR6Qm308qc9umuNbSasy5othXXA8n
        sUDx7TjR6uAQSg+dWZm6jjrMtcf5Y6YUYxIg==
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 222.92.124.153
X-QQ-STYLE: 
X-QQ-mid: bizmailfree34t1522139353t6714
From: "=?utf-8?B?6ZmI5Y2O5omN?=" <chenhc@lemote.com>
To: "=?utf-8?B?VG9ueSBMaW5kZ3Jlbg==?=" <tony@atomide.com>
Cc: "=?utf-8?B?QW5kcmV3IE1vcnRvbg==?=" <akpm@linux-foundation.org>,
        "=?utf-8?B?RmFiaW8gRXN0ZXZhbQ==?=" <festevam@gmail.com>,
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
Date: Tue, 27 Mar 2018 16:29:12 +0800
X-Priority: 3
Message-ID: <tencent_1DDCF65B56759D1B570EF7DD@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20180323181452.GJ5799@atomide.com>
        <CAOMZO5Bmpk4cwav-qTnNA6L16DwdDPp5LeKC-jY9=QzfVBuKSQ@mail.gmail.com>
        <20180323121530.f28dc29939d9395268911a4e@linux-foundation.org>
        <tencent_79FD53B203715FD7439C6EAB@qq.com>
        <20180326153714.GG5700@atomide.com>
In-Reply-To: <20180326153714.GG5700@atomide.com>
X-QQ-ReplyHash: 1163589376
X-QQ-SENDSIZE: 520
Feedback-ID: bizmailfree:lemote.com:qybgweb:qybgweb10
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2R8dE0d023857

Allwinner devices are OK, Exynos devices (except 4210) are OK.
 
------------------ Original ------------------
From:  "Tony Lindgren"<tony@atomide.com>;
Date:  Mon, Mar 26, 2018 11:37 PM
To:  "陈华才"<chenhc@lemote.com>;
Cc:  "Andrew Morton"<akpm@linux-foundation.org>; "Fabio Estevam"<festevam@gmail.com>; "Stephen Rothwell"<sfr@canb.auug.org.au>; "Rich Felker"<dalias@libc.org>; "Russell King"<linux@arm.linux.org.uk>; "Yoshinori Sato"<ysato@users.sourceforge.jp>; "linux-kernel"<linux-kernel@vger.kernel.org>; "Ralf Baechle"<ralf@linux-mips.org>; "linux-omap"<linux-omap@vger.kernel.org>; "James Hogan"<james.hogan@mips.com>; "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"<linux-arm-kernel@lists.infradead.org>;
Subject:  Re: Regression with arm in next with stack protector
 
* 陈华才 <chenhc@lemote.com> [180326 06:59]:
> Hi, Tony and Fabio,
> 
> Could you please upload your kernel binary to somewhere for me? I don't understand why some ARM boards is OK while others are broken.

Well the kernel I'm testing is just current Linux next cross
compiled omap2plus_defconfig kernel. I do have few more config
options enabled like LOCKDEP and DEBUG_ATOMIC_SLEEP, but I
doubt they matter here :)

Then I'm using gcc-7.3.0 and binutils-2.30 built with the
buildall.git scripts:

git://git.infradead.org/users/segher/buildall.git

If you still need binaries, let me know.

Do you know which arm devices are working with your patch?

Regards,

Tony
