Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91027ECDFBB
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 00:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0187420671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 00:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MySCWDL/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0187420671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730745AbeGSA5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 20:57:33 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:19133 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729972AbeGSA5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 20:57:32 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20180719001708epoutp04b7b0fc9504897a5c0f061f700cc7e05c~CnPvTG1wY0394903949epoutp04a;
        Thu, 19 Jul 2018 00:17:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180719001708epoutp04b7b0fc9504897a5c0f061f700cc7e05c~CnPvTG1wY0394903949epoutp04a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1531959428;
        bh=KLCx10UMNZIhfe2gqBLsT2fmN7sxu8jXZP5zGSKDkfQ=;
        h=Date:From:To:Cc:Subject:References:From;
        b=MySCWDL/LDRqqnY/fE7oqOnn2neinJLR0Pan9XD/bfxJmRVKtKEaPZVkeg79oh7As
         YgSxD581GvY3QOplIF+ESpWpmlR9iHKMmRhfRiTbD1Kw1D4vH8WsT7Z4YNRIkNd7xq
         4Af6KqIVSpAKsRD7EuWXV4myN0xSDHeIWS5g5Ivo=
Received: from epsmges2p1.samsung.com (unknown [182.195.40.156]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20180719001705epcas1p46ca89306f3d9373494757fc918cfcbbc~CnPsGIGtJ2411824118epcas1p4R;
        Thu, 19 Jul 2018 00:17:05 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.C3.04217.188DF4B5; Thu, 19 Jul 2018 09:17:05 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20180719001704epcas2p2aab364365a7e3e9e52d619bd612a6958~CnPr2GW-s1325713257epcas2p2q;
        Thu, 19 Jul 2018 00:17:04 +0000 (GMT)
X-AuditID: b6c32a45-441ff70000001079-ea-5b4fd881fe05
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 2B.6A.04192.088DF4B5; Thu, 19 Jul
        2018 09:17:04 +0900 (KST)
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PC300JGG7GG4T60@mmp2.samsung.com>; Thu, 19 Jul 2018 09:17:04 +0900 (KST)
Message-id: <5B4FD880.60806@samsung.com>
Date:   Thu, 19 Jul 2018 09:17:04 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
MIME-version: 1.0
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?Iuy1nOywrOyasCAoc2Ftc3VuZy5jb20pIg==?= 
        <cw00.choi@samsung.com>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
Subject: [GIT PULL] extcon next for v4.19
Content-type: text/plain; charset="utf-8"
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHKsWRmVeSWpSXmKPExsWy7bCmhW7jDf9ogxfnOC2uf3nOatG8eD2b
        xeVdc9gsbjeuYHNg8dg/dw27R9+WVYwenzfJBTBHpdpkpCampBYppOYl56dk5qXbKnkHxzvH
        m5oZGOoaWlqYKynkJeam2iq5+AToumXmAG1TUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gq
        RRsaGukZGpjrGRkBaeNYKyNToJKE1Iymt2sZC1oFKp7v3cjcwDift4uRk0NCwETi5t6jLF2M
        XBxCAjsYJSZ0LodyvjNKTP36jhmmqvP0WnaIxAZGibaP65khnLuMEpc7DjCCVPEKaEgs7njL
        CmKzCKhKzHjUww5iswloSex/cYMNxOYXUJS4+uMxWL2oQITEzvnf2CF6BSV+TL7HAmKLAM15
        efQW2BnMAkcYJV4eXg92hrCApsS9h2fABjED2S++TGKBsOUlNq95C3aRhMAMNomXJxYwQdzt
        ItF99Ts7hC0s8er4FihbWuLZqo2MEA3tjBJfXjSzQjgTGCU+nNoM1W0s8WxhFxPECj6JjsN/
        gbo5gOK8Eh1tQhAlHhL/tjSDlQgJxEpcvHiRZQKjzCwkH81CcuwsJMcuYGRexSiWWlCcm55a
        bFRgqFecmFtcmpeul5yfu4kRnJa0XHcwzjjnc4hRgINRiYc3469vtBBrYllxZe4hRgkOZiUR
        3r0n/aOFeFMSK6tSi/Lji0pzUosPMZoCQ38is5Rocj4wZeaVxBuaGhkbG1uYmlsaG1gqifPu
        4fWIFhJITyxJzU5NLUgtgulj4uCUamBMFfjoZCjeeeJP9JUPiryiMeGmV/k+3ttqL3l1ttyG
        j72Hvtp9+33OJMmvxVQ6QLN2+zKt9SfaD4ketQ9XSN/0/2vZxTqbnXcKnmanrjOwXH2b4b2o
        pPrcpMVHG6WtT5VMjsh+t9jfJW3KG02f8HnL92S5cB8L2nxXZmk7T464/uWLWYG9+beVWIoz
        Eg21mIuKEwELSK8PYQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsVy+t9jQd2GG/7RBg03zSyuf3nOatG8eD2b
        xeVdc9gsbjeuYHNg8dg/dw27R9+WVYwenzfJBTBHcdmkpOZklqUW6dslcGU0vV3LWNAqUPF8
        70bmBsb5vF2MnBwSAiYSnafXsncxcnEICaxjlPj0YgYbSEJI4D6jxLtXFiA2r4CGxOKOt6wg
        NouAqsSMRz3sIDabgJbE/hc3wOr5BRQlrv54zNjFyMEhKhAh0X2iEqJVUOLH5HssILYI0JiX
        R2+xgOxiFjjCKPHo5XcmkISwgKbEvYdn2EB6mQXUJaZMyQUJMwvIS2xe85Z5AiPfLCSjZiFU
        zUJStYCReRWjZGpBcW56brFRgVFearlecWJucWleul5yfu4mRmAYbjus1b+D8fGS+EOMAhyM
        Sjy8GX99o4VYE8uKK3MPMUpwMCuJ8O496R8txJuSWFmVWpQfX1Sak1p8iFGag0VJnJc//1ik
        kEB6YklqdmpqQWoRTJaJg1OqgdG0RrQ247nFNcfIY5l/rn+Y1MvhJ5Btzv13i4/DjcuGKQ4M
        zG0/939q+r9x9bGz7cdPPeL60HB504JzDk0KSQe224md28tQqnply7YIcYVLrOGKX3UecZvd
        fGf/94lqwR4D0zuaPRP2GchsnOhU3dGxUO/M0cXlu7Z0+HVcmfXI5e4L0wVSnvuUWIozEg21
        mIuKEwEIckgZPwIAAA==
X-CMS-MailID: 20180719001704epcas2p2aab364365a7e3e9e52d619bd612a6958
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180719001704epcas2p2aab364365a7e3e9e52d619bd612a6958
References: <CGME20180719001704epcas2p2aab364365a7e3e9e52d619bd612a6958@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

This is extcon-next pull request for v4.19. I add detailed description of
this pull request on below. Please pull extcon with following updates.

Best Regards,
Chanwoo Choi


The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-4.19

for you to fetch changes up to 8a9dbb779fe882325b9a0238494a7afaff2eb444:

  extcon: Release locking when sending the notification of connector state (2018-07-12 09:06:31 +0900)

----------------------------------------------------------------
Update extcon for 4.19

Detailed description for this pull request:
1. Release locking when sending the connector state in extcon_sync()
-  Previously, extcon used the spinlock before calling the notifier_call_chain
to prevent the scheduled out of task and to prevent the notification delay.
When spinlock is locked for sending the notification, deadlock issue
occured on the side of extcon consumer device. To fix this issue on extcon
consumer device, release locking when sending the connector state.

2. Fix minor issues of extcon provider driver
- extcon-intel-int3496.c uses 'linux/gpio/consumer.h' instead of 'linux/gpio.h'
- extcon-usbc-cors-ec.c adds SPDX license and fix the wrong license information

----------------------------------------------------------------
Chanwoo Choi (1):
      extcon: Release locking when sending the notification of connector state

Enric Balletbo i Serra (2):
      extcon: usbc-cros-ec: Make license text and module license match.
      extcon: usbc-cros-ec: Switch to SPDX identifier.

Wolfram Sang (1):
      extcon: int3496: Use proper GPIO include

 drivers/extcon/extcon-intel-int3496.c |  2 +-
 drivers/extcon/extcon-usbc-cros-ec.c  | 22 ++++++----------------
 drivers/extcon/extcon.c               |  3 ++-
 3 files changed, 9 insertions(+), 18 deletions(-)


