Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1047503-1519203428-2-11780555285350837043
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519203428; b=eyvq7XfJmAS2TjhvaFOgz79FsHLLSMta83GEqV5OGS9q9w+
    7pbqToC1g96bCPbguPomo+1k7z0KwC/PpWwMS8fJVS2esUqvwULb5+bQJ62kzGNX
    bDvzu3C8GZKZJaStNojFtTRHAT4FYUGj8sGVCBS5fOKJXOto+QhJxt/ibYDBOrfb
    b4aPeWV/21ABIbyRXTWxVgEdpxbJNjt9GrTTJf0SnstG3CIo8Rpmd/+9CYMaEgJs
    BhrOfKEbkrEJM0Wo38RRMs2ga3pUpJm4hwwVdkU0QAWxPgdlnNLyjaZkLK+ds5wy
    ESi6oE07PMZqloPcuIM/nXwWnhRhrteCmVkGp8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:sender:list-id; s=arctest; t=1519203428; bh=rXftO0zO
    Ou7ouqEvsw8oZ8NNHqra1TLTTU5nuwhAf6s=; b=fnmrvZrn0ANO3rYF5MiSQTnt
    dWIsuaOTJ2NkItHVnWCekAJR1k6iIfOsoSpSprx9qWJFsqPYf1iRzv/UCQc0cyEp
    +AtH4XDLw9bQ3F0G7VIY0fN0GepYjcWoRsDP2Y4V2gjuTIunrAq4ZWYs83Em4ydU
    bbqaMe6mtF1k4jpIfCQVNO7WKT+OEjuGuLanBKe3P8Sb2zX4g86B/IXP0+BexUMU
    yEbN3W52ytChpm8zARgZ6rN2KQu83UnXN/SS4ul4MzGpZJ5fK1vkhmHlOvUjPpFf
    38yaY6zVJDlyKUQYiQAJulKus2HON3ZjMJDdjo9wYdt4E5q8Ih5CM2ZD1voqCA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=OyVTZMDP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=OyVTZMDP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752655AbeBUI4O (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 03:56:14 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57088 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeBUI4I (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 21 Feb 2018 03:56:08 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180221085605euoutp024744e65faf29a31f252f28281ec859f2~VS2lpSIUc2484324843euoutp02X
X-AuditID: cbfec7f2-1c1ff70000011644-32-5a8d3424e6be
From: Andrzej Hajda <a.hajda@samsung.com>
To: devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Cc: Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v4 0/6] dt-bindings: add bindings for USB physical connector
Date: Wed, 21 Feb 2018 09:55:35 +0100
Message-id: <20180221085541.14556-1-a.hajda@samsung.com>
X-Mailer: git-send-email 2.16.1
X-Brightmail-Tracker: H4sIAAAAAAAAAzVRa0hTYRjuO2fn4nJxmqZfWmmj6OpUEvqg6IbUgfpRfyIGy1YeL+im7XjJ
        ftSwjM2pmRlqxYo0E9PMeW1eIhUHWk5daGYpoVAtZ+UcZHjJefLf87zP8/A+Ly+NSydFAXS8
        JoXTalSJMlIsauyes4Vsi8hVhPUVB6OPL/oIlKl3Eqi2uIZAw7NfCfSoa3n23v2TRAXj+SJk
        s72kkOFOGYXME0MEslsekqjY1o6hJ+VZOKru+kyhp8MDGMpq66KOMGyVqQqw9rxcjH2gLyFY
        c6WBZMeNVoytK7vO5tVXAtZl3nKaVogPRnOJ8WmcNvTQBXGcs+U2mTzsfcX1J4fSgXmvbOBF
        QyYCDo2ZQTYQ01KmAsCColXiArD7nlm06sq6UYoLQjmADfMmTCBLAL7WPSM8LpLZBRfqRkgP
        9mWUcHrQspLAmX4R7O91UNmApn2YU/DH3a0ej4jZDj8szlIeLGEQnKr6BoRtQbBzKpPwZCHT
        RcL7BUukIETCL5aW/5V8oMNaTwl4EzTo32BCwAhgT7sBF0ghgDaHHRNcB2CndWClKs6sgwWN
        RbinEWQkUH9LKkAW6mZ9BPdR6DDOrOySLh9TP/aJzAcbH4M1lcCfS+XVsRwfruHS5bxKzadq
        YuWXktRmsPz73kXrTDNwD17sAAwNZN4StDdHISVUaXyGugNAGpf5SjKkuQqpJFqVcZXTJkVp
        UxM5vgME0iKZv+T8zmsKKROrSuESOC6Z066qGO0VoANFFDPd23/YeezcjuNK+fNfpYWtyn1y
        5UTTzYn2UHFpdPpv5u+cOZOLtWmagr03tCZHgaCehjrSbnePWl01exzNDSEjugRLvinkbGRM
        bWCFO9x4AjPY1n7vfac/c3JhNMbhl16yPrG6jdWW7DeJh0x+rxQu53xYS87k27TNl2UiPk4V
        vhvX8qp/HJfy5vcCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJLMWRmVeSWpSXmKPExsVy+t/xa7rKJr1RBovm61vcWneO1aKp4y2r
        xcYZ61ktrn95zmox/whQ7MrX92wWk+5PYLE4f34Du0XnxCXsFpseX2O1uLxrDpvFjPP7mCwW
        LWtltlh75C67xdLrF5ksWvceYXcQ8Fgzbw2jx+W+XiaP2R0zWT02repk87jffZzJY/OSeo++
        LasYPT5vkgvgiOKySUnNySxLLdK3S+DKeLu7n63gOk/F5x897A2Mfzi7GDk5JARMJFqbFzN3
        MXJxCAksYZT4uGMpI0hCSKCRSWLlbm4Qm01AU+Lv5ptsILaIQKzE21OfwRqYBS6wSPyeOJO9
        i5GDQ1jAR+L1ZEWQGhYBVYkb/76wg9i8AhYSb9a8YIRYJi9x+E0T6wRGrgWMDKsYRVJLi3PT
        c4sN9YoTc4tL89L1kvNzNzECA3DbsZ+bdzBe2hh8iFGAg1GJh9dCpydKiDWxrLgy9xCjBAez
        kghvpVBvlBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe8waVUUIC6YklqdmpqQWpRTBZJg5OqQbG
        aTNXfPr8zMGfb5vRvCKepf97XI+7nynq6I14y871d7Ft98nPmxe/XfUrmTkw9mrec2WNX3le
        ZcdPf2343FVzm3V3Qc75l4HLd2qaut8KnFz7a1Gr/is9r4O6Ww4a7/bmeZD8P/FwJivP/L3h
        HjsbDIKU29fsNe0Xqqv6ZhZyKmn19rz+bUvXKrEUZyQaajEXFScCANz7aLw8AgAA
X-CMS-MailID: 20180221085603eucas1p1c941a765f267145fc48de67184b613b3
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180221085603eucas1p1c941a765f267145fc48de67184b613b3
X-RootMTR: 20180221085603eucas1p1c941a765f267145fc48de67184b613b3
References: <CGME20180221085603eucas1p1c941a765f267145fc48de67184b613b3@eucas1p1.samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

Thanks for reviews of previous iterations.

This patchset introduces USB physical connector bindings, together with
working example.
I have removed RFC prefix - the patchset seems to be heading
to a happy end :)

v4: improved binding descriptions, added missing reg in dts.
v3: Separate binding for Samsung 11-pin connector, added full-blown USB-C
    example.
v2: I have addressed comments by Rob and Laurent, thanks 

Changes in datail are described in the patches.

Regards
Andrzej


Andrzej Hajda (5):
  dt-bindings: add bindings for USB physical connector
  dt-bindings: add bindings for Samsung micro-USB 11-pin connector
  arm64: dts: exynos: add micro-USB connector node to TM2 platforms
  arm64: dts: exynos: add OF graph between MHL and USB connector
  extcon: add possibility to get extcon device by OF node

Maciej Purski (1):
  drm/bridge/sii8620: use micro-USB cable detection logic to detect MHL

 .../connector/samsung,usb-connector-11pin.txt      | 49 +++++++++++
 .../bindings/connector/usb-connector.txt           | 75 +++++++++++++++++
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 39 ++++++++-
 drivers/extcon/extcon.c                            | 44 +++++++---
 drivers/gpu/drm/bridge/sil-sii8620.c               | 97 +++++++++++++++++++++-
 include/linux/extcon.h                             |  6 ++
 6 files changed, 294 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/connector/samsung,usb-connector-11pin.txt
 create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt

-- 
2.16.1

