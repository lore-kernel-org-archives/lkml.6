Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A7BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD13C2184E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CBfanqvL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbeLRLXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:23:54 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55782 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbeLRLXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:23:53 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181218112351euoutp02055b68a3fa4478fe96148a30a0a20d7f~xaZQZSDrV1261112611euoutp02L
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 11:23:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181218112351euoutp02055b68a3fa4478fe96148a30a0a20d7f~xaZQZSDrV1261112611euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1545132232;
        bh=NKvXK1MeO0eV8j/6E9wS58HIqqN66Hhn9V6+QE8HPyg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=CBfanqvLBszOFu4o9AJxnPy0+4wqpB8SJqwEc9p4VuGIGBB/f8ehVzmARSeKuXi4C
         ubMLUe38QKQRxHcLqoFCMc3kanm67Q+Lsy8vciMsVFuXn3FS8w+jw+VYJBLtl90YFX
         4rpeeG2uiZQa45w0K49kbZ8cu3Fc1yzXnjLlGU4E=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181218112351eucas1p27a66e9dea27a1526287a03d021f724ff~xaZPs7p5l0905109051eucas1p2O;
        Tue, 18 Dec 2018 11:23:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A8.C2.04441.6C8D81C5; Tue, 18
        Dec 2018 11:23:50 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181218112350eucas1p1b689ae88b6f9d0ed24b1bf9b53be4c2f~xaZOlt2FE1673916739eucas1p12;
        Tue, 18 Dec 2018 11:23:50 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181218112349eusmtrp1af386196ad1262bf1ad5f74158fac2ad~xaZOXCwtd0258502585eusmtrp1Z;
        Tue, 18 Dec 2018 11:23:49 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-dc-5c18d8c656cd
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id CA.9B.04284.5C8D81C5; Tue, 18
        Dec 2018 11:23:49 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181218112349eusmtip2c53e0aa0711150b09801e4ade0166dfa~xaZNw3Rzi3126731267eusmtip2j;
        Tue, 18 Dec 2018 11:23:49 +0000 (GMT)
Subject: Re: [RFC/RFT 08/10] i2c: exynos5: use core helper to mark adapter
 suspended
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrzej Hajda <a.hajda@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <87b6a87b-92d3-a1eb-b77b-f91651c72270@samsung.com>
Date:   Tue, 18 Dec 2018 12:23:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181210210310.12677-9-wsa+renesas@sang-engineering.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfyyUcRzHfe957rnH6epx2H2Gal3Tph9+LKtHmtikm/6hP2qra7p4wuLo
        zinS2MyR+R1xF0VT7NZOOz8yxUIcaaf8zmQtNCkhtNlE7p4p/70+3/f7831/PtuHxITtXEcy
        Sh7PKOSyaDHBxxu7Vk1HukZB6jE7dIge05u49A9jCYfOm/yO0X19z3m0YXKYS2f+WUb0QHMZ
        QS/lvEF0w7efHLq0r5VD55rO+NlIDLq7hKSuKkUy3zpESHLrdUjytbIWlywZ9gQTF/knw5no
        qARG4e57hR853P0aj5uDW/rcIZSKZuyzkDUJlBekly5ysxCfFFI1CNRPRnC2WEZQOKUm2GIJ
        wTPdAL7VUr6wbmEhVY0g3ZDCmuYRVHws4JkFO+o81PSUY2a2p4Ihf6PSkoFRrRx4WZjKMQsE
        5QlZc1mEmQWUL7SslVgYp1xg/N2CxeNASWE6tRVnPbbQo5mysDUVCBkPB7lmxqi9kNbwAGNZ
        BGNTjzjmMKD6eZBuWkPs2AHw4lU+h2U7mDXW81h2ht572TjbkIYgo1TLY4tsBA1lTQTr8oEO
        44fNOHIzwhVqm93NCJQ/PG3Yx+JOGJ2zZWfYCYWNJRj7LIBMtZD94wBojfp/qW3v+7F8JNZu
        20y7bRvttm20/2MrEK5DIkaljIlglJ5y5qabUhajVMkj3MJiYwxo87J6142/mtBK/9V2RJFI
        vENg1S2SCrmyBGViTDsCEhPbC8ZUIBUKwmWJSYwiNlShimaU7ciJxMUiwW2rz5eEVIQsnrnO
        MHGMYkvlkNaOqSiUuTwZMkOaTGcdvlS1DCQJ/TTS3RrfEEFskL+rd9ix6qITcoeCiRBTwR2P
        Xd6LXacGz7nQ+pblw1Zt/NWRt2r1gDzZpq5Mnvc4dnw/LzDR58JR2/SeYpHnp878+6dz/Pnx
        TkW/O+qcO69NaFY2Ro9rbjjN9siLZwPWk+mgUq9pMa6MlHkexBRK2V+ibjCkVQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xe7pHb0jEGDRe0bK4te4cq8Wb49OZ
        LPofv2a2OH9+A7vFpsfXWC06/n5htLi8aw6bxefeI4wWW1++Y7KYcX4fk0XfOXcHbo9NqzrZ
        PDYvqfd4v+8qm0ffllWMHs8Wrmfx+LxJLoAtSs+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRS
        z9DYPNbKyFRJ384mJTUnsyy1SN8uQS/j2okDLAVvJSrW9V1lbGB8IdLFyMkhIWAiMffDP5Yu
        Ri4OIYGljBLf161nhkjISJyc1sAKYQtL/LnWxQZR9JZRoqnvCCNIQlggTGLFyblgDSICfhKH
        lr0Ds5kF9jFJ7HhTCtFwlVGi7UYTG0iCTcBQouttF5jNK2AnsffPdDCbRUBV4s6ZD0xdjBwc
        ogIxEs8WVEOUCEqcnPmEBcTmFHCTaJ93hRVivrrEn3mXoHbJSzRvnQ1li0vcejKfaQKj0Cwk
        7bOQtMxC0jILScsCRpZVjCKppcW56bnFhnrFibnFpXnpesn5uZsYgTG67djPzTsYL20MPsQo
        wMGoxMPLcEI8Rog1say4MvcQowQHs5II761SiRgh3pTEyqrUovz4otKc1OJDjKZAv01klhJN
        zgemj7ySeENTQ3MLS0NzY3NjMwslcd7zBpVRQgLpiSWp2ampBalFMH1MHJxSDYwlz4LKBdf7
        eH+49KvgdLGLpcZn07kV7L1MF9+1qE1hPBXnPJN/j/LXK64LFqV7/lD9HhVW/ulWzuSOi/35
        B+/l9BziYLOscL7aobK31EVd9/d5iZB6S8UNtismfd30KWbhhScp7HcN7/xJX75mt+zOVqWN
        +4M3HVdsWtekm7uNwd3k9QMXty4lluKMREMt5qLiRACdA0D65wIAAA==
