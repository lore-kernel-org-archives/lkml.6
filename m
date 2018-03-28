Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753273AbeC1Nmv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 09:42:51 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:59666 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751207AbeC1Nmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 09:42:49 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180328134247epoutp04e80c0cf13fefab196bcc203a54b49b36~gGV56yciK1053710537epoutp04Y
X-AuditID: b6c32a46-b85ff70000000fe8-ae-5abb9bd764af
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Bernie Thompson <bernie@plugable.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 1/2] video: udlfb: Return an error code only as a
 constant in dlfb_realloc_framebuffer()
Date: Wed, 28 Mar 2018 15:42:44 +0200
Message-id: <60893411.8iluP6siGW@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <632abf1e-8c40-cbd2-4bbe-5dfdf89cb95f@users.sourceforge.net>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsWy7bCmqe712bujDJ4v4rK4eP8bi8WVr+/Z
        LM53Lme22HpL2uJE3wdWi8u75rA5sHnc7z7O5PF0ahebR9OpdlaPz5vkAliiuGxSUnMyy1KL
        9O0SuDIO7j7CXrCepWLTvWOMDYzHmLsYOTgkBEwkTvbUdjFycQgJ7GCUuL5iGguE851R4sGf
        y4xdjJxgRYcWL2eGSGxglNg+YQMjhPOVUWLH2mZ2kCo2ASuJie2rGEHGigiYSvw5EQJSwyyw
        kVGi++deJpAaYYFCiR27trOA2CwCqhInz29hA7F5BbQk+m6/A5sjKuAlsWVfOxPIHE4BT4nt
        c30hSgQlfky+B9bKLCAvsW//VFYIW0fi7LF1YPdICGxgk9h5pY8V4moXiesN/6A+EJZ4dXwL
        O4QtLfFs1UaohmZGiW879jBDJCYwSuxZLwRhW0scPn4RagOfRMfhv+yQ8OKV6GiDKvGQeLJv
        MRuE7Sjx+2w/NOhuM0psu/2BaQKj7Cwkh89CcvgsJIcvYGRexSiWWlCcm55abFRgpFecmFtc
        mpeul5yfu4kRnA603HYwLjnnc4hRgINRiYe3IGZXlBBrYllxZe4hRgkOZiUR3vcau6OEeFMS
        K6tSi/Lji0pzUosPMUpzsCiJ87YGuEQJCaQnlqRmp6YWpBbBZJk4OKUaGMUvGDBmNVya6v2M
        ff20793JC76t05da8bQv/PLPG65F+apyy/VCkop3nRANOpobUWh2wHfh1W+nmKtbzs+w/WcS
        tK560f/Jtj8iIt1uK3Z8+RShyuI9e4v0kZ9lC5buV1kwYcbZFlHlytfP+4LLWLa2zLgWEbly
        /uS/ogu373XozY/wTXrC1aDEUpyRaKjFXFScCADiU9VNAwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsVy+t9jQd1rs3dHGZy4Z2Jx8f43FosrX9+z
        WZzvXM5ssfWWtMWJvg+sFpd3zWFzYPO4332cyePp1C42j6ZT7awenzfJBbBEcdmkpOZklqUW
        6dslcGUc3H2EvWA9S8Wme8cYGxiPMXcxcnJICJhIHFq8HMjm4hASWMcocW7HAjYI5yujxJF7
        T9lAqtgErCQmtq9i7GLk4BARMJX4cyIEpIZZYCOjxNOr81hAaoQFCiV27NoOZrMIqEqcPL8F
        rJdXQEui7/Y7dhBbVMBLYsu+diaQOZwCnhLb5/pC7LrLKDFr7WRWiHpBiR+T74HNYRaQl9i3
        fyorhK0lsX7ncaYJjPyzkJTNQlI2C0nZAkbmVYySqQXFuem5xUYFRnmp5XrFibnFpXnpesn5
        uZsYgQG87bBW/w7Gx0viDzEKcDAq8fAWxOyKEmJNLCuuzD3EKMHBrCTC+15jd5QQb0piZVVq
        UX58UWlOavEhRmkOFiVxXv78Y5FCAumJJanZqakFqUUwWSYOTqkGxsObv7ytdE+9fa5OUCnx
        6gflWew/Vmdu9DA9+KlyVtm0eTK3W/2WFKYslHP5sbXRZyb3lZcta6J37Lrfnb5ILsH0/U0p
        tWBOBrF7wiIsR7qPK08OEo2tudt5+mKpx+bpU3qua9vlLWHeJm+lGmu8R/lW+wHJA/OSNLUn
        /fFUcXLeFXnidTGvsRJLcUaioRZzUXEiAJ78EGxcAgAA
X-CMS-MailID: 20180328134246epcas2p38c1479c4a191cad283c2b9f9334e1f82
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20171124204825epcas1p41626d598b6e437dfb4c6b648e3730cc1
X-RootMTR: 20171124204825epcas1p41626d598b6e437dfb4c6b648e3730cc1
References: <CGME20171124204825epcas1p41626d598b6e437dfb4c6b648e3730cc1@epcas1p4.samsung.com>
        <25aee051-12fb-de5f-c806-f419fa4c0ef1@users.sourceforge.net>
        <632abf1e-8c40-cbd2-4bbe-5dfdf89cb95f@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, January 07, 2018 02:34:51 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 7 Jan 2018 14:02:36 +0100
> 
> * Return an error code without storing it in an intermediate variable.
> 
> * Delete the label "error" and local variable "retval"
>   which became unnecessary with this refactoring.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
