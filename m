Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF9BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26AD22080F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Kyeu7GOe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26AD22080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387551AbeKVNqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 08:46:22 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:11359 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732441AbeKVNqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 08:46:22 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20181122030859epoutp043c3932b94864ea0caf92319e30592e59~pU3wjyB6P1400714007epoutp04u;
        Thu, 22 Nov 2018 03:08:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20181122030859epoutp043c3932b94864ea0caf92319e30592e59~pU3wjyB6P1400714007epoutp04u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542856140;
        bh=9gGCNSpPazcvpkyJ9e+lj4HPOuWP1bcuLX8she3GIHg=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=Kyeu7GOe+xhjoip+ZJg+eFRWTPNgnQcXKTmBcG/JhkhmdgCGvLol25M+GfjHem/Fj
         9cbNs5WmmNKIn2P/XjwUlvN6wXoObIIPH6Evba5hgxcOg7a04hNnnaYzFbhMgUP6rU
         kdAdgYK3o/dxTKrzcMfYE8jkUGYCpJEkCK/ZPM/E=
Received: from epsmges2p3.samsung.com (unknown [182.195.40.152]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181122030857epcas1p277782def274c773b6de89d4ac021142e~pU3t8kqCF1391113911epcas1p2p;
        Thu, 22 Nov 2018 03:08:57 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        2B.A3.04062.8CD16FB5; Thu, 22 Nov 2018 12:08:56 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20181122030856epcas2p141b48026e82c0b45b4a3eed4097a2f03~pU3tgcjqX3041630416epcas2p1I;
        Thu, 22 Nov 2018 03:08:56 +0000 (GMT)
X-AuditID: b6c32a47-30fff70000000fde-91-5bf61dc8b016
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        02.8C.03627.8CD16FB5; Thu, 22 Nov 2018 12:08:56 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PIK0097DREWQE90@mmp1.samsung.com>; Thu, 22 Nov 2018 12:08:56 +0900 (KST)
Message-id: <5BF61DC8.7010809@samsung.com>
Date:   Thu, 22 Nov 2018 12:08:56 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     tjakobi@math.uni-bielefeld.de, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, rjw@rjwysocki.net, len.brown@intel.com,
        pavel@ucw.cz, gregkh@linuxfoundation.org, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH 5/6] drivers: power: suspend: call devfreq
 suspend/resume