X-CMS-MailID: 20181218112350eucas1p1b689ae88b6f9d0ed24b1bf9b53be4c2f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181210210429epcas5p2b545f32165b5025e7cec0b5f5b98f783
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181210210429epcas5p2b545f32165b5025e7cec0b5f5b98f783
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
        <CGME20181210210429epcas5p2b545f32165b5025e7cec0b5f5b98f783@epcas5p2.samsung.com>
        <20181210210310.12677-9-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018-12-10 22:03, Wolfram Sang wrote:
> Rejecting transfers should be handled by the core. Also, this will
> ensure proper locking which was forgotten in this open coded version.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Works fine on TM2e and OdroidXU3. The only minor issue is the following
warning:

WARNING: CPU: 4 PID: 28 at drivers/i2c/i2c-core-base.c:1869
__i2c_transfer+0x428/0x5e0
Modules linked in:
CPU: 4 PID: 28 Comm: cpuhp/4 Tainted: G        W        
4.20.0-rc1-00031-ga1c77790d03f #5130
Hardware name: Samsung TM2E board (DT)
pstate: 20000005 (nzCv daif -PAN -UAO)
pc : __i2c_transfer+0x428/0x5e0
lr : i2c_transfer+0x64/0xb8
...
Call trace:
 __i2c_transfer+0x428/0x5e0
 i2c_transfer+0x64/0xb8
 regmap_i2c_read+0x5c/0xa0
 _regmap_raw_read+0xac/0x2a8
 _regmap_bus_read+0x3c/0x70
 _regmap_read+0x64/0x1a0
 regmap_read+0x48/0x70
 regulator_is_enabled_regmap+0x38/0xb8
 _regulator_is_enabled.part.1+0x1c/0x30
 create_regulator+0x264/0x270
 _regulator_get+0x90/0x2b0
 regulator_get_optional+0x10/0x18
 dev_pm_opp_set_regulators+0xb8/0x1e8
 cpufreq_init+0xd0/0x2f8
 cpufreq_online+0xc0/0x660
 cpuhp_cpufreq_online+0xc/0x18
 cpuhp_invoke_callback+0xac/0x7b0
 cpuhp_thread_fun+0xec/0x180
 smpboot_thread_fn+0x1f0/0x290
 kthread+0xfc/0x128
 ret_from_fork+0x10/0x1c
---[ end trace bea5412bc21deb81 ]---

Similar warning was already there ('HS-I2C is not initialized' message,
without backtrace) during system suspend/resume. It looks that cpu freq
is resumed too early, before any device drivers, but this is not an
issue for this patchset.

> ---
>  drivers/i2c/busses/i2c-exynos5.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
> index c1ce2299a76e..fe2f2031ea36 100644
> --- a/drivers/i2c/busses/i2c-exynos5.c
> +++ b/drivers/i2c/busses/i2c-exynos5.c
> @@ -183,7 +183,6 @@ enum i2c_type_exynos {
>  
>  struct exynos5_i2c {
>  	struct i2c_adapter	adap;
> -	unsigned int		suspended:1;
>  
>  	struct i2c_msg		*msg;
>  	struct completion	msg_complete;
> @@ -715,11 +714,6 @@ static int exynos5_i2c_xfer(struct i2c_adapter *adap,
>  	struct exynos5_i2c *i2c = adap->algo_data;
>  	int i, ret;
>  
> -	if (i2c->suspended) {
> -		dev_err(i2c->dev, "HS-I2C is not initialized.\n");
> -		return -EIO;
> -	}
> -
>  	ret = clk_enable(i2c->clk);
>  	if (ret)
>  		return ret;
> @@ -847,8 +841,7 @@ static int exynos5_i2c_suspend_noirq(struct device *dev)
>  {
>  	struct exynos5_i2c *i2c = dev_get_drvdata(dev);
>  
> -	i2c->suspended = 1;
> -
> +	i2c_mark_adapter_suspended(&i2c->adap, true);
>  	clk_unprepare(i2c->clk);
>  
>  	return 0;
> @@ -871,7 +864,7 @@ static int exynos5_i2c_resume_noirq(struct device *dev)
>  
>  	exynos5_i2c_init(i2c);
>  	clk_disable(i2c->clk);
> -	i2c->suspended = 0;
> +	i2c_mark_adapter_suspended(&i2c->adap, false);
>  
>  	return 0;
>  }

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

