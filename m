Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2759C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CDF220652
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="f8k857sE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CDF220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeJHSFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:05:01 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35674 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbeJHSFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:05:00 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181008105352euoutp02dc059f3a3ad37458b35b61540303da4a~bnLzIowJ92831328313euoutp02k
        for <linux-kernel@vger.kernel.org>; Mon,  8 Oct 2018 10:53:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181008105352euoutp02dc059f3a3ad37458b35b61540303da4a~bnLzIowJ92831328313euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1538996032;
        bh=KiII+K4XFC3ZgweWHo1e+3734qTjzZ5LKNbwM5NvE6Q=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=f8k857sE5N3EbqJEhc3g7qI9keYHU80a2dNMLFK2kNL9NSGbRQp5qdyy/EVEU7n5w
         S3DskTVs+2say94RW47sdXk/QSKFNJIYMI+T/TZ3M/aBdUEiMR4/NUeLKBl0OeTHFu
         bJckho5NWmw6uhNI0nh/3/P86N4a3l0TKHWJsL28=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181008105351eucas1p148abea7ce775b2976273b7bc5babbe51~bnLyNBW121856018560eucas1p10;
        Mon,  8 Oct 2018 10:53:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 4B.BE.04806.E373BBB5; Mon,  8
        Oct 2018 11:53:50 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181008105350eucas1p2a16945864d1b9ca2bb15b9126b700f03~bnLxZUHUO1504015040eucas1p23;
        Mon,  8 Oct 2018 10:53:50 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181008105350eusmtrp240cd906427081d815a93d42e603adde6~bnLxIY_dT1820518205eusmtrp2X;
        Mon,  8 Oct 2018 10:53:50 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-39-5bbb373e259f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D8.78.04284.E373BBB5; Mon,  8
        Oct 2018 11:53:50 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181008105349eusmtip1d69fa019691d264eaa6b000e6dd341cb~bnLwyGDkt3003130031eusmtip1G;
        Mon,  8 Oct 2018 10:53:49 +0000 (GMT)
Subject: Re: [RESEND PATCH v2 2/3] video: ssd1307fb: Do not hard code
 active-low reset sequence
To:     =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date:   Mon, 8 Oct 2018 12:53:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1538040281-21319-2-git-send-email-michal.vokac@ysoft.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsWy7djPc7p25rujDX49srSYf+Qcq8XGzbdZ
        LE70fWC1uLxrDpvF/89PWC1a9x5ht3ixRdyB3WPTqk42j43vdjB5fN4k5/Hy7wfmAJYoLpuU
        1JzMstQifbsErozlO6ayFjxlqbi6tJe9gfEdcxcjJ4eEgInE0XlnWLoYuTiEBFYwSmya8Yod
        wvnCKHHy8Hwo5zOjxKmWv4wwLTMvrYNKLGeUuLPxONgsIYH3jBI3eutAbGGBRIn7V96zgNgi
        ArYS+980s4PYzALHGSXO7FAEsdkErCQmtq8CG8oioCLRMn0hUxcjB4eoQIRE/xl1kDCvgKDE
        yZlPwMZwCrhLfN28mQlijLxE89bZzCA3SAgsYpd4/v8rI0RDmcT+602sEIe6SDxacAbqT2GJ
        V8e3sEPYMhL/d85ngmiezijx5tdSFghnPaPEmjPHmCCqrCUOH7/ICnIRs4CmxPpd+hBhR4kv
        JyczgoQlBPgkbrwVhDiIT2LStunMEGFeiY42IYhqNYkNyzawwazt2rkS6hwPiaX3prBOYFSc
        heTNWUhem4WwdwEj8ypG8dTS4tz01GLjvNRyveLE3OLSvHS95PzcTYzA9HL63/GvOxj3/Uk6
        xCjAwajEwxvgtytaiDWxrLgy9xCjBAezkgiv6HagEG9KYmVValF+fFFpTmrxIUZpDhYlcd5l
        8zZGCwmkJ5akZqemFqQWwWSZODilGhh1NedsuGiWxZtrGfszONLngvQVvrPBO2V3HrBtsWq9
        /E7jk7zHp98LdbbkBhTFut5fIfQ8LzPi4+rtii+dd7BdO8GwLtVEgCU/svlXhtIUpUkrVkr+
        sCzeEdrr3bFI5+6j2Xt3r673+sx2dYVU5tvuRSH2K1NFm/ZmsVw1zz67z7r7cchHhaVKLMUZ
        iYZazEXFiQAlELt/KwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsVy+t/xu7p25rujDS49ZLWYf+Qcq8XGzbdZ
        LE70fWC1uLxrDpvF/89PWC1a9x5ht3ixRdyB3WPTqk42j43vdjB5fN4k5/Hy7wfmAJYoPZui
        /NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYzlO6ayFjxl
        qbi6tJe9gfEdcxcjJ4eEgInEzEvr2LsYuTiEBJYySmxYMI2ti5EDKCEjcXx9GUSNsMSfa11s
        ILaQwFtGiWeTE0BsYYFEiftX3rOA2CICthL73zRDzbnOKHHj72NGEIdZ4DijxItVV5lAqtgE
        rCQmtq9iBFnAK2AnMfuQEEiYRUBFomX6QrASUYEIiVsPO8CG8goISpyc+QTM5hRwl/i6eTNY
        DbOAusSfeZeYIWx5ieats5knMArOQtIyC0nZLCRlCxiZVzGKpJYW56bnFhvqFSfmFpfmpesl
        5+duYgTGzbZjPzfvYLy0MfgQowAHoxIPb4Dfrmgh1sSy4srcQ4wSHMxKIryi24FCvCmJlVWp
        RfnxRaU5qcWHGE2BnpjILCWanA+M6bySeENTQ3MLS0NzY3NjMwslcd7zBpVRQgLpiSWp2amp
        BalFMH1MHJxSDYz5WeH6O57Ovvv6paTAXMe25i/n9XxyNyTsVZ1x/emcHHcZffXWHUbiC6tP
        1vTs4lqlULj7nqzW5+SHZRZ19txVyuyF5m+XPvsivDu27/CiTmfJuTXHdn4osVz7vM9Dh/de
        eujEO+rfP/sbX6uKXFzA+9t7qbzFpy15V3knZcSxT7eaHNr+0VqJpTgj0VCLuag4EQCtojo7
        sQIAAA==
Message-Id: <20181008105350eucas1p2a16945864d1b9ca2bb15b9126b700f03~bnLxZUHUO1504015040eucas1p23@eucas1p2.samsung.com>
X-CMS-MailID: 20181008105350eucas1p2a16945864d1b9ca2bb15b9126b700f03
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180927092739epcas5p48229ea32d3382e27602660e991efca09
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180927092739epcas5p48229ea32d3382e27602660e991efca09
References: <1538040281-21319-1-git-send-email-michal.vokac@ysoft.com>
        <CGME20180927092739epcas5p48229ea32d3382e27602660e991efca09@epcas5p4.samsung.com>
        <1538040281-21319-2-git-send-email-michal.vokac@ysoft.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/27/2018 11:24 AM, Michal Vokáč wrote:
> The SSD130x OLED display reset signal is active low. Now the reset
> sequence is implemented in such a way that users are forced to
> define reset-gpios as GPIO_ACTIVE_HIGH in DT to make the reset work.
> 
> Do not hard code the active-low sequence into the driver but instead
> allow the user to specify the gpio as GPIO_ACTIVE_LOW to reflect
> the real world.
> 
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>

Patch queued for 4.20, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
