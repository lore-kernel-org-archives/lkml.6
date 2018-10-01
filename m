Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAC3C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 07:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F431208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 07:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="B0XF8jQo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F431208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbeJAOBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 10:01:37 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60366 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728696AbeJAOBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 10:01:36 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181001072512euoutp018cdd82d1e6721a2c84a57c5e59fdb557~Za0nl22Bq1756217562euoutp01G
        for <linux-kernel@vger.kernel.org>; Mon,  1 Oct 2018 07:25:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181001072512euoutp018cdd82d1e6721a2c84a57c5e59fdb557~Za0nl22Bq1756217562euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1538378712;
        bh=W3qTB7TMez+22zFQO7WyaARqp2QZFiR/NQIYeAEMaXQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=B0XF8jQoCfCeixDt1cIxQECffNdjgodKIsr3iOTvnFeA/Tb1KckfI83Sgs2LcFm4v
         WSbcfMmOlChcp2gCUf1WHCFn88iXjxPEWMgSXAzXOYE3qpK+M0a4Ss+Ln2z7bVCiRd
         ePVC2XOjB7nzUwxZZGlmJPlilAJmu5DJgZ6Nb+lw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181001072512eucas1p18b615c8aeda542b9705ac9abcce613f3~Za0m3bbfQ2850328503eucas1p11;
        Mon,  1 Oct 2018 07:25:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id F7.E7.04294.7DBC1BB5; Mon,  1
        Oct 2018 08:25:11 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181001072510eucas1p29a6e504d642d2cac67ed7c3b43f9d53c~Za0l11ceE1868218682eucas1p2w;
        Mon,  1 Oct 2018 07:25:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181001072510eusmtrp243f9447c3591b08b7ad4eb9c4322d96c~Za0lk0Iho1773917739eusmtrp2E;
        Mon,  1 Oct 2018 07:25:10 +0000 (GMT)
X-AuditID: cbfec7f4-c77a99c0000010c6-e8-5bb1cbd7fdef
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 3D.10.04284.6DBC1BB5; Mon,  1
        Oct 2018 08:25:10 +0100 (BST)
