Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755084AbeDZKKv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 06:10:51 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51647 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753879AbeDZKKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 06:10:47 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180426101045euoutp02674ce9dfd7cde79acc5e51d4d790289d~o9KDhd7eK2739427394euoutp02c
X-AuditID: cbfec7f5-b5fff700000028a9-6f-5ae1a5a4efb2
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/2] video: fbdev-MMP: Improve a size determination in
 path_init()
Date: Thu, 26 Apr 2018 12:10:43 +0200
Message-id: <2229029.HUmMdrHkAV@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <293fb9cb-3020-bded-b1bd-67bbb2820aa2@users.sourceforge.net>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsWy7djP87pLlj6MMli2Vcjiytf3bBbnO5cz
        W2y9JW1xou8Dq8XlXXPYHFg97ncfZ/JoOtXO6vF5k1wAcxSXTUpqTmZZapG+XQJXxpe5jawF
        M1kruuevZG5gXMDSxcjJISFgIvHz8lSmLkYuDiGBFYwS02ftYoFwPjNK7PoxDyjDAVZ15Fwo
        RHwZo8T/dduYQbqFBH4zSjxaKwRiswlYSUxsX8UIUi8iYCrx50QISD2zQAejxMbjU8C2CQtE
        SFz+tocVxGYRUJXYdvQzWJxXQFPi8/8H7CC2qICXxJZ97UwgNqeAp8S73pmMEDWCEj8m3wOr
        ZxaQl9i3fyorhK0jcfbYOkaQZRICC9gkpq1sgnrNRWLW9+mMELawxKvjW9ghbBmJy5O7WSAa
        mhklvu3YwwyRmMAosWe9EIRtLXH4+EWoDXwSk7ZNZ4aEBK9ERxtUiYdE24UmqPmOEuubP7NC
        Qug2o8TbP4eYJjDKzkJy+Cwkh89CcvgCRuZVjOKppcW56anFxnmp5XrFibnFpXnpesn5uZsY
        gdF/+t/xrzsY9/1JOsQowMGoxMP7Y96DKCHWxLLiytxDjBIczEoivPGtD6OEeFMSK6tSi/Lj
        i0pzUosPMUpzsCiJ88Zp1EUJCaQnlqRmp6YWpBbBZJk4OKUaGGt9plxd+f/46tuntpw1aotN
        fZ6/0Wf1AkZ2jiYT9xdtKg+NYrauev/p9fFZhS+9z2d4injzVMhNXXH+snSQUNWueY5VmvcK
        z38+tkj0Unz2zcTzBUIlK/p5DF50f3h1oe6XlWJGOEcOu/PtNdsFM6PmGB9wr/t+P+PYkhOi
        cRP7cywuHS6yP6zEUpyRaKjFXFScCABWIJMi+gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsVy+t/xy7qLlz6MMlg3R9niytf3bBbnO5cz
        W2y9JW1xou8Dq8XlXXPYHFg97ncfZ/JoOtXO6vF5k1wAcxSXTUpqTmZZapG+XQJXxpe5jawF
        M1kruuevZG5gXMDSxcjBISFgInHkXGgXIxeHkMASRomXG6awQDh/GSXef17B1MXIycEmYCUx
        sX0VI0iDiICpxJ8TISA1zAIdjBIT/y1hBqkRFoiQuPxtDyuIzSKgKrHt6GcWEJtXQFPi8/8H
        7CC2qICXxJZ97WAzOQU8Jd71zmSEWHabUeL7ybPMEA2CEj8m3wNrZhaQl9i3fyorhK0lsX7n
        caYJjPyzkJTNQlI2C0nZAkbmVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIEhuu3Yzy07GLve
        BR9iFOBgVOLh/THvQZQQa2JZcWXuIUYJDmYlEd741odRQrwpiZVVqUX58UWlOanFhxilOViU
        xHnPG1RGCQmkJ5akZqemFqQWwWSZODilGhj5oydlTOta80Y4ny/Fw7Tn44K5YfvKju/XXcYb
        0SSlc7N29svOBF8TwVUGqr8eX5rvrLTCVWbvMyvOG1tmNkUuMjlYK7HpoVJ5bvu+LaVtfmni
        U5xDndUqJ2yO0iw8OP2IQ9Qubb4VIle2fNmU+OPDLwa/K7HPCrO+GnzrzH1wZ/bKvZNk1/xW
        YinOSDTUYi4qTgQALiR/5U0CAAA=
X-CMS-MailID: 20180426101043eucas1p20bcd2df08cc8b0d2630f83fe1bcb00c8
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20171126204359epcas2p46af86788c6717a9d1392cd693f524987
X-RootMTR: 20171126204359epcas2p46af86788c6717a9d1392cd693f524987
References: <e2c5fe9e-8e01-7fef-a243-ff5d063787b0@users.sourceforge.net>
        <CGME20171126204359epcas2p46af86788c6717a9d1392cd693f524987@epcas2p4.samsung.com>
        <293fb9cb-3020-bded-b1bd-67bbb2820aa2@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, November 26, 2017 09:43:52 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 26 Nov 2017 21:21:33 +0100
> 
> Replace the specification of a data structure by a pointer dereference
> as the parameter for the operator "sizeof" to make the corresponding size
> determination a bit safer according to the Linux coding style convention.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch queued for 4.18, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
