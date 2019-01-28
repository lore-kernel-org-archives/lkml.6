Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93626C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 574C0214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CGpFSaQ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfA1L5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 06:57:31 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:42289 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfA1L5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 06:57:30 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190128115728euoutp01aef6746e462ca5cab77c2721b8d01ebf~_ATTkQxs53001630016euoutp01V
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 11:57:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190128115728euoutp01aef6746e462ca5cab77c2721b8d01ebf~_ATTkQxs53001630016euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548676648;
        bh=HlMB35jE8cLFqFqz1XM/4CgeA6M10H/5fASwzD1f71w=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=CGpFSaQ2d5+cN4n9/MZ8qm+PZ/aztB9B/ReNbPXDnVTy4CdwqxWwbxvUt1oPCJBts
         mDl8Hb4fRq62qfn6tReWV8noqZg9+EJTfYXk0nyg1Aq6agjrXwNGemNbI4JomNKhsk
         pKA+Ly5M5Mwu9WkPIXDJNevAerf/IjS2zl3IXvPw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190128115728eucas1p17662ac7d116fdf5764fe4fbd3d9fdcfe~_ATTF04XM2727027270eucas1p1f;
        Mon, 28 Jan 2019 11:57:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 4C.12.04294.72EEE4C5; Mon, 28
        Jan 2019 11:57:27 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190128115726eucas1p1c1ea64fc7dd4bcde6e4c3c5acf0a77d6~_ATSGjPiP0380403804eucas1p1w;
        Mon, 28 Jan 2019 11:57:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190128115726eusmtrp2a9f0eab43f2e9df0368d802ce35ca628~_ATR363yq3114631146eusmtrp2L;
        Mon, 28 Jan 2019 11:57:26 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-c0-5c4eee27442f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 22.9F.04128.62EEE4C5; Mon, 28
        Jan 2019 11:57:26 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190128115726eusmtip285b54a195aef9bfb2a58e8ed1a6dd056~_ATRVbioi0430504305eusmtip21;
        Mon, 28 Jan 2019 11:57:26 +0000 (GMT)
