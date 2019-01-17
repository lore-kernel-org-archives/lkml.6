Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A984CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 05:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8369220657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 05:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbfAQF7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 00:59:07 -0500
Received: from mx.socionext.com ([202.248.49.38]:43913 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbfAQF7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 00:59:07 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 17 Jan 2019 14:59:04 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id CEB8360062;
        Thu, 17 Jan 2019 14:59:04 +0900 (JST)
Received: from 10.213.24.1 (10.213.24.1) by m-FILTER with ESMTP; Thu, 17 Jan 2019 14:59:04 +0900
Received: from SOC-EX01V.e01.socionext.com (10.213.24.21) by
 SOC-EX01V.e01.socionext.com (10.213.24.21) with Microsoft SMTP Server (TLS)
 id 15.0.995.29; Thu, 17 Jan 2019 14:59:04 +0900
Received: from SOC-EX01V.e01.socionext.com ([10.213.24.21]) by
 SOC-EX01V.e01.socionext.com ([10.213.24.21]) with mapi id 15.00.0995.028;
 Thu, 17 Jan 2019 14:59:04 +0900
From:   <yamada.masahiro@socionext.com>
To:     <aik@ozlabs.ru>, <linux-kbuild@vger.kernel.org>
CC:     <mark.rutland@arm.com>, <mgreer@animalcreek.com>,
        <linux-kernel@vger.kernel.org>, <paulus@samba.org>,
        <hpa@zytor.com>, <x86@kernel.org>, <mingo@redhat.com>,
        <joel@jms.id.au>, <jhogan@kernel.org>,
        <devicetree@vger.kernel.org>, <keescook@chromium.org>,
        <npiggin@gmail.com>, <robh+dt@kernel.org>, <bp@alien8.de>,
        <tglx@linutronix.de>, <michal.lkml@markovi.net>,
        <maurosr@linux.vnet.ibm.com>, <linux-mips@vger.kernel.org>,
        <ralf@linux-mips.org>, <paul.burton@mips.com>,
        <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH 2/3] kbuild: add real-prereqs shorthand for $(filter-out
 FORCE, $^)
Thread-Topic: [PATCH 2/3] kbuild: add real-prereqs shorthand for $(filter-out
 FORCE, $^)
Thread-Index: AQHUrhxEUYXvMJEkIEyeKkRKmK6traWy9b3g
Date:   Thu, 17 Jan 2019 05:59:03 +0000
Message-ID: <bf7380ec3fa145958c3f7b3e3551a395@SOC-EX01V.e01.socionext.com>
References: <1547698231-20985-1-git-send-email-yamada.masahiro@socionext.com>
 <1547698231-20985-2-git-send-email-yamada.masahiro@socionext.com>
 <71a0e80a-c587-4973-cfc3-9c74b2b3a16c@ozlabs.ru>
In-Reply-To: <71a0e80a-c587-4973-cfc3-9c74b2b3a16c@ozlabs.ru>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: POLICY190117
x-originating-ip: [10.213.24.1]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxleGV5LA0KDQo+IFdoYXQgaXMgdGhpcyBzZXJpZXMgbWFkZSBvbiB0b3Agb2Y/IFRoaXMg
ZG9lcyBub3QgYXBwbHkgb24gdG9wIG9mIG1hc3Rlcg0KPiBmcm9tDQo+IGh0dHBzOi8vZ2l0Lmtl
cm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LTIuNi5naXQN
Cg0KDQpJZiB5b3Ugd2FudCB0byBhcHBseSB0aGlzIHNlcmllcyBjbGVhbmx5LCBwbGVhc2UgYXBw
bHkgdGhlIGZvbGxvd2luZyBmaXJzdDoNCg0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9w
YXRjaC8xMDc2MTYyNS8NCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTA3Njcx
OTMvDQoNCg0KDQpUaGUgY29uZmxpY3RzIGFyZSBub3Qgc2lnbmlmaWNhbnQuDQpZb3UgY2FuIHVz
ZSAnZ2l0IGFtIC1DMScgaWYgeW91IHdhbnQgdG8gYXBwbHkgdGhpcyBzZXJpZXMNCmRpcmVjdGx5
IHRvIExpbnVzIHRyZWUuDQoNCk1hc2FoaXJvDQoNCg==
