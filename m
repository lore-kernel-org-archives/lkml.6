Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DEFC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36C32087A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="anougqh0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F36C32087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbeJ2Wlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 18:41:46 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36238 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbeJ2Wlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 18:41:45 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181029135258euoutp023e435a26c27a8fc7328f6deb8f334d0a~iGLLBBHQo2097220972euoutp02Y
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 13:52:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181029135258euoutp023e435a26c27a8fc7328f6deb8f334d0a~iGLLBBHQo2097220972euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1540821178;
        bh=G893y91TBDqObOIS4HGfX5I4jbnjfITeREHllR1W5Yk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=anougqh0vXcCwnPkVP9wBNQ0vEFNo06pPUAd4YEDEoLXT9eEkUFTnz+vvTEucqzcS
         NbRDoBfbOupKWblhaTS48P8w5BI5X2ab0vPg/ufWI7BHn/4mjM0R9oLP333ce4Ml1h
         bFwlALYHFTdV+upPMq3M2TXfj5JILWwW9+Hk5pZ4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181029135257eucas1p1ce7a5e7f52e5102da026b4691d056f7a~iGLKB9lkN2114321143eucas1p13;
        Mon, 29 Oct 2018 13:52:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 0E.39.04441.9B017DB5; Mon, 29
        Oct 2018 13:52:57 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181029135256eucas1p1451a2da7fbb5f0fc7eb08c115c1b83f2~iGLJJsbme1198211982eucas1p1o;
        Mon, 29 Oct 2018 13:52:56 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181029135256eusmtrp29b1d031d753ce2662fd6881f5d798f88~iGLI5T9nN2201122011eusmtrp2T;
        Mon, 29 Oct 2018 13:52:56 +0000 (GMT)
X-AuditID: cbfec7f2-a1ae89c000001159-2e-5bd710b9468b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 88.E7.04128.8B017DB5; Mon, 29
        Oct 2018 13:52:56 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181029135255eusmtip28d388b31ee222cdc5b45b15ffbb5053b~iGLIPE3xP2874828748eusmtip2l;
        Mon, 29 Oct 2018 13:52:55 +0000 (GMT)
Subject: Re: [PATCH v2] drm/bridge: analogix_dp: Fix misleading indentation
 reported by smatch
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        zain wang <wzz@rock-chips.com>,
        dri-devel@lists.freedesktop.org, Lin Huang <hl@rock-chips.com>,
        David Airlie <airlied@linux.ie>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Sean Paul <seanpaul@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <f2bb09b8-c916-dd2a-03a6-f2bec157c117@samsung.com>
