Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BB6C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 02:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33CD2174A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 02:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F33CD2174A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeH0Fp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 01:45:57 -0400
Received: from mail.windriver.com ([147.11.1.11]:56450 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbeH0Fp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 01:45:57 -0400
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w7R21FR1010754
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 26 Aug 2018 19:01:15 -0700 (PDT)
Received: from ALA-MBD.corp.ad.wrs.com ([169.254.3.79]) by
 ALA-HCB.corp.ad.wrs.com ([147.11.189.41]) with mapi id 14.03.0415.000; Sun,
 26 Aug 2018 19:01:14 -0700
From:   "Bai, Haiqing" <Haiqing.Bai@windriver.com>
To:     David Miller <davem@davemloft.net>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "jon.maloy@ericsson.com" <jon.maloy@ericsson.com>,
        "Xue, Ying" <Ying.Xue@windriver.com>,
        "Gao, Zhenbo" <Zhenbo.Gao@windriver.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] tipc: fix the big/little endian issue in tipc_dest
Thread-Topic: [PATCH net] tipc: fix the big/little endian issue in tipc_dest
Thread-Index: AQHUOsIv5vQS/UHLV0WwXwqj55Pg9aTRqYqAgAE0cgA=
Date:   Mon, 27 Aug 2018 02:01:14 +0000
Message-ID: <C2A454FDE6C23F41BD5011E2458C46C9F30147AB@ALA-MBD.corp.ad.wrs.com>
References: <1535014158-18578-1-git-send-email-Haiqing.Bai@windriver.com>
 <20180825.173641.1890220553842463695.davem@davemloft.net>
In-Reply-To: <20180825.173641.1890220553842463695.davem@davemloft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [128.224.176.244]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzLCAgVjIgd2lsbCAgYmUgc2VuZCBvdXQuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQpGcm9tOiBEYXZpZCBNaWxsZXIgW21haWx0bzpkYXZlbUBkYXZlbWxvZnQubmV0XSANClNl
bnQ6IDIwMTjE6jjUwjI2yNUgODozNw0KVG86IEJhaSwgSGFpcWluZw0KQ2M6IG5ldGRldkB2Z2Vy
Lmtlcm5lbC5vcmc7IGpvbi5tYWxveUBlcmljc3Nvbi5jb207IFh1ZSwgWWluZzsgR2FvLCBaaGVu
Ym87IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0
XSB0aXBjOiBmaXggdGhlIGJpZy9saXR0bGUgZW5kaWFuIGlzc3VlIGluIHRpcGNfZGVzdA0KDQpG
cm9tOiBIYWlxaW5nIEJhaSA8SGFpcWluZy5CYWlAd2luZHJpdmVyLmNvbT4NCkRhdGU6IFRodSwg
MjMgQXVnIDIwMTggMTY6NDk6MTggKzA4MDANCg0KPiBGaXhlczogZDA2YjJmYTM0ZjE4ICgidGlw
YzogaW1wcm92ZSBkZXN0aW5hdGlvbiBsaW5rZWQgbGlzdCIpDQoNClBsZWFzZSBmaXggdGhpczoN
Cg0KW2RhdmVtQGxvY2FsaG9zdCBuZXRdJCBnaXQgZGVzY3JpYmUgZDA2YjJmYTM0ZjE4DQpmYXRh
bDogTm90IGEgdmFsaWQgb2JqZWN0IG5hbWUgZDA2YjJmYTM0ZjE4DQo=
