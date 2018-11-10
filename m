Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210D3C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 08:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA3DB20840
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 08:42:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA3DB20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbeKJS0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 13:26:16 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:49120 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728833AbeKJS0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 13:26:15 -0500
Received: by mail-io1-f70.google.com with SMTP id c17-v6so4464022ioi.15
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 00:42:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:content-transfer-encoding;
        bh=3DIJHg6advQKsWO2lP0lI4h6QIQoF/9fZ1aZ8Y28p0Y=;
        b=K5SAQYxJXSVSG7kdKGfWv1Jiut+GxLvwOK5Tyudz1Og2pUNpzYjDvRCSZXoBNXHEfy
         PWRutGsO1D2a6zcQT/l3MqEQd5s4k2BE4GWA60ki/AlQ5o9H/5kV/3T3nRtiflKthioa
         AuDMZ7QrGGvdK3W4YE07Sx4zNaNKZgX413oxWsuj3Aa7nAimMuLuz0yH5049g6nfNRT9
         CWZkMqWB6UF880wovB1fYw7NaghqamAMvWqlFJ4cDRmTmpCc44ahG8zft3q8xEPJzTl5
         RvhmLhZXldfSNLOQHnEcWeJ36XoyEFNWoL0/5wGYkmjvZL9NETv4D+MySXv9HoNKx8z3
         Wmmg==
X-Gm-Message-State: AGRZ1gKll8M1RJyorRTEzD6vnU+wvj6/TAaFvShLw+iGe9jLe3IA2q6G
        SjdTbKg4ex4SYFI59Rjq8Bhfaxf6n8olNagqpVY3pg2H4sTt
X-Google-Smtp-Source: AJdET5cRqXxGKfRtQr3WM/ggh3fnd7a4iRLR86ZWS98pNQUz3z8UDrBRvlEKazB714spifjqW7C8p5aRFOm+wLiAzfqSIxSWLBub
MIME-Version: 1.0
X-Received: by 2002:a24:59d1:: with SMTP id p200-v6mr4447407itb.10.1541839323603;
 Sat, 10 Nov 2018 00:42:03 -0800 (PST)
Date:   Sat, 10 Nov 2018 00:42:03 -0800
In-Reply-To: <000000000000e12d4105746dcb0d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002f2da2057a4b7162@google.com>
Subject: Re: WARNING in format_decode (2)
From:   syzbot <syzbot+1ec5c5ec949c4adaa0c4@syzkaller.appspotmail.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        netdev@vger.kernel.org, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

