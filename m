Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0A1C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 17:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25372208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 17:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25372208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbeH0U5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 16:57:31 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:59832 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbeH0U5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 16:57:31 -0400
Received: by mail-it0-f71.google.com with SMTP id a10-v6so9105924itc.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 10:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-transfer-encoding;
        bh=lnzUpom4al8F8UoKQz9kH09Tz28FlIHXr/pQaKXw7MQ=;
        b=GnNbam05qzsJ5atu50O3MZ7k3fr6oTvNntVC2SX5uHbAncAw3u/F5F8BNm23fgWuXD
         E6FbgQzrFi6Y6p7A9BhfJka7ybMrj4BbFcvX9MERD6wpZT5oq0XpFaWSBA0UYLMhh5xL
         fktcRS86Y2JSuW1/6WDq6MWbGWYdJigJwHk5YmSYdpQy9ZBAws0psq1+i+MjsUO4zBts
         yMIp7nriVVHTBBJEsFq5DV0TkfpIw/p7vDlrLar0cY4Et2PZN3BpH7qFHcIVlnX15cEN
         Ijl9C7qojLOphqNw5dD1ThV6DKTNI6NXumtvKMIKLsi6aAdf89F6Rqg1FGXn8YD9zzE+
         ZWQw==
X-Gm-Message-State: APzg51BvGyUgiGF03GarsLpI6fJIRfsBQ08N63CXxa6jdsFIJG5AsxyN
        LmoUFWuPL0nn4sJju6do5GPSKEReJR7Lzb3FEJ589DiJixl4
X-Google-Smtp-Source: ANB0VdYYbZX8uGxbM+0/+kg9V1q/1FlKul7fhWxan6yo/1B4b+uj5IYfj1p1++hpCeI4dFKPyQ7heGmSPxQEiM8Kii/GGeaHMyoP
MIME-Version: 1.0
X-Received: by 2002:a24:3cc3:: with SMTP id m186-v6mr4585428ita.30.1535389804340;
 Mon, 27 Aug 2018 10:10:04 -0700 (PDT)
