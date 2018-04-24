Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752075AbeDXQAS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 12:00:18 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50073 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751285AbeDXQAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 12:00:00 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180424155958euoutp012aaca26d691b87d14c18ba0f54e2dc2f~oaoZPGJXr2320923209euoutp01Q
X-AuditID: cbfec7f5-f95739c0000028a9-c2-5adf54782e79
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 57/61] video: fbdev: simplify getting .drvdata
Date: Tue, 24 Apr 2018 17:59:40 +0200
Message-ID: <2148068.ySUABWLNhf@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-Reply-To: <20180419140641.27926-58-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42LZduzned2KkPtRBgdmClpc+fqezWLrLWmL
        E30fWC0u75oD5L18x2TRd87dgc3jfvdxJo9nC9ezeHzeJBfAHMVlk5Kak1mWWqRvl8CVsX/z
        XtaCRuaKh00PmRoYdzN1MXJySAiYSNy69YMRxBYSWMEo0fgrtIuRC8j+wiixfsYSJgjnM6PE
        i1cf2OE6bpxmh0gsZ5T4NfspM4TzgVHi+4l/YFVsAlYSE9tXgc0VETCWWNM8G6yDWWAZo8Tu
        mZfYQBLCAk4SDxbOBEpwcLAIqErse+8PEuYV0JS49GcLK4gtKuAlsWVfO9itnALuEvcnPmWB
        qBGUODnzCZjNLCAv0XG5kRXium52ib+LgiFsF4nb+/5DXS0s8er4FihbRuL/zvlgr0kINDNK
        fNuxhxkiMYFRYs96IQjbWuLw8YusILcxAx20fpc+RNhWomnCLRaQsIQAn8SNt4IQJ/BJTNo2
        nRkizCvR0QY1RE1iw7INbDBbu3auhFrkIXH6/gu2CYxKs5A8MwvJM7MQ9i5gZF7FKJ5aWpyb
        nlpsnJdarlecmFtcmpeul5yfu4kRmEZO/zv+dQfjvj9JhxgFOBiVeHh//L4bJcSaWFZcmXuI
        UYKDWUmEd6/cvSgh3pTEyqrUovz4otKc1OJDjNIcLErivHEadVFCAumJJanZqakFqUUwWSYO
        TqkGxhkqdbxyT/6UCWy9nMq6h+eodVihAtP8qLsXC1/rrqnRniVSG/xITGvLbKUq++XeuVFB
        i6wufb86Meqe96qcSddu67pkTfs2Z8X9qluXbaKeSrTeqbusdd6sP8h4j4qfXLZRwL+/z51M
        lnw03qbsysZ/KuWNk+n5xB+vXjXYaMdKFTjZcO5YocRSnJFoqMVcVJwIADH1fM0fAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsVy+t/xu7rFIfejDGZ+Y7G48vU9m8XWW9IW
        J/o+sFpc3jUHyHv5jsmi75y7A5vH/e7jTB7PFq5n8fi8SS6AOUrPpii/tCRVISO/uMRWKdrQ
        wkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEvY//mvawFjcwVD5seMjUw7mbqYuTk
        kBAwkbh14zR7FyMXh5DAUkaJKU+/MXYxcgAlZCSOry+DqBGW+HOtiw2i5h2jxMnm62DNbAJW
        EhPbVzGC2CICxhJrmmeDDWIWWMQosfrCNbAiYQEniQcLZ7KDDGURUJXY994fJMwroClx6c8W
        VhBbVMBLYsu+drByTgF3ifsTn7JALLvEKNF76w4bRIOgxMmZT1hAbGYBeYmOy42sELaOxILd
        n9gmMArOQlI2C0nZLCRlCxiZVzGKpJYW56bnFhvpFSfmFpfmpesl5+duYgTGyLZjP7fsYOx6
        F3yIUYCDUYmH98fvu1FCrIllxZW5hxglOJiVRHj3yt2LEuJNSaysSi3Kjy8qzUktPsRoCvTc
        RGYp0eR8YPzmlcQbmhqaW1gamhubG5tZKInznjeojBISSE8sSc1OTS1ILYLpY+LglGpgrNzs
        euiq0S7m3FeuhyVevOjpXexpc2HOFJ6uplv+b478vXW/57BSSiFb8j/tS6eNRHQSJSRPqK9b
        1KEgWzNH/f7Nk73Wol82beeep8yR+XTLu38vHr86kGOrzvXMfmGAQktK2ytR9+7myM/Hl23f
        +veY6pPuyCMzFXrdzv16WJat+LIh/lHXLCWW4oxEQy3mouJEAFCI0PqnAgAA
X-CMS-MailID: 20180424155949eucas1p1829eec2ae5b078c6b017b8c5f7840715
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180424155949eucas1p1829eec2ae5b078c6b017b8c5f7840715
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180419140717epcas3p4240e2c1bf23b1fa7dc3cf9b3a1d1251b
X-RootMTR: 20180419140717epcas3p4240e2c1bf23b1fa7dc3cf9b3a1d1251b
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
        <CGME20180419140717epcas3p4240e2c1bf23b1fa7dc3cf9b3a1d1251b@epcas3p4.samsung.com>
        <20180419140641.27926-58-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, April 19, 2018 04:06:27 PM Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Patch queued for 4.18, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
