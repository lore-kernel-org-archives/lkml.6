Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C481C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53883276A8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="S0igsazf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53883276A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754482AbeF1QoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 12:44:25 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53384 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752603AbeF1QoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 12:44:23 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180628164421euoutp017b16c9cd93c5f0534ca860de7aee51f6~8YKsv1Zw23224932249euoutp01g;
        Thu, 28 Jun 2018 16:44:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180628164421euoutp017b16c9cd93c5f0534ca860de7aee51f6~8YKsv1Zw23224932249euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1530204261;
        bh=lfaCIn/su4byC0JK9JB+pH8p+PBSZzzBuF4vISDuQdU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=S0igsazfnwdk2awfdwLRRWnT/tNd+XMOYkioe2q4DbWHr7Prk6+1RtS4t8EJe40kG
         wV/jYk3aFYQB5jAdEQ4AAi16wmXQGDEx9RWyEtCZq6OJIm6tTnZ1QwARZiwnX5srmL
         scREDTKmRXX/YqEIMe8djEzxBVlec/4BLolQYPOs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180628164420eucas1p2fb421eca984f7259d7fc875b1b3dd587~8YKrW9hPS1087610876eucas1p2Q;
        Thu, 28 Jun 2018 16:44:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 4C.49.10409.360153B5; Thu, 28
        Jun 2018 17:44:19 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180628164419eucas1p1906efbe47edc243f0ddab32d194eeba0~8YKqlalVS3253632536eucas1p1V;
        Thu, 28 Jun 2018 16:44:19 +0000 (GMT)
X-AuditID: cbfec7f5-b5fff700000028a9-c7-5b3510636513
Received: from eusync3.samsung.com ( [203.254.199.213]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 69.2F.04178.360153B5; Thu, 28
        Jun 2018 17:44:19 +0100 (BST)
Received: from AMDC2075.DIGITAL.local ([106.120.51.25]) by
        eusync3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PB1006SUL5Q0Y10@eusync3.samsung.com>;
        Thu, 28 Jun 2018 17:44:19 +0100 (BST)
From:   Maciej Purski <m.purski@samsung.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, Maciej Purski <m.purski@samsung.com>
Subject: [PATCH 0/3]  Fix packed pixel modes display on MHL2
Date:   Thu, 28 Jun 2018 18:44:00 +0200
Message-id: <1530204243-6370-1-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7djPc7opAqbRBr95LG6tO8dq0XvuJJNF
        U8dbVouNM9azWlz5+p7NonPiEnaLy7vmsFkseHmLxWLtkbvsDpwel/t6mTxmd8xk9dj+7QGr
        x/3u40wefVtWMXp83iQXwBbFZZOSmpNZllqkb5fAlXFo/gn2glOsFdcndTM1MB5k6WLk5JAQ
        MJFYcW0+YxcjF4eQwApGiXNTd0I5nxklzp/sZYOpurH3OFRiGaPEsrMNTCAJIYH/jBIP7+h3
        MXJwsAloSaxpjwcJiwgoS/yduAqsnlngKpPEycvbweqFBWwkGjZ0sYLYLAKqEu0TP4Et4BVw
        lrh4ZQ8jxDI5iZvnOplBmiUEOtgkzs87ywayQELARWLN6RyIGmGJV8e3sEPYMhKdHQeZIOxq
        iZUvl7NA9DYwSny5e5kZImEtcfj4RbDFzAJ8EpO2TWeGmMkr0dEmBFHiIfHl71lmiL9iJV7N
        vcg4gVFiASPDKkbx1NLi3PTUYuO81HK94sTc4tK8dL3k/NxNjMAIPP3v+NcdjPv+JB1iFOBg
        VOLhPXHFJFqINbGsuDL3EKMEB7OSCK8Qp2m0EG9KYmVValF+fFFpTmrxIUZpDhYlcd44jboo
        IYH0xJLU7NTUgtQimCwTB6dUA2NhRpzGHmO/oq2vItWEVn35fCJB7uubrc6LvKI0RSsr2x5V
        f/Z2mGEQtiOHZ0GVeaBe6UEWq6vpp54IzOBL2Lc/ZL140sEJgb7ro6RMXGdb77lve7K0tX11
        7q+2DUfc39ZKMt6eK6sjzCj8qKvo9MX7R5gdznXnnvj+12yqlLP2p+ULL767IKfEUpyRaKjF
        XFScCAD22crhvAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLJMWRmVeSWpSXmKPExsVy+t/xq7rJAqbRBhsPcVvcWneO1aL33Ekm
        i6aOt6wWG2esZ7W48vU9m0XnxCXsFpd3zWGzWPDyFovF2iN32R04PS739TJ5zO6Yyeqx/dsD
        Vo/73ceZPPq2rGL0+LxJLoAtissmJTUnsyy1SN8ugSvj0PwT7AWnWCuuT+pmamA8yNLFyMkh
        IWAicWPvccYuRi4OIYEljBI3d5xmB0kICTQySbyc7dvFyMHBJqAlsaY9HiQsIqAs8XfiKrB6
        ZoGbTBJ/z+5lBUkIC9hINGzoArNZBFQl2id+YgOxeQWcJS5e2cMIsUxO4ua5TuYJjFwLGBlW
        MYqklhbnpucWG+oVJ+YWl+al6yXn525iBAbKtmM/N+9gvLQx+BCjAAejEg/viSsm0UKsiWXF
        lbmHGCU4mJVEeIU4TaOFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8543qIwSEkhPLEnNTk0tSC2C
        yTJxcEo1MC5UUpk7Z91Ug/19Fl77j12+66z10+32tklJr5483/1FTNV3q/Jb3xCVnS1v5wV+
        1y2a0mCQcnL5F76jip+e/dgvd1q6d8fXH9pcH9grDqcs4nNYq9+mF2I1q+JaRJVp46riQ+k6
        1stvb7aW+vaSJy+42LbjVq22P7vh0yup/lk+LEtPP95ee1aJpTgj0VCLuag4EQAJNLnKEAIA
        AA==
X-CMS-MailID: 20180628164419eucas1p1906efbe47edc243f0ddab32d194eeba0
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180628164419eucas1p1906efbe47edc243f0ddab32d194eeba0
References: <CGME20180628164419eucas1p1906efbe47edc243f0ddab32d194eeba0@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this patchset is a next attempt to fix packed pixel modes display on MHL2. It appeared, that
the current implementation does not work well with every dongle. Thanks to bigger number
of test devices I managed to prepare a patchset, which should finally fix display
of packed pixel modes on MHL2, while not breaking it on MHL3.

Best regards,

Maciej Purski

Maciej Purski (3):
  drm/bridge/sii8620: Send AVI infoframe in all MHL versions
  drm/bridge/sii8620: Fix display of packed pixel modes
  drm/bridge/sii8620: Fix link mode selection

 drivers/gpu/drm/bridge/sil-sii8620.c | 86 +++++++++++++++++++++++-------------
 1 file changed, 55 insertions(+), 31 deletions(-)

-- 
2.7.4

