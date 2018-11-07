Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFA2C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B3020862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:00:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B3020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbeKHEbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 23:31:45 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:41261 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbeKHEbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 23:31:44 -0500
Received: by mail-it1-f199.google.com with SMTP id s195-v6so3746832itc.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 11:00:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-transfer-encoding;
        bh=WcFTKclafqKHvD5XX8AFxeH8l3c61ghKK/bFBxMd+tY=;
        b=hkqwITkTdNxVOqpkXTE9aiNe16/ogq3Dp/C6pxf2ty6RweiUC60StcOuilgjSNQDoN
         BhwsNicaS8cuUleNHiKanKo/CS4XXJT0l2XuOqGqTC6eopM0/CLxNnc6KhuYe/uhM7Wh
         KJ+w4XHtyRPVGSNP5EekFc0K2RlcP+qQobhDtrkZ/czEImiV3uxtcfnh3ysBd07/vSNc
         Eb1v7McBXfuaTZRDEGymvIxpqmL7EMb1bIBpF+SIH3ppqzz8Z0ozREGhJ0RBbnBAOvQr
         B4kxrl3ZtC976ct//cplviTGwmXjKTyYoG6WrxACBSVJQhottceNlct4nSKYNHKTkhR9
         zmbQ==
X-Gm-Message-State: AGRZ1gKAF4LccWFiLAEJxDMfwmkvDZ/IJ8eslZJL/rBR4hcnnXQOVTi/
        AWETxdRHTpnrDOpgO5QnekyPdCgxghicFM19qbN5hFvmnRN8
X-Google-Smtp-Source: AJdET5eH02RSAaGQv8cjAzp2oL+2LeFQ+zQuRQb5epk5gY4j6m6XJJISolTWInBl/yVLxRpv5W+y1/DGbqaJQgjLJ2/B8fIl7jfd
MIME-Version: 1.0
X-Received: by 2002:a02:4d44:: with SMTP id l65-v6mr1102124jab.6.1541617204454;
 Wed, 07 Nov 2018 11:00:04 -0800 (PST)
Date:   Wed, 07 Nov 2018 11:00:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d9f094057a17b97b@google.com>
Subject: WARNING in rollback_registered_many (2)
From:   syzbot <syzbot+40918e4d826fb2ff9b96@syzkaller.appspotmail.com>
To:     avagin@virtuozzo.com, davem@davemloft.net, ebiederm@xmission.com,
        edumazet@google.com, ktkhai@virtuozzo.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tyhicks@canonical.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCnN5emJvdCBmb3VuZCB0aGUgZm9sbG93aW5nIGNyYXNoIG9uOg0KDQpIRUFEIGNv
