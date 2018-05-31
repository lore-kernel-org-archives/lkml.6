Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753979AbeEaGRe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 02:17:34 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:57679 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753772AbeEaGR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 02:17:28 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180531061727epoutp03b0cc7050f6c60612000480923810d5ab~zpjVvo9690403404034epoutp03X
X-AuditID: b6c32a38-78bff700000010f7-50-5b0f9370ed91
Mime-Version: 1.0
Subject: RE: [RFC] PM / devfreq: Add support for alerts
Reply-To: myungjoo.ham@samsung.com
From: MyungJoo Ham <myungjoo.ham@samsung.com>
To: Akhil P Oommen <akhilpo@codeaurora.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mka@chromium.org" <mka@chromium.org>
CC: "jcrouse@codeaurora.org" <jcrouse@codeaurora.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <1527745019-25155-1-git-send-email-akhilpo@codeaurora.org>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180531061720epcms1p31f5451bcf3150a7dddd33e1e415bb730@epcms1p3>
Date: Thu, 31 May 2018 15:17:20 +0900
X-CMS-MailID: 20180531061720epcms1p31f5451bcf3150a7dddd33e1e415bb730
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEJsWRmVeSWpSXmKPExsWy7bCmgW7BZP5og613LS1m9T1ls3h5SNPi
        +pfnrBYbF2RbnG16w24xcf9ZdovLu+awWXzuPcJo8XnDY0YHTo/ZDRdZPC739TJ59G1Zxejx
        eZNcAEtUqk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO
        0CVKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElulaENDIz1DA3M9IyMgbRxrZWQKVJKQmnHu
        2mSWgrdsFYu2bWVpYNzL2sXIySEhYCJx9dtcpi5GLg4hgR2MEpPmbWDsYuTg4BUQlPi7Qxik
        RljAXOLD3Xlg9UICShINN/cxQ8T1JToebGMEsdkEdCW2brjLAjJHROAMo8TrnZfZQRxmgdOM
        Em+P/GSG2MYrMaP9KQuELS2xfflWsG5OAXeJU6/62SHiohI3V7+Fs98fm88IYYtItN47CzVH
        UOLBz91QcSmJJ28XQtXXS1z/vAjsGwmBCYwSv2/8h0roSzy6MpsN4jNfiVt380DCLAKqEu2v
        F0CVuEhM2/sPzGYWkJfY/nYOM0g5s4CmxPpd+jDnN2z8zY7OZhbgk3j3tYcVJr5j3hMmCFtN
        4tDuJVD1MhKnpy+EOt9DYv7umywTGBVnIYJ6FpLFsxAWL2BkXsUollpQnJueWmxYYKJXnJhb
        XJqXrpecn7uJEZwetSx2MO4553OIUYCDUYmHd8NKvmgh1sSy4srcQ4wSHMxKIrxTyvijhXhT
        EiurUovy44tKc1KLDzGaAv0/kVlKNDkfmLrzSuINTY2MjY0tTAzNTA0NlcR528z/RQkJpCeW
        pGanphakFsH0MXFwSjUwNqvKzHE6wv52uuvKSNEvHRpa725t0NP4cu6MgkLNtipL9eUTn+1b
        lfaHzYht+rrts5Tf3q7cfErps/Xql9vDDZ+c+eHgMl9erNmaJWJa0XFX+0JOuV2TJPckq5zI
        rvV+9/TWzmNipROe2prbM/9OkT32yvfRI2/n7zNvu8050XJMPfyv5cpjAkosxRmJhlrMRcWJ
        ACnXPuqlAwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180531053717epcas5p48e0d962e2108d04529b4582a70cd7d5a
References: <1527745019-25155-1-git-send-email-akhilpo@codeaurora.org>
        <CGME20180531053717epcas5p48e0d962e2108d04529b4582a70cd7d5a@epcms1p3>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Currently, DEVFREQ reevaluates the device state periodically and/or
> based on the OPP list changes. Private API has to be exposed to allow
> the device driver to alert/notify the governor to reevaluate when a new
> set of data is available. This makes the governor more coupled to a
> particular device driver. We can improve here by exposing a DEVFREQ API
> to allow the device drivers to send generic alerts to the governor.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@codeaurora.org>
> ---
>  drivers/devfreq/devfreq.c  | 21 +++++++++++++++++++++
>  drivers/devfreq/governor.h |  1 +
>  include/linux/devfreq.h    |  5 +++++
>  3 files changed, 27 insertions(+)
> 

Hello Akhil,

It appears that this will have the same effect with
"[PATCH 08/11] PM / devfreq: Make update_devfreq() public" from Matthias Kaehlcke, doesn't it?


Cheers,
MyungJoo