In-reply-to: <1542823301-23563-6-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIJsWRmVeSWpSXmKPExsWy7bCmue5J2W/RBo+2sFkc3KppsXHGelaL
        7Ru/sVrMP3KO1aJ58Xo2izPduRb9j18zW5w/v4Hd4mzTG3aLWw0yFrOm7GWy2PT4GqvF5V1z
        2Cw+9x5htJhxfh+Txdojd9ktll6/yGRxu3EFm8XdU0eBZpy+xGrRuvcIu0Xb6g+sFm8u3GNx
        EPfYtnsbq8eaeWsYPWY3XGTxmND/idFj8Z6XTB6bVnWyeeyfu4bdY/OSeo9/x9g9Dr7bw+Sx
        5Wo7i0ffllWMHitWf2f3+LxJLoAvKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLC
        XEkhLzE31VbJxSdA1y0zB+h9JYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BZYFe
        cWJucWleul5yfq6VoYGBkSlQYUJ2xo81d5kLTvFVXP7cytzA+Je7i5GTQ0LARGLr1gbWLkYu
        DiGBHYwS806vZIRwvjNKbDjSxw5TtW3OLiaIxG5Giddf94EleAUEJX5MvsfSxcjBwSwgL3Hk
        UjZImFlAU+LFl0ksEPV3GSXuNl9ihajXknj7/xUbiM0ioCrx4vl9FhCbDSi+/8UNsDi/gKLE
        1R+PGUFsUYEIiZ3zv7GDDBIROM8osWbnHrArmAVamSX+fdgC1iEs4C+xufc52AZOAW+Jya/m
        g3VICPxklzixeiUbxA8uEk2HV7JC2MISr45vgfpNWuLZqo2MEA3tjBJfXjSzQjgTGCU+nNrM
        BFFlLPFsYRcTxHd8Eh2H/7KDPC0hwCvR0SYEUeIhMb+hiw3i6fuMEqfnbWGfwCg7CymcZiHC
        aRZSOC1gZF7FKJZaUJybnlpsVGCMHIObGMHJXct9B+O2cz6HGAU4GJV4eBuiv0YLsSaWFVfm
        HmKU4GBWEuG9sAIoxJuSWFmVWpQfX1Sak1p8iNEUGMwTmaVEk/OBmSevJN7Q1MjY2NjC1NzS
        2MBSSZz3ofTcaCGB9MSS1OzU1ILUIpg+Jg5OqQZG7WixP3wK2Se+2OfUvNG4Uv/+Pf8GsRU7
        uxq2Vh/KqLs9zS5y/nG3b+Gb/ny8GxWtNtfq6rNj1xR/lBlLXZTTKPws5c2XPOff7ZrwK0cW
        dAaWr3cVf5EUeueRW8/1Cd5L97l9/SeyRvbmqdMW/VLBuqqdBxN+C1bdrVwY2KfS6zq3k2NR
        9PRQJZbijERDLeai4kQAEATibwQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t9jAd0Tst+iDSacUrA4uFXTYuOM9awW
        2zd+Y7WYf+Qcq0Xz4vVsFme6cy36H79mtjh/fgO7xdmmN+wWtxpkLGZN2ctksenxNVaLy7vm
        sFl87j3CaDHj/D4mi7VH7rJbLL1+kcniduMKNou7p44CzTh9idWide8Rdou21R9YLd5cuMfi
        IO6xbfc2Vo8189YwesxuuMjiMaH/E6PH4j0vmTw2repk89g/dw27x+Yl9R7/jrF7HHy3h8lj
        y9V2Fo++LasYPVas/s7u8XmTXABfFJdNSmpOZllqkb5dAlfGjzV3mQtO8VVc/tzK3MD4l7uL
        kZNDQsBEYtucXUxdjFwcQgI7GSU2PV/AApLgFRCU+DH5HpDNwcEsIC9x5FI2hKkuMWVKLkT5
        fUaJLWvPs0GUa0m8/f8KzGYRUJV48fw+2Bg2oPj+FzfA4vwCihJXfzxmBJkjKhAh0X2iEmSO
        iMB5RomDfZ2sIDXMAq3MEo/askBsYQFfiR3fHjDBLZt3fiE7SIJTwFti8qv57BMYBWYhOXUW
        wqmzEE5dwMi8ilEytaA4Nz232KjAKC+1XK84Mbe4NC9dLzk/dxMjMLK3Hdbq38H4eEn8IUYB
        DkYlHl6NyK/RQqyJZcWVuYcYJTiYlUR4L6wACvGmJFZWpRblxxeV5qQWH2KU5mBREuflzz8W
        KSSQnliSmp2aWpBaBJNl4uCUamDM0M9sfZSo4H5YY9KeBt7Pm7JsJuSnP3Y9ICaS8kpV5aXU
        VEf1vWXS4pVLeGI0l5TfvD01W7hUR419T/mWJwm9+xjC3SuqF0SfvMYcUrsr5/Hc/RvS7zmb
        /j31jHvalOxPhz12b3qWzSiRe2JZ6vfne6bViN5OfrR8r63i4Qq5IP/lV30f/+pRYinOSDTU
        Yi4qTgQAZOxRMOgCAAA=
X-CMS-MailID: 20181122030856epcas2p141b48026e82c0b45b4a3eed4097a2f03
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181121180206eucas1p265865226e3938a28e842e8367233dc2e
References: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181121180206eucas1p265865226e3938a28e842e8367233dc2e@eucas1p2.samsung.com>
        <1542823301-23563-6-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018년 11월 22일 03:01, Lukasz Luba wrote:
> Devfreq framework supports suspend of its devices.
> Call the the devfreq interface and allow devfreq devices preserve/restore
> their states during suspend/resume.
> 
> The patch draws on Tobias Jakobi's work posted ~2 years ago, who tried to
> solve issue with devfreq device's frequency during suspend/resume.
> During the discussion on LKML some corner cases and comments appeared
> related to the design. This patch address them keeping in mind suggestions
> from Chanwoo Choi.

Please remove the duplicate information about patch history
because you already explained it on cover-letter.

Looks good to me.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

> 
> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/base/power/main.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index a690fd4..0992e67 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -32,6 +32,7 @@
>  #include <trace/events/power.h>
>  #include <linux/cpufreq.h>
>  #include <linux/cpuidle.h>
> +#include <linux/devfreq.h>
>  #include <linux/timer.h>
>  
>  #include "../base.h"
> @@ -1078,6 +1079,7 @@ void dpm_resume(pm_message_t state)
>  	dpm_show_time(starttime, state, 0, NULL);
>  
>  	cpufreq_resume();
> +	devfreq_resume();
>  	trace_suspend_resume(TPS("dpm_resume"), state.event, false);
>  }
>  
> @@ -1852,6 +1854,7 @@ int dpm_suspend(pm_message_t state)
>  	trace_suspend_resume(TPS("dpm_suspend"), state.event, true);
>  	might_sleep();
>  
> +	devfreq_suspend();
>  	cpufreq_suspend();
>  
>  	mutex_lock(&dpm_list_mtx);
> 

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