Subject: Re: [PATCH] devfreq: Suspend all devices on system shutdown
To:     myungjoo.ham@samsung.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        Markus Reichl <m.reichl@fivetechno.de>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <d5506b03-e035-aca9-5e01-e642c2bc5111@samsung.com>
Date:   Mon, 28 Jan 2019 12:57:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190128080535epcms1p44636143629448c4e24a6628e87a72bf2@epcms1p4>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH++1ud3fTxfVqeTIrmJSp5FwYXEisYH+MHhL0R1ADm3lRyReb
        WiaUYmkt0wgf83ZLU2Yy87XMdIXg1IYIU9M0THsusocauKBEMq9Xy/8+33O+h/M9cAiMapME
        EEmpGYwhVZ+sxOXi9ue/XXuCZ2N0Efk2Fd1qbpbQ457PEnpwsEVKT+QG0iN2Dqfnb/Yi2jzY
        JaK/9P5C9Ou8evygTDsxeVlrs17Htd2zz0Ta4jYr0s7bth+XnJJHxTPJSVmMQRV9Rp6Y+9CF
        0m1eF0buBOWi+zITkhFARsKUvVZsQnKCIusRlDY0rAoPgkWLAwliHkFN3TC2NnKjqhATGg8Q
        1L0cWh2ZQ/CtuFbKu3xJDZQUuqR8w498j+CnixPxAiOnEIw5LCLehZNqMM2YcJ4VZDRUDExK
        eBaTO8E617PMBLGJ1MHVEblg8YH+SreYZxkZAyw3i3jGyB3wZIbDBPaHCXfVyi4gu6TQOFK5
        mlsDzYWfkMC+8NXZJhU4EJY61wbyERSaWakgihA85jpwwbUfepzDK4kwMgSa7SqhfAiKWvpw
        vgzkRng14yOE2Ai32yswoayAawWU4N4FrLPp39ruoRfYLaRk153GrjuHXXcO+39vNRJbkT+T
        aUxJYIx7U5nz4UZ9ijEzNSH8bFqKDS3/0sAfp6cD2RfjHIgkkNJb0bJ0TEdJ9FnG7BQHAgJT
        +inKxmN0lCJen32RMaTFGjKTGaMDbSXESn9FzoZ3pykyQZ/BnGOYdMaw1hURsoBcVHR3lG6l
        TzaeCApemnvkKdIdDhOpo1RD3tJ9ORYuuv4ItbnfvuVA/Gj5U/WkalRTXRNJTcdycREK92jB
        lZyjXB4XnWf5EBrGaqJmvnf6UiXl7WnuHwvT+Qh3X6qg25raa81vchbeljaMed1T7w4f3iYb
        c4T0JX/0MGVWV7BSbEzUq0Mxg1H/F4oSv/JHAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xe7pq7/xiDHpWaFpsnLGe1eL6l+es
        FufPb2C3uNUgY3F51xw2i8+9RxgtZpzfx2Tx8sgPRovbjSvYHDg9bt2p99i0qpPN4+C7PUwe
        fVtWMXp83iQXwBqlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZ
        llqkb5egl9Gw5hxjwSbuisuzlRsYF3J2MXJySAiYSHTPb2cGsYUEljJKnL8qDhGXkTg5rYEV
        whaW+HOti62LkQuo5i2jxLqna9hAEsICLhL97efYQWwRgYeMEoc2aIAUMQvcBxo0+RALRMdJ
        Roltna/AOtgEDCW63naB2bwCdhLTT98BW8EioCqx6v1hMFtUIEZi1pM+dogaQYmTM5+wgNic
        An4Ss+a8YwSxmQXUJf7Mu8QMYctLbH87B8oWl7j1ZD7TBEahWUjaZyFpmYWkZRaSlgWMLKsY
        RVJLi3PTc4uN9IoTc4tL89L1kvNzNzECo3DbsZ9bdjB2vQs+xCjAwajEw7vhv2+MEGtiWXFl
        7iFGCQ5mJRHeqdf9YoR4UxIrq1KL8uOLSnNSiw8xmgI9N5FZSjQ5H5gg8kriDU0NzS0sDc2N
        zY3NLJTEec8bVEYJCaQnlqRmp6YWpBbB9DFxcEo1MF4NX3/T5Tl/+ITdiuYnX67nSODPf7wj
        5Tuvb9TBrpj7dgvVtc7oODUu1X/VM3fC+soYBcPjJf+W6zyWd7rneufOtBdLfX7t23s9aXJm
        Ve+pzyx7+4546bgfcC+auy/4s5Ysv+CLHA3N/YLh/icD2n7OuWbZyz+xQ7y18NOEV7NrDiVs
        0/95ba8SS3FGoqEWc1FxIgCJj/DT2AIAAA==
X-CMS-MailID: 20190128115726eucas1p1c1ea64fc7dd4bcde6e4c3c5acf0a77d6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190125135414eucas1p2ffc71c63f1a27f67d076dec889954b40
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190125135414eucas1p2ffc71c63f1a27f67d076dec889954b40
References: <20190125135403.10228-1-m.szyprowski@samsung.com>
        <CGME20190125135414eucas1p2ffc71c63f1a27f67d076dec889954b40@epcms1p4>
        <20190128080535epcms1p44636143629448c4e24a6628e87a72bf2@epcms1p4>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi MyungJoo,

On 2019-01-28 09:05, MyungJoo Ham wrote:
>> This way devfreq core ensures that all its devices will be set to safe
>> operation points before reboot operation. There are board on which some
>> aggressive power saving operation points are behind the capabilities of
>> the bootloader to properly reset the hardware and boot the board. This
>> way one can avoid board crash early after reboot.
>>
>> Similar pattern is used in CPUfreq subsystem.
>>
>> Reported-by: Markus Reichl <m.reichl@fivetechno.de>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
> You are invoking ALL devfreq suspend callbacks at shutdown
> with this commit.
>
> Can you make it invoke only devices explicitly saying their needs
> to handle "SHUTDOWN" event?
>
> For example, we can add a flag at struct devfreq_dev_profile:
> "uint32_t requirement"
> , where
> 0x1: need to operate at the initial frequency for suspend
> 0x2: need to operate at the initial frequency for shutdown
> 0x4: it forgets its status at resume, reconfigure frequency at resume.
> (or reverse 0x1's semantics for the backward compatibility)

Frankly speaking this looks like an over-engineering. Switching to safe
frequency during reboot shouldn't have any negative side-effects. IMHO
such flags can be always added later, once there will be a real use case
for them.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

