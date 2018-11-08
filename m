Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2E7ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8DAB2086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TU6q7odT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8DAB2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbeKHXV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:21:56 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54465 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbeKHXVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:21:30 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181108134555euoutp02a3712376fad96fd3f6ab968ed6874bbc~lKh3h12vK2016120161euoutp02b;
        Thu,  8 Nov 2018 13:45:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181108134555euoutp02a3712376fad96fd3f6ab968ed6874bbc~lKh3h12vK2016120161euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1541684755;
        bh=LH8AbjiCzbYe7n4dQSriBqHOahkUSXTTSJ/64gLOmh4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=TU6q7odTxNeURjr/BiJs4WNhieupqKWuLt1foSnC4TVekkdsTGudSNZxPUNamYbKU
         U6f/V/5MIWtTXzF8ziXldFLlCbjnUY5ZT7ccpDbmAWnLQQiHb+aviwnZ1i5NCEQxO5
         saDy2uHLbyvxgYSkhem7HF8r+XkJ3kFGtCT9SW2E=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181108134554eucas1p142b574b8331ceea9b939c70af9b9e85e~lKh2uVNRp0695906959eucas1p1h;
        Thu,  8 Nov 2018 13:45:54 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id BE.9B.04441.21E34EB5; Thu,  8
        Nov 2018 13:45:54 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181108134553eucas1p1a513f538b74fab263c3f143914d30720~lKh2JBsv61720917209eucas1p1x;
        Thu,  8 Nov 2018 13:45:53 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-bc-5be43e12f577
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C8.F3.04128.11E34EB5; Thu,  8
        Nov 2018 13:45:53 +0000 (GMT)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PHV00GNNNKETS20@eusync1.samsung.com>;
        Thu, 08 Nov 2018 13:45:53 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 0/4] Fix common issue in MAX* extcon drivers
Date:   Thu, 08 Nov 2018 14:45:44 +0100
Message-id: <20181108134548.31140-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWy7djP87pCdk+iDb584LTYOGM9q8X1L89Z
        Lc6f38BucXnXHDaLGef3MVmsPXKX3eJ24wo2B3aPTas62Tz6tqxi9Pi8SS6AOYrLJiU1J7Ms
        tUjfLoErY/qcz8wFi7krzpy/w9rAOJezi5GDQ0LARGLnZ4cuRi4OIYEVjBJT2l6wQjifGSXO
        L3nH2MXICVa09u5qdojEMkaJxWsvQDkNTBJXb71nAqliEzCU6HrbxQZiiwg4S9z+8I0FxGYW
        eMgoseWqAsg6YQEbiY2LREDCLAKqEt/ebQAr5xWwlTh9fisTxDJ5idUbDjCDzJcQuMsq8evg
        P6iEi8T2c5uhLhKWeHV8CzuELSNxeXI3C0RDM6NE+4xZ7BBOD6PE1jk72CCqrCUOH7/ICnER
        n8SkbdOZIQHAK9HRJgRR4iHR8XsO2AIhgViJiYva2ScwSixgZFjFKJ5aWpybnlpsmJdarlec
        mFtcmpeul5yfu4kRGFOn/x3/tIPx66WkQ4wCHIxKPLwSio+jhVgTy4orcw8xSnAwK4nwbtJ5
        Ei3Em5JYWZValB9fVJqTWnyIUZqDRUmct5rhQbSQQHpiSWp2ampBahFMlomDU6qBUft1fbkU
        zz/+8y/u3uiyMZ10Z6XCjH+Gci8W8xpMWuxX3p1zk7lFZYW1i4DuDRlbDb4/b64ecjDmttT7
        9ohnGmf4HMG7NnmdS5ZabUyUdxSYyca+5vKyDvOlM/ct5Lxbu6rbcqX5ph1zBbYYZBtmB9j7
        fbvdEl/VGB02Q+Bv0szqF4mTZ31ap8RSnJFoqMVcVJwIAIzaFQSlAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKJMWRmVeSWpSXmKPExsVy+t/xy7qCdk+iDfZ/1LHYOGM9q8X1L89Z
        Lc6f38BucXnXHDaLGef3MVmsPXKX3eJ24wo2B3aPTas62Tz6tqxi9Pi8SS6AOYrLJiU1J7Ms
        tUjfLoErY/qcz8wFi7krzpy/w9rAOJezi5GTQ0LARGLt3dXsXYxcHEICSxgltu89wAzhNDFJ
        PDj0nw2kik3AUKLrbReYLSLgLHH7wzcWkCJmgYeMEq+2HGHsYuTgEBawkdi4SASkhkVAVeLb
        uw1g9bwCthKnz29lgtgmL7F6wwHmCYxcCxgZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgR6
        ftuxn1t2MHa9Cz7EKMDBqMTDe0DucbQQa2JZcWXuIUYJDmYlEd5NOk+ihXhTEiurUovy44tK
        c1KLDzFKc7AoifOeN6iMEhJITyxJzU5NLUgtgskycXBKNTBOuyv3uY5RzrdMLXDTX/MXrBs1
        7vD4eYnEca2c4an6+qRKi1JyoOScoz/+6Pn2fN3c6fM1KFC1WVn5K9cUP/bvHp6pm6IapZuO
        bWK8xtH5r/3kntgLGYl30q34za2Of+UScj1bm9vRL/JAsELJLOqK+ZXzevdn3Be4EPzBVuH9
        087zx/0jw5VYijMSDbWYi4oTATnlNKD4AQAA
X-CMS-MailID: 20181108134553eucas1p1a513f538b74fab263c3f143914d30720
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181108134553eucas1p1a513f538b74fab263c3f143914d30720
References: <CGME20181108134553eucas1p1a513f538b74fab263c3f143914d30720@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All

Most MAX* MUIC drivers unconditionally force UART path during probe.
This approach causes some issues, especially when board is booted with
non-UART cable connected to micro-USB port. For example, when USB cable is
connected, UART TX/RX lines are unconditionally short-circuited to USB
D+/D- lines. This is in turn recognized by a series of serial BREAK
signals and some random characters when USB host tries to perform
enumeration procedure.

To solve the above issue and keep UART console operational as early as
possible, set UART path only when USB ID reports UART capable cable.

This patchset fixes following MAX* extcon drivers: 8997, 14577, 77693
and 77843.

Tested on following Samsung boards: Trats (8997), Rinato (14577), Trats2
(77693) and TM2/TM2e (77843).

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Patch summary:

Marek Szyprowski (4):
  extcon: max77843: Avoid forcing UART path on drive probe
  extcon: max77693: Avoid forcing UART path on drive probe
  extcon: max14577: Avoid forcing UART path on drive probe
  extcon: max8997: Avoid forcing UART path on drive probe

 drivers/extcon/extcon-max14577.c | 15 +++++++++++++--
 drivers/extcon/extcon-max77693.c | 16 ++++++++++++++--
 drivers/extcon/extcon-max77843.c | 18 +++++++++++++++---
 drivers/extcon/extcon-max8997.c  | 15 +++++++++++++--
 4 files changed, 55 insertions(+), 9 deletions(-)

-- 
2.17.1

