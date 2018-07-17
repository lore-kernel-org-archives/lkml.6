Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922C5ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4089020C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4089020C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbeGQIq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 04:46:28 -0400
Received: from smtpbg65.qq.com ([103.7.28.233]:4433 "EHLO smtpbg65.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbeGQIq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 04:46:28 -0400
X-QQ-GoodBg: 0
X-QQ-SSF: 00100000000000F0
X-QQ-FEAT: hcmviN0nPXLXoRw+YsYJM3mfiTquQ6FwmjEtIM2oU4j7a5Fw4mZBEzo+AE5V9
        cN52WwBb1k44F2OX00VToIRcLBxwUt8rjrVKYhSVqTPDD2RkGjQsqJQ8fkYOB6BtFjzxjbC
        ESWVOsxuvvcYNHNEmDVLHJR1+YjcCFwqKcBD8Nt4bm1muBWQV40ZJlT81XkYF4V2aC5dOG7
        QmlY7TwuGoUtxeebjOjvLpRf4kUj+J1NyXxSyYEBzsXytt0bzSkptYql9Bx/Ua6A+Vynnwb
        K4SzSKSeC4VgRO2gqv7iNziFbTItt0V8feGQ==
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 222.92.124.153
X-QQ-STYLE: 
X-QQ-mid: bizmailfree7t1531815298t32857
From:   "=?utf-8?B?6ZmI5Y2O5omN?=" <chenhc@lemote.com>
To:     "=?utf-8?B?R3JlZyBLcm9haC1IYXJ0bWFu?=" <gregkh@linuxfoundation.org>
Cc:     "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>,
        "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>,
        "=?utf-8?B?UGF1bCBCdXJ0b24=?=" <paul.burton@mips.com>,
        "=?utf-8?B?SmFtZXMgSG9nYW4=?=" <jhogan@kernel.org>
Subject: Re: [PATCH 4.9 03/32] MIPS: Use asyncIPIsforarch_trigger_cpumask_backtrace()
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Tue, 17 Jul 2018 16:14:58 +0800
X-Priority: 3
Message-ID: <tencent_339CA9301A5289DE7945E7F2@qq.com>
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
        <tencent_06288B95133EFFAE55198FCC@qq.com>
        <20180717072055.GB12255@kroah.com>
In-Reply-To: <20180717072055.GB12255@kroah.com>
X-QQ-ReplyHash: 2870787012
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
        by smtp.qq.com (ESMTP) with SMTP
        id ; Tue, 17 Jul 2018 16:15:00 +0800 (CST)
Feedback-ID: bizmailfree:lemote.com:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEdyZWcsDQoNCkkgaGF2ZSByZXNlbmQgcGF0Y2hlcyBhbmQgY2Mgc3RhYmxlIGxpc3Qu
DQoNClRoaXMgcGF0Y2ggaXMgbmVlZGVkIGZvciA0LjQueSBidXQgbmVlZCByZXN0cnVjdGlv
biwgYXMgUGF1bCBzYWlkOg0KU3RyaWN0bHkgc3BlYWtpbmcgdGhlIGZhdWx0eSBNSVBTIGlt
cGxlbWVudGF0aW9uIGNhbiBiZQ0KdHJhY2VkIGZ1cnRoZXIgYmFjayB0byBjb21taXQgODU2
ODM5Yjc2ODM2ICgiTUlQUzogQWRkDQphcmNoX3RyaWdnZXJfYWxsX2NwdV9iYWNrdHJhY2Uo
KSBmdW5jdGlvbiIpIGluIHYzLjE5DQoNCkh1YWNhaQ0KIA0KLS0tLS0tLS0tLS0tLS0tLS0t
IE9yaWdpbmFsIC0tLS0tLS0tLS0tLS0tLS0tLQ0KRnJvbTogICJHcmVnIEtyb2FoLUhhcnRt
YW4iPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsNCkRhdGU6ICBUdWUsIEp1bCAxNywg
MjAxOCAwMzoyMCBQTQ0KVG86ICAi6ZmI5Y2O5omNIjxjaGVuaGNAbGVtb3RlLmNvbT47DQpD
YzogICJsaW51eC1rZXJuZWwiPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyAic3Rh
YmxlIjxzdGFibGVAdmdlci5rZXJuZWwub3JnPjsgIlBhdWwgQnVydG9uIjxwYXVsLmJ1cnRv
bkBtaXBzLmNvbT47ICJKYW1lcyBIb2dhbiI8amhvZ2FuQGtlcm5lbC5vcmc+Ow0KU3ViamVj
dDogIFJlOiBbUEFUQ0ggNC45IDAzLzMyXSBNSVBTOiBVc2UgYXN5bmNJUElzZm9yYXJjaF90
cmlnZ2VyX2NwdW1hc2tfYmFja3RyYWNlKCkNCiANCk9uIFR1ZSwgSnVsIDE3LCAyMDE4IGF0
IDAyOjUzOjM4UE0gKzA4MDAsIOmZiOWNjuaJjSB3cm90ZToNCj4gSGksIEdyZWcsDQo+IA0K
PiBJIGhhdmUgYmFja3BvcnRlZCBhbmQgdGVzdGVkIGl0IHRvIDQuOSBhbmQgNC40Og0KPiBo
dHRwczovL3BhdGNod29yay5saW51eC1taXBzLm9yZy9wYXRjaC8xOTg2Mi8NCj4gaHR0cHM6
Ly9wYXRjaHdvcmsubGludXgtbWlwcy5vcmcvcGF0Y2gvMTk4NjMvDQoNCkkgY2FuJ3QgZG8g
YW55dGhpbmcgd2l0aCByYW5kb20gd2ViIGxpbmtzLiAgUGxlYXNlIHByb3Blcmx5IGNjOiB0
aGUNCnN0YWJsZSBsaXN0IHdpdGggdGhlIGJhY2twb3J0cyBhbmQgSSBjYW4gdGFrZSB0aGVt
IGZyb20gdGhlcmUuDQoNCkFuZCBhcmUgeW91IHN1cmUgdGhleSBhcmUgbmVlZGVkIGZvciA0
LjQueT8NCg0KdGhhbmtzLA0KDQpncmVnIGstaA==