Date:   Mon, 29 Oct 2018 14:52:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181016095336.15656-1-enric.balletbo@collabora.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm2zmbx+Xsc2l7UStcF7KyGyJHFElZdPwj/Sio+aOWHZbkZu04
        uxB4qeZdzG44LTfLLNEyrWzlBZa4tDa6eFnFymgRBSKlToWs3I6S/573ed73e54HPoqQfhaG
        UunaLFanVWXIRWLyUe+MI8qCh1O35uUF0GWOPgGdXzgqpM2fXQQ9MDkmops+WBE93dJP0FNO
        u4huc5QK6aILN/3ot09qRHRzj8uPdrXYEW0YXr5DwlTnviaZt+VlAuax6yZiOj0mkqkurBIy
        7Z4RIfOpxCZgZo3dJFP+oBEx460rd4uV4vjDbEZ6NqvbknBQfMTz5SV5rJc4OXbe5JeLfguK
        kT8FOBq+9dmExUhMSfFtBDPVgwQ/TCCoNzgRP4wjKJsYIhdOui1OoRdLcQOCS5Wx/NIogu8D
        BpFXWIYPwrUGt88jGO+HyoKfvpcIbCbgneMr8goiHAmzbe98BxKcAK6Ojz6exGvhzXAX4cUh
        eB/0jJgRvxMEfVVuXwp/nASdEw6fAYFXQftoDcFjGbx31wq8ZoDzKDCY+/342AowVLyfb70M
        ftgezPPh8NdSO8/nQH7VAMEfFyJ4fqNBxAtx8Mz2eq4zNecQCfeebOHpRKj56vDRgAPBORrE
        ZwiEykdXCZ6WQKFBym9HwCf7Q4LHMqh/NSmqQHLjombGRW2Mi9oY//uaENmIZKye06hZbpuW
        PbGZU2k4vVa9OS1T04rmPt6LP7Zfj9Hkm0NWhCkkD5CMLBlKlQpV2dwpjRUBRciDJT/sc5Tk
        sOrUaVaXeUCnz2A5KwqjSLlMcuv6/VQpVquy2KMse4zVLagCyj80F52saLInXzWlHZ/OzpmJ
        WZl7J6UqqyBladia4/UdSu6uK065t2sDVqyejStNih28aNWfqNxpPRcdGWFRKKUz7ihd4x6a
        Wue2hKtjShNX9J82Bl+ZWu+pKzlbt73mvrNMX3S5V7ZxU7JLfcYdsivIpUDZkYr42oFbyqDm
        p2apZ0hOckdU2zYQOk71D3Ybmet0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsVy+t/xe7o7BK5HG7Sf5LXoPXeSyaKp4y2r
        xcKHd5ktrnx9z2ax5vYhRosfG04xW3y/cZbNYvO5HlaLzolL2C0u75rDZrH2yF12i7sbzjJa
        tF0Xc+D1mN1wkcXjcl8vk8eOu0sYPfZ+W8DiMbtjJqvH9m8PWD3udx9n8vg7az+LR9+WVYwe
        nzfJBXBF6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl
        6GV8e3yGpeAYc8X71gXsDYx/mLoYOTkkBEwk9u+8wQpiCwksZZT4PckYIi4usXv+W2YIW1ji
        z7Uuti5GLqCa14wS87d0sIEkhAUSJOYufwI2SEQgUuLY5gXsIEXMAouZJS6enscEMXUqo8Sr
        t2ANbAKaEn833wSzeQXsJO7uuccIYrMIqEpcur4PbJuoQITE6uUvWCFqBCVOznzCAmJzCjhJ
        7P1yDmwms4C6xJ95l5ghbHmJ7W/nQNniEreezGeawCg0C0n7LCQts5C0zELSsoCRZRWjSGpp
        cW56brGRXnFibnFpXrpecn7uJkZghG879nPLDsaud8GHGAU4GJV4eB9wX4sWYk0sK67MPcQo
        wcGsJML76ixQiDclsbIqtSg/vqg0J7X4EKMp0HMTmaVEk/OBySevJN7Q1NDcwtLQ3Njc2MxC
        SZz3vEFllJBAemJJanZqakFqEUwfEwenVAPjxMzSIEM3t7f6K7yO5JSvEtrMMju4RPeDyqS9
        dYfs3R0mP13+58oE97B7JlnsMmbmjMcF7I8r72DZOv+i4X7VQyx8flqL2pt0Dy9ndn5q7C08
        zy9RoSpOZZqbvjiDTkp94fYXhr1WCrU3V/4z8stIXnPzwe27p++Ku5quTj2lvf/SKY1dTSxK
        LMUZiYZazEXFiQCOI8jdBgMAAA==
X-CMS-MailID: 20181029135256eucas1p1451a2da7fbb5f0fc7eb08c115c1b83f2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181016095350epcas4p3a71b29adb3fbeb8075568de20d43e3a0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181016095350epcas4p3a71b29adb3fbeb8075568de20d43e3a0
References: <CGME20181016095350epcas4p3a71b29adb3fbeb8075568de20d43e3a0@epcas4p3.samsung.com>
        <20181016095336.15656-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.10.2018 11:53, Enric Balletbo i Serra wrote:
> This patch avoids that building the bridge/analogix source code with
> smatch triggers complaints about inconsistent indenting. It also fixes
> a typo in DRM_ERROR message, attch is replaced for attach.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Queued to drm-misc-next.

Regards
Andrzej

