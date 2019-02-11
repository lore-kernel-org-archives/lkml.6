Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73766C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422C42146F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oPYFIotk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfBKI1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:27:06 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:58430 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfBKI1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:27:06 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190211082703epoutp025c420dc799ccd33e1fc175d832d8d196~CQdlTsk5f1108511085epoutp02i
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 08:27:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190211082703epoutp025c420dc799ccd33e1fc175d832d8d196~CQdlTsk5f1108511085epoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549873623;
        bh=mhxaXxKlnEnSe2EhbqXy8YaxKZf+9reidLLv5+AfCaE=;
        h=To:Cc:From:Subject:Date:References:From;
        b=oPYFIotkp8px6V/1Q3m5ZB98iD4O92ER9c0kc6WHxEtsTRUPrXqwoCclv7Er5nIKl
         HttOupLNxNQwRm/mawKk3yuon+lkNJcROw/+8kiwQt1JBc8wEzxaOg1qxetTcxKALx
         2uG2DdI/xe0gItmjDnc3+46UWl6364XUck7Bqz0k=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.158]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190211082700epcas1p4fa0cc7fbd222c33ef25df9fe8dac331e~CQdiWo2Xe1947919479epcas1p4b;
        Mon, 11 Feb 2019 08:27:00 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        1E.29.04074.DC1316C5; Mon, 11 Feb 2019 17:26:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190211082653epcas1p13b821c85b62b6611ca0a6b0a6c3d68b9~CQdbx7x5a0754907549epcas1p1P;
        Mon, 11 Feb 2019 08:26:53 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190211082653epsmtrp186a76b2e7329473cf952e2d6aa9965de~CQdbw4tX62988029880epsmtrp1J;
        Mon, 11 Feb 2019 08:26:53 +0000 (GMT)
X-AuditID: b6c32a35-27fff70000000fea-5f-5c6131cdda86
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E0.55.03601.DC1316C5; Mon, 11 Feb 2019 17:26:53 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190211082653epsmtip13132506d730cf8a08b76f0e177c97412~CQdboLTbN1620116201epsmtip1g;
        Mon, 11 Feb 2019 08:26:53 +0000 (GMT)
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?7LWc7LCs7JqwIChzYW1zdW5nLmNvbSk=?= 
        <cw00.choi@samsung.com>,
        =?UTF-8?B?7LWc7LCs7JqwIChzYW1zdW5nLmNvbSk=?= <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Subject: [GIT PULL] extcon next for v5.1