bW1pdDogICAgMDQyY2I1NjQ3ODE1IG5ldDogcGh5OiBBbGxvdyBCQ001NDYxNlMgUEhZIHRvIHNl
dHVwIGludGVybi4uDQpnaXQgdHJlZTogICAgICAgbmV0DQpjb25zb2xlIG91dHB1dDogaHR0cHM6
Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20veC9sb2cudHh0P3g9MTVjMDEwMmI0MDAwMDANCmtlcm5l
bCBjb25maWc6ICBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS94Ly5jb25maWc/eD04ZjU1
OWZlZTJmYzMzNzVhDQpkYXNoYm9hcmQgbGluazogaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5j
b20vYnVnP2V4dGlkPTQwOTE4ZTRkODI2ZmIyZmY5Yjk2DQpjb21waWxlcjogICAgICAgZ2NjIChH
Q0MpIDguMC4xIDIwMTgwNDEzIChleHBlcmltZW50YWwpDQoNClVuZm9ydHVuYXRlbHksIEkgZG9u
J3QgaGF2ZSBhbnkgcmVwcm9kdWNlciBmb3IgdGhpcyBjcmFzaCB5ZXQuDQoNCklNUE9SVEFOVDog
aWYgeW91IGZpeCB0aGUgYnVnLCBwbGVhc2UgYWRkIHRoZSBmb2xsb3dpbmcgdGFnIHRvIHRoZSBj
b21taXQ6DQpSZXBvcnRlZC1ieTogc3l6Ym90KzQwOTE4ZTRkODI2ZmIyZmY5Yjk2QHN5emthbGxl
ci5hcHBzcG90bWFpbC5jb20NCg0KZGV2aWNlIGJyaWRnZV9zbGF2ZV8wIGxlZnQgcHJvbWlzY3Vv
dXMgbW9kZQ0K77+977+9OiBwb3J0IDEoYnJpZGdlX3NsYXZlXzApIGVudGVyZWQgZGlzYWJsZWQg
c3RhdGUNCmJvbmQyICh1bnJlZ2lzdGVyaW5nKTogUmVsZWFzZWQgYWxsIHNsYXZlcw0KYm9uZDEg
KHVucmVnaXN0ZXJpbmcpOiBSZWxlYXNlZCBhbGwgc2xhdmVzDQpib25kMCAodW5yZWdpc3Rlcmlu
Zyk6IFJlbGVhc2VkIGFsbCBzbGF2ZXMNCldBUk5JTkc6IENQVTogMSBQSUQ6IDk3NDggYXQgbmV0
L2NvcmUvZGV2LmM6ODAyMiAgDQpyb2xsYmFja19yZWdpc3RlcmVkX21hbnkrMHhlY2EvMHgxMjUw
IG5ldC9jb3JlL2Rldi5jOjgwMjINCktlcm5lbCBwYW5pYyAtIG5vdCBzeW5jaW5nOiBwYW5pY19v
bl93YXJuIHNldCAuLi4NCkNQVTogMSBQSUQ6IDk3NDggQ29tbToga3dvcmtlci91NDo1IE5vdCB0
YWludGVkIDQuMjAuMC1yYzErICMxNzQNCkhhcmR3YXJlIG5hbWU6IEdvb2dsZSBHb29nbGUgQ29t
cHV0ZSBFbmdpbmUvR29vZ2xlIENvbXB1dGUgRW5naW5lLCBCSU9TICANCkdvb2dsZSAwMS8wMS8y
MDExDQpXb3JrcXVldWU6IG5ldG5zIGNsZWFudXBfbmV0DQpDYWxsIFRyYWNlOg0KICBfX2R1bXBf
c3RhY2sgbGliL2R1bXBfc3RhY2suYzo3NyBbaW5saW5lXQ0KICBkdW1wX3N0YWNrKzB4MjQ0LzB4
MzlkIGxpYi9kdW1wX3N0YWNrLmM6MTEzDQogIHBhbmljKzB4MmFkLzB4NTVjIGtlcm5lbC9wYW5p
Yy5jOjE4OA0KICBfX3dhcm4uY29sZC44KzB4MjAvMHg0NSBrZXJuZWwvcGFuaWMuYzo1NDANCiAg
cmVwb3J0X2J1ZysweDI1NC8weDJkMCBsaWIvYnVnLmM6MTg2DQogIGZpeHVwX2J1ZyBhcmNoL3g4
Ni9rZXJuZWwvdHJhcHMuYzoxNzggW2lubGluZV0NCiAgZG9fZXJyb3JfdHJhcCsweDExYi8weDIw
MCBhcmNoL3g4Ni9rZXJuZWwvdHJhcHMuYzoyNzENCiAgZG9faW52YWxpZF9vcCsweDM2LzB4NDAg
YXJjaC94ODYva2VybmVsL3RyYXBzLmM6MjkwDQogIGludmFsaWRfb3ArMHgxNC8weDIwIGFyY2gv
eDg2L2VudHJ5L2VudHJ5XzY0LlM6OTY5DQpSSVA6IDAwMTA6cm9sbGJhY2tfcmVnaXN0ZXJlZF9t
YW55KzB4ZWNhLzB4MTI1MCBuZXQvY29yZS9kZXYuYzo4MDIyDQpDb2RlOiA1NyAxOSAwMCAwMCA0
OCBjNyBjNiBlMCAwMSBiYiA4OCA0OCBjNyBjNyAyMCAwMiBiYiA4OCBjNiAwNSBlYSAyZSBlZCAg
DQowMyAwMSBlOCBlMiBjMCAyNCBmYiAwZiAwYiBlOSBhNiBmOSBmZiBmZiBlOCAwNiA1ZiA1YiBm
YiA8MGY+IDBiIGU5IDdiIGY5ICANCmZmIGZmIGU4IGZhIDVlIDViIGZiIDBmIDBiIGU5IGVhIGY5
IGZmIGZmIGU4IGVlIDVlDQpSU1A6IDAwMTg6ZmZmZjg4MDFiYmMxNzA1OCBFRkxBR1M6IDAwMDEw
MjkzDQpSQVg6IGZmZmY4ODAxODc4NDgyODAgUkJYOiBmZmZmODgwMTkyYzMxMjQwIFJDWDogZmZm
ZmZmZmY4NjI0MjUzMw0KUkRYOiAwMDAwMDAwMDAwMDAwMDAwIFJTSTogZmZmZmZmZmY4NjI0MmJi
YSBSREk6IDAwMDAwMDAwMDAwMDAwMDENClJCUDogZmZmZjg4MDFiYmMxNzJhMCBSMDg6IGZmZmY4
ODAxODc4NDgyODAgUjA5OiBmZmZmZmJmZmYxM2RlZTYwDQpSMTA6IGZmZmZmYmZmZjEzZGVlNjAg
UjExOiBmZmZmZmZmZjg5ZWY3MzA3IFIxMjogZGZmZmZjMDAwMDAwMDAwMA0KUjEzOiAwMDAwMDAw
MDAwMDAwMDAxIFIxNDogZmZmZmZmZmY4NDg4OTMwMCBSMTU6IGZmZmY4ODAxYmJjMTcxMzgNCiAg
dW5yZWdpc3Rlcl9uZXRkZXZpY2VfbWFueSsweGZhLzB4NGMwIG5ldC9jb3JlL2Rldi5jOjkxMDcN
CiAgZGVmYXVsdF9kZXZpY2VfZXhpdF9iYXRjaCsweDQzYS8weDU0MCBuZXQvY29yZS9kZXYuYzo5
NTc2DQogIG9wc19leGl0X2xpc3QuaXNyYS41KzB4MTA1LzB4MTYwIG5ldC9jb3JlL25ldF9uYW1l
c3BhY2UuYzoxNTYNCiAgY2xlYW51cF9uZXQrMHg1NTUvMHhiMTAgbmV0L2NvcmUvbmV0X25hbWVz
cGFjZS5jOjU1MQ0KICBwcm9jZXNzX29uZV93b3JrKzB4YzkwLzB4MWM0MCBrZXJuZWwvd29ya3F1
ZXVlLmM6MjE1Mw0KICB3b3JrZXJfdGhyZWFkKzB4MTdmLzB4MTM5MCBrZXJuZWwvd29ya3F1ZXVl
LmM6MjI5Ng0KICBrdGhyZWFkKzB4MzVhLzB4NDQwIGtlcm5lbC9rdGhyZWFkLmM6MjQ2DQogIHJl
dF9mcm9tX2ZvcmsrMHgzYS8weDUwIGFyY2gveDg2L2VudHJ5L2VudHJ5XzY0LlM6MzUyDQpLZXJu
ZWwgT2Zmc2V0OiBkaXNhYmxlZA0KUmVib290aW5nIGluIDg2NDAwIHNlY29uZHMuLg0KDQoNCi0t
LQ0KVGhpcyBidWcgaXMgZ2VuZXJhdGVkIGJ5IGEgYm90LiBJdCBtYXkgY29udGFpbiBlcnJvcnMu
DQpTZWUgaHR0cHM6Ly9nb28uZ2wvdHBzbUVKIGZvciBtb3JlIGluZm9ybWF0aW9uIGFib3V0IHN5
emJvdC4NCnN5emJvdCBlbmdpbmVlcnMgY2FuIGJlIHJlYWNoZWQgYXQgc3l6a2FsbGVyQGdvb2ds
ZWdyb3Vwcy5jb20uDQoNCnN5emJvdCB3aWxsIGtlZXAgdHJhY2sgb2YgdGhpcyBidWcgcmVwb3J0
LiBTZWU6DQpodHRwczovL2dvby5nbC90cHNtRUojYnVnLXN0YXR1cy10cmFja2luZyBmb3IgaG93
IHRvIGNvbW11bmljYXRlIHdpdGggIA0Kc3l6Ym90Lg0K
