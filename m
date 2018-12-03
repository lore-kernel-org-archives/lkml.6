Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2228C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 702B420878
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PZmtrG7m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 702B420878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbeLCOcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:32:45 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60036 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbeLCOcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:32:45 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181203143129euoutp0153c3e7956d1025a9052e3098fb3d083a~s2RzJOKvg1512915129euoutp01y
        for <linux-kernel@vger.kernel.org>; Mon,  3 Dec 2018 14:31:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181203143129euoutp0153c3e7956d1025a9052e3098fb3d083a~s2RzJOKvg1512915129euoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1543847489;
        bh=xnvwoL8u4q3jdpcw9MomShy0KGKgN6QxlXlHKX/7FTo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=PZmtrG7mus0DRl7/H+WsXKbsfOxmI0z9Oy5AvidiOmDfR5cnfRswRXUyjp673TSfU
         nek7qQntLHWQqrhAR6TP795CnZhtzeZUS5mnf03rCHuDLgCqY9sK+80ymFQ/3dQ0zK
         k1avNr9zvtZyWoi6c4WL6n31USAPedq1MlybBNE8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181203143128eucas1p19e2ea9db521aa745ff93977171d5d6f1~s2Rxl0npp1711417114eucas1p1M;
        Mon,  3 Dec 2018 14:31:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 18.CA.04441.F3E350C5; Mon,  3
        Dec 2018 14:31:27 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181203143127eucas1p2604fc066139a32fdffe996212b42b40e~s2RwrM_2o0832208322eucas1p2B;
        Mon,  3 Dec 2018 14:31:27 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181203143127eusmtrp103bf2b3db0d489f291e8c9e5e2ea143c~s2RwalByQ1650116501eusmtrp1c;
        Mon,  3 Dec 2018 14:31:27 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-9e-5c053e3fe2a1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 2E.E8.04128.E3E350C5; Mon,  3
        Dec 2018 14:31:26 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181203143126eusmtip202d74b9b677be3a30dfbb759f4d9400c~s2Rve22Pf0696906969eusmtip2D;
        Mon,  3 Dec 2018 14:31:25 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     tjakobi@math.uni-bielefeld.de, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, cw00.choi@samsung.com,
        rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        gregkh@linuxfoundation.org, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, m.szyprowski@samsung.com,
        b.zolnierkie@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v2 0/5] devfreq: handle suspend/resume
