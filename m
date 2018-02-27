Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-613114-1519715558-2-942700995883338235
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
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
    t=1519715558; b=nD8QAM3A+2pINtup6TuvPapdiIp2LQgL8kUkUUi5XnLKtSe
    KmPfdaL+Rbybg3bnCR5WhK5NiGeQX8zzwccdsogk60i5ph3g+VdMBLY8qSqebxKg
    keNIDF9NoJpE8IpzIsp0iZNO2orxjQqAdAxBUTgLe1vI40OrBnRVsaUCtbiGO3N3
    h/qak/tg66GrdRU9bkJ5sH/gO0H+N26aGYXIryOGOpfUDyG6VfM0E5Wjoe1z10Y8
    cEOfSPu0Otjko0Ij6Xff8QZ7PfPA2G79zkeFJAa75kP4FN0nUqnLugiYULP8Y7zl
    K8yhAFJA1x2ylaPtu+6e3idJ/PfvPXDQN9RA66A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:sender:list-id; s=arctest; t=1519715558; bh=lSX8KKmw
    NZSHHOFpjVv2mMgJAgzSb0QLAx8xz8/DYNs=; b=DpGcWXNmjxaezu+E5TX86wRd
    xovVVLH7N+gwkqQwebQOL+C3zRYJKtgX0B5bzyV7Q8SJwzdtANGS/g198QD2X4tF
    LCYEoaYQ5PbOsLqlo4wYCA/4NKBswlKb3sk5MEedNNovZsxPolgQrUAiL0/VssQ6
    fT3aw0IaxZz4GiNoIMP72syfx4CWrekTS91FiUgwg0kEQGG22Iu9RJPpdU8c2A9s
    /KcZnCgqGTe+HBlz6KHY8Tp77GZE5UxKD69/ovcGIaahcjHeapzdBoGtQDo8ldGD
    FWsJX7xXRFMaFvLbimSfyjctjyxqomwSfQMzZbZMuzw1yU827fc9gO1xA9aREQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=lxn4DR3N x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=lxn4DR3N x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752182AbeB0HLr (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 02:11:47 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50086 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752105AbeB0HLm (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 27 Feb 2018 02:11:42 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180227071140euoutp026051319b22c035abc37c69f6095fbafe~XHTIWrGd82547425474euoutp02y
X-AuditID: cbfec7f2-1c1ff70000011644-af-5a9504aaa476
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
Subject: [PATCH v5 0/6] dt-bindings: add bindings for USB physical connector
Date: Tue, 27 Feb 2018 08:11:28 +0100
Message-id: <20180227071134.28063-1-a.hajda@samsung.com>
X-Mailer: git-send-email 2.16.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsWy7djP87qrWKZGGVy8b2Bxa905Voumjres
        FhtnrGe1uP7lOavF/CNAsStf37NZTLo/gcXi/PkN7BadE5ewW2x6fI3V4vKuOWwWM87vY7JY
        tKyV2WLtkbvsFkuvX2SyaN17hN1BwGPNvDWMHpf7epk8ZnfMZPXYtKqTzeN+93Emj81L6j36
        tqxi9Pi8SS6AI4rLJiU1J7MstUjfLoEr49ui/6wFU3krmp/6NzBu4Opi5OSQEDCRuLnyDlsX
        IxeHkMAKRokXX1uYIJzPjBIzmu4yw1Qte9wDlVjGKLFs714WCOc/o8S+RWtYQKrYBDQl/m6+
        yQZiiwjESry7tIsZpIhZ4AKLxIXTr9hBEsICPhIdP96DjWURUJW48GM6K4jNK2AhMevaNah1
        8hILz14Fa5YQOMAmsbSlhQUi4SLxZu0yqCJhiVfHt7BD2DISnR0HmSAauhklTu3rhOqewihx
        /tVlJogqa4nDxy+CrWMW4JOYtG06UBEHUJxXoqNNCKLEQ+Ly1qtQQx0lOq49AFsmBPTO1O9X
        2ScwSi5gZFjFKJ5aWpybnlpsmJdarlecmFtcmpeul5yfu4kRGPmn/x3/tIPx66WkQ4wCHIxK
        PLwz5KZECbEmlhVX5h5ilOBgVhLhXbl4cpQQb0piZVVqUX58UWlOavEhRmkOFiVx3jiNuigh
        gfTEktTs1NSC1CKYLBMHp1QDY3pAgm3ydZHixoaqb4li7j3TfbcYhKvMnnFf/MnSKTy2H42k
        JyoIW168c5DZrmhPyK7vHTEXmH8t/VdXeGypv5+BwYaaHtUdb09cWsYmPvdd38PzK75b3nkw
        yfnw6fUuTR/6H7o/TU+/8lJmjqbLlo1O/WsDdiTPrThXeFE9rWDaZhcxlymZi5RYijMSDbWY
        i4oTAT6QgJ/4AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsVy+t/xy7orWaZGGbw8aGVxa905Voumjres
        FhtnrGe1uP7lOavF/CNAsStf37NZTLo/gcXi/PkN7BadE5ewW2x6fI3V4vKuOWwWM87vY7JY
        tKyV2WLtkbvsFkuvX2SyaN17hN1BwGPNvDWMHpf7epk8ZnfMZPXYtKqTzeN+93Emj81L6j36
        tqxi9Pi8SS6AI4rLJiU1J7MstUjfLoEr49ui/6wFU3krmp/6NzBu4Opi5OSQEDCRWPa4h6mL
        kYtDSGAJo8SvDYugnEYmidbfOxlBqtgENCX+br7JBmKLCMRKvD31mRmkiFngAovE74kz2UES
        wgI+Eh0/3jOD2CwCqhIXfkxnBbF5BSwkZl27xgyxTl5i4dmrzBMYuRYwMqxiFEktLc5Nzy02
        1CtOzC0uzUvXS87P3cQIDMFtx35u3sF4aWPwIUYBDkYlHt4ZclOihFgTy4orcw8xSnAwK4nw
        rlw8OUqINyWxsiq1KD++qDQntfgQozQHi5I473mDyighgfTEktTs1NSC1CKYLBMHp1QDo7xS
        sYLtJB7RxcVXUrkalLZ31Tc7TtJ2cLt3u6U1rvw8V7O4iFWkm0S6kqew5cQOgbtR03OPsdxs
        X/RYVf2Q6P3QPo/AzfWmPZ9ke4z7fn4xkevqUKl5sOzxYnfbLRaFnZx1lvrCG1u9Zm30dvTa
        kXpNeWrY/u9t/7f9EBLpO3AmZVLLXgklluKMREMt5qLiRADFsnekPQIAAA==
X-CMS-MailID: 20180227071137eucas1p104aeeb0fd926fe985e250174d9d65b2e
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180227071137eucas1p104aeeb0fd926fe985e250174d9d65b2e
X-RootMTR: 20180227071137eucas1p104aeeb0fd926fe985e250174d9d65b2e
References: <CGME20180227071137eucas1p104aeeb0fd926fe985e250174d9d65b2e@eucas1p1.samsung.com>
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

v5: fixed extra parenthesis in dts, renamed extcon function.
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
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 38 ++++++++-
 drivers/extcon/extcon.c                            | 44 +++++++---
 drivers/gpu/drm/bridge/sil-sii8620.c               | 97 +++++++++++++++++++++-
 include/linux/extcon.h                             |  6 ++
 6 files changed, 293 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/connector/samsung,usb-connector-11pin.txt
 create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt

-- 
2.16.2

