Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA206C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4C02156D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fgLNrKrh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F4C02156D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbeI0LhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 07:37:10 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:59600 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbeI0LhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 07:37:10 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20180927052042epoutp01d9d05af100ae57a81d91013a8fb758bc~YKiw22ZLb2302623026epoutp01g
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 05:20:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180927052042epoutp01d9d05af100ae57a81d91013a8fb758bc~YKiw22ZLb2302623026epoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1538025642;
        bh=W4hdH+QuPYklQ67q406WgkLtowrL8WdIJHVIUegM8G8=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=fgLNrKrhxTDkC9uGWtZ4pvGYTJFeMvOH9pcOh57sW0EmvjvjcKyLI8MnATAgJIPJT
         pdzH2nLZgA4LrTRHhZabC59B+tRXiFlwvZULh89+oprUBlNDx57Lx5ror//qM2P1iN
         cmBdLn6aPOr9o2cl8m2PZ+YVzAYII/8yxORVPi7A=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.157]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180927052039epcas1p1faac9dd504d2bd4a159fac1ec181e880~YKiuy-OX_0942909429epcas1p11;
        Thu, 27 Sep 2018 05:20:39 +0000 (GMT)
X-AuditID: b6c32a38-839ff7000000107c-e1-5bac68a4d3d8
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        FB.81.04220.4A86CAB5; Thu, 27 Sep 2018 14:20:36 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v2] PM / devfreq: Stop the governor before
 device_unregister()
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "john.reitan@arm.com" <john.reitan@arm.com>,
        "beata.michalska@arm.com" <beata.michalska@arm.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <1537544432-34712-1-git-send-email-vincent.donnefort@arm.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180927052036epcms1p15fb2970f4ddc0256096d674d6932aabd@epcms1p1>
Date:   Thu, 27 Sep 2018 14:20:36 +0900
X-CMS-MailID: 20180927052036epcms1p15fb2970f4ddc0256096d674d6932aabd
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmru6SjDXRBjuOWFu8vfeR1eLlIU2L
        61+es1p8X3WO1eJs0xt2i8u75rBZfO49wmhxsWEHswOHx5p5axg9+rasYvT4vEkugDkq2yYj
        NTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6AAlhbLEnFKg
        UEBicbGSvp1NUX5pSapCRn5xia1SakFKToFlgV5xYm5xaV66XnJ+rpWhgYGRKVBhQnbG5JuL
        WArOslb82HaesYHxAksXIyeHhICJxOUFC4FsLg4hgR2MEos6G9i7GDk4eAUEJf7uEAapERYI
        kVh/YRY7iC0koCTRcHMfM0RcX6LjwTZGEJtNQFdi64a7YHNEBM4zSiz/dYAdxGEWmMoocedB
        OzvENl6JGe1PoTZLS2xfvhWsm1PAS+LIeoipEgKiEjdXv2WHsd8fm88IYYtItN47C1UjKPHg
        526ouJTEk7cLoerrJa5/XsQEslhCYAKjxO8b/6ES+hKPrsxmA7F5BXwltr88AHYEi4CqxIr/
        G6EOcpE4tO4GWD2zgLzE9rdzmEEhwSygKbF+lz7M/Q0bf7Ojs5kF+CTefe1hhYnvmPeECcJW
        kzi0ewlUvYzE6ekLoe73kFi+YDHzBEbFWYiwnoVk8SyExQsYmVcxiqUWFOempxYbFpggR+8m
        RnBq1LLYwbjnnM8hRgEORiUe3g0bV0cLsSaWFVfmHmKU4GBWEuHNVVwTLcSbklhZlVqUH19U
        mpNafIjRFOj/icxSosn5wLSdVxJvaGpkbGxsYWJoZmpoqCTO+0RqbrSQQHpiSWp2ampBahFM
        HxMHp1QDo8IV71np7l4sKyMO3+Pc0Fayc1/Z8i52M7GPSw6WMDAc5vn9wE41JHfylW9VdxSC
        K+0vX3i27OfaJwFTNy/+clk+acMfpzm2R5tjNglNeyP5X8phX9WLw45vXl+0nWJjrLVkXYHK
        hZncTnlfb/MWlytM/8nD+ONdHVPQ7Nkl96+rn40T6dSseafEUpyRaKjFXFScCAByXA9jowMA
        AA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180921154052epcas1p4d4ba6b7435a50f1f77ae85ceda594b69
References: <1537544432-34712-1-git-send-email-vincent.donnefort@arm.com>
        <5B8901D7.5040301@samsung.com>
        <CGME20180921154052epcas1p4d4ba6b7435a50f1f77ae85ceda594b69@epcms1p1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> device_release() is freeing the resources before calling the device
> specific release callback which is, in the case of devfreq, stopping
> the governor.
> 
> It is a problem as some governors are using the device resources. e.g.
> simpleondemand which is using the devfreq deferrable monitoring work. If it
> is not stopped before the resources are freed, it might lead to a use after
> free.
> 
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> Reviewed-by: John Einar Reitan <john.reitan@arm.com>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>


Cheers,
MyungJoo
