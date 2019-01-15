Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD77C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 04:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D9520651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 04:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfAOEnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 23:43:04 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:40349 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfAOEnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 23:43:04 -0500
Received: by mail-io1-f69.google.com with SMTP id u2so1087996iob.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 20:43:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-transfer-encoding;
        bh=+ZN2k/FAzbBiH8bFl9sH6z6FpVTp2oha0mwreEMwqrA=;
        b=aKwH5Tdkccdcyod6GMq9bs38bnOJP+7CahDAaTrNjc78joF0OcAUCV8tCJcg376Ecg
         C8ficKj0Pt6+xuwgFoioUfKoKBnObgnWZc5uyFK2Ut3f1loCh+Kw34JK6Ag+bur0iRHu
         BLDc/3hkf4YmijIbrxr43DOi8kLOkTVrAokbAzVy+jq7nq6GT9VINTTalw7dZaEg0pd5
         DEtL+JAvILDAlIMsxz1WiBXtEdHv3Qi6jL34Opc4nEOjjgiVtTShxhIMzQYt86rcY7+Y
         73xYec5UXRfsiw3uWiKx9S2z1VIAdh3Bq/Qid6tz95MzPRsSUwaxSCO2R57dRo0YZHD9
         rn+w==
X-Gm-Message-State: AJcUukdIEIGnw1e52ZziUBVnE2P5xMTGXff4HcL1C33XZj8aSq5JMzjP
        YG2HiF3k+aR+cA1C6gFsyZlvpZhyF1sre3Om5TB34qQcL9fv
X-Google-Smtp-Source: ALg8bN5IJ8jBC/pJ7LLxE8gvsIqAvivcDUoZPQNVLC3bMdmo9hsIUszlSm+1zKbyLpjO6IZ6O46ya5d0nk8RUY4iucPnWKjgYVqN
MIME-Version: 1.0
X-Received: by 2002:a6b:680a:: with SMTP id d10mr1058562ioc.35.1547527383190;
 Mon, 14 Jan 2019 20:43:03 -0800 (PST)
