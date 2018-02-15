Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1146594-1518691183-2-14310460282734289122
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518691183; b=ob5aS72kUT981gzKDc+4YDG1haOU4PV50nZY6Vk1ba334ix
    mV9kmpgs/20SR3hmxMZWpFuusk1iI6njzf6skLqHhJNKtFhQrFAUaOewDVu0/mQu
    CPmV2kS3Ee3Qx90tJJdIZbBr5tujLS8/haEGHPfwftyAmYvUFX3dfqh0fkADJomA
    htJOnfg4kSi9HLxBsMqE44P9cJitEwKZGHZFQyMKTq/lzP8Ouq9egN8xRL2WZeGh
    Xa+YkeymYMeLWlzoyzpnn0EZm71GFwlC8Y6IT6kBoeFXUpslKumGGPhi1wzHQEB8
    zdz88Jco7lqyp1WJ5wJ6JB8O4GuPHN0x7v7isgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:sender:list-id; s=arctest; t=1518691183; bh=A71pr4/k
    gE60XK2lwPD/vBrnRf9uueAgOzzs2ljkckA=; b=KM3N0mgmkTiWXJAdqQSM6OUP
    jdlWQ8dnM+7lZwBH1g1jo4RZOPMTuXn3G8M2OSHalcaPioZEY6wl2i+WG5WCM+7A
    n5qudxXWCGI/V9NMyrAUt4E422jv73ZyqRMUBJbw0Lj5+l6AnYQFY5JFuVE3DCbK
    8xgQmc3slb6gVQi26ZSqztZ7DduD8WNOTaGRypOvILNgb0mD791btEMnS0wSUQ6T
    hAemTKjKfwcboBtTXSb5i1kxfGSczFfNn98Yq7BD0bb5DDmBMOxIeOYr97cHvVYV
    l8JNgUxMeuw1QUMciLj08qPtcJxNz/LziTx1wqZRHyMz6smpCbGsxhpOXDoVwA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=ajONaecP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=ajONaecP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755459AbeBOKji (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 05:39:38 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47529 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755283AbeBOKjc (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 15 Feb 2018 05:39:32 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180215103929euoutp01843adf80da3d3af2358d10d20c332860~TeZKAKs6m1210812108euoutp01-
X-AuditID: cbfec7f5-f95739c0000028a9-e7-5a85635eadec
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
Subject: [RFC PATCH v2 0/6] dt-bindings: add bindings for USB physical
 connector
Date: Thu, 15 Feb 2018 11:39:14 +0100
Message-id: <20180215103920.32017-1-a.hajda@samsung.com>
X-Mailer: git-send-email 2.16.1
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRe0hTYRjG+87Z2Y6rxWEafmoYLIKSMqOoD9KwEjpEVNR/o7STnqalU3a8
        ZISuscnmZXhZNemilEnJSps2ZNnQORwqOi+paIlCdHFomWahqGsX/e95n+f38r4vL4mLv/HC
        yTR5NquQM+kSvpBn6VruP5CYrJHGGObD0MSbfgKptHMEemtsJNDYn+8EqnF4vY9Lv/iocqqc
        h1yuJgHSVdQJkPnLKIGGrY/5yOiyYehZvQZHrx2TAvRibBBDmg8OQTxFm56aAD2sL8PoR9pq
        gjY36Pj0VIkTo5vrCml9SwOgF82RF0mpMDaFTU/LZRUHT1wTpuq7V0CWdevtjuFJTAnUQcUg
        iITUEehonAHFQEiKqZcA6sZ/bBSLAJrmjcQmNXJPSQSCegBtD9o2KA+ANZ8tmI/iU/vgWvM4
        36dDqKvw55AV90E4NcCDA71ugS8Ipi7BLr3ND/GoPfCTwe7XIgrBcnUvHhi3C3bOqvzjINXO
        h30uoyAQJMCy5Xe8gA6GbmfLhr8T6rQdWKChBMAemw4PFAYAXe5hLEAdh53OQf9FOLUdVloe
        eiHS64ugtkgcQGjosT3f2OIkHGjW+HGx95zWGiteDsJqwZYGEMrmcBkyljssZ/OiOSaDy5HL
        opMzM8zA+/3ededSK7CtXrcDigSSbaKYWLVUTDC5XH6GHUASl4SIfks1UrEohcm/wyoykxQ5
        6SxnBxEkTxIqStxbIBVTMiabvcWyWaxiM8XIoHAluJErn4tk+lrlua/+LsRfrpvuAVdCa20J
        j1dlZreoqT2tdvAJun8qwn33XGywR/N1oa1w6KiNifOsKHYsFKtG1VrCWtG9u9A1c6xozplY
        nXW2cL/J0o+NiM5nAy7njCrfUVVq6My7+W+9ICnuwurse2X76RDPWmlVAphYno6S8LhU5lAU
        ruCY/4Tvn//5AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsVy+t/xq7oxya1RBp33bCxurTvHatHU8ZbV
        YuOM9awW1788Z7WYfwQoduXrezaLSfcnsFicP7+B3aJz4hJ2i02Pr7FaXN41h81ixvl9TBaL
        lrUyW6w9cpfdYun1i0wWrXuPsDsIeKyZt4bR43JfL5PH7I6ZrB6bVnWyedzvPs7ksXlJvUff
        llWMHp83yQVwRHHZpKTmZJalFunbJXBl9J38xViwi7vi4OW7TA2MLZxdjJwcEgImElcbG1hB
        bCGBJYwS8x85dDFyAdmNTBJ/TjezgyTYBDQl/m6+yQZiiwjESrw99ZkZpIhZ4AKLxO+JM8GK
        hAUCJBqPr2IGsVkEVCVuTzkE1sArYCExoeU0M8Q2eYnDb5pYJzByLWBkWMUoklpanJueW2yo
        V5yYW1yal66XnJ+7iREYgtuO/dy8g/HSxuBDjAIcjEo8vAY2LVFCrIllxZW5hxglOJiVRHg/
        RrVGCfGmJFZWpRblxxeV5qQWH2KU5mBREuc9b1AZJSSQnliSmp2aWpBaBJNl4uCUamB0Vnj1
        qXN9V8un6A9pccFrexY2Oda0PRZ+vvijEtfGbbfaGGc2HrO1Vdz4qaig7PZXX5VpGWuY4tP9
        DOeX8Ar+nsk3R7fWqZ9ty53gWQzsC4QfvPnlnHxUeDf78VndldFWcjtZLp69aj/N1KT9a+8f
        ZdFb+/cvWPvu8H1bBU41p41m8x//e1qkxFKckWioxVxUnAgAEbYOOz0CAAA=
X-CMS-MailID: 20180215103925eucas1p1f2278a69a7d81b6ba1ae3583d11e1997
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180215103925eucas1p1f2278a69a7d81b6ba1ae3583d11e1997
X-RootMTR: 20180215103925eucas1p1f2278a69a7d81b6ba1ae3583d11e1997
References: <CGME20180215103925eucas1p1f2278a69a7d81b6ba1ae3583d11e1997@eucas1p1.samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

Thanks for reviews of previous iterations.

This patchset introduces USB physical connector bindings, together with working example.

v2: I have addressed comments by Rob and Laurent, thanks 
v3: Separate binding for Samsung 11-pin connector, added full-blown USB-C example.

Changes are also described in patches.

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

 .../connector/samsung,usb-connector-11pin.txt      | 51 ++++++++++++
 .../bindings/connector/usb-connector.txt           | 74 +++++++++++++++++
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 38 ++++++++-
 drivers/extcon/extcon.c                            | 44 +++++++---
 drivers/gpu/drm/bridge/sil-sii8620.c               | 97 +++++++++++++++++++++-
 include/linux/extcon.h                             |  6 ++
 6 files changed, 294 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/connector/samsung,usb-connector-11pin.txt
 create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt

-- 
2.16.1

