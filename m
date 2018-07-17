Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2700ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C68E208AD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:53:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C68E208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbeGQHY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 03:24:57 -0400
Received: from smtpbgbr2.qq.com ([54.207.22.56]:47204 "EHLO smtpbgbr2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727600AbeGQHY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 03:24:57 -0400
X-QQ-GoodBg: 0
X-QQ-SSF: 00100000000000F0
X-QQ-FEAT: PML9g4LxpBqRsjLmSNxM3sGM7TfO77yuwjnbZhBbUIT3SzlE4L8wdGIPRNcEJ
        Og/FwdrcZyifVErqWJivH7zDyzCSfRnXNhMC30s8oOPPYY3b7X7kAbA7ExzZQrJrdfcW67G
        GxqrhHNzPliEMZtT4WT33xkNoV3pzb2XKbLvm8fJ+HVvmRNLh1qDR8BILZVk0+it/RpFvyb
        y2JNtr8KIMJHVugGVeii009cIjASbSqaI+vXROzCnxh8R3/Kwx77e7D/MwfP9vgFqLnJJBt
        pAPJaAq+S+vcKg8PPLH7tfbgrf3H9/12RoEg==
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 222.92.124.153
X-QQ-STYLE: 
X-QQ-mid: bizmailfree7t1531810418t42879
From:   "=?utf-8?B?6ZmI5Y2O5omN?=" <chenhc@lemote.com>
To:     "=?utf-8?B?R3JlZyBLcm9haC1IYXJ0bWFu?=" <gregkh@linuxfoundation.org>
Cc:     "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>,
        "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>,
        "=?utf-8?B?UGF1bCBCdXJ0b24=?=" <paul.burton@mips.com>,
        "=?utf-8?B?SmFtZXMgSG9nYW4=?=" <jhogan@kernel.org>
Subject: Re: [PATCH 4.9 03/32] MIPS: Use async IPIsforarch_trigger_cpumask_backtrace()
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Tue, 17 Jul 2018 14:53:38 +0800
X-Priority: 3
Message-ID: <tencent_06288B95133EFFAE55198FCC@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20180716073504.433996952@linuxfoundation.org>
        <20180716073504.871411055@linuxfoundation.org>
        <tencent_63FC64B11AAB89F2466748AE@qq.com>
        <20180716094023.GA20647@kroah.com>
        <tencent_47C96C376F2E810C2237848B@qq.com>
        <20180716104621.GB11023@kroah.com>
        <20180716183402.GC13309@kroah.com>
In-Reply-To: <20180716183402.GC13309@kroah.com>
X-QQ-ReplyHash: 3098631688
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
        by smtp.qq.com (ESMTP) with SMTP
        id ; Tue, 17 Jul 2018 14:53:39 +0800 (CST)
Feedback-ID: bizmailfree:lemote.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEdyZWcsDQoNCkkgaGF2ZSBiYWNrcG9ydGVkIGFuZCB0ZXN0ZWQgaXQgdG8gNC45IGFu
ZCA0LjQ6DQpodHRwczovL3BhdGNod29yay5saW51eC1taXBzLm9yZy9wYXRjaC8xOTg2Mi8N
Cmh0dHBzOi8vcGF0Y2h3b3JrLmxpbnV4LW1pcHMub3JnL3BhdGNoLzE5ODYzLw0KDQpIdWFj
YWkNCiANCi0tLS0tLS0tLS0tLS0tLS0tLSBPcmlnaW5hbCAtLS0tLS0tLS0tLS0tLS0tLS0N
CkZyb206ICAiR3JlZyBLcm9haC1IYXJ0bWFuIjxncmVna2hAbGludXhmb3VuZGF0aW9uLm9y
Zz47DQpEYXRlOiAgVHVlLCBKdWwgMTcsIDIwMTggMDI6MzQgQU0NClRvOiAgIumZiOWNjuaJ
jSI8Y2hlbmhjQGxlbW90ZS5jb20+Ow0KQ2M6ICAibGludXgta2VybmVsIjxsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnPjsgInN0YWJsZSI8c3RhYmxlQHZnZXIua2VybmVsLm9yZz47
ICJQYXVsIEJ1cnRvbiI8cGF1bC5idXJ0b25AbWlwcy5jb20+OyAiSmFtZXMgSG9nYW4iPGpo
b2dhbkBrZXJuZWwub3JnPjsNClN1YmplY3Q6ICBSZTogW1BBVENIIDQuOSAwMy8zMl0gTUlQ
UzogVXNlIGFzeW5jIElQSXNmb3JhcmNoX3RyaWdnZXJfY3B1bWFza19iYWNrdHJhY2UoKQ0K
IA0KT24gTW9uLCBKdWwgMTYsIDIwMTggYXQgMTI6NDY6MjFQTSArMDIwMCwgR3JlZyBLcm9h
aC1IYXJ0bWFuIHdyb3RlOg0KPiBPbiBNb24sIEp1bCAxNiwgMjAxOCBhdCAwNTo0NjoxMlBN
ICswODAwLCDpmYjljY7miY0gd3JvdGU6DQo+ID4gSnVzdCBjaGFuZ2UgImNhbGxfc2luZ2xl
X2RhdGFfdCIgdG8gInN0cnVjdCBjYWxsX3NpbmdsZV9kYXRhIiBhbmQgZXZlcnl0aGluZyBp
cyBPSy4NCj4gDQo+IE9rLCBJJ3ZlIGRvbmUgdGhhdCBub3csIHRoYW5rcy4NCg0KQW5kIEkg
bWVzc2VkIGl0IHVwLiAgU28gSSd2ZSBqdXN0IGRyb3BwZWQgaXQgZW50aXJlbHkuICBDYW4g
c29tZW9uZSBzZW5kDQptZSBhIHByb3Blcmx5IGJhY2twb3J0ZWQgcGF0Y2ggcGxlYXNlPw0K
DQp0aGFua3MsDQoNCmdyZWcgay1o



