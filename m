Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932420AbeBTCxW convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 21:53:22 -0500
Received: from mx01.hxt-semitech.com.96.203.223.in-addr.arpa ([223.203.96.7]:38806
        "EHLO barracuda.hxt-semitech.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S932352AbeBTCxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 21:53:20 -0500
X-ASG-Debug-ID: 1519095135-093b7e4b5084150001-xx1T2L
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
From: "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
To: "jcm@jonmasters.org" <jcm@jonmasters.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>
CC: "lenb@kernel.org" <lenb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zheng, Joey" <yu.zheng@hxt-semitech.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Jiang, Yutang2" <yutang2.jiang@hxt-semitech.com>
Subject: Re: [PATCH v3] ACPI / tables: Add IORT to injectable table list
Thread-Topic: [PATCH v3] ACPI / tables: Add IORT to injectable table list
X-ASG-Orig-Subj: Re: [PATCH v3] ACPI / tables: Add IORT to injectable table list
Thread-Index: AQHTqbXVNRd8qwRBR0yHzFlHYBt9F6OsEg+A
Date: Tue, 20 Feb 2018 02:52:08 +0000
Message-ID: <1519095127.2772.10.camel@hxt-semitech.com>
References: <1517567138-27283-1-git-send-email-shunyong.yang@hxt-semitech.com>
         <68362a1f-cc0c-42f9-97da-bdf379c4f5a1@huawei.com>
         <em5890c25f-84af-42ac-bfea-b27c6516e46b@bjl0091>
         <669340a4-e748-07f4-51d5-bf0566cd75b8@jonmasters.org>
In-Reply-To: <669340a4-e748-07f4-51d5-bf0566cd75b8@jonmasters.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.127.0.10]
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <39975D59931B8546AE827CBEC3180C33@hxt-semitech.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: UNKNOWN[10.128.0.14]
X-Barracuda-Start-Time: 1519095136
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4929 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.48101
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jon,

On Mon, 2018-02-19 at 14:13 -0500, Jon Masters wrote:
> On 02/02/2018 07:12 AM, Wang, Dongsheng wrote:
> > 
> > Hey, Hanjun,
> > 
> > On 2018/2/2 19:54:24, "Hanjun Guo" <guohanjun@huawei.com> wrote:
> > 
> > > 
> > > On 2018/2/2 18:25, Yang Shunyong wrote:
> > > > 
> > > > Loading IORT table from initrd is used to fix firmware IORT
> > > > defects.
> > > I don't think this fix "firmware defects", it just for debug
> > > purpose,
> > > we will not use that for production purpose, right? I think above
> > > line
> > > can be removed.
> > > 
> > I thinks the upgrade feature not only for debug. Here's an
> > important
> > way to fix bugs that come from the firmware.
> > 
> > Documentation/acpi/initrd_table_override.txt
> I think we should message that this is for debug/development use.
> Ultimately, it's not the way to address firmware problems. Firmware
> needs to address that by shipping the correct(ed) tables :)

Thanks for your feedback.
According to following description in
Documentation/acpi/initrd_table_override.txt
"Complain to your platform/BIOS vendor if you find a bug which is so
severe that a workaround is not accepted in the Linux kernel. And this
facility allows you to upgrade the buggy tables before your
platform/BIOS vendor releases an upgraded BIOS binary."

I have changed the commit message to "Loading IORT table from initrd
can be used to fix severe firmware
IORT defects temporarily before platform/BIOS vendor releases an
upgraded BIOS binary..." in v4.

Detail Link is here,
https://patchwork.kernel.org/patch/10202391/

Thanks.
Shunyong.
