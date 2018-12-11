Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2E3C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E776F2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TYbpcWio"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E776F2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbeLKF12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 00:27:28 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:52056 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbeLKF12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 00:27:28 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20181211052726epoutp0128d5e814fa3abec7aa293218b940ffff~vMBDTSdm52800128001epoutp01Q;
        Tue, 11 Dec 2018 05:27:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20181211052726epoutp0128d5e814fa3abec7aa293218b940ffff~vMBDTSdm52800128001epoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1544506046;
        bh=aSeLG28trxAIAr/Q4sYLG+x+WN+oHYCl2qBfx6Nz2E0=;
        h=Date:From:To:Cc:Subject:References:From;
        b=TYbpcWiothmHuaztBqzhD/s3G6l1j39ZjwsU9sl0mWkF/cS92b1dma97Pn1dwOZL6
         yb7kfdeZKWoZbOwq6VyPcHuO9iIOcZEtvIGUsvgT3sxW08Z9iy1xdDLKkWJ5z7IMUy
         xwB5rZAQyO+cQP4ARKtFShxFg6RiuHv5eFxKQoEY=
Received: from epsmges2p2.samsung.com (unknown [182.195.40.156]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181211052722epcas1p18e6f7d7d5a924b0dadda24ee581d882a~vMA-y3TJO2589325893epcas1p1c;
        Tue, 11 Dec 2018 05:27:22 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        4B.EE.04060.ABA4F0C5; Tue, 11 Dec 2018 14:27:22 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20181211052721epcas2p1f5a54f0b24fa8f654b379be8a43db644~vMA-c_15B2092520925epcas2p1C;
        Tue, 11 Dec 2018 05:27:21 +0000 (GMT)
X-AuditID: b6c32a46-b45ff70000000fdc-f9-5c0f4aba6a8f
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        05.35.03627.9BA4F0C5; Tue, 11 Dec 2018 14:27:21 +0900 (KST)
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PJK004RE4HLB020@mmp1.samsung.com>; Tue, 11 Dec 2018 14:27:21 +0900 (KST)
Message-id: <5C0F4AB9.2090304@samsung.com>
Date:   Tue, 11 Dec 2018 14:27:21 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
MIME-version: 1.0
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?UTF-8?B?Iuy1nOywrOyasCAoc2Ftc3VuZy5jb20pIg==?= 
        <cw00.choi@samsung.com>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
Subject: [GIT PULL] extcon next for v4.21
Content-type: text/plain; charset="utf-8"
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLKsWRmVeSWpSXmKPExsWy7bCmue4uL/4Ygx8XOSwm3rjCYnH9y3NW
        i+bF69ksLu+aw2Zxu3EFmwOrx6ZVnWwe++euYffo27KK0ePzJrkAlqhsm4zUxJTUIoXUvOT8
        lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygvUoKZYk5pUChgMTiYiV9O5ui
        /NKSVIWM/OISW6XUgpScAssCveLE3OLSvHS95PxcK0MDAyNToMKE7Iw/ax8wFnTzVnTcX8HW
        wPiaq4uRk0NCwERi8e0Wpi5GLg4hgR2MEl0fn7JCON8ZJTbtnsYCUzXh612oqt2MEgfndbBD
        OHcZJb7tfskKUsUroCVxcO9LRhCbRUBV4sHslWA2G1B8/4sbbCA2v4CixNUfj8HiogIREjvn
        f2OH6BWU+DH5Htg2EQENiZdHb7GALGAWaGCSmPTzMFiDsICmxM61P8GWMQPZL75MYoGw5SU2
        r3nLDHHqAjaJKR/dIWwXiUVLPzBB2MISr45vYYewpSWerdrICLJAQqCdUeLLi2ZWCGcCo8SH
        U5uhOowlni3sYoLYwCfRcfgvUDcHUJxXoqNNCKLEQ+LF9x6wg4QEYiWeXb3NPoFRZhaSh2Yh
        uXUWklsXMDKvYhRLLSjOTU8tNiowQo60TYzgpKXltoNxyTmfQ4wCHIxKPLwVbXwxQqyJZcWV
        uYcYJTiYlUR4ddN4Y4R4UxIrq1KL8uOLSnNSiw8xmgIDfyKzlGhyPjCh5pXEG5oaGRsbW5ia
        WxobWCqJ8z6UnhstJJCeWJKanZpakFoE08fEwSnVwBhecmTvwQPHJt7JT45Rk9P/aWFlpWO1
        SebG4xqd1/cEGxUqFT+ncolt09qmsDct8evHa4J2t+xfLJzdXuEb0cy1UG7D46tLLT74Or/P
        CV6zeNMc88ZlN2+1eRbced6WOHPu0jyxfdNyn2UkvVt3703fB+VLGqeygm9d+ioid/lf4XZ+
        T6/ZodVKLMUZiYZazEXFiQDtWe2dcAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOLMWRmVeSWpSXmKPExsVy+t9jAd2dXvwxBl+bTCwm3rjCYnH9y3NW
        i+bF69ksLu+aw2Zxu3EFmwOrx6ZVnWwe++euYffo27KK0ePzJrkAligum5TUnMyy1CJ9uwSu
        jD9rHzAWdPNWdNxfwdbA+Jqri5GTQ0LARGLC17tMXYxcHEICOxkl1p+6xgrh3GeUODLhAgtI
        Fa+AlsTBvS8ZQWwWAVWJB7NXgtlsQPH9L26wgdj8AooSV388BopzcIgKREh0n6iEaBWU+DH5
        HtgYEQENiZdHb7GAzGcWaGCS6Gn9zwSSEBbQlNi59icrSC+zgLrElCm5IGFmAXmJzWveMk9g
        5JuFZNQshKpZSKoWMDKvYpRMLSjOTc8tNiowykst1ytOzC0uzUvXS87P3cQIDM5th7X6dzA+
        XhJ/iFGAg1GJh7eijS9GiDWxrLgy9xCjBAezkgivbhpvjBBvSmJlVWpRfnxRaU5q8SFGaQ4W
        JXFe/vxjkUIC6YklqdmpqQWpRTBZJg5OqQbGlQ9n3jj5L3RB5+H42y+X5sj5GR/q7rStqU/d
        W/W6altSRfSJ45xqNi9K72+wWhL2ds3X6GbbOr+Ve3w2M7y1DTjbtqgr3ynob+493Y9fDhy/
        Kaj63ZdTxEzh8Pdp6VeMT9sv3jM9Or5BeFvHjLl+fMXBDl+u5ckV9szKs7fSmG7cb9Zkef2l
        EktxRqKhFnNRcSIAminq1EoCAAA=
X-CMS-MailID: 20181211052721epcas2p1f5a54f0b24fa8f654b379be8a43db644
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181211052721epcas2p1f5a54f0b24fa8f654b379be8a43db644
References: <CGME20181211052721epcas2p1f5a54f0b24fa8f654b379be8a43db644@epcas2p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

This is extcon-next pull request for v4.21. I add detailed description of
this pull request on below. Please pull extcon with following updates.

Best Regards,
Chanwoo Choi


The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-4.21

for you to fetch changes up to a2dc50914744eea9f83a70a5db0486be625e5dc0:

  extcon: max8997: Fix lack of path setting in USB device mode (2018-11-14 09:06:32 +0900)

----------------------------------------------------------------
Update extcon for 4.21

Detailed description for this pull request:
1. Fix minor issue of Maxim MUIC (Micro USB IC) device driver
- Avoid forcing UART path on probe for extcon-max77843/77693/14577/8997.c
- Set USB path in USB device mode for extcon-max8997.c

----------------------------------------------------------------
Marek Szyprowski (5):
      extcon: max77843: Avoid forcing UART path on drive probe
      extcon: max77693: Avoid forcing UART path on drive probe
      extcon: max14577: Avoid forcing UART path on drive probe
      extcon: max8997: Avoid forcing UART path on drive probe
      extcon: max8997: Fix lack of path setting in USB device mode

 drivers/extcon/extcon-max14577.c | 15 +++++++++++++--
 drivers/extcon/extcon-max77693.c | 16 ++++++++++++++--
 drivers/extcon/extcon-max77843.c | 18 +++++++++++++++---
 drivers/extcon/extcon-max8997.c  | 25 +++++++++++++++++--------
 4 files changed, 59 insertions(+), 15 deletions(-)