Date:   Mon, 14 Jan 2019 20:43:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f49537057f77cb00@google.com>
Subject: KASAN: use-after-scope Read in corrupted
From:   syzbot <syzbot+bd36b7dd9330f67037ab@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, cai@lca.pw, crecklin@redhat.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCnN5emJvdCBmb3VuZCB0aGUgZm9sbG93aW5nIGNyYXNoIG9uOg0KDQpIRUFEIGNv
bW1pdDogICAgMWJkYmUyMjc0OTIwIE1lcmdlIHRhZyAndmZpby12NS4wLXJjMicgb2YgZ2l0Oi8v
Z2l0aHViLmNvbS4uDQpnaXQgdHJlZTogICAgICAgdXBzdHJlYW0NCmNvbnNvbGUgb3V0cHV0OiBo
dHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS94L2xvZy50eHQ/eD0xNTE5ZDM5ZjQwMDAwMA0K
a2VybmVsIGNvbmZpZzogIGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvLmNvbmZpZz94
PWVkZjFjMzAzMTA5N2MzMDQNCmRhc2hib2FyZCBsaW5rOiBodHRwczovL3N5emthbGxlci5hcHBz
cG90LmNvbS9idWc/ZXh0aWQ9YmQzNmI3ZGQ5MzMwZjY3MDM3YWINCmNvbXBpbGVyOiAgICAgICBn
Y2MgKEdDQykgOS4wLjAgMjAxODEyMzEgKGV4cGVyaW1lbnRhbCkNCnN5eiByZXBybzogICAgICBo
dHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS94L3JlcHJvLnN5ej94PTEwZmNlMTRmNDAwMDAw
DQpDIHJlcHJvZHVjZXI6ICAgaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20veC9yZXByby5j
P3g9MTEwYjIwMTc0MDAwMDANCg0KSU1QT1JUQU5UOiBpZiB5b3UgZml4IHRoZSBidWcsIHBsZWFz
ZSBhZGQgdGhlIGZvbGxvd2luZyB0YWcgdG8gdGhlIGNvbW1pdDoNClJlcG9ydGVkLWJ5OiBzeXpi
b3QrYmQzNmI3ZGQ5MzMwZjY3MDM3YWJAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQ0KDQo9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0NCkJVRzogS0FTQU46IHVzZS1hZnRlci1zY29wZSBpbiBkZWJ1Z19sb2NrZGVwX3JjdV9l
bmFibGVkLnBhcnQuMCsweDUwLzB4NjAgIA0Ka2VybmVsL3JjdS91cGRhdGUuYzoyNDkNClJlYWQg
b2Ygc2l6ZSA0IGF0IGFkZHIgZmZmZjg4ODBhOTQ1ZWFiYyBieSB0YXNrICANCmA577+977+977+9
77+977+977+9I++/vSgVEO+/ve+/ve+/ve+/ve+/vTzvv73vv73vv73vv73vv70QGmvvv73vv73v
v73vv73vv73vv73vv71F77+977+977+977+977+9Pjlo77+977+977+977+977+977+977+977+9
QS8tMjEyMjE4ODYzNA0KDQpDUFU6IDAgUElEOiAtMjEyMjE4ODYzNCBDb21tOiDvv73vv71F77+9
77+977+977+977+977+977+977+977+977+977+977+977+9TzLvv70gTm90IHRhaW50ZWQgNS4w
LjAtcmMxKyAgDQojMTkNCkhhcmR3YXJlIG5hbWU6IEdvb2dsZSBHb29nbGUgQ29tcHV0ZSBFbmdp
bmUvR29vZ2xlIENvbXB1dGUgRW5naW5lLCBCSU9TICANCkdvb2dsZSAwMS8wMS8yMDExDQotLS0t
LS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0NCkJhZCBvciBtaXNzaW5nIHVzZXJjb3B5
IHdoaXRlbGlzdD8gS2VybmVsIG1lbW9yeSBvdmVyd3JpdGUgYXR0ZW1wdCBkZXRlY3RlZCAgDQp0
byBTTEFCIG9iamVjdCAndGFza19zdHJ1Y3QnIChvZmZzZXQgMTM0NCwgc2l6ZSA4KSENCldBUk5J
Tkc6IENQVTogMCBQSUQ6IC0xNDU1MDM2Mjg4IGF0IG1tL3VzZXJjb3B5LmM6NzggIA0KdXNlcmNv
cHlfd2FybisweGViLzB4MTEwIG1tL3VzZXJjb3B5LmM6NzgNCktlcm5lbCBwYW5pYyAtIG5vdCBz
eW5jaW5nOiBwYW5pY19vbl93YXJuIHNldCAuLi4NCkNQVTogMCBQSUQ6IC0xNDU1MDM2Mjg4IENv
bW06IO+/ve+/vUXvv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv71PMu+/vSBO
b3QgdGFpbnRlZCA1LjAuMC1yYzErICANCiMxOQ0KSGFyZHdhcmUgbmFtZTogR29vZ2xlIEdvb2ds
ZSBDb21wdXRlIEVuZ2luZS9Hb29nbGUgQ29tcHV0ZSBFbmdpbmUsIEJJT1MgIA0KR29vZ2xlIDAx
LzAxLzIwMTENCkNhbGwgVHJhY2U6DQpLZXJuZWwgT2Zmc2V0OiBkaXNhYmxlZA0KUmVib290aW5n
IGluIDg2NDAwIHNlY29uZHMuLg0KDQoNCi0tLQ0KVGhpcyBidWcgaXMgZ2VuZXJhdGVkIGJ5IGEg
Ym90LiBJdCBtYXkgY29udGFpbiBlcnJvcnMuDQpTZWUgaHR0cHM6Ly9nb28uZ2wvdHBzbUVKIGZv
ciBtb3JlIGluZm9ybWF0aW9uIGFib3V0IHN5emJvdC4NCnN5emJvdCBlbmdpbmVlcnMgY2FuIGJl
IHJlYWNoZWQgYXQgc3l6a2FsbGVyQGdvb2dsZWdyb3Vwcy5jb20uDQoNCnN5emJvdCB3aWxsIGtl
ZXAgdHJhY2sgb2YgdGhpcyBidWcgcmVwb3J0LiBTZWU6DQpodHRwczovL2dvby5nbC90cHNtRUoj
YnVnLXN0YXR1cy10cmFja2luZyBmb3IgaG93IHRvIGNvbW11bmljYXRlIHdpdGggIA0Kc3l6Ym90
Lg0Kc3l6Ym90IGNhbiB0ZXN0IHBhdGNoZXMgZm9yIHRoaXMgYnVnLCBmb3IgZGV0YWlscyBzZWU6
DQpodHRwczovL2dvby5nbC90cHNtRUojdGVzdGluZy1wYXRjaGVzDQo=
