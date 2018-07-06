Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057C7C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBAF420863
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBAF420863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753576AbeGFIJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 04:09:06 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:57795 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753457AbeGFIJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 04:09:02 -0400
Received: by mail-it0-f71.google.com with SMTP id g6-v6so9058410iti.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 01:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:content-transfer-encoding;
        bh=b88685mbWuznjLCgcAgNOoWylkxhI5wGGeRXV/Gn/lU=;
        b=hO8N/5AN6zLT5sA+7xRVHAEUlh4i+evneLII4WIldCSLrcuKpD1mZ2sQsCkSp9N6iL
         msLWEI/tkolVdXYwPhSdJPWto6UcXi/frhuPvXVmX1wKPMmpIoONHqO7iRLn/okM6bYA
         qjkabuFtaz0S4O8EYtMPgpL4ffyyTF5sm7E2ogTHj8iaeA4DluK6A4ujVpM+rEUjnXdU
         bOlgPgVUbumgafxHLzXG7GZrkvsNVpEuPMtWzo3hQg1YicQBwcVcAotoDtii0ThRzkIp
         7haJRuaVvr6B7Oxvaq5lsUTL5jTXCjz+fWsRura8DuEwfyWlrngrurhE/TqDdDh++jjM
         dFjQ==
X-Gm-Message-State: APt69E2/QWSgPj+jt655ZJzCn67bwCE9zn26MoRRw9PbpgqZVt6xBvn/
        3aNw+MUGU1142KW045JBlmM5eZQcki9guFLTKC/ISdPPRSIK
X-Google-Smtp-Source: AAOMgpdMNUAx3izoQYl1mIiP7HoEq0+pHyWjvmI1fT5xGRi5xRgZzu5+w/6wuoLGCuo4UlGqe8doGVR7xqw2bGGPm0ou398YShoi
MIME-Version: 1.0
X-Received: by 2002:a02:b705:: with SMTP id g5-v6mr4054010jam.10.1530864541775;
 Fri, 06 Jul 2018 01:09:01 -0700 (PDT)
