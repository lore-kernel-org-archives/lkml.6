Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62786ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DCB720BED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:46:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DCB720BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbeGPKND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:13:03 -0400
Received: from smtpbg202.qq.com ([184.105.206.29]:45927 "EHLO smtpbg202.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728450AbeGPKND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:13:03 -0400
X-QQ-GoodBg: 0
X-QQ-SSF: 00100000000000F0
X-QQ-FEAT: f0dVAzX4zgkY7lCwgcveRazqcQlzSHQvsZTX1YHpMjrQSi+SrPCM0w8Pz1WNi
        OVOAHyzPofkCT4yaBNgj3qPzykZBmTUQc9N8OsksllH2mU4XgWiJXfk2XfvunvI15dQxr5J
        n8emrirwMpstza0kCTSPAFBIi9RkeatRhzEq4x9EebSB8BJAXfUSEwpG9pZaKVh/mauCVrl
        hpqGsIp9D63DughbHpf+6ilwFU6Z29UjGme7FfKC3yjR3bPIU7KVlVRSeMYDBbmQoalDdoN
        NuJHb97dq1PVAVBZ7Iu5+rHWbRibdd741Y4Q==
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 222.92.124.153
X-QQ-STYLE: 
X-QQ-mid: bizmailfree7t1531734373t18023
From:   "=?utf-8?B?6ZmI5Y2O5omN?=" <chenhc@lemote.com>
To:     "=?utf-8?B?R3JlZyBLcm9haC1IYXJ0bWFu?=" <gregkh@linuxfoundation.org>
Cc:     "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>,
        "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>,
        "=?utf-8?B?UGF1bCBCdXJ0b24=?=" <paul.burton@mips.com>,
        "=?utf-8?B?SmFtZXMgSG9nYW4=?=" <jhogan@kernel.org>
Subject: Re: [PATCH 4.9 03/32] MIPS: Use async IPIs forarch_trigger_cpumask_backtrace()
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Mon, 16 Jul 2018 17:46:12 +0800
X-Priority: 3
Message-ID: <tencent_47C96C376F2E810C2237848B@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20180716073504.433996952@linuxfoundation.org>
        <20180716073504.871411055@linuxfoundation.org>
        <tencent_63FC64B11AAB89F2466748AE@qq.com>
        <20180716094023.GA20647@kroah.com>
In-Reply-To: <20180716094023.GA20647@kroah.com>
X-QQ-ReplyHash: 1242527133
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
        by smtp.qq.com (ESMTP) with SMTP
        id ; Mon, 16 Jul 2018 17:46:14 +0800 (CST)
Feedback-ID: bizmailfree:lemote.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SnVzdCBjaGFuZ2UgImNhbGxfc2luZ2xlX2RhdGFfdCIgdG8gInN0cnVjdCBjYWxsX3Npbmds
ZV9kYXRhIiBhbmQgZXZlcnl0aGluZyBpcyBPSy4NCg0KSHVhY2FpDQoNCi0tLS0tLS0tLS0t
LS0tLS0tLSBPcmlnaW5hbCAtLS0tLS0tLS0tLS0tLS0tLS0NCkZyb206ICAiR3JlZyBLcm9h
aC1IYXJ0bWFuIjxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47DQpEYXRlOiAgTW9uLCBK
dWwgMTYsIDIwMTggMDU6NDAgUE0NClRvOiAgIumZiOWNjuaJjSI8Y2hlbmhjQGxlbW90ZS5j
b20+Ow0KQ2M6ICAibGludXgta2VybmVsIjxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
PjsgInN0YWJsZSI8c3RhYmxlQHZnZXIua2VybmVsLm9yZz47ICJQYXVsIEJ1cnRvbiI8cGF1
bC5idXJ0b25AbWlwcy5jb20+OyAiSmFtZXMgSG9nYW4iPGpob2dhbkBrZXJuZWwub3JnPjsg
IlJhbGYgQmFlY2hsZSI8cmFsZkBsaW51eC1taXBzLm9yZz47ICJsaW51eC1taXBzIjxsaW51
eC1taXBzQGxpbnV4LW1pcHMub3JnPjsNClN1YmplY3Q6ICBSZTogW1BBVENIIDQuOSAwMy8z
Ml0gTUlQUzogVXNlIGFzeW5jIElQSXMgZm9yYXJjaF90cmlnZ2VyX2NwdW1hc2tfYmFja3Ry
YWNlKCkNCiANCk9uIE1vbiwgSnVsIDE2LCAyMDE4IGF0IDA1OjI5OjA1UE0gKzA4MDAsIOmZ
iOWNjuaJjSB3cm90ZToNCj4gSGksIEdyZWcsDQo+IA0KPiBrZXJuZWwtNC45IGRvZXNuJ3Qg
aGF2ZSBjYWxsX3NpbmdsZV9kYXRhX3QsIHdlIHNob3VsZCB1c2Ugc3RydWN0IGNhbGxfc2lu
Z2xlX2RhdGEgaW5zdGVhZC4NCg0KQ2FuIHlvdSBzZW5kIG1lIGEgcGF0Y2ggdG8gbWVyZ2Ug
d2l0aCB0aGlzIG9uZSB3aXRoIHRoYXQgY2hhbmdlIHNvIHRoYXQNCkkga25vdyBJIGdldCBp
dCByaWdodD8NCg0KdGhhbmtzLA0KDQpncmVnIGstaA==



