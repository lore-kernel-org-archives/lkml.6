Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752678AbeEOJsF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 05:48:05 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:17190 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752403AbeEOJr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 05:47:57 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180515094755epoutp02a744ea23ca6f78ed8790d9f1cd359dd0~uyGiltPyO0168501685epoutp02D
X-AuditID: b6c32a45-8f3ff70000001020-54-5afaacca10b0
Subject: Re: [PATCH 26/61] media: platform: exynos4-is: simplify getting
 .drvdata
To: linux-media@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <613c3648-1d2e-e008-60a8-d9f21eca9fae@samsung.com>
Date: Tue, 15 May 2018 11:47:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-version: 1.0
In-reply-to: <20180419140641.27926-27-wsa+renesas@sang-engineering.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsWy7bCmue6pNb+iDO7dsrDYekvaov/xa2aL
        8+c3sFucbXrDbrHp8TVWi8u75rBZ9GzYymqx9eU7JosZ5/cxWSzb9IfJou+cuwO3x6ZVnWwe
        m5fUe/RtWcXo8WzhehaPz5vkAlijuGxSUnMyy1KL9O0SuDKuTfnEVLCYqaLl7gXmBsavjF2M
        nBwSAiYSp47NBrOFBHYwSvxZytrFyAVkf2eU+HF8GlsXIwdY0Yez8hDxDYwS3Z9+M0M49xkl
        zq44wQrSLSwQLHHtxDoWEFtEQF7iSe8NNpAiZoFWZon7W9vAitgEDCV6j/aBreMVsJPo+rme
        HcRmEVCVuNu2FqxZVCBCoun5T3aIGkGJH5PvsYBcwSngLrHxtxJImFlAU+LFl0ksELa4xLH7
        NxkhbHmJzWvegh0nIfCeTaJv1gVWiA9cJJZ+c4T4WFji1fEt7BC2tMSzVRuhIVEt0dnWxQ7R
        2wIMiWmX2CAS1hKHj19khVjAJ9Fx+C87xExeiY42IQjTQ+L/ugqIakeJ69+OQcPnGqPE/41b
        GCcwys1C8s0sJC/MQvLCLCQvLGBkWcUollpQnJueWmxUYKhXnJhbXJqXrpecn7uJEZxytFx3
        MM4453OIUYCDUYmHN2Hazygh1sSy4srcQ4wSHMxKIry7jYBCvCmJlVWpRfnxRaU5qcWHGKU5
        WJTEedcofY0SEkhPLEnNTk0tSC2CyTJxcEo1MD7wcf/FtZDX41JHwbN8m+8Len65y8+7KFSq
        qSx557/iv69n5lvlHcoz1Z4+/eAK/+iQszJKN0xjhI4Gyqx511sapHWBs9Jelj19QR+D58+v
        9VH9j9Lrf5l+Pm1xxPduI1+mSKWxi5+YEK9mwiGrnd4WTx+Lq/9+oJN0sv/bW679t//YlRU5
        KLEUZyQaajEXFScCAD46KYg1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsVy+t9jQd1Ta35FGby9oWax9Za0Rf/j18wW
        589vYLc42/SG3WLT42usFpd3zWGz6NmwldVi68t3TBYzzu9jsli26Q+TRd85dwduj02rOtk8
        Ni+p9+jbsorR49nC9SwenzfJBbBGcdmkpOZklqUW6dslcGVcm/KJqWAxU0XL3QvMDYxfGbsY
        OTgkBEwkPpyV72Lk4hASWMcocfTsBOYuRk4g5yGjxKtpHCC2sECwxLUT61hAbBEBeYknvTfY
        QBqYBVqZJe78XcUC0d3EKHF/23OwKjYBQ4neo32MIDavgJ1E18/17CA2i4CqxN22tWA1ogIR
        EvfOf2KDqBGU+DH5HgvIRZwC7hIbfyuBmMwC6hJTpuSCVDALiEscu3+TEcKWl9i85i3zBEaB
        WUiaZyF0zELSMQtJxwJGllWMkqkFxbnpucVGBUZ5qeV6xYm5xaV56XrJ+bmbGIExsu2wVv8O
        xsdL4g8xCnAwKvHwJkz7GSXEmlhWXJl7iFGCg1lJhHe3EVCINyWxsiq1KD++qDQntfgQozQH
        i5I4L3/+sUghgfTEktTs1NSC1CKYLBMHp1QDo0i3/Yfrq0+wZj3R9F3psN7fkY3t371DgkLq
        T5UVrr6aNZ9RVeHI1j8tc7RFUvTuruDY7/5hEj/DZPdZDHsu2k4onP2Kub6j+tXHUyL/gyYx
        nt68zsm8bMsKN++bM9sfrNq2rnrhzNVP5Ku5+i/NUIs6Ux2YtenCLGvP5n6XV4dVBY/f8TM+
        raTEUpyRaKjFXFScCAAegqjFjQIAAA==
X-CMS-MailID: 20180515094754epcas2p2715cc9c6376ddbb5f400830ef41b514b
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180515094754epcas2p2715cc9c6376ddbb5f400830ef41b514b
X-RootMTR: 20180515094754epcas2p2715cc9c6376ddbb5f400830ef41b514b
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
        <20180419140641.27926-27-wsa+renesas@sang-engineering.com>
        <CGME20180515094754epcas2p2715cc9c6376ddbb5f400830ef41b514b@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/19/2018 04:05 PM, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