Date:   Mon, 27 Aug 2018 10:10:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e12d4105746dcb0d@google.com>
Subject: WARNING in format_decode (2)
From:   syzbot <syzbot+1ec5c5ec949c4adaa0c4@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCnN5emJvdCBmb3VuZCB0aGUgZm9sbG93aW5nIGNyYXNoIG9uOg0KDQpIRUFEIGNv
bW1pdDogICAgMmFkMGQ1MjY5OTcwIE1lcmdlIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20v
bGludXgva2Vybi4uDQpnaXQgdHJlZTogICAgICAgbmV0LW5leHQNCmNvbnNvbGUgb3V0cHV0OiBo
dHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS94L2xvZy50eHQ/eD0xNWI4ZWZiYTQwMDAwMA0K
a2VybmVsIGNvbmZpZzogIGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvLmNvbmZpZz94
PTc5ZTY5NTgzOGNlN2EyMTANCmRhc2hib2FyZCBsaW5rOiBodHRwczovL3N5emthbGxlci5hcHBz
cG90LmNvbS9idWc/ZXh0aWQ9MWVjNWM1ZWM5NDljNGFkYWEwYzQNCmNvbXBpbGVyOiAgICAgICBn
Y2MgKEdDQykgOC4wLjEgMjAxODA0MTMgKGV4cGVyaW1lbnRhbCkNCnN5eiByZXBybzogICAgICBo
dHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS94L3JlcHJvLnN5ej94PTE2MjZmNzYxNDAwMDAw
DQoNCklNUE9SVEFOVDogaWYgeW91IGZpeCB0aGUgYnVnLCBwbGVhc2UgYWRkIHRoZSBmb2xsb3dp
bmcgdGFnIHRvIHRoZSBjb21taXQ6DQpSZXBvcnRlZC1ieTogc3l6Ym90KzFlYzVjNWVjOTQ5YzRh
ZGFhMGM0QHN5emthbGxlci5hcHBzcG90bWFpbC5jb20NCg0KKiogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqKg0KKiogICBOT1RJQ0UgTk9USUNF
IE5PVElDRSBOT1RJQ0UgTk9USUNFIE5PVElDRSBOT1RJQ0UgICAqKg0KKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKg0KLS0tLS0tLS0tLS0t
WyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tDQpQbGVhc2UgcmVtb3ZlIHVuc3VwcG9ydGVkICUAIGlu
IGZvcm1hdCBzdHJpbmcNCldBUk5JTkc6IENQVTogMCBQSUQ6IDY0NTMgYXQgbGliL3ZzcHJpbnRm
LmM6MjE0OSBmb3JtYXRfZGVjb2RlKzB4OGZjLzB4YWYwICANCmxpYi92c3ByaW50Zi5jOjIxNDkN
Cktlcm5lbCBwYW5pYyAtIG5vdCBzeW5jaW5nOiBwYW5pY19vbl93YXJuIHNldCAuLi4NCg0KQ1BV
OiAwIFBJRDogNjQ1MyBDb21tOiBzeXotZXhlY3V0b3I3IE5vdCB0YWludGVkIDQuMTguMCsgIzE5
MA0KSGFyZHdhcmUgbmFtZTogR29vZ2xlIEdvb2dsZSBDb21wdXRlIEVuZ2luZS9Hb29nbGUgQ29t
cHV0ZSBFbmdpbmUsIEJJT1MgIA0KR29vZ2xlIDAxLzAxLzIwMTENCkNhbGwgVHJhY2U6DQogIF9f
ZHVtcF9zdGFjayBsaWIvZHVtcF9zdGFjay5jOjc3IFtpbmxpbmVdDQogIGR1bXBfc3RhY2srMHgx
YzkvMHgyYjQgbGliL2R1bXBfc3RhY2suYzoxMTMNCiAgcGFuaWMrMHgyMzgvMHg0ZTcga2VybmVs
L3BhbmljLmM6MTg0DQogIF9fd2Fybi5jb2xkLjgrMHgxNjMvMHgxYmEga2VybmVsL3BhbmljLmM6
NTM2DQogIHJlcG9ydF9idWcrMHgyNTIvMHgyZDAgbGliL2J1Zy5jOjE4Ng0KICBmaXh1cF9idWcg
YXJjaC94ODYva2VybmVsL3RyYXBzLmM6MTc4IFtpbmxpbmVdDQogIGRvX2Vycm9yX3RyYXArMHgx
ZmMvMHg0ZDAgYXJjaC94ODYva2VybmVsL3RyYXBzLmM6Mjk2DQogIGRvX2ludmFsaWRfb3ArMHgx
Yi8weDIwIGFyY2gveDg2L2tlcm5lbC90cmFwcy5jOjMxNg0KICBpbnZhbGlkX29wKzB4MTQvMHgy
MCBhcmNoL3g4Ni9lbnRyeS9lbnRyeV82NC5TOjk5Mw0KUklQOiAwMDEwOmZvcm1hdF9kZWNvZGUr
MHg4ZmMvMHhhZjAgbGliL3ZzcHJpbnRmLmM6MjE0OQ0KQ29kZTogZTggNTkgNTkgYzkgZmEgNDEg
YzYgMDQgMjQgMTIgZTkgOTQgZmQgZmYgZmYgZTggNGEgNTkgYzkgZmEgMGYgYmUgZjMgIA0KNDgg
YzcgYzcgNjAgYmMgODkgODcgYzYgMDUgMjggYWEgZDIgMDEgMDEgZTggZTQgZTkgOTMgZmEgPDBm
PiAwYiA0ZCA4YiA3ZCAgDQpjMCBlOSA1NiBmZSBmZiBmZiA0OCA4YiBiZCA2OCBmZiBmZiBmZiBl
OCBjZCA0ZiAwOA0KUlNQOiAwMDE4OmZmZmY4ODAxYjZiMjc2ODggRUZMQUdTOiAwMDAxMDI4Mg0K
UkFYOiAwMDAwMDAwMDAwMDAwMDAwIFJCWDogMDAwMDAwMDAwMDAwMDAwMCBSQ1g6IDAwMDAwMDAw
MDAwMDAwMDANClJEWDogMDAwMDAwMDAwMDAwMDAwMCBSU0k6IGZmZmZmZmZmODE2NDIyYjEgUkRJ
OiBmZmZmODgwMWI2YjI3Mzc4DQpSQlA6IGZmZmY4ODAxYjZiMjc3MzAgUjA4OiBmZmZmODgwMWI2
OWEwMDQwIFIwOTogMDAwMDAwMDAwMDAwMDAwNg0KUjEwOiAwMDAwMDAwMDAwMDAwMDAwIFIxMTog
MDAwMDAwMDAwMDAwMDAwMCBSMTI6IGZmZmY4ODAxYjZiMjc3YTgNClIxMzogZmZmZjg4MDFiNmIy
NzcwOCBSMTQ6IDAwMDAwMDAwMDAwMDAwMDAgUjE1OiBmZmZmODgwMWI2YjI3YjA0DQogIHZzbnBy
aW50ZisweDE4NS8weDFiNjAgbGliL3ZzcHJpbnRmLmM6MjI0NQ0KICB2c2NucHJpbnRmKzB4MmQv
MHg4MCBsaWIvdnNwcmludGYuYzoyMzk2DQogIF9fdHJhY2VfYXJyYXlfdnByaW50ay5wYXJ0LjYw
KzB4YzcvMHgzMzAga2VybmVsL3RyYWNlL3RyYWNlLmM6Mjk5MA0KICBfX3RyYWNlX2FycmF5X3Zw
cmludGsga2VybmVsL3RyYWNlL3RyYWNlLmM6MzAyMSBbaW5saW5lXQ0KICB0cmFjZV9hcnJheV92
cHJpbnRrIGtlcm5lbC90cmFjZS90cmFjZS5jOjMwMjEgW2lubGluZV0NCiAgdHJhY2VfdnByaW50
aysweDVmLzB4OTAga2VybmVsL3RyYWNlL3RyYWNlLmM6MzA1OQ0KICBfX3RyYWNlX3ByaW50aysw
eGNlLzB4MTIwIGtlcm5lbC90cmFjZS90cmFjZV9wcmludGsuYzoyMzcNCiAgX19fX2JwZl90cmFj
ZV9wcmludGsga2VybmVsL3RyYWNlL2JwZl90cmFjZS5jOjI3NCBbaW5saW5lXQ0KICBicGZfdHJh
Y2VfcHJpbnRrKzB4YjE2LzB4YzMwIGtlcm5lbC90cmFjZS9icGZfdHJhY2UuYzoxNjYNCiAgYnBm
X3Byb2dfZTUxZGVhYzE0NDFiYzA4MysweDk0YS8weDEwMDANCkR1bXBpbmcgZnRyYWNlIGJ1ZmZl
cjoNCiAgICAoZnRyYWNlIGJ1ZmZlciBlbXB0eSkNCktlcm5lbCBPZmZzZXQ6IGRpc2FibGVkDQpS
ZWJvb3RpbmcgaW4gODY0MDAgc2Vjb25kcy4uDQoNCg0KLS0tDQpUaGlzIGJ1ZyBpcyBnZW5lcmF0
ZWQgYnkgYSBib3QuIEl0IG1heSBjb250YWluIGVycm9ycy4NClNlZSBodHRwczovL2dvby5nbC90
cHNtRUogZm9yIG1vcmUgaW5mb3JtYXRpb24gYWJvdXQgc3l6Ym90Lg0Kc3l6Ym90IGVuZ2luZWVy
cyBjYW4gYmUgcmVhY2hlZCBhdCBzeXprYWxsZXJAZ29vZ2xlZ3JvdXBzLmNvbS4NCg0Kc3l6Ym90
IHdpbGwga2VlcCB0cmFjayBvZiB0aGlzIGJ1ZyByZXBvcnQuIFNlZToNCmh0dHBzOi8vZ29vLmds
L3Rwc21FSiNidWctc3RhdHVzLXRyYWNraW5nIGZvciBob3cgdG8gY29tbXVuaWNhdGUgd2l0aCAg
DQpzeXpib3QuDQpzeXpib3QgY2FuIHRlc3QgcGF0Y2hlcyBmb3IgdGhpcyBidWcsIGZvciBkZXRh
aWxzIHNlZToNCmh0dHBzOi8vZ29vLmdsL3Rwc21FSiN0ZXN0aW5nLXBhdGNoZXMNCg==