Date:   Mon,  3 Dec 2018 15:31:10 +0100
Message-Id: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSWUwTURT1dWY6I6EwFgNPtmijBlARE9QXNS6RjzH6oTEGgxosdgQDLbUD
        uGFAiUKVxdQFUlyDCBlrCrWWpoALVqpiKcW4QVAjrhUJUsVoIto6Vf/OOfece8/HpTCph4ik
        dqjyWI1KniMTB+GWzu/dc5YtJTYnDdYidOtaPGquMRKopXmMQE++vCPQOXs3gUrqjGL04KgS
        VQ1+xJDL1UQi58EhEvUVRyP9iXYRMg0+JtBD22kx8lbYAapxXRehK/YBEtU/cYtQ/4FGMRq4
        f8e3o6uXQIfa7SQ6fHmEQEM9z/HlkLG0WgjGcNYAmNpiN84cqxoFTF3bBxFj4rVi5sYZA8lc
        vVjEjHeSzK3hNhFjflSKM5VmHjCNl7+RjNcUuzYkLWiJgs3ZUcBq5i7dGpRlLKkm1DdCd9dU
        uchi4Aw+AiZSkE6G+h+viCMgiJLSjQCWvfaIBfIFwLGWTlwgXgA9rb9EfyMmw3lSGDQAWN70
        WPQv0lf/w0coSkwnQiu/0x+YTNcB2GuN93sw+i4GbZ91fzaF0QvgoOMi5sc4PQNWVoz9wRJ6
        FTz91IgL12Lhs24t5g9DuoKCF6wnAzVSoLmknRRwGPQ4zAEcDbuOlwfCHHSW8WIBF8LSe9aA
        ZzG87XAT/qIYHQ+NtrmCvAJ22m8DvwzpEPj00yS/jPmgzlKNCbIElh2WCu44aC7vCZQJhw2G
        U4HlDOTPleF+u5TeAs28+hiI1f8/dR4AHkSw+Zwyk+XmqdhdiZxcyeWrMhO35SpNwPeBXeOO
        USv42pvRAWgKyIIly9PxzVJCXsDtUXYASGGyyRL1Tp8kUcj37GU1uema/ByW6wBRFC6LkOyb
        8HKTlM6U57HZLKtmNX+nImpiZDHIoTexDm120YI47wuu39aQOvbWNL+5YE1abfIsYtFwlzrV
        GR86Lfu9O2pc8WZDRuacm/rRlOhf3xRHdQtdwVl30tQrZ2//OdMyZWS96rm2KSZ39XTvxqj9
        /N6YQr7ygi7mQWq3TrvuhDMsO9yaVJ8fEpdaNT6NvpTnSZjqLk2JkclwLks+LwHTcPLfxtgF
        kn0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsVy+t/xe7p2dqwxBkcWWlgc3KppsXHGelaL
        7Ru/sVpc//Kc1WL+kXOsFs2L17NZnOnOteh//JrZ4vz5DewWZ5vesFvcapCxmDVlL5PFpsfX
        WC0u75rDZvG59wijxYzz+5gs1h65y26x9PpFJovbjSvYLO6eOgo04/QlVovWvUfYLdpWf2C1
        eHPhHouDhMe23dtYPdbMW8PoMbvhIovHhP5PjB6L97xk8ti0qpPNY//cNewem5fUe/w7xu5x
        8N0eJo8tV9tZPPq2rGL0WLH6O7vH501yAXxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6
        hsbmsVZGpkr6djYpqTmZZalF+nYJehnrm6ezFuznr5jRf569gfEsTxcjJ4eEgInEpjUL2LsY
        uTiEBJYySix6c5gdIiEmMWnfdihbWOLPtS42iKJPjBLXd6wFSnBwsAnoSexYVQgSFxFYzihx
        /+dssEnMAg+YJTqeb2IF6RYWMJN4fHwJM4jNIqAq0df7DczmFfCUmHNjPQvEBjmJm+c6mScw
        8ixgZFjFKJJaWpybnltspFecmFtcmpeul5yfu4kRGIHbjv3csoOx613wIUYBDkYlHl6HeJYY
        IdbEsuLK3EOMEhzMSiK8BYVAId6UxMqq1KL8+KLSnNTiQ4ymQMsnMkuJJucDk0NeSbyhqaG5
        haWhubG5sZmFkjjveYPKKCGB9MSS1OzU1ILUIpg+Jg5OqQZGv84lESe6d16vmTibZ6IFn8aX
        NwuOzl0pM/nlfVv9I2eVl+jeOPzzX+fDZRrvdrufaK7PfliUP3vuxDBr5YUvxAuN6t8L1bxQ
        ub/dRYlXT2Qb7yojlYJ5+UVbJycEzt2W8fFfwJ7Ff4p0t1rW3ZPP9hSaHfabN6HMwzp4l0vh
        7VlO621v+fxpVGIpzkg01GIuKk4EAEf5GybWAgAA
X-CMS-MailID: 20181203143127eucas1p2604fc066139a32fdffe996212b42b40e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181203143127eucas1p2604fc066139a32fdffe996212b42b40e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181203143127eucas1p2604fc066139a32fdffe996212b42b40e
References: <CGME20181203143127eucas1p2604fc066139a32fdffe996212b42b40e@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This v2 patch set aims to address the issue with devfreq devices' frequency
during suspend/resume. It extends suspend/resume by calls to Devfreq
framework. In the devfreq framework there is a small refactoring to avoid
code duplication in changging frequency (patch 1) and there are extensions
for suspending devices. The suspending device has now chance to set proper
state when the system is going for suspend. This phase is the right place
to set needed frequences for the next resume process.

It has been tested on Odroid u3 with Exynos 4412.

The patch set draws on Tobias Jakobi's work posted ~2 years ago, who tried
to solve issue with devfreq device's frequency during suspend/resume.
During the discussion on LKML some corner cases and comments appeared
related to the design. This patch set address them keeping in mind
suggestions from Chanwoo Choi.
Tobias's paches:
https://www.spinics.net/lists/linux-samsung-soc/msg56602.html 

Changes:
v2:
- refactored patchset and merget patch 1 and 3 as suggested by Chanwoo Choi,
- changed devfreq_{susped|resume}_device functions,
- added doxygen information for new entres in 'struct devfreq',
- devfreq_set_target skipped one argument, now resume_freq is set inside,
- minor changes addresing comments from maintainers regarding the style,

Regards,
Lukasz Luba

Lukasz Luba (5):
  devfreq: refactor set_target frequency function
  devfreq: add support for suspend/resume of a devfreq device
  devfreq: add devfreq_suspend/resume() functions
  drivers: power: suspend: call devfreq suspend/resume
  arm: dts: exynos4: opp-suspend in DMC and leftbus

 arch/arm/boot/dts/exynos4210.dtsi |   2 +
 arch/arm/boot/dts/exynos4412.dtsi |   2 +
 drivers/base/power/main.c         |   3 +
 drivers/devfreq/devfreq.c         | 155 +++++++++++++++++++++++++++++---------
 include/linux/devfreq.h           |  13 ++++
 5 files changed, 141 insertions(+), 34 deletions(-)

-- 
2.7.4

