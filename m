Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A28C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CFD821904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="U0QGcSR3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfBGRXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:23:15 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:49297 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfBGRXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:23:15 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190207172311epoutp02b45884a7fcd92e84ec0dd75c25c9ddb9~BJMjA6I7g1906919069epoutp02O;
        Thu,  7 Feb 2019 17:23:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190207172311epoutp02b45884a7fcd92e84ec0dd75c25c9ddb9~BJMjA6I7g1906919069epoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549560191;
        bh=L/k9LAJOAH/6jaNqfeViWvLDnTrbf4Vv2nefQELC7ps=;
        h=From:To:Cc:Subject:Date:References:From;
        b=U0QGcSR3qtshSjJERUJknXf8H7N26kxPle4zym8gSY2uLsQDrzVFeCRv36Ad3AFcu
         vp475n2ZOHzl7J6REl9UGR0kJKi2r5GN401fHoOFATOQU6uBVykTuDxYFqXv2prmri
         mh48Jr8Jszdr7zu6kmZp9YeCgYjle5KFND+lH2zc=
Received: from epsmges1p3.samsung.com (unknown [182.195.42.55]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190207172311epcas1p3dc5c1bb6e0a2808e29a5c3ba134d99c6~BJMivTB1O3177831778epcas1p3S;
        Thu,  7 Feb 2019 17:23:11 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        9D.48.04069.F796C5C5; Fri,  8 Feb 2019 02:23:11 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190207172309epcas1p411f0d5d58ee8aee8d47bd836641d07fe~BJMhmMBOu1937719377epcas1p4G;
        Thu,  7 Feb 2019 17:23:09 +0000 (GMT)
X-AuditID: b6c32a37-971ff70000000fe5-e3-5c5c697f99fb
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 8A.F8.04015.D796C5C5; Fri,  8 Feb
        2019 02:23:09 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMK00KKMGAAD880@mmp2.samsung.com>; Fri, 08 Feb 2019
        02:23:09 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH] ASoC: doc: Fix typos in dpcm.rst
Date:   Thu, 07 Feb 2019 18:22:56 +0100
Message-id: <20190207172256.1972-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsWy7bCmvm59ZkyMwbMVbBZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6M/XPuMhb8F6r4OXkucwNjL38XIweH
        hICJxKpfsV2MXBxCAjsYJZ4tb2WCcL4zSpyedh7I4QQr+njgKitEYgOjxLWj7cwQzi9GiacH
        7rODVLEJGEr0Hu1jBLFFBMQkbs/pBCtiFmhhkpgzdykzSEIYqOjL50ksIDaLgKrE+b3zwFbw
        ClhJPOjaxwaxTl7ifO86doi4oMSPyffA6pmB4gevPGcBGSohsIJNYsXnb8wQDS4Sz67fY4N4
        SFri0lFbiHC1xK7t3cwQ9R2MEi0XtkPVW0scPn6RFWIon8S7rz2sEL28Eh1tQhAlHhKLd7wF
        e0ZIIFZiyePZTBMYJWchOWkWkpMWMDKtYhRLLSjOTU8tNiww1itOzC0uzUvXS87P3cQIjmUt
        8x2MG875HGIU4GBU4uHV0IuJEWJNLCuuzD3EKMHBrCTC65gKFOJNSaysSi3Kjy8qzUktPsQo
        zcGiJM673sE5RkggPbEkNTs1tSC1CCbLxMEp1cAooa+i+OOXZZ14T7pb+U5e+crw83tnbC0p
        X7Jr2uQZG2Ne8Dx9Jr249/Nh336RJZxn3/Es/VOT+qphk+qxbypTFL70BViKCoo9z3K7Lz1p
        qpu3fKFgVmyuvW725vcV/eF6fO9vsnyI51+vfWOF4JaIE9yL+Ro3hQQ9f/pwFlfvkm3ljgxc
        LkeUWIozEg21mIuKEwEttva04QIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCLMWRmVeSWpSXmKPExsVy+t9jQd3azJgYgydTjCyuXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZ++fcZSz4L1Txc/Jc5gbGXv4uRk4O
        CQETiY8HrrJ2MXJxCAmsY5T48+wAM4Tzi1HiXPdjFpAqNgFDid6jfYwgtoiAmMTtOZ1gRcwC
        TUwSu25fZAdJCAMVffk8CayBRUBV4vzeeUwgNq+AlcSDrn1sEOvkJc73rmOHiAtK/Jh8D6ye
        GSh+8MpzlgmMPLOQpGYhSS1gZFrFKJlaUJybnltsVGCYl1quV5yYW1yal66XnJ+7iREYltsO
        a/XtYLy/JP4QowAHoxIP7wXtmBgh1sSy4srcQ4wSHMxKIryOqUAh3pTEyqrUovz4otKc1OJD
        jNIcLErivLfzjkUKCaQnlqRmp6YWpBbBZJk4OKUaGHeUT1hQd7lequb097bFpg+lVmVwmvCw
        vj2+RKM3REQ7+fC/Y9zTjZVm86i/lt9a/EFJOfIq70ueBtd/Lrtt92q/6smZvLTnRf3Hxqwd
        Bx0uB3+sP7I80vpC1/6Ly0Sm/tBe4ZT42JE/SmSWrkLAwy8LPI+aTPv4RHP9/+VeGUtOS+5M
        4Ga3OqPEUpyRaKjFXFScCABOkYLdRwIAAA==
