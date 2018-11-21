Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF5BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67993214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67993214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732685AbeKVE10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:27:26 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:39215 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729179AbeKVE1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 23:27:25 -0500
Received: by mail-it1-f199.google.com with SMTP id k133so7696526ite.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 09:52:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-transfer-encoding;
        bh=B2vvCar/KLQ8fyCZfvnIQMa38sTy9JCVDDWnoh6WsYM=;
        b=EAUfp2xE/uMPRoZkscQzdxxhZslXhuVNDK7DXd/H9HkPCGZ06VkYCrZ+h76i8WLji5
         oI60g+hspiePG6CoqD7b2G+7UH3UkR/pGD1p/zaHZHWnp+YepffUEFsUKCpvXmk38H5t
         YRFAIHmOgVjJFCvFyRqkGhsIrVGV0DaUXicum5srhkFzjD8iR+uklinJpGZzYgIyuHzo
         N7FmVRzmUaf8m32jyPWRw3C/JC0kjXHF0BASjkNmyfQtsPBvf7+l6bnQHfSjQnEBLgX9
         10/uZ0y+tqfb1/I8AMSJtUgTdumJTUhoKnldEYWYelOFJIl2OwowNvisyA7XW0/aa1zd
         oSSg==
X-Gm-Message-State: AA+aEWboffFHnKdNfMeRU61yTIy4xzrI8LnTr8uCLBVtjuVNGjWbK4Gi
        l0gkd5f0HEuAxbWPU/MXX2yhsvHvLl6MkZpDgQCxbg9FO3D8
X-Google-Smtp-Source: AFSGD/VZ/jrm48cdL4txz0eHr9dDkGpRKtamrU9UqwkRkn0XBnODmAJlbQZi/dMXEsj6UEhc6J8eJmvKq4dUIIrgCkKq8pdeq2++
MIME-Version: 1.0
X-Received: by 2002:a5e:d919:: with SMTP id n25-v6mr4547748iop.0.1542822723434;
 Wed, 21 Nov 2018 09:52:03 -0800 (PST)
