Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAB9ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 06:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CAB32083E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 06:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CAB32083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbeJSO2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 10:28:17 -0400
Received: from smtpbguseast2.qq.com ([54.204.34.130]:45714 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbeJSO2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 10:28:17 -0400
X-QQ-GoodBg: 0
X-QQ-SSF: 00100000000000F0
X-QQ-FEAT: knxJV7dvAn1w0IOSP7+bkXXNMqGP+lNGHxbK/ispaARsHvhOK3qdVzL9EWJlg
        h9Y746AYFZRT+LNDzZ9tWsGgjhhTfVzsFyABXedej++Wjf5saCLipLRLMv9ktaU15ICccba
        WnSGWL9MMz3pkOlOTx40/O63APoXqrST7S52o+ka6wCTwjMtQJuSU3mWZF7GHQzAtie21k5
        zDAqydfQo9mowCcKpWrkr+Cy10lTJBoMx2qIXnlFQiWbuAx1WPASCR0aiVKpjAUJ2U2i/bI
        71dAlgSOL1JYIWSNCZlQGLdOax9aKK8pnIOw==
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 222.92.124.153
X-QQ-STYLE: 
X-QQ-mid: bizmailfree7t1539930208t40217
From:   "=?utf-8?B?6ZmI5Y2O5omN?=" <chenhc@lemote.com>
To:     "=?utf-8?B?U3VkZWVwIEhvbGxh?=" <sudeep.holla@arm.com>
Cc:     "=?utf-8?B?R3JlZyBLcm9haC1IYXJ0bWFu?=" <gregkh@linuxfoundation.org>,
        "=?utf-8?B?UmFmYWVsIEogLiBXeXNvY2tp?=" <rafael@kernel.org>,
        "=?utf-8?B?TEtNTA==?=" <linux-kernel@vger.kernel.org>,
        "=?utf-8?B?emhhbmdmeA==?=" <zhangfx@lemote.com>,
        "=?utf-8?B?d3V6aGFuZ2ppbg==?=" <wuzhangjin@gmail.com>,
        "=?utf-8?B?U3VkZWVwIEhvbGxh?=" <sudeep.holla@arm.com>
Subject: Re: [PATCH] cacheinfo: Keep the old value if of_property_read_u32fails
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Fri, 19 Oct 2018 14:23:27 +0800
X-Priority: 3
Message-ID: <tencent_618B672134A6B5732D255D23@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <1539739563-1886-1-git-send-email-chenhc@lemote.com>
        <20181017093540.GB16320@e107155-lin>
        <CAAhV-H64KYE6YDLrBuK_oYkyBHe8F_5Ja433tY+Pp841kJw57g@mail.gmail.com>
        <20181018091146.GA22021@e107155-lin>
In-Reply-To: <20181018091146.GA22021@e107155-lin>
X-QQ-ReplyHash: 17757426
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
        by smtp.qq.com (ESMTP) with SMTP
        id ; Fri, 19 Oct 2018 14:23:29 +0800 (CST)
Feedback-ID: bizmailfree:lemote.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFN1ZGVlcCwNCg0KSSB1c2UgTUlQUywgYW5kIHRoZXJlIGlzIG5vICJzaXplIiBpbiAv
c3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHVYL2NhY2hlL2luZGV4WC8gZmlsZSBhZnRlciB5
b3VyIHBhdGNoLiBCZWNhdXNlIHRoZSBEVCBub2RlIG9ubHkgaGFzICJuZXh0LWxldmVsLWNh
Y2hlID0gPCZMMj47IiAgYnV0IGhhcyBubyAic2l6ZSIgaW5mb3JtYXRpb24uDQoNCkh1YWNh
aQ0KIA0KIA0KLS0tLS0tLS0tLS0tLS0tLS0tIE9yaWdpbmFsIC0tLS0tLS0tLS0tLS0tLS0t
LQ0KRnJvbTogICJTdWRlZXAgSG9sbGEiPHN1ZGVlcC5ob2xsYUBhcm0uY29tPjsNCkRhdGU6
ICBUaHUsIE9jdCAxOCwgMjAxOCAwNToxNSBQTQ0KVG86ICAiSHVhY2FpIENoZW4iPGNoZW5o
Y0BsZW1vdGUuY29tPjsNCkNjOiAgIkdyZWcgS3JvYWgtSGFydG1hbiI8Z3JlZ2toQGxpbnV4
Zm91bmRhdGlvbi5vcmc+OyAiUmFmYWVsIEogLiBXeXNvY2tpIjxyYWZhZWxAa2VybmVsLm9y
Zz47ICJMS01MIjxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgInpoYW5nZngiPHpo
YW5nZnhAbGVtb3RlLmNvbT47ICJ3dXpoYW5namluIjx3dXpoYW5namluQGdtYWlsLmNvbT47
ICJTdWRlZXAgSG9sbGEiPHN1ZGVlcC5ob2xsYUBhcm0uY29tPjsNClN1YmplY3Q6ICBSZTog
W1BBVENIXSBjYWNoZWluZm86IEtlZXAgdGhlIG9sZCB2YWx1ZSBpZiBvZl9wcm9wZXJ0eV9y
ZWFkX3UzMmZhaWxzDQogDQpIaSBIdWFjYWksDQoNCk9uIFRodSwgT2N0IDE4LCAyMDE4IGF0
IDA5OjI4OjExQU0gKzA4MDAsIEh1YWNhaSBDaGVuIHdyb3RlOg0KPiBIaSwgU3VkZWVwLA0K
PiANCj4gUGxlYXNlIHNlZSB0aGlzIGNhbGwtZ3JhcGg6DQo+IA0KPiBzdGF0aWMgaW50IGRl
dGVjdF9jYWNoZV9hdHRyaWJ1dGVzKHVuc2lnbmVkIGludCBjcHUpDQo+ICAgICAgICAgLi4u
Lg0KPiAgICAgICAgIHJldCA9IHBvcHVsYXRlX2NhY2hlX2xlYXZlcyhjcHUpOw0KPiAgICAg
ICAgIC4uLi4NCj4gICAgICAgICByZXQgPSBjYWNoZV9zaGFyZWRfY3B1X21hcF9zZXR1cChj
cHUpOyAtLT4NCj4gY2FjaGVfc2V0dXBfb2Zfbm9kZSgpIC0tPiBjYWNoZV9vZl9zZXRfcHJv
cHMoKSAtLT4NCj4gY2FjaGVfc2l6ZSgpL2NhY2hlX25yX3NldHMNCj4gDQo+IHBvcHVsYXRl
X2NhY2hlX2xlYXZlcygpIGlzIGFyY2gtc3BlY2lmaWMsIEFsbCBhcmNocyBleGNlcHQgYXJt
NjQgaGF2ZQ0KPiBwcm92aWRlIGluaXRpYWwgdmFsdWVzIHRvIGNhY2hlaW5mbzpzaXplIGFu
ZCBjYWNoZWluZm86bnVtYmVyX29mX3NldHMuDQo+IA0KPiBSZWxhdGVkIGZpbGVzOg0KPiBh
cmNoL25kczMyL2tlcm5lbC9jYWNoZWluZm8uYw0KPiBhcmNoL21pcHMva2VybmVsL2NhY2hl
aW5mby5jDQoNCk9ubHkgYWJvdmUgMiBjb3VsZCBiZSBhZmZlY3RlZCwgYnV0IEkgd2FudCB0
byBiZSBzdXJlLiBJIHdhc24ndCBhd2FyZQ0Kb2YgTUlQUyBhcmNoIHNldHRpbmcgdmFsdWVz
IGVsc2V3aGVyZSwgYXNzdW1lZCBEVCwgbXkgYmFkLg0KWW91IGhhdmUgc3RpbGwgbm90IGFu
c3dlcmVkIG15IHF1ZXN0aW9uLiBXaGljaCBhcmNoIGFyZSB5b3UgZmFjaW5nIGlzc3VlID8N
Ck9yIGFyZSB5b3UgcHJvcG9zaW5nIHRoaXMgYnkgY29kZSBpbnNwZWN0aW9uID8gSSBjaGFu
Z2VzIGxvb2sgZmluZSwgYnV0DQp3YW50IHRvIGJlIHN1cmUgaWYgdGhlIGlzc3VlIHlvdSBh
cmUgc2VlaW5nIGlzIGluIGFib3ZlIGFyY2hpdGVjdHVyZXMuDQoNCi0tDQpSZWdhcmRzLA0K
U3VkZWVw