X-CMS-MailID: 20190207172309epcas1p411f0d5d58ee8aee8d47bd836641d07fe
CMS-TYPE: 101P
X-CMS-RootMailID: 20190207172309epcas1p411f0d5d58ee8aee8d47bd836641d07fe
References: <CGME20190207172309epcas1p411f0d5d58ee8aee8d47bd836641d07fe@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a few typos in the DPCM documentation.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 Documentation/sound/soc/dpcm.rst | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/sound/soc/dpcm.rst b/Documentation/sound/soc/dpcm.rst
index f6845b2278ea..77f67ded53de 100644
--- a/Documentation/sound/soc/dpcm.rst
+++ b/Documentation/sound/soc/dpcm.rst
@@ -13,7 +13,7 @@ drivers that expose several ALSA PCMs and can route to multiple DAIs.
 The DPCM runtime routing is determined by the ALSA mixer settings in the same
 way as the analog signal is routed in an ASoC codec driver. DPCM uses a DAPM
 graph representing the DSP internal audio paths and uses the mixer settings to
-determine the patch used by each ALSA PCM.
+determine the path used by each ALSA PCM.
 
 DPCM re-uses all the existing component codec, platform and DAI drivers without
 any modifications.
@@ -101,7 +101,7 @@ The audio driver processes this as follows :-
 
 4. Machine driver or audio HAL enables the speaker path.
 
-5. DPCM runs the PCM ops for startup(), hw_params(), prepapre() and
+5. DPCM runs the PCM ops for startup(), hw_params(), prepare() and
    trigger(start) for DAI1 Speakers since the path is enabled.
 
 In this example, the machine driver or userspace audio HAL can alter the routing
@@ -221,7 +221,7 @@ like a BT phone call :-
 This allows the host CPU to sleep while the DSP, MODEM DAI and the BT DAI are
 still in operation.
 
-A BE DAI link can also set the codec to a dummy device if the code is a device
+A BE DAI link can also set the codec to a dummy device if the codec is a device
 that is managed externally.
 
 Likewise a BE DAI can also set a dummy cpu DAI if the CPU DAI is managed by the
@@ -249,7 +249,7 @@ configuration.
 	struct snd_interval *channels = hw_param_interval(params,
 						SNDRV_PCM_HW_PARAM_CHANNELS);
 
-	/* The DSP will covert the FE rate to 48k, stereo */
+	/* The DSP will convert the FE rate to 48k, stereo */
 	rate->min = rate->max = 48000;
 	channels->min = channels->max = 2;
 
@@ -386,5 +386,3 @@ This means creating a new FE that is connected with a virtual path to both
 DAI links. The DAI links will be started when the FE PCM is started and stopped
 when the FE PCM is stopped. Note that the FE PCM cannot read or write data in
 this configuration.
-
-
-- 
2.20.1