Date:   Fri, 06 Jul 2018 01:09:01 -0700
In-Reply-To: <1616306.R4SzcgHSdy@positron.chronox.de>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000363e2e0570502d42@google.com>
Subject: Re: KMSAN: uninit-value in af_alg_free_areq_sgls
From:   syzbot <syzbot+9c251bdd09f83b92ba95@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        smueller@chronox.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCnN5emJvdCB0cmllZCB0byB0ZXN0IHRoZSBwcm9wb3NlZCBwYXRjaCBidXQgYnVp
bGQvYm9vdCBmYWlsZWQ6DQoNCmxvc3QgY29ubmVjdGlvbiB0byB0ZXN0IG1hY2hpbmUNCg0KDQoN
ClsuLi4uXSBTdGFydGluZyBlbmhhbmNlZCBzeXNsb2dkOiByc3lzbG9nZBtbPzI1bBtbPzFjGzcb
WzFHWxtbMzJtIG9rICANChtbMzk7NDltGzgbWz8yNWgbWz8wYy4NClsuLi4uXSBTdGFydGluZyBw
ZXJpb2RpYyBjb21tYW5kIHNjaGVkdWxlcjogY3JvbhtbPzI1bBtbPzFjGzcbWzFHWxtbMzJtIG9r
ICANChtbMzk7NDltGzgbWz8yNWgbWz8wYy4NClsuLi4uXSBTdGFydGluZyBPcGVuQlNEIFNlY3Vy
ZSBTaGVsbCBzZXJ2ZXI6IHNzaGRbICAgMjEuNzA5MjgwXSByYW5kb206ICANCnNzaGQ6IHVuaW5p
dGlhbGl6ZWQgdXJhbmRvbSByZWFkICgzMiBieXRlcyByZWFkKQ0KG1s/MjVsG1s/MWMbNxtbMUdb
G1szMm0gb2sgG1szOTs0OW0bOBtbPzI1aBtbPzBjLg0KDQpEZWJpYW4gR05VL0xpbnV4IDcgc3l6
a2FsbGVyIHR0eVMwDQoNCnN5emthbGxlciBsb2dpbjogWyAgIDI2LjIyOTExM10gcmFuZG9tOiBz
c2hkOiB1bmluaXRpYWxpemVkIHVyYW5kb20gcmVhZCAgDQooMzIgYnl0ZXMgcmVhZCkNClsgICAy
Ni41MzI4NDNdIHJhbmRvbTogc3NoZDogdW5pbml0aWFsaXplZCB1cmFuZG9tIHJlYWQgKDMyIGJ5
dGVzIHJlYWQpDQpbICAgMjcuNzg3Mjc3XSByYW5kb206IHNzaGQ6IHVuaW5pdGlhbGl6ZWQgdXJh
bmRvbSByZWFkICgzMiBieXRlcyByZWFkKQ0KV2FybmluZzogUGVybWFuZW50bHkgYWRkZWQgJzEw
LjEyOC4wLjInIChFQ0RTQSkgdG8gdGhlIGxpc3Qgb2Yga25vd24gaG9zdHMuDQpbICAgMzMuMjk5
MzY4XSByYW5kb206IHNzaGQ6IHVuaW5pdGlhbGl6ZWQgdXJhbmRvbSByZWFkICgzMiBieXRlcyBy
ZWFkKQ0KZmxhZyBwcm92aWRlZCBidXQgbm90IGRlZmluZWQ6IC1vcw0KVXNhZ2Ugb2YgLi9zeXot
ZnV6emVyOg0KICAgLWFib3J0X3NpZ25hbCBpbnQNCiAgICAgCWluaXRpYWwgc2lnbmFsIHRvIHNl
bmQgdG8gZXhlY3V0b3IgaW4gZXJyb3IgY29uZGl0aW9uczsgdXBncmFkZXMgdG8gIA0KU0lHS0lM
TCBpZiBleGVjdXRvciBkb2VzIG5vdCBleGl0DQogICAtYXJjaCBzdHJpbmcNCiAgICAgCXRhcmdl
dCBhcmNoIChkZWZhdWx0ICJhbWQ2NCIpDQogICAtYnVmZmVyX3NpemUgdWludA0KICAgICAJaW50
ZXJuYWwgYnVmZmVyIHNpemUgKGluIGJ5dGVzKSBmb3IgZXhlY3V0b3Igb3V0cHV0DQogICAtY29s
bGlkZQ0KICAgICAJY29sbGlkZSBzeXNjYWxscyB0byBwcm92b2tlIGRhdGEgcmFjZXMgKGRlZmF1
bHQgdHJ1ZSkNCiAgIC1jb3Zlcg0KICAgICAJY29sbGVjdCBmZWVkYmFjayBzaWduYWxzIChjb3Zl
cmFnZSkNCiAgIC1kZWJ1Zw0KICAgICAJZGVidWcgb3V0cHV0IGZyb20gZXhlY3V0b3INCiAgIC1l
eGVjdXRvciBzdHJpbmcNCiAgICAgCXBhdGggdG8gZXhlY3V0b3IgYmluYXJ5IChkZWZhdWx0ICIu
L3N5ei1leGVjdXRvciIpDQogICAtaXBjIHN0cmluZw0KICAgICAJaXBjIHNjaGVtZSAocGlwZS9z
aG1lbSkNCiAgIC1sZWFrDQogICAgIAlkZXRlY3QgbWVtb3J5IGxlYWtzDQogICAtbWFuYWdlciBz
dHJpbmcNCiAgICAgCW1hbmFnZXIgcnBjIGFkZHJlc3MNCiAgIC1uYW1lIHN0cmluZw0KICAgICAJ
dW5pcXVlIG5hbWUgZm9yIG1hbmFnZXIgKGRlZmF1bHQgInRlc3QiKQ0KICAgLW91dHB1dCBzdHJp
bmcNCiAgICAgCXdyaXRlIHByb2dyYW1zIHRvIG5vbmUvc3Rkb3V0L2RtZXNnL2ZpbGUgKGRlZmF1
bHQgInN0ZG91dCIpDQogICAtcHByb2Ygc3RyaW5nDQogICAgIAlhZGRyZXNzIHRvIHNlcnZlIHBw
cm9mIHByb2ZpbGVzDQogICAtcHJvY3MgaW50DQogICAgIAludW1iZXIgb2YgcGFyYWxsZWwgdGVz
dCBwcm9jZXNzZXMgKGRlZmF1bHQgMSkNCiAgIC1zYW5kYm94IHN0cmluZw0KICAgICAJc2FuZGJv
eCBmb3IgZnV6emluZyAobm9uZS9zZXR1aWQvbmFtZXNwYWNlKSAoZGVmYXVsdCAibm9uZSIpDQog
ICAtdGVzdA0KICAgICAJZW5hYmxlIGltYWdlIHRlc3RpbmcgbW9kZQ0KICAgLXRocmVhZGVkDQog
ICAgIAl1c2UgdGhyZWFkZWQgbW9kZSBpbiBleGVjdXRvciAoZGVmYXVsdCB0cnVlKQ0KICAgLXRp
bWVvdXQgZHVyYXRpb24NCiAgICAgCWV4ZWN1dGlvbiB0aW1lb3V0DQogICAtdiBpbnQNCiAgICAg
CXZlcmJvc2l0eQ0KDQoNCg0KVGVzdGVkIG9uOg0KDQpjb21taXQ6ICAgICAgICAgOWM5ZGY5ZjI3
NWYwIGttc2FuOiByZW1vdmUga21zYW5fdGhyZWFkc19yZWFkeQ0KZ2l0IHRyZWU6ICAgICAgIGh0
dHBzOi8vZ2l0aHViLmNvbS9nb29nbGUva21zYW4uZ2l0L21hc3Rlcg0Ka2VybmVsIGNvbmZpZzog
IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvLmNvbmZpZz94PWIxMWY0Y2ZiMjYyZWU2
MDcNCmNvbXBpbGVyOiAgICAgICBjbGFuZyB2ZXJzaW9uIDcuMC4wICh0cnVuayAzMzQxMDQpDQpw
YXRjaDogICAgICAgICAgaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20veC9wYXRjaC5kaWZm
P3g9MTZhNWFmODQ0MDAwMDANCg0K