Date:   Wed, 21 Nov 2018 09:52:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000061c4cf057b306863@google.com>
Subject: WARNING in remove_proc_entry (2)
From:   syzbot <syzbot+46d1fec9e51890edb1a6@syzkaller.appspotmail.com>
To:     andy@greyhouse.net, davem@davemloft.net, j.vosburgh@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, vfalico@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCnN5emJvdCBmb3VuZCB0aGUgZm9sbG93aW5nIGNyYXNoIG9uOg0KDQpIRUFEIGNv
bW1pdDogICAgYzhjZTk0YjhmZTUzIE1lcmdlIHRhZyAnbWlwc19maXhlc180LjIwXzMnIG9mIGdp
dDovL2dpdC5rZS4uDQpnaXQgdHJlZTogICAgICAgdXBzdHJlYW0NCmNvbnNvbGUgb3V0cHV0OiBo
dHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS94L2xvZy50eHQ/eD0xMzI1ZjIyNTQwMDAwMA0K
a2VybmVsIGNvbmZpZzogIGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvLmNvbmZpZz94
PTczZTJiYzBjYjY0NjM0NDYNCmRhc2hib2FyZCBsaW5rOiBodHRwczovL3N5emthbGxlci5hcHBz
cG90LmNvbS9idWc/ZXh0aWQ9NDZkMWZlYzllNTE4OTBlZGIxYTYNCmNvbXBpbGVyOiAgICAgICBn
Y2MgKEdDQykgOC4wLjEgMjAxODA0MTMgKGV4cGVyaW1lbnRhbCkNCg0KVW5mb3J0dW5hdGVseSwg
SSBkb24ndCBoYXZlIGFueSByZXByb2R1Y2VyIGZvciB0aGlzIGNyYXNoIHlldC4NCg0KSU1QT1JU
QU5UOiBpZiB5b3UgZml4IHRoZSBidWcsIHBsZWFzZSBhZGQgdGhlIGZvbGxvd2luZyB0YWcgdG8g
dGhlIGNvbW1pdDoNClJlcG9ydGVkLWJ5OiBzeXpib3QrNDZkMWZlYzllNTE4OTBlZGIxYTZAc3l6
a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQ0KDQpJUHY2OiBBRERSQ09ORihORVRERVZfVVApOiBicmlk
Z2UwOiBsaW5rIGlzIG5vdCByZWFkeQ0KSVB2NjogQUREUkNPTkYoTkVUREVWX0NIQU5HRSk6IGJy
aWRnZTA6IGxpbmsgYmVjb21lcyByZWFkeQ0KSVB2NjogQUREUkNPTkYoTkVUREVWX0NIQU5HRSk6
IGJyaWRnZTA6IGxpbmsgYmVjb21lcyByZWFkeQ0KLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0t
LS0tLS0tLS0tDQpyZW1vdmVfcHJvY19lbnRyeTogcmVtb3Zpbmcgbm9uLWVtcHR5IGRpcmVjdG9y
eSAnbmV0L2JvbmRpbmcnLCBsZWFraW5nIGF0ICANCmxlYXN0ICfvv70PJw0KV0FSTklORzogQ1BV
OiAwIFBJRDogOTAwMSBhdCBmcy9wcm9jL2dlbmVyaWMuYzo2ODEgIA0KcmVtb3ZlX3Byb2NfZW50
cnkrMHgzZTEvMHg0YTAgZnMvcHJvYy9nZW5lcmljLmM6Njc5DQpLZXJuZWwgcGFuaWMgLSBub3Qg
c3luY2luZzogcGFuaWNfb25fd2FybiBzZXQgLi4uDQpDUFU6IDAgUElEOiA5MDAxIENvbW06IGt3
b3JrZXIvdTQ6NiBOb3QgdGFpbnRlZCA0LjIwLjAtcmMzKyAjMzQzDQpIYXJkd2FyZSBuYW1lOiBH
b29nbGUgR29vZ2xlIENvbXB1dGUgRW5naW5lL0dvb2dsZSBDb21wdXRlIEVuZ2luZSwgQklPUyAg
DQpHb29nbGUgMDEvMDEvMjAxMQ0KV29ya3F1ZXVlOiBuZXRucyBjbGVhbnVwX25ldA0KQ2FsbCBU
cmFjZToNCiAgX19kdW1wX3N0YWNrIGxpYi9kdW1wX3N0YWNrLmM6NzcgW2lubGluZV0NCiAgZHVt
cF9zdGFjaysweDI0NC8weDM5ZCBsaWIvZHVtcF9zdGFjay5jOjExMw0KICBwYW5pYysweDJhZC8w
eDU1YyBrZXJuZWwvcGFuaWMuYzoxODgNCiAgX193YXJuLmNvbGQuOCsweDIwLzB4NDUga2VybmVs
L3BhbmljLmM6NTQwDQogIHJlcG9ydF9idWcrMHgyNTQvMHgyZDAgbGliL2J1Zy5jOjE4Ng0KICBm
aXh1cF9idWcgYXJjaC94ODYva2VybmVsL3RyYXBzLmM6MTc4IFtpbmxpbmVdDQogIGRvX2Vycm9y
X3RyYXArMHgxMWIvMHgyMDAgYXJjaC94ODYva2VybmVsL3RyYXBzLmM6MjcxDQogIGRvX2ludmFs
aWRfb3ArMHgzNi8weDQwIGFyY2gveDg2L2tlcm5lbC90cmFwcy5jOjI5MA0KICBpbnZhbGlkX29w
KzB4MTQvMHgyMCBhcmNoL3g4Ni9lbnRyeS9lbnRyeV82NC5TOjk2OQ0KUklQOiAwMDEwOnJlbW92
ZV9wcm9jX2VudHJ5KzB4M2UxLzB4NGEwIGZzL3Byb2MvZ2VuZXJpYy5jOjY3OQ0KQ29kZTogZmEg
NDggYzEgZWEgMDMgODAgM2MgMDIgMDAgMGYgODUgODYgMDAgMDAgMDAgNDkgOGIgOTQgMjQgYzgg
MDAgMDAgMDAgIA0KNDggYzcgYzYgODAgMmYgMzcgODggNDggYzcgYzcgMDAgMmYgMzcgODggZTgg
MWYgYzkgNTIgZmYgPDBmPiAwYiBlOSAxOSBmZSAgDQpmZiBmZiBlOCA5MyBiNyBjYyBmZiBlOSA4
OCBmZCBmZiBmZiBlOCA0OSBiOCBjYyBmZg0KUlNQOiAwMDAwOmZmZmY4ODgxN2UzMTcyZjAgRUZM
QUdTOiAwMDAxMDI4Mg0KUkFYOiAwMDAwMDAwMDAwMDAwMDAwIFJCWDogZmZmZjg4ODFjMDYwMjE4
MCBSQ1g6IDAwMDAwMDAwMDAwMDAwMDANClJEWDogMDAwMDAwMDAwMDAwMDAwMCBSU0k6IGZmZmZm
ZmZmODE2NWVhZjUgUkRJOiAwMDAwMDAwMDAwMDAwMDA1DQpSQlA6IGZmZmY4ODgxN2UzMTczYzgg
UjA4OiBmZmZmODg4MWMwZTg4NDAwIFIwOTogZmZmZmVkMTAzYjVjNTAyMA0KUjEwOiBmZmZmZWQx
MDNiNWM1MDIwIFIxMTogZmZmZjg4ODFkYWUyODEwNyBSMTI6IGZmZmY4ODgxY2VkMWUzNDANClIx
MzogZmZmZjg4ODE3ZTMxNzMyMCBSMTQ6IDFmZmZmMTEwMmZjNjJlNjAgUjE1OiBmZmZmODg4MWMw
NjAyMjI4DQogIGJvbmRfZGVzdHJveV9wcm9jX2RpcisweDg3LzB4ZGQgZHJpdmVycy9uZXQvYm9u
ZGluZy9ib25kX3Byb2Nmcy5jOjMwNw0KICBib25kX25ldF9leGl0KzB4MzNmLzB4NGQwIGRyaXZl
cnMvbmV0L2JvbmRpbmcvYm9uZF9tYWluLmM6NDgzNw0KICBvcHNfZXhpdF9saXN0LmlzcmEuNSsw
eGIwLzB4MTYwIG5ldC9jb3JlL25ldF9uYW1lc3BhY2UuYzoxNTMNCiAgY2xlYW51cF9uZXQrMHg1
NTUvMHhiMTAgbmV0L2NvcmUvbmV0X25hbWVzcGFjZS5jOjU1MQ0KICBwcm9jZXNzX29uZV93b3Jr
KzB4YzkwLzB4MWM0MCBrZXJuZWwvd29ya3F1ZXVlLmM6MjE1Mw0KICB3b3JrZXJfdGhyZWFkKzB4
MTdmLzB4MTM5MCBrZXJuZWwvd29ya3F1ZXVlLmM6MjI5Ng0KICBrdGhyZWFkKzB4MzVhLzB4NDQw
IGtlcm5lbC9rdGhyZWFkLmM6MjQ2DQogIHJldF9mcm9tX2ZvcmsrMHgzYS8weDUwIGFyY2gveDg2
L2VudHJ5L2VudHJ5XzY0LlM6MzUyDQpLZXJuZWwgT2Zmc2V0OiBkaXNhYmxlZA0KUmVib290aW5n
IGluIDg2NDAwIHNlY29uZHMuLg0KDQoNCi0tLQ0KVGhpcyBidWcgaXMgZ2VuZXJhdGVkIGJ5IGEg
Ym90LiBJdCBtYXkgY29udGFpbiBlcnJvcnMuDQpTZWUgaHR0cHM6Ly9nb28uZ2wvdHBzbUVKIGZv
ciBtb3JlIGluZm9ybWF0aW9uIGFib3V0IHN5emJvdC4NCnN5emJvdCBlbmdpbmVlcnMgY2FuIGJl
IHJlYWNoZWQgYXQgc3l6a2FsbGVyQGdvb2dsZWdyb3Vwcy5jb20uDQoNCnN5emJvdCB3aWxsIGtl
ZXAgdHJhY2sgb2YgdGhpcyBidWcgcmVwb3J0LiBTZWU6DQpodHRwczovL2dvby5nbC90cHNtRUoj
YnVnLXN0YXR1cy10cmFja2luZyBmb3IgaG93IHRvIGNvbW11bmljYXRlIHdpdGggIA0Kc3l6Ym90
Lg0K