c3l6Ym90IGhhcyBmb3VuZCBhIHJlcHJvZHVjZXIgZm9yIHRoZSBmb2xsb3dpbmcgY3Jhc2ggb246
DQoNCkhFQUQgY29tbWl0OiAgICBkYTg1ZDhiZmQxNTEga3NlbGZ0ZXN0cy9icGY6IHVzZSBwaW5n
NiBhcyB0aGUgZGVmYXVsdCBpcHY2Li4NCmdpdCB0cmVlOiAgICAgICBicGYNCmNvbnNvbGUgb3V0
cHV0OiBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS94L2xvZy50eHQ/eD0xMTZiZjUzMzQw
MDAwMA0Ka2VybmVsIGNvbmZpZzogIGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvLmNv
bmZpZz94PThmNTU5ZmVlMmZjMzM3NWENCmRhc2hib2FyZCBsaW5rOiBodHRwczovL3N5emthbGxl
ci5hcHBzcG90LmNvbS9idWc/ZXh0aWQ9MWVjNWM1ZWM5NDljNGFkYWEwYzQNCmNvbXBpbGVyOiAg
ICAgICBnY2MgKEdDQykgOC4wLjEgMjAxODA0MTMgKGV4cGVyaW1lbnRhbCkNCnN5eiByZXBybzog
ICAgICBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS94L3JlcHJvLnN5ej94PTE2ZDAzMjQ3
NDAwMDAwDQpDIHJlcHJvZHVjZXI6ICAgaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20veC9y
ZXByby5jP3g9MTA0ZjU1MzM0MDAwMDANCg0KSU1QT1JUQU5UOiBpZiB5b3UgZml4IHRoZSBidWcs
IHBsZWFzZSBhZGQgdGhlIGZvbGxvd2luZyB0YWcgdG8gdGhlIGNvbW1pdDoNClJlcG9ydGVkLWJ5
OiBzeXpib3QrMWVjNWM1ZWM5NDljNGFkYWEwYzRAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQ0K
DQoqKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICoqDQoqKiAgIE5PVElDRSBOT1RJQ0UgTk9USUNFIE5PVElDRSBOT1RJQ0UgTk9USUNFIE5PVElD
RSAgICoqDQoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqDQotLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0NClBsZWFzZSBy
ZW1vdmUgdW5zdXBwb3J0ZWQgJQAgaW4gZm9ybWF0IHN0cmluZw0KV0FSTklORzogQ1BVOiAwIFBJ
RDogNTY1NCBhdCBsaWIvdnNwcmludGYuYzoyMTUyIGZvcm1hdF9kZWNvZGUrMHg4ZmMvMHhhZjAg
IA0KbGliL3ZzcHJpbnRmLmM6MjE1Mg0KS2VybmVsIHBhbmljIC0gbm90IHN5bmNpbmc6IHBhbmlj
X29uX3dhcm4gc2V0IC4uLg0KQ1BVOiAwIFBJRDogNTY1NCBDb21tOiBzeXotZXhlY3V0b3I4MTgg
Tm90IHRhaW50ZWQgNC4yMC4wLXJjMSsgIzgwDQpIYXJkd2FyZSBuYW1lOiBHb29nbGUgR29vZ2xl
IENvbXB1dGUgRW5naW5lL0dvb2dsZSBDb21wdXRlIEVuZ2luZSwgQklPUyAgDQpHb29nbGUgMDEv
MDEvMjAxMQ0KQ2FsbCBUcmFjZToNCiAgX19kdW1wX3N0YWNrIGxpYi9kdW1wX3N0YWNrLmM6Nzcg
W2lubGluZV0NCiAgZHVtcF9zdGFjaysweDI0NC8weDM5ZCBsaWIvZHVtcF9zdGFjay5jOjExMw0K
ICBwYW5pYysweDJhZC8weDU1YyBrZXJuZWwvcGFuaWMuYzoxODgNCiAgX193YXJuLmNvbGQuOCsw
eDIwLzB4NDUga2VybmVsL3BhbmljLmM6NTQwDQogIHJlcG9ydF9idWcrMHgyNTQvMHgyZDAgbGli
L2J1Zy5jOjE4Ng0KICBmaXh1cF9idWcgYXJjaC94ODYva2VybmVsL3RyYXBzLmM6MTc4IFtpbmxp
bmVdDQogIGRvX2Vycm9yX3RyYXArMHgxMWIvMHgyMDAgYXJjaC94ODYva2VybmVsL3RyYXBzLmM6
MjcxDQogIGRvX2ludmFsaWRfb3ArMHgzNi8weDQwIGFyY2gveDg2L2tlcm5lbC90cmFwcy5jOjI5
MA0KICBpbnZhbGlkX29wKzB4MTQvMHgyMCBhcmNoL3g4Ni9lbnRyeS9lbnRyeV82NC5TOjk2OQ0K
UklQOiAwMDEwOmZvcm1hdF9kZWNvZGUrMHg4ZmMvMHhhZjAgbGliL3ZzcHJpbnRmLmM6MjE1Mg0K
Q29kZTogZTggYzkgMzcgYjUgZjkgNDEgYzYgNDUgMDAgMTIgZTkgOWIgZmQgZmYgZmYgZTggYmEg
MzcgYjUgZjkgMGYgYmUgZjMgIA0KNDggYzcgYzcgYzAgZjEgZDUgODggYzYgMDUgZDIgMDggNDcg
MDIgMDEgZTggNzQgOTkgN2UgZjkgPDBmPiAwYiA0ZCA4YiA2NiAgDQpjMCBlOSA1OSBmZSBmZiBm
ZiA0OCA4YiBiZCA3MCBmZiBmZiBmZiBlOCA2ZCA4NCBmOA0KUlNQOiAwMDE4OmZmZmY4ODAxYmE3
NmY2NzAgRUZMQUdTOiAwMDAxMDI4Ng0KUkFYOiAwMDAwMDAwMDAwMDAwMDAwIFJCWDogMDAwMDAw
MDAwMDAwMDAwMCBSQ1g6IDAwMDAwMDAwMDAwMDAwMDANClJEWDogMDAwMDAwMDAwMDAwMDAwMCBS
U0k6IGZmZmZmZmZmODE2NWU5YjUgUkRJOiAwMDAwMDAwMDAwMDAwMDA1DQpSQlA6IGZmZmY4ODAx
YmE3NmY3MTggUjA4OiBmZmZmODgwMWI2Y2ZjMGMwIFIwOTogMDAwMDAwMDAwMDAwMDAwMA0KUjEw
OiAwMDAwMDAwMDAwMDAwMDAwIFIxMTogMDAwMDAwMDAwMDAwMDAwMCBSMTI6IGZmZmY4ODAxYmE3
NmZhZWMNClIxMzogZmZmZjg4MDFiYTc2Zjc5MCBSMTQ6IGZmZmY4ODAxYmE3NmY2ZjAgUjE1OiAw
MDAwMDAwMDAwMDAwMDAwDQogIHZzbnByaW50ZisweDE4NS8weDFiNjAgbGliL3ZzcHJpbnRmLmM6
MjI0OA0KICB2c2NucHJpbnRmKzB4MmQvMHg4MCBsaWIvdnNwcmludGYuYzoyMzk5DQogIF9fdHJh
Y2VfYXJyYXlfdnByaW50ay5wYXJ0LjU5KzB4NWIvMHgyZjAga2VybmVsL3RyYWNlL3RyYWNlLmM6
Mjk5Mg0KICBfX3RyYWNlX2FycmF5X3ZwcmludGsga2VybmVsL3RyYWNlL3RyYWNlLmM6MzAyMyBb
aW5saW5lXQ0KICB0cmFjZV9hcnJheV92cHJpbnRrIGtlcm5lbC90cmFjZS90cmFjZS5jOjMwMjMg
W2lubGluZV0NCiAgdHJhY2VfdnByaW50aysweDcxLzB4OTAga2VybmVsL3RyYWNlL3RyYWNlLmM6
MzA2MQ0KICBfX3RyYWNlX3ByaW50aysweGNlLzB4MTIwIGtlcm5lbC90cmFjZS90cmFjZV9wcmlu
dGsuYzoyMzgNCiAgX19fX2JwZl90cmFjZV9wcmludGsga2VybmVsL3RyYWNlL2JwZl90cmFjZS5j
OjI3MSBbaW5saW5lXQ0KICBicGZfdHJhY2VfcHJpbnRrKzB4YjMwLzB4YzUwIGtlcm5lbC90cmFj
ZS9icGZfdHJhY2UuYzoxNjMNCiAgYnBmX3Byb2dfMTIxODNjZGIxY2Q1MWRhYisweDNlNy8weDEw
MDANCktlcm5lbCBPZmZzZXQ6IGRpc2FibGVkDQpSZWJvb3RpbmcgaW4gODY0MDAgc2Vjb25kcy4u
DQoNCg==
