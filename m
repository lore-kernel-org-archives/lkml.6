Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753032AbeE1Eva (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 00:51:30 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:54427 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751068AbeE1Ev1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 00:51:27 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180528045125epoutp01c84e7dd933a37f2f07cc449bcc877641~ytcXsmZSm1786317863epoutp01P
X-AuditID: b6c32a35-ba1ff70000000fe2-92-5b0b8ac94899
To: undisclosed-recipients:;
Mime-Version: 1.0
Subject: RE: [PATCH 03/11] PM / devfreq: Remove check for df->max_freq == 0
 from governors
Reply-To: myungjoo.ham@samsung.com
From: MyungJoo Ham <myungjoo.ham@samsung.com>
CC: Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20180525203043.249193-4-mka@chromium.org>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180528045121epcms1p2f7bf3a2f366a85364753e47858cad632@epcms1p2>
Date: Mon, 28 May 2018 13:51:21 +0900
X-CMS-MailID: 20180528045121epcms1p2f7bf3a2f366a85364753e47858cad632
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA11Sa0hTYRju8+xyXC0+p9WH3eYJJY1Nz3TuFBlBFwYZKUE/mrVO+qHSbu5M
        6YK07C4Z3aBwmulW3kapmC6ji9MCE63MZpGGlCFBJqEFJWbbPFL063t43ud9n+f9eElC1iyK
        JHNNNmw1sQZKJBG0dMQqFV3F83UJNYPJzPSlp2Km6du4kPnsjWUGJkeFTEVnr5DpudUuYo47
        74iYnqIvYuZVW5mImSjpBMzNgZchzETDR8CcfNAp3ijVuq+7gXbq1yWgddhfCrRNdWdF2kfl
        brH2fHMd0E40rUgT78brczCbha1ybMo0Z+WaslOobTv1m/Tq5ARaQa9lNJTcxBpxCrU5NU2x
        NdfgT0vJC1hDvp9KYzmOit+w3mrOt2F5jpmzpVA6mlYp6QSNUqXyv4l71qnUfsk+nNNbeU9s
        uS042HAx3Q6GiWIQSiKYhDr6WkExkJAy6AFosL4PBAoRcBkqd3wUFgOSlMIwNO0JD8BwmIFq
        p1cEFDJIIfvbh8Ex4TAenRluCXaKoALdbRgSBEYS0CVArsYZMOslRddOfxLM4qWotfpukA+F
        GvShxBEyyy9Cb+vHxHN4/GkF3xuBTr7v4TOHoeGf93k+Eo2MVfL6o2hgoiokYIzgBYCm3szw
        hXj0od8hCmAp3I5OlLiDgwQwGnV53vGBNiP3UFFwKAFXotaxMiKwMAFj0Z22+Ln89sYp8f+Y
        gAvR1+/nhHO85/oIv0sM8t538fplqPtqJZ9fiyr724kLIKr07++W/mNc+tf4BiDqwGJs4YzZ
        mKMttJJjjVy+KVuZaTY2geDFxqk94EpvqhdAElALpPYpiU4mZAu4Q0YvQCRBRUglCj8lzWIP
        HcZWs96ab8CcF6j9+18kIhdlmv33b7LpabUqMTGRSaKT1TRNLZGe0vzeLYPZrA0fwNiCrXN9
        IWRopB20jaypibr8qT28Gh9d8k6XvNqn6awq3Fv7rOL8vo4j3WHqGvnaXS9cccu/PenL8z0+
        kzQ+6OztL3hsiImJSZekFsp0pyd/4YUzy/dbfryZ51Pvd9Y7Wxq7PEe2XH0+meVIKcp1bahr
        KNw72rWjkBrN6PbpqzZ9Xuo89tqXsCNvVXQ7JeByWDqOsHLsH/V9xPjHAwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180525203122epcas3p42a494949f50aa933355840b7e46bb0fe
References: <20180525203043.249193-4-mka@chromium.org>
        <20180525203043.249193-1-mka@chromium.org>
        <CGME20180525203122epcas3p42a494949f50aa933355840b7e46bb0fe@epcms1p2>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Commit "PM / devfreq: Fix handling of min/max_freq == 0" ensures that
>df->max_freq is not 0, remove unnecessary checks.
>
>Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>---
> drivers/devfreq/governor_performance.c    | 5 +----
> drivers/devfreq/governor_simpleondemand.c | 7 +++----
> 2 files changed, 4 insertions(+), 8 deletions(-)
>
>diff --git a/drivers/devfreq/governor_performance.c b/drivers/devfreq/governor_performance.c
>index 4d23ecfbd948..1c990cb45098 100644
>

Thanks!

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
