Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D41C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF21220672
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OL29Jmsi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF21220672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbeLEK5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:57:44 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:64038 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbeLEK5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:57:44 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20181205105739epoutp039a14101e4bf5c38a022f909ee3e45333~tapqNIZOj0563505635epoutp03x;
        Wed,  5 Dec 2018 10:57:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20181205105739epoutp039a14101e4bf5c38a022f909ee3e45333~tapqNIZOj0563505635epoutp03x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1544007459;
        bh=IryPAHkxJo8GHjC+5JEgNPTLsL1RkR9VDqsE3lfdh9w=;
        h=To:Subject:Cc:From:Date:In-reply-to:References:From;
        b=OL29Jmsig8GK9+HDgthxj21m+0JsA0laT7m1FP3fK8JIxC+8MYlbWNxN7CXAu8lq9
         nzgmzVTP2UkIxxEUDASaFeHRPJRw850b0n5ehBlPn6U3ccmNW/K3Xh8pr/y4/GdcQw
         ZC3pHEsOa1AU3UCPOqqYuYvcTDYpLzX1IU9WemBQ=
Received: from epsmges1p1.samsung.com (unknown [182.195.42.53]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20181205105739epcas1p39922d0d40d5b2f469d1156f916a7343f~tapp9mlt-2450324503epcas1p37;
        Wed,  5 Dec 2018 10:57:39 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        71.B1.04058.22FA70C5; Wed,  5 Dec 2018 19:57:38 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181205105738epcas1p1795484fe370d1e287585e1a8d66ff02e~tappnG8kh2462024620epcas1p1T;
        Wed,  5 Dec 2018 10:57:38 +0000 (GMT)
X-AuditID: b6c32a35-e37ff70000000fda-e0-5c07af22be17
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 6B.69.03601.22FA70C5; Wed,  5 Dec
        2018 19:57:38 +0900 (KST)
To:     undisclosed-recipients:;
Received: from [106.116.147.40] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PJ900ABFFRXRO10@mmp2.samsung.com>; Wed, 05 Dec 2018 19:57:38 +0900 (KST)
Subject: Re: [PATCH v3 5/5] clk: samsung: exynos5433: add imem clocks
Cc:     Stephen Boyd <sboyd@kernel.org>, k.konieczny@partner.samsung.com,
        linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <3bb9f4b5-e069-79fe-6ab3-2750c6191e57@samsung.com>
Date:   Wed, 05 Dec 2018 11:57:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-version: 1.0
In-reply-to: <154394884525.88331.3007383362383800806@swboyd.mtv.corp.google.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsWy7bCmnq7SevYYgy9TzC2uf3nOajH/yDlW
        i759/xkt+h+/ZrY4f34Du8Wmx9dYLS7vmsNmMeP8PiaLpdcvMlm07j3CbvHv2kYWB26PNfPW
        MHpsWtXJ5rF5Sb3HwXd7mDz6tqxi9Pi8SS6ALYrLJiU1J7MstUjfLoEr4/qKiWwFtwQq9u05
        z9TA+Jyni5GDQ0LARKL7a1UXIxeHkMAORomdrTfZIJzvjBIPdm5k6mLkBCvafOA/K0RiA6PE
        +58dzCAJEQEZibmzH0Ml7jNK3NvXwwiSEBZwlViw7RxYglmghVli4Y5JYKPYBAwleo/2gRXx
        CthJrFxzghXEZhFQlbj86hsLiC0qECHRcX81G0SNoMSPyffA4pwCARI7j+xkB7GZBTQlXnyZ
        xAJhi0scu3+TEcKWl9i85i0zyGIJge9sEusOX4D6wUXi79/TrBC2sMSr41vYIQEgLXHpqC1E
        uFpi1/ZuqN4ORomWC9uZIRLWEoePX2SFWMAn8e5rDytEL69ER5sQRImHxKcZndCQmMkkse/t
        FfYJjLKzkPwwC8nds5DcPQvJ3QsYWVYxiqUWFOempxYbFhjqFSfmFpfmpesl5+duYgSnGy3T
        HYxTzvkcYhTgYFTi4ZWYwhYjxJpYVlyZe4hRgoNZSYR3hQ17jBBvSmJlVWpRfnxRaU5q8SFG
        aQ4WJXHeJ1Jzo4UE0hNLUrNTUwtSi2CyTBycUg2MNqVlPXNVjzwXfzPnaeTt2Y/WN24xtlxy
        biZDyQe5yBdim2Ymbus27H98PHbhpKZsLudijwv5Yddfz3IV/3V6tqApJ8PTYsVLfn7LXs1Y
        McnH+H7L7bxNSzerC+TM6+J5xPl+a+zSOVEpF/cbPHM4+rZYiFW4UdrEVT907qrzeUJryzd9
        VJ18WomlOCPRUIu5qDgRAPqqPo4zAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42I5/e+xoK7SevYYg2nPVSyuf3nOajH/yDlW
        i759/xkt+h+/ZrY4f34Du8Wmx9dYLS7vmsNmMeP8PiaLpdcvMlm07j3CbvHv2kYWB26PNfPW
        MHpsWtXJ5rF5Sb3HwXd7mDz6tqxi9Pi8SS6ALYrLJiU1J7MstUjfLoEr4/qKiWwFtwQq9u05
        z9TA+Jyni5GTQ0LARGLzgf+sXYxcHEIC6xgllq6awQiSEBGQkZg7+zEriC0k8JBRYttBbhBb
        WMBVYsG2c2ANzAItzBKHdm9lgeieySRx8MI/ZpAqNgFDid6jfWCTeAXsJFauOQE2iUVAVeLy
        q28sILaoQITE2ZfroGoEJX5MvgcW5xQIkNh5ZCd7FyMH0AZ1iSlTckHCzALiEsfu32SEsOUl
        Nq95yzyBUWAWku5ZCB2zkHTMQtKxgJFlFaNkakFxbnpusVGBYV5quV5xYm5xaV66XnJ+7iZG
        YNRsO6zVt4Px/pL4Q4wCHIxKPLwKs9lihFgTy4orcw8xSnAwK4nwrrBhjxHiTUmsrEotyo8v
        Ks1JLT7EKM3BoiTOezvvWKSQQHpiSWp2ampBahFMlomDU6qBUVtStUe95uV0/5rU3NR7ba0H
        +tVSz3VPd10mqi5+VrzaYLrbxgXa0SvZOmJurnkT5XhCSOt67+Wvyxce5/KR+Mv5/0/IoxP6
        s2e2XPPu9p1QM1O9m0lVIKTCNXlu80VrJr47PBnn7SceeqV/SmvqlAyG53d+a1zxUD7nO1m7
        /XxD+L7AnklxSizFGYmGWsxFxYkAt3eVzZYCAAA=
X-CMS-MailID: 20181205105738epcas1p1795484fe370d1e287585e1a8d66ff02e
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20181204165318eucas1p2dccd5382ee8b9f4da8c3076fb56607ee
References: <20181204165248.17572-1-k.konieczny@partner.samsung.com>
        <CGME20181204165318eucas1p2dccd5382ee8b9f4da8c3076fb56607ee@eucas1p2.samsung.com>
        <20181204165248.17572-6-k.konieczny@partner.samsung.com>
        <154394884525.88331.3007383362383800806@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/18 19:40, Stephen Boyd wrote:
> Quoting Kamil Konieczny (2018-12-04 08:52:48)
>> +
>> +static const unsigned long imem_clk_regs[] __initconst = {
>> +       ENABLE_ACLK_IMEM,
>> +       ENABLE_ACLK_IMEM_INT_MEM,
>> +       ENABLE_ACLK_IMEM_SSS,
>> +       ENABLE_ACLK_IMEM_SLIMSSS,
>> +       ENABLE_ACLK_IMEM_RTIC,
>> +       ENABLE_ACLK_IMEM_SMMU_SSS,
>> +       ENABLE_ACLK_IMEM_SMMU_SLIMSSS,
>> +       ENABLE_ACLK_IMEM_SMMU_RTIC,
>> +       ENABLE_ACLK_IMEM_ARBG_TX,
>> +       ENABLE_ACLK_IMEM_SMMU_ARBG_TX,
>> +       ENABLE_PCLK_IMEM,
>> +       ENABLE_PCLK_IMEM_SSS,
>> +       ENABLE_PCLK_IMEM_SLIMSSS,
>> +       ENABLE_PCLK_IMEM_RTIC,
>> +       ENABLE_PCLK_IMEM_SMMU_SSS,
>> +       ENABLE_PCLK_IMEM_SMMU_SLIMSSS,
>> +       ENABLE_PCLK_IMEM_SMMU_RTIC,
>> +       ENABLE_PCLK_IMEM_SMMU_ARGB_TX,
>> +};
>> +
>> +static const struct samsung_gate_clock imem_gate_clks[] __initconst = {
>> +       /* ENABLE_ACLK_IMEM */
>> +       GATE(CLK_ACLK_AXI2AHB_IMEMH, "aclk_axi2ahb_imemh", "aclk_imem_200",
>> +                       ENABLE_ACLK_IMEM, 24, 0, 0),

I don't think that clock will ever need to be disabled/enabled, so I would
drop this definition. The clock will remain in its default state after reset
(enabled).

>> +       GATE(CLK_ACLK_AXIDS_SROMC, "aclk_axids_sromc", "aclk_imem_200",
>> +                       ENABLE_ACLK_IMEM, 23, CLK_IGNORE_UNUSED, 0),
> 
> Why is there so much use of CLK_IGNORE_UNUSED in this file?

I suppose CLK_IGNORE_UNUSED is needed because there is no drivers that
would enable required clocks. For some clocks the flag could probably
indeed just be omitted, e.g. SLIMSSS clocks. 

I'm inclined to just define clocks that we are confident about and which
are needed now. i.e. the SSS IP block clocks. So in include/dt-bindings/
clock/exynos5433.h we would have something like:
 
+/* CMU_IMEM */
+#define CLK_ACLK_SSS			1
+#define CLK_PCLK_SSS			40

+#define IMEM_NR_CLK			41

The other clocks could be added later as needed by someone who has 
detailed knowledge about respective peripheral blocks.

-- 
Regards,
Sylwester
