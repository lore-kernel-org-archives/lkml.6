Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AE5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 04:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF3A21479
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 04:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WfV6D6oq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfBREdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 23:33:18 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:52253 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbfBREdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 23:33:18 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190218043314epoutp015df07cb9532eb16485ce7cfc08947d22~EWybf_oRK0911009110epoutp01i
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 04:33:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190218043314epoutp015df07cb9532eb16485ce7cfc08947d22~EWybf_oRK0911009110epoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550464394;
        bh=MYtaGIdr6501ly3aKVGw/1ZM7IAFGKVfdjfjCe6geJg=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=WfV6D6oqVaQ14qUbypOBBOf7BX/09xs+c71PlHS0ULI/InLzN613d1sLrfJw1ytVr
         pt/kL+5izjzL2nt0lLtTekMVrt2A6X/lBubioviNQS2yQpDRmZXRhlUHXgyNkdX1nI
         lfHmdpasq7Yp+FkgLWMUbTJarpID1u1kZ9gbwkhQ=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.158]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190218043311epcas1p413dcf023bff7d6d148e7f96c357ea32b~EWyZWd8SF0440904409epcas1p4D;
        Mon, 18 Feb 2019 04:33:11 +0000 (GMT)
X-AuditID: b6c32a36-5c1ff7000000104d-c6-5c6a35871c10
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        64.0B.04173.7853A6C5; Mon, 18 Feb 2019 13:33:11 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v3 5/7] drivers: devfreq: add longer polling interval in
 idle
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        "tkjos@google.com" <tkjos@google.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "chris.diamand@arm.com" <chris.diamand@arm.com>,
        "mka@chromium.org" <mka@chromium.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <1550010238-24002-6-git-send-email-l.luba@partner.samsung.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190218043311epcms1p33ccb2c312e871294025171d97bb87ac6@epcms1p3>
Date:   Mon, 18 Feb 2019 13:33:11 +0900
X-CMS-MailID: 20190218043311epcms1p33ccb2c312e871294025171d97bb87ac6
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDJsWRmVeSWpSXmKPExsWy7bCmvm67aVaMwZZPhhYbZ6xntZj26TKL
        xctDmhbXvzxntVjWoGpxtukNu8WtBhmLy7vmsFl87j3CaLH2yF12i0sHFjBZfN7wmNFiX8cD
        JovDb9pZLd5PLnbg91gzbw2jx+yGiyweLftusXss2FTqsfDTV1aPg+/2MHm833eVzaNvyypG
        j8+b5AI4o7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0y
        c4CuV1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUWBboFSfmFpfmpesl5+daGRoY
        GJkCFSZkZ8xc8YelYKlAxcN171gbGL/xdDFyckgImEisn3yIuYuRi0NIYAejxJ7Fa4AcDg5e
        AUGJvzuEQWqEBYIl9i2+yghiCwkoSTTc3McMEdeX6HiwDSzOJqArsXXDXRYQW0RgGaPE3LfW
        IDOZBb4zS3z6fp0RYhmvxIz2pywQtrTE9uVbweKcAt4Se/tuskPERSVurn4LZ78/Nh+qV0Si
        9d5ZZghbUOLBz92MMHNmTPkPNbNa4lHPRbBnJARaGCVWzdzGBJHQlzgz9yQbiM0r4CtxtmEV
        WDOLgKpE27bJUINcJCa0rAEbxCwgL7H97RxwQDALaEqs36UPc3/Dxt/s6GxmAT6Jd197WGHi
        O+Y9gVqrJnFo9xKoehmJ09MXQt3vIXFk8jfGCYyKsxBBPQvJ4lkIixcwMq9iFEstKM5NTy02
        LDBCjt1NjOCUrGW2g3HROZ9DjAIcjEo8vB/KMmOEWBPLiitzDzFKcDArifBaG2fFCPGmJFZW
        pRblxxeV5qQWH2I0Bfp/IrOUaHI+MF/klcQbmhoZGxtbmBiamRoaKonzrndwjhESSE8sSc1O
        TS1ILYLpY+LglGpg3KaW5eKtvNtELdyqh8263Heecnhi+7fXYfslvco+rDdbuXq/uqz75FQj
        za8vme2aNvnMY9XRjjvwfaH0tzclTjydeyo4WorCKuS+S9td0K7+Zfh03YKiKWZnHH6V8hVE
        2W//9ueyg131rpgJjWcdy2Lju9/HKIbUuL616FAJ17er3qe/+4oSS3FGoqEWc1FxIgDZdLJY
        3wMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190212222436eucas1p21eebc80796406787a2ebf9a84ee5b868
References: <1550010238-24002-6-git-send-email-l.luba@partner.samsung.com>
        <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190212222436eucas1p21eebc80796406787a2ebf9a84ee5b868@epcms1p3>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch adds new mechanism for devfreq devices which changes polling
> interval. The system should sleep longer when the devfreq device is almost
> not used. The devfreq framework will not schedule the work too often.
> This low-load state is recognised when the device is operating at the lowest
> frequency and has low busy_time/total_time factor (< 30%).
> When the frequency is different then min, the device is under normal polling
> which is the value defined in driver's 'polling_ms'.
> When the device is getting more pressure, the framework is able to catch it
> based on 'load' in lowest frequency and will start polling more frequently.
> The second scenario is when the governor recognised heavy load at minimum
> frequency and increases the frequency. The devfreq framework will start
> polling in shorter intervals.
> The polling interval, when the device is not heavily, can also be changed
> from userspace of defined by the driver's author.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/devfreq/devfreq.c                 | 151 +++++++++++++++++++++++++++---
>  drivers/devfreq/governor.h                |   3 +-
>  drivers/devfreq/governor_simpleondemand.c |   6 +-
>  3 files changed, 145 insertions(+), 15 deletions(-)
> 

There are some requirements that you need to consider:

Is 30% really applicable to ALL devfreq devices?
    - What if some devices do not want such behaviors?
    - What if some devices want different values (change behavors)?
    - What if some manufactures want different default values?
    - What if some devices want to let the framework know that it's in idle?
    - What if some other kernel context, device (drivers),
    or userspace process want to notify that it's no more idling?

As mentioned in the internal thread (tizen.org),
I'm not convinced by the idea of assuming that a device can be considered "idling"
if it has simply "low" utilization.

You are going to deteriorate the UI response time of mobile devices significantly.

Cheers,
MyungJoo.
