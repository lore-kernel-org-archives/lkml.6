Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754255AbeDPMlh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 08:41:37 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:43526 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752620AbeDPMld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 08:41:33 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180416124131euoutp01f66a11ea36d128c1e60a1684e2997e9a~l6w10RUSW1023210232euoutp01k
X-AuditID: cbfec7f4-713ff700000043e4-42-5ad499faaa82
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maciej Purski <m.purski@samsung.com>
Subject: Re: [PATCH 03/14] thermal: exynos: Read soc_type from match data
Date: Mon, 16 Apr 2018 14:41:26 +0200
Message-ID: <5369056.eM2qptIOQZ@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-Reply-To: <09824e4e-b60a-13eb-36a5-a6f2172b5539@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djPc7q/Zl6JMth3k81i3mdZi/lXrrFa
        9D9+zWxx/vwGdovLu+awWXzuPcJoMeP8PiaLBS9vsVg8edjH5sDpsXPWXXaPxXteMnlsWtXJ
        5nHn2h42j74tqxg9Pm+SC2CL4rJJSc3JLEst0rdL4Mp4fXw/c8Fktoo/O56zNTB2snYxcnJI
        CJhIbPp5Hsjm4hASWMEo8bh7GzOE84VR4szro4wQzmdGiVur/rHAtLR2NUG1LGeU2Lr6LFTV
        B0aJK69XsoFUsQlYSUxsX8UIYosI6Ek0vm9jAiliFpjBJLFxyzuw7cICnhK/L30Da2ARUJVY
        0TUFzOYV0JQ482UiO4gtKuAlsWVfOxOIzSlgJzF33Rx2iBpBiZMzn4CdxCwgL9FxuRHsJAmB
        XewSNxqnQb3nIvHv90d2CFtY4tXxLVC2jMT/nfOZIBqaGSW+7djDDJGYwCixZ70QhG0tcfj4
        RaBBHEAbNCXW79KHCNtKHD35kw0kLCHAJ3HjrSDEDXwSk7ZNZ4YI80p0tEENUZPYsGwDG8zW
        rp0roRZ5SHQv6WGawKg0C8k3s5B8Mwth7wJG5lWM4qmlxbnpqcVGeanlesWJucWleel6yfm5
        mxiBqej0v+NfdjDu+pN0iFGAg1GJh3fH2ctRQqyJZcWVuYcYJTiYlUR4lyUChXhTEiurUovy
        44tKc1KLDzFKc7AoifPGadRFCQmkJ5akZqemFqQWwWSZODilGhhnvFBomGa5faZ7ArOr65Gi
        yp4bE2b6ezIqxT5+6cT7SL3xgemTS8/ShAS2NdgG18fFMUfxKGXEKztunnJ7V3bbIpHt3iGr
        RUP7vZed8LjvJX3g4bufdiqpGl83VNn99GG//v+cie7nzH/FvX8+/hYVizF1TZ9Zdf3ftEt/
        VYRcmfqZZ786eFqJpTgj0VCLuag4EQBRmtugQQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsVy+t/xu7o/Zl6JMlhxjcti3mdZi/lXrrFa
        9D9+zWxx/vwGdovLu+awWXzuPcJoMeP8PiaLBS9vsVg8edjH5sDpsXPWXXaPxXteMnlsWtXJ
        5nHn2h42j74tqxg9Pm+SC2CL0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXS
        t7NJSc3JLEst0rdL0Mt4fXw/c8Fktoo/O56zNTB2snYxcnJICJhItHY1AdlcHEICSxkltndf
        AnI4gBIyEsfXl0HUCEv8udbFBlHzjlHi6+OTLCAJNgEriYntqxhBbBEBPYnG921MIEXMApOY
        JBperwNLCAt4Svy+9I0NxGYRUJVY0TUFzOYV0JQ482UiO4gtKuAlsWVfOxOIzSlgJzF33Rx2
        iG3bGSUuNZ+EahCUODnzCdhmZgF5iY7LjawQto7Egt2f2CYwCs5CUjYLSdksJGULGJlXMYqk
        lhbnpucWG+kVJ+YWl+al6yXn525iBMbYtmM/t+xg7HoXfIhRgINRiYd3x9nLUUKsiWXFlbmH
        GCU4mJVEeJclAoV4UxIrq1KL8uOLSnNSiw8xmgJ9N5FZSjQ5Hxj/eSXxhqaG5haWhubG5sZm
        FkrivOcNKqOEBNITS1KzU1MLUotg+pg4OKUaGOcZzTy3cdYaZpflEbM+vDtzV/Jibti/9Yfs
        f1c87NkuKRx5eMPEN7ty+NPjjTj2fG1fztlqUhIYU5fPlR9Q8b+p0WfrZ46VgbJ/Tv+cV15/
        rMozzXkGw6kDjK7736X/2J3aeZavuv3HEZ60u7ayz6s/nUrYcuq/+vfAbWUbLxSZHUo3jpN+
        e1aJpTgj0VCLuag4EQCYUqxBxwIAAA==
X-CMS-MailID: 20180416124129eucas1p1545c737e0feb0f9f2c327b8597c46bce
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180416124129eucas1p1545c737e0feb0f9f2c327b8597c46bce
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180416124129eucas1p1545c737e0feb0f9f2c327b8597c46bce
X-RootMTR: 20180416124129eucas1p1545c737e0feb0f9f2c327b8597c46bce
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
        <1523873525-23718-4-git-send-email-b.zolnierkie@samsung.com>
        <09824e4e-b60a-13eb-36a5-a6f2172b5539@linaro.org>
        <CGME20180416124129eucas1p1545c737e0feb0f9f2c327b8597c46bce@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, April 16, 2018 02:19:30 PM Daniel Lezcano wrote:
> On 16/04/2018 12:11, Bartlomiej Zolnierkiewicz wrote:
> > From: Maciej Purski <m.purski@samsung.com>
> > 
> > Device context's field data->soc is currently obtained by comparing
> > of_compatible's. Provide soc_type as .data field in device's match
> > table, as it is done in most drivers.
> > 
> > Signed-off-by: Maciej Purski <m.purski@samsung.com>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Zhang & Eduardo are Thermal Maintainers (+ I'm Maintainer for
Samsung Thermal) so I assume you meant "Reviewed-by:"?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
