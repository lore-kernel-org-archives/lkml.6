Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC213C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760EA2075C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nFllKEko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387776AbfBOMpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 07:45:44 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:25104 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728436AbfBOMpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 07:45:44 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190215124541epoutp01697f43c61e7365e396860638c745c318~DikirdGzt1052710527epoutp01n;
        Fri, 15 Feb 2019 12:45:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190215124541epoutp01697f43c61e7365e396860638c745c318~DikirdGzt1052710527epoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550234741;
        bh=geAVXLLT313jDDG5IkQYupK5mQwcEfKhWe6g3wWdM0A=;
        h=Subject:To:Cc:From:Date:In-reply-to:References:From;
        b=nFllKEko4kv5yYWDCQrvZ2wPQoWjVPkuE2K1LAXsI/zUXZHlekAsFA/Ei7b8LzeKB
         6q7eojZfRoZCV128zxNNqUQKL53H4uDd1DbkNNjW02HVkDdQwdqX+BOQP9NbdqdLMj
         XMf7tBizxz4s0rMpGpfQY5RWKBloEbfJfTuHCy1Q=
Received: from epsmges1p3.samsung.com (unknown [182.195.42.55]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190215124540epcas1p2c67e3696a4694e902f4af8714c514e57~DikhxSlL50035100351epcas1p2S;
        Fri, 15 Feb 2019 12:45:40 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        28.A2.04069.474B66C5; Fri, 15 Feb 2019 21:45:40 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190215124539epcas1p27dc71aea62b3d2fc11864a2c89b42ade~Dikgr6QhT3075630756epcas1p2v;
        Fri, 15 Feb 2019 12:45:39 +0000 (GMT)
X-AuditID: b6c32a37-971ff70000000fe5-18-5c66b4748ebd
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EA.44.04015.374B66C5; Fri, 15 Feb 2019 21:45:39 +0900 (KST)
Received: from [106.116.147.40] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PMY00H5KWRZMU80@mmp1.samsung.com>; Fri, 15 Feb 2019 21:45:39 +0900 (KST)
Subject: Re: [PATCH] ASoC: samsung: odroid: Add missing DAPM routes
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <ddefa7c5-3341-dd4b-9088-2ae8c9db050b@samsung.com>
Date:   Fri, 15 Feb 2019 13:45:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-version: 1.0
In-reply-to: <20190215120422.22907-1-s.nawrocki@samsung.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsWy7bCmvm7JlrQYg57LEhZXLh5ispj68Amb
        xfnzG9gtvl3pYLK4vGsOm8XaI3fZLS6u+MLkwO6x4XMTm8fOWXfZPTat6mTz6NuyitHj8ya5
        ANYoLpuU1JzMstQifbsErowVy1+yFnQzV1xePIGlgfEwUxcjJ4eEgIlE94eNrF2MXBxCAjsY
        JW43bGaHcL4zSiz+tRfI4QCrmtmUChHfzSix4MRWNpBuIYH7jBLz7tSC2MICzhI35/wFi4sI
        iEncntPJDNLALDCNUeLzpAvMIAk2AUOJ3qN9jCBDeQXsJA6dtQMJswioSixpXMsKYosKREgc
        7n3HCGLzCghK/Jh8jwXE5hSwkVi1+ShYDbOApsSLL5NYIGxxiWP3bzJC2PISm9e8BdsrIXCb
        TaLn8jZ2iDddJI5PWcQM8Yy0xKWjthDhaold27uh6jsYJVoubGeGSFhLHD5+EWoZn8S7rz2s
        EL28Eh1tQhAlHhItv09AA6ufUeLOkxlsExhlZiG5exaSW2chuXUWklsXMLKsYhRLLSjOTU8t
        Niww1itOzC0uzUvXS87P3cQIThFa5jsYN5zzOcQowMGoxMO7IiM1Rog1say4MvcQowQHs5II
        L+eatBgh3pTEyqrUovz4otKc1OJDjNIcLErivOsdnGOEBNITS1KzU1MLUotgskwcnFINjJ6b
        GqxvB0cvntuqt7DIQGLHCd9NDR8l6mU/b5r2KziCmdP/8o0rgjxxU/481naxuW8964mJptTn
        wwdsbzNqKyxXPeP2dkaaer2J6cPc7E1al9TmL/M0e/3Ma0L5vecSL38t3fS1Zd369RucCo/k
        3D4f4LNV64/kdT3Vqmkvz6/KaMtXPvYu5JYSS3FGoqEWc1FxIgAbXl9PDQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsVy+t9jAd3iLWkxBmdf81hcuXiIyWLqwyds
        FufPb2C3+Halg8ni8q45bBZrj9xlt7i44guTA7vHhs9NbB47Z91l99i0qpPNo2/LKkaPz5vk
        AlijuGxSUnMyy1KL9O0SuDJWLH/JWtDNXHF58QSWBsbDTF2MHBwSAiYSM5tSuxi5OIQEdjJK
        rF56kh3Cecgo8ejNKeYuRk4OYQFniZtz/rKB2CICYhK353QygxQxC0xjlJg7eRFUx0RGiba7
        JxlBqtgEDCV6j/YxgqzgFbCTOHTWDiTMIqAqsaRxLSuILSoQIfHx6T4mEJtXQFDix+R7LCA2
        p4CNxKrNR1lBWpkF1CWmTMkFCTMLiEscu3+TEcKWl9i85i3zBEaBWUi6ZyF0zELSMQtJxwJG
        llWMkqkFxbnpucVGBYZ5qeV6xYm5xaV56XrJ+bmbGIExsO2wVt8OxvtL4g8xCnAwKvHwBqSl
        xgixJpYVV+YeYpTgYFYS4eVckxYjxJuSWFmVWpQfX1Sak1p8iFGag0VJnPd23rFIIYH0xJLU
        7NTUgtQimCwTB6dUA2Pk5Zb6ltCbH2o8EgReCrfdcq7+Nnf93aa4hda51t9vXfhn31E0dYZi
        RNKZmV/un1yxzZqP/1b6s0+39NJDS8N3LoyeftTX/8+6kwaLX8958rZFzXTWv0W7f4p+fDTl
        3aTJS1t5k0QmsVzbIvJDjbW8lLGY+3B089aNzJYccru7nc/cOLlj3WRxJZbijERDLeai4kQA
        qTzOY30CAAA=
X-CMS-MailID: 20190215124539epcas1p27dc71aea62b3d2fc11864a2c89b42ade
CMS-TYPE: 101P
X-CMS-RootMailID: 20190215120457epcas2p3cd14657fc2159c058ab6448c10a47648
References: <CGME20190215120457epcas2p3cd14657fc2159c058ab6448c10a47648@epcas2p3.samsung.com>
        <20190215120422.22907-1-s.nawrocki@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/19 13:04, Sylwester Nawrocki wrote:
> With old DTS there will be missing DAPM routes linking BE with CODECs.
> Add those routes in the card driver so sound works properly on Odroid
> XU3/4 also without DTS updates enabling the secondary PCM.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

I forgot to add: 

Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
