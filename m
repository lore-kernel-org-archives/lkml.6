Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751702AbeEBOOk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 10:14:40 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59357 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751100AbeEBOOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 10:14:36 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180502141434euoutp0168f3faeb0ba34a19ef6e1cbada7197b0~q2Wo9Mr6B1806718067euoutp01v
X-AuditID: cbfec7f5-f95739c0000028a9-77-5ae9c7c9fc5c
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] thermal: ti-soc-thermal: fix incorrect entry in
 omap5430_adc_to_temp[]
Date: Wed, 02 May 2018 16:14:32 +0200
Message-id: <17742083.Vu59BImYbG@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsWy7djPc7onj7+MMvh/X8Bi/pVrrBantjcx
        WVzeNYfNYvaSfhaLz71HGC2ePOxjc2Dz2DnrLrvH4j0vmTyO39jO5PF5k1wASxSXTUpqTmZZ
        apG+XQJXRuPDKawFv9kqpk5XaWD8xdrFyMkhIWAicfhZF0sXIxeHkMAKRok1394zQzifGSWm
        Nkxngam6e+YQVGIZo8SJk8ehWn4zSnxevI4ZpIpNwEpiYvsqRhBbRMBNYtaSP2A2s0ClxJLX
        V5i6GDk4hAViJHpuGYOEWQRUJV4d7WICsXkFtCROtb8EGyMq4CWxZV87VFxQ4sfkeywQY+Ql
        9u2fygph60icPbaOEeQGCYEeNonLM6ewQVzqInFk7VSoq4UlXh3fwg5hy0hcntzNAtHQzCjx
        bcceZojEBEaJPeuFIGxricPHL0Jt4JOYtG06M8jREgK8Eh1tUCUeEhf+X4Pa5SixY+V1sDFC
        ArESG053Mk9glJmF5O5ZSO6eheTuBYzMqxjFU0uLc9NTi43zUsv1ihNzi0vz0vWS83M3MQIj
        //S/4193MO77k3SIUYCDUYmH1yDvRZQQa2JZcWXuIUYJDmYlEd6VHc+ihHhTEiurUovy44tK
        c1KLDzFKc7AoifPGadRFCQmkJ5akZqemFqQWwWSZODilGhj3aTzbeG2aoN8+x5tNq7MXLJ2w
        TUpnVVFepsCnM4W3t/IlPsuLWf7iRbLUsQBjy4+nHHgurOLJMuX6fSszZNGZk+0dmb9P9bpW
        ZOa98lu0UvawOY+ygwwP+675nVed1+ytnHAp3ty5KyG/mefB7aTki5ypE369dN6oeI0psmZm
        hMvxK28YvduUWIozEg21mIuKEwFnrzJO+AIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsVy+t/xq7onjr+MMljZYGgx/8o1VotT25uY
        LC7vmsNmMXtJP4vF594jjBZPHvaxObB57Jx1l91j8Z6XTB7Hb2xn8vi8SS6AJYrLJiU1J7Ms
        tUjfLoEro/HhFNaC32wVU6erNDD+Yu1i5OSQEDCRuHvmEHMXIxeHkMASRolH768zQjh/GSVW
        Lp/ICFLFJmAlMbF9FZgtIuAmMWvJHzCbWaBSYuXCRqBJHBzCAjESPbeMQcIsAqoSr452MYHY
        vAJaEqfaXzKD2KICXhJb9rVDxQUlfky+xwIxRl5i3/6prBC2lsT6nceZJjDyzkJSNgtJ2Swk
        ZQsYmVcxiqSWFuem5xYb6RUn5haX5qXrJefnbmIEBuG2Yz+37GDsehd8iFGAg1GJh9cg70WU
        EGtiWXFl7iFGCQ5mJRHelR3PooR4UxIrq1KL8uOLSnNSiw8xSnOwKInznjeojBISSE8sSc1O
        TS1ILYLJMnFwSjUwqheFnp72UqWXje3q38V/I1/b75uWv3QiY1zB/u1lgbfDt9qImRaaXlge
        fuZOr8xjl7jJtyOPlbYw3rSfsOG+WHlDRoiIBPtr+3MTc12Wpy/L2rNS8tDe88/OdWw2vHav
        5F6je7MxDxfDTKm3LTF5LFIbS2/ZX1puupe17NPU9cbzp8YtnZjfosRSnJFoqMVcVJwIAK6M
        gas+AgAA
X-CMS-MailID: 20180502141432eucas1p1c85aa366979b73c59a46ec0c2f7ef8e6
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180502141432eucas1p1c85aa366979b73c59a46ec0c2f7ef8e6
X-RootMTR: 20180502141432eucas1p1c85aa366979b73c59a46ec0c2f7ef8e6
References: <CGME20180502141432eucas1p1c85aa366979b73c59a46ec0c2f7ef8e6@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Entry for Index 941 has one zero too much. Fix it.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
v2:
- Fix patch description.

 drivers/thermal/ti-soc-thermal/omap5-thermal-data.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
===================================================================
--- a/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c	2018-04-30 16:23:42.000000000 +0200
+++ b/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c	2018-05-02 14:16:09.461434201 +0200
@@ -310,7 +310,7 @@ omap5430_adc_to_temp[
 	119800, 120200, 120600, 121000, 121400, 121800, 122400, 122600, 123000,
 	123400,
 	/* Index 940 - 945 */
-	123800, 1242000, 124600, 124900, 125000, 125000,
+	123800, 124200, 124600, 124900, 125000, 125000,
 };
 
 /* OMAP54xx ES2.0 data */