Received: from [106.120.51.25] (unknown [106.120.51.25]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181001072510eusmtip1ffc8097ce54e90698d224de23a69294b~Za0lOKTxd1033010330eusmtip1F;
        Mon,  1 Oct 2018 07:25:10 +0000 (GMT)
Subject: Re: [PATCH] regulator: core: Pass max_uV value to
 regulator_set_voltage_rdev
To:     Dmitry Osipenko <digetx@gmail.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        Carlos Hernandez <ceh@ti.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
From:   Maciej Purski <m.purski@samsung.com>
Date:   Mon, 1 Oct 2018 09:25:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <dbaa721a-9a47-2c6a-46d5-92a7ca13c5aa@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRTut3t3d9Vm12nspGEx/CfxkRE0KEUh4hIEkoijBbryoqabY/NZ
        kEsj02CVpua0WrWpaKEuHymouJymkuYDNUkwtTBLzbSV+Kp5J/nfd75zzne+Dw6JCeq57mSc
        IolRKWQJIsIRb+hc7fcd7a2VHs1v9xMXfJohxK3aNUJctTSNxKbpEa54qLmUEJcY7uLilx0T
        PHHb8Nlgkrb+ysPpJt0EjzZV5hD0K0MGra2rRHTXWCOHXjZ5hvIuOJ6KZhLiUhiVf1CUY2zH
        uosyyylNP5jJ0aAFMhc5kEAdhwJdGZ6LHEkBVYHg++pXgi1WEKwtPbMXywiK327wdlYW+6yI
        bZQj6L/ZyGGLeQTa+624bcqVioAm0ziWi0jSjaKhcoux0Rg1hMC0EGajCcobXmRH2mic8oI7
        f4oJG95PSeBpwWdkw3zKBbqLZ7YVHahAMM61cFkZIYzPPOGw+BA0zpdiNgtA9fBgdL4eZ5dT
        oOVdNcaaPg1GSw3OYleY66qzhzkIW02sEFCpMNeZhbNCGgQWjdW+cBLedA1wbaYx6ghUN/uz
        dAj06G5sRwTKGcbmXVg/zpDXUGSn+XD7loCdFsHsww37JQBj9xT3HhLpdqXU7Uqm25VM9/+u
        HuGVSMgkq+UxjPqYgkn1U8vk6mRFjN/lRLkJ/Xum3s2uldeoef2SGVEkEu3lh5qrpQKuLEWd
        LjcjIDGRG//8cI1UwI+WpV9lVImRquQERm1GHiQuEvLLHtdKBVSMLImJZxglo9rpckgHdw1K
        MwhbAuN9vYYqfk4uX3uews2sGjRaAmsHpoxOdcq51k6zJSJDsjkxEq6/mJ8TUJ0tGGjXtsTN
        yH58CXLzOTPp6bN44OOHKiwsaV+Rx/sQ/ylDZnjjCZFv8JWJC8pvvEc1uYU+baH6PfQDS+HC
        rLU8qqRv7DfRJ7nea5QcFmjPiXB1rCzAG1OpZX8BGG1OuEgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsVy+t/xu7rXTm+MNvg+V8Ni6sMnbBb7+n6z
        Waz++JjRYtPja6wWl3fNYbOYvaSfxWLtkbvsFvuveDlweHz7OonFY+esu+wem1Z1snlsXlLv
        0bdlFaPH8RvbmTw+b5ILYI/SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3
        s0lJzcksSy3St0vQyzjyR7CgmbtiwaUmpgbGdxxdjJwcEgImEu/PfWMEsYUEljJKbL2iBhGX
        kDh7/z8rhC0s8edaF1sXIxdQzWtGiZuLe1lAEsIC4RI7N91i7mLk4BAR8JBY9T8VpIZZ4DKj
        xKnG+0wQDTdZJJ7uPcMKUsQmoCWxpj0epJdXwE5i28xLYHNYBFQkun/MZAOxRQUiJDpXzmeB
        qBGUODnzCZjNKWArsfTVXrCDmAXMJOZtfsgMYYtL3HoynwnClpfY/nYO8wRGoVlI2mchaZmF
        pGUWkpYFjCyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAmNx27Gfm3cwXtoYfIhRgINRiYc3
        4ND6aCHWxLLiytxDjBIczEoivEFXNkQL8aYkVlalFuXHF5XmpBYfYjQFem4is5Rocj4wTeSV
        xBuaGppbWBqaG5sbm1koifOeN6iMEhJITyxJzU5NLUgtgulj4uCUamCc80dpwgd/JvePvwxY
        jmQ5PfqWGs4aWrBlqt4Wx3M107adiW/Syv7pXnB34u9dPMkc70KWTgp4VNXJPuldVvWsFVJf
        b7Qd3/f5Y+lVY1NX9pC8nzvFTWw223HIRbeuOlMV8veM7qn7lalXVuzzMnfe/zZoeUjCZ777
        M1+y9WqcCSndfefX7KZAJZbijERDLeai4kQA9tfOBNsCAAA=
Message-Id: <20181001072510eucas1p29a6e504d642d2cac67ed7c3b43f9d53c~Za0l11ceE1868218682eucas1p2w@eucas1p2.samsung.com>
X-CMS-MailID: 20181001072510eucas1p29a6e504d642d2cac67ed7c3b43f9d53c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180618140856eucas1p281619f9bf003655a3c2eac356216ab25
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180618140856eucas1p281619f9bf003655a3c2eac356216ab25
References: <20180615112916.GK112168@atomide.com>
        <CGME20180618140856eucas1p281619f9bf003655a3c2eac356216ab25@eucas1p2.samsung.com>
        <1529330913-11152-1-git-send-email-m.purski@samsung.com>
        <20180702080505.GN112168@atomide.com>
        <95655644-ef41-f5bd-7e8e-a257d48cd020@gmail.com>
        <20180928202251.GM5662@atomide.com>
        <2c0132ff-ea0f-f19e-ebfb-a0d077565d2c@gmail.com>
        <20180928224109.GS5662@atomide.com>
        <ea0a59ef-e201-986a-9499-a0638359b1b9@gmail.com>
        <d14cc796-8644-41a3-5135-299bd8820204@gmail.com>
        <20180929002753.GT5662@atomide.com>
        <dbaa721a-9a47-2c6a-46d5-92a7ca13c5aa@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
unfortunately, I don't work at kernel anymore. That would be great, if you could take over those patches and finish the 
work.
Best regards,
Maciej

On 09/29/2018 02:44 AM, Dmitry Osipenko wrote:
> On 9/29/18 3:27 AM, Tony Lindgren wrote:
>> * Dmitry Osipenko <digetx@gmail.com> [180928 23:55]:
>>> On 9/29/18 2:17 AM, Dmitry Osipenko wrote:
>>>> On 9/29/18 1:41 AM, Tony Lindgren wrote:
>>>>> I'm still getting these errors after init:
>>>>
>>>> Thank you very much again, seems I got what's wrong with your case. The ti-abb-regulator driver sets the "abb->current_info_idx = -EINVAL" on probe and that value is getting updated only after the first voltage change, hence _regulator_get_voltage() returns -22.
>>
>> OK that's starting to make some sense now thanks.
>>
>>>> Please try this patch:
>>>
>>> I've revised the patch and here is the current final version.
>>
>> Hey cool this one works now :) I suggest you rework the whole series
>> with these fixes. I recall the series had a problem with git bisect
>> too between the patches. It will make life easier for other people
>> who may need to git bisect these patches.
> 
> Awesome! There are few other things in this patchset that also need fixing. I've asked Maciej if he's going to continue working on the patches, waiting for the answer. I can pick up the patches and try to finish the work if necessary.
> 
> 
