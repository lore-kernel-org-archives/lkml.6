Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FADC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC7A2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KLyyZi20"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC7A2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbeKZTHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:07:53 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:21204 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbeKZTHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:07:52 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20181126081431epoutp01fd9cd9e3e16a8b0427e5b7bbeae95618~qnnqVtAX-1779417794epoutp01E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 08:14:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20181126081431epoutp01fd9cd9e3e16a8b0427e5b7bbeae95618~qnnqVtAX-1779417794epoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1543220071;
        bh=nbKY0/RMvhmuZhMhNRLBHblEx0Q0gRo1x76spSLSRmw=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=KLyyZi20wGnOCCxAlnv1maFlN7qAbADG8k/yeYF/yJwiJr5ylam2qTunv/p+YXHBb
         jBYPddzOdN5k4CrHnDd2bQVUWlL9pp9rD18qoxURo9HovXymCq4asmXdrGh+pIlpCT
         k9vurgLJOdhEa+5T5a07/Y7/ePArSX000+Vg+6VQ=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.156]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181126081428epcas1p2c187f770b7b878f092f7e72d4cc0a545~qnnnAqARF2431524315epcas1p28;
        Mon, 26 Nov 2018 08:14:28 +0000 (GMT)
X-AuditID: b6c32a37-429ff70000000fdc-2c-5bfbab630471
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        D4.48.04060.36BABFB5; Mon, 26 Nov 2018 17:14:28 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 1/6] devfreq: add basic fileds supporting suspend
 functionality
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "tjakobi@math.uni-bielefeld.de" <tjakobi@math.uni-bielefeld.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "anton@enomsg.org" <anton@enomsg.org>,
        "ccross@android.com" <ccross@android.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "kgene@kernel.org" <kgene@kernel.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <1542823301-23563-2-git-send-email-l.luba@partner.samsung.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20181126081427epcms1p8801d251017da40b59d7e8391ee247fdb@epcms1p8>
Date:   Mon, 26 Nov 2018 17:14:27 +0900
X-CMS-MailID: 20181126081427epcms1p8801d251017da40b59d7e8391ee247fdb
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgl+LIzCtJLcpLzFFi42LZdlhTVzdl9e9og+4GRouDWzUtNs5Yz2qx
        feM3VovrX56zWsw/co7VonnxejaLM925Fv2PXzNbnD+/gd3ibNMbdotbDTIWs6bsZbLY9Pga
        q8XlXXPYLD73HmG0mHF+H5PF2iN32S2WXr/IZHH31FGg9tOXWC1a9x5ht2hb/YHV4s2FeywO
        4h7bdm9j9Vgzbw2jx+yGiyweE/o/MXos3vOSyWPTqk42j/1z17B7bF5S7/HvGLvHwXd7mDy2
        XG1n8ejbsorRY8Xq7+wenzfJBfBFZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqY
        KynkJeam2iq5+AToumXmAL2vpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySmwLNAr
        TswtLs1L10vOz7UyNDAwMgUqTMjO2DhvOlvBSo6KSzc7WRsYv7N1MXJySAiYSNx/283excjF
        ISSwg1Gip3MGUIKDg1dAUOLvDmGQGmGBUIlluzYygdhCAkoSDTf3MUPE9SU6HmxjBLHZBHQl
        tm64ywIyR0SgkVliyZ4vrCAOs8BkNolZzxqgtvFKzGh/ygJhS0tsX74VrJtTwFviwJuNjBBx
        UYmbq9+yw9jvj82HiotItN47ywxhC0o8+LkbKi4l8eTtQqj6eonrnxcxgSyWEJjAKPH7xn+o
        hL7EoyuzwY7gFfCV6P55kAnkSxYBVYnta81BTAkBF4n1j+pAKpgF5CW2v53DDBJmFtCUWL9L
        HyLMJ/Huaw8rzCc75j1hgrDVJA7tXgK1SEbi9PSFUFd6SDRcnc4CCbfLjBL3nypOYJSfhQjd
        WUiWzUJYtoCReRWjWGpBcW56arFhgTFyhG5iBKd+LfMdjBvO+RxiFOBgVOLhnfDrV7QQa2JZ
        cWXuIUYJDmYlEV7fJb+jhXhTEiurUovy44tKc1KLDzGaAn08kVlKNDkfmJfySuINTY2MjY0t
        TAzNTA0NlcR5n0jNjRYSSE8sSc1OTS1ILYLpY+LglGpgzA7gL9ixYnX/yp9rbm127Vn0aZ3B
        oyL7K0b2gQXb29yn3NSw82vJ5Axa5zhb54BcDofTtu3NTXbC/D+6nzed/5bvztd4n0luq1PG
        Pbu7h4yKgp5/Pj9PRClmbXOi1tuHC91PnlVgs09Yvepw+Zzn+9K1Tn1iVG8KfpWQ7r6o9ffP
        mTsfSm6RVWIpzkg01GIuKk4EAFmGGFQTBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181121180201eucas1p1f1f96941c3d16a96722e65d5c21bfe80
References: <1542823301-23563-2-git-send-email-l.luba@partner.samsung.com>
        <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181121180201eucas1p1f1f96941c3d16a96722e65d5c21bfe80@epcms1p8>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>The patch prepares devfreq device for handling suspend/resume functionality.
>The new fields will store needed information during this process.
>Devfreq framework handles opp-suspend DT entry and there is no need of
>modyfications in the drivers code.
>
>The patch draws on Tobias Jakobi's work posted ~2 years ago, who tried to
>solve issue with devfreq device's frequency during suspend/resume.
>During the discussion on LKML some corner cases and comments appeared
>related to the design. This patch address them keeping in mind suggestions
>from Chanwoo Choi.
>
>Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
>Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>

When you add new elements in a common struct (i.e., struct devfreq),
please describe kindly in the doxygen entries so that developers
may understand before reading all places where the new elements are
used.

You have added three new elements and there is no explanations on them.


Cheers,
MyungJoo