Organization: Samsung Electronics
Message-ID: <28f4fb8e-26aa-fa5b-03ea-cfcc6161d0c6@samsung.com>
Date:   Mon, 11 Feb 2019 17:26:52 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGJsWRmVeSWpSXmKPExsWy7bCmru5Zw8QYg1mX5Cwm3rjCYnH9y3NW
        i+bF69ksLu+aw2Zxu3EFmwOrx6ZVnWwe++euYffo27KK0ePzJrkAlqhsm4zUxJTUIoXUvOT8
        lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygvUoKZYk5pUChgMTiYiV9O5ui
        /NKSVIWM/OISW6XUgpScAssCveLE3OLSvHS95PxcK0MDAyNToMKE7Iz5z6QKJnJV/LzxmqWB
        sZmji5GTQ0LARGLlzNNMXYxcHEICOxglTtx7yQbhfGKUuNowA8r5xihx+uwBJpiWb/d3MEMk
        9jJKTHzayAjhvGeUeLm7DaxKREBD4uXRWywgCWaBViaJh5eXsoAk2AS0JPa/uMEGYgsDFS3Z
        8YUZxOYXUJS4+uMxI4jNK2An0TV7PdggFgFViZWnf7KD2KICERKHe99B1QhKnJz5BGwms4C4
        xK0n85kgbHmJ7W/nMEOceoBN4vYtKwjbReL7xf9QLwhLvDq+hR3ClpJ42d8GZVdLrDx5BOxn
        CYEORokt+y+wQiSMJfYvnQzUzAG0QFNi/S59iF18Eu++9rCChCUEeCU62oQgqpUlLj+4C7VK
        UmJxeycbhO0h8fbZYrCJQgKxEs2fN7FPYFSYheSbWUi+mYXkm1kIixcwsqxiFEstKM5NTy02
        LDBEju1NjOA0qWW6g3HKOZ9DjAIcjEo8vB8SE2KEWBPLiitzDzFKcDArifDq6iTGCPGmJFZW
        pRblxxeV5qQWH2I0BQb2RGYp0eR8YArPK4k3NDUyNja2MDE0MzU0VBLnXe/gHCMkkJ5Ykpqd
        mlqQWgTTx8TBKdXAKP7zxqaZMu4PG25//3/109bbeeldLZs5pya+tc3sZwv8pSookbklZdux
        YMkFCV63MwW3uGWkvNmbsH5PocZ6h8ClKpy+L1T7XDUm5M+dHdZdfVfFSfTwrmCRq4zmWbHT
        D62aaeuessdja0ClUKVtmOWN9gPWKSd2f70/UV+27f376WlpyrW8SizFGYmGWsxFxYkA+CZ6
        U6kDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsWy7bCSnO5Zw8QYg88dHBYTb1xhsbj+5Tmr
        RfPi9WwWl3fNYbO43biCzYHVY9OqTjaP/XPXsHv0bVnF6PF5k1wASxSXTUpqTmZZapG+XQJX
        xvxnUgUTuSp+3njN0sDYzNHFyMkhIWAi8e3+DuYuRi4OIYHdjBLd2ycxQiQkJaZdPAqU4ACy
        hSUOHy6GqHnLKDFvxmkmkBoRAQ2Jl0dvsYAkmAVamSTm9M9hA0mwCWhJ7H9xA8wWBipasuML
        M4jNL6AocfXHY7AFvAJ2El2z14MNYhFQlVh5+ic7iC0qECHx8ek+JogaQYmTM5+wgNjMAuoS
        f+ZdYoawxSVuPZnPBGHLS2x/O4d5AqPgLCQts5C0zELSMgtJywJGllWMkqkFxbnpucWGBUZ5
        qeV6xYm5xaV56XrJ+bmbGMHhr6W1g/HEifhDjAIcjEo8vB8SE2KEWBPLiitzDzFKcDArifDq
        6iTGCPGmJFZWpRblxxeV5qQWH2KU5mBREueVzz8WKSSQnliSmp2aWpBaBJNl4uCUamBcGn3w
        Qbb2ozXbvc8+mxO+yMkw+FaDwgWVW6+q/72/o/Chr6CpaUeEscvsb8+EIx2SuBsuXeBW2ZKR
        3WO0/+drtf8+s357+eycp87DJlATVb16Fveh1C/M0qeeZ7exzDnY3rWjwXV/5v+N20UP+82e
        Gs1w1M1c/vDhVTtyvmv2syXGcPx+F/ZKiaU4I9FQi7moOBEAJxQOR3sCAAA=
X-CMS-MailID: 20190211082653epcas1p13b821c85b62b6611ca0a6b0a6c3d68b9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190211082653epcas1p13b821c85b62b6611ca0a6b0a6c3d68b9
References: <CGME20190211082653epcas1p13b821c85b62b6611ca0a6b0a6c3d68b9@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

This is extcon-next pull request for v5.1. I add detailed description of
this pull request on below. Please pull extcon with following updates.

Best Regards,
Chanwoo Choi

The following changes since commit d13937116f1e82bf508a6325111b322c30c85eb9:

  Linux 5.0-rc6 (2019-02-10 14:42:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-5.1

for you to fetch changes up to 3dfed89512d3b65f6f092cfaaee53b0698bbf75e:

  extcon: ptn5150: Fix return value check in ptn5150_i2c_probe() (2019-02-11 17:21:38 +0900)

----------------------------------------------------------------
Vijai Kumar K (1):
      extcon: Add support for ptn5150 extcon driver

Wei Yongjun (1):
      extcon: ptn5150: Fix return value check in ptn5150_i2c_probe()

 .../devicetree/bindings/extcon/extcon-ptn5150.txt  |  27 ++
 drivers/extcon/Kconfig                             |   8 +
 drivers/extcon/Makefile                            |   1 +
 drivers/extcon/extcon-ptn5150.c                    | 339 +++++++++++++++++++++
 4 files changed, 375 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/extcon/extcon-ptn5150.txt
 create mode 100644 drivers/extcon/extcon-ptn5150.c
