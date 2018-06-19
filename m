Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3540C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724B420874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TVxg3DCe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 724B420874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937743AbeFSLpe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 07:45:34 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40520 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936748AbeFSLpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 07:45:31 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180619114528euoutp014b24777504a35df4ba7e0eb334eb5fc9~5jSLDEBB_0858008580euoutp01M
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 11:45:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180619114528euoutp014b24777504a35df4ba7e0eb334eb5fc9~5jSLDEBB_0858008580euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1529408728;
        bh=Ff60aOiVGiWlF6qJruuyNYbhNau0V0UOh4NMP+JRlOU=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=TVxg3DCeHX5UzJhdgqh0uxisktM5dEaWMdarhVW0/48OY6sVCKw6yCs+KzttjC3zo
         /jLcaQfhBViLSdZguKL0MGqSyaKpaVP46bK0xk1T5xwseiTn73RkXsEmaIakrGmlO+
         TTAYyingjBa3wgLpB6WchZBUkN6ZARQcuK6e/FAw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180619114528eucas1p1a1ff8b9f18b2de1fb7daf5804047df6b~5jSKXgwPI0721507215eucas1p1a;
        Tue, 19 Jun 2018 11:45:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id D2.39.17380.7DCE82B5; Tue, 19
        Jun 2018 12:45:27 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180619114527eucas1p154dc59055086a514a0423fc4cfb0b8c8~5jSJigH_r0719907199eucas1p1N;
        Tue, 19 Jun 2018 11:45:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180619114527eusmtrp1455a910e44d44fed7bcb05504c533d53~5jSJSPoXR1326513265eusmtrp1-;
        Tue, 19 Jun 2018 11:45:27 +0000 (GMT)
X-AuditID: cbfec7f4-6f9ff700000043e4-1a-5b28ecd7a65b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9A.D4.04178.6DCE82B5; Tue, 19
        Jun 2018 12:45:26 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180619114526eusmtip2fcee35e34eb0cfe8092dea9eae8a0c89~5jSI9WRfa0261802618eusmtip2N;
        Tue, 19 Jun 2018 11:45:26 +0000 (GMT)
Subject: Re: dynamic reservation and allocation of physically contiguous
 memory using CMA
To:     "Amit Chandra (amichand)" <amichand@cisco.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Tue, 19 Jun 2018 13:45:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <DF0025E0-5C00-4566-82D2-F3599F206210@cisco.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsWy7djPc7rX32hEGzw7Zmbx7e0cRotNj6+x
        WlzeNYfNomfDVlaLe2v+s1rMOL+PyYHNY8rvjawemz5NYvfYvKTe4/MmuQCWKC6blNSczLLU
        In27BK6MlfcOMxecE6xoPdvH0sC4ja+LkYNDQsBEYu9CrS5GLg4hgRWMEv/PTWPsYuQEcr4w
        SqyZxw+R+MwocWDqBXaQBEjD9mPXWSESyxklDh+4zQLhvGeUmPDqKRNIlbBAtET79p/sIAkR
        gd9MEteP3mAFSbAJGEp0ve1iA7FZBFQlflzbB7ZPVCBGYtvlBywgNq+AoMTJmU/AbE4BW4l7
        x6czg9jMAvISzVtnQ9niEreezGcCWSAhMJldouvdZ3aI5jKJpo+dbBC3ukjMnb+XCcIWlnh1
        fAvUDzISpyf3sEA0NzNKtM+YxQ7h9DBKbJ2zA6rbWuLw8YusoGBiFtCUWL9LHyLsKHFwy3EW
        SOjxSdx4KwhxEJ/EpG0gh4KEeSU62oQgqtUkZh1fB7f24IVLzBC2h8SL2S3sExgVZyF5eRaS
        N2cheXMWwg0LGFlWMYqnlhbnpqcWG+WllusVJ+YWl+al6yXn525iBKab0/+Of9nBuOtP0iFG
        AQ5GJR5ejfXq0UKsiWXFlbmHGCU4mJVEeBlOaUQL8aYkVlalFuXHF5XmpBYfYpTmYFES543T
        qIsSEkhPLEnNTk0tSC2CyTJxcEo1MNY9/rxt8t65N66J7zNI+Ruy7MHtFQYPfFeKFyeFTTLI
        6dv1foll64TnvgL3VWZ+2CN9QKHkaV1qcnJQ7CS1tldpiWEb/0qJt5UGOurK1C3nqFp44q+D
        3oody98taXhfLj315DkLo5TPi4WXa7G9n5Nsl+l14FmB0OoAsXdfzm7YlW3Izxu+1EqJpTgj
        0VCLuag4EQCSbGRWMwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xe7rX3mhEG3zYb23x7e0cRotNj6+x
        WlzeNYfNomfDVlaLe2v+s1rMOL+PyYHNY8rvjawemz5NYvfYvKTe4/MmuQCWKD2bovzSklSF
        jPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MlfcOMxecE6xoPdvH
        0sC4ja+LkZNDQsBEYvux66xdjFwcQgJLGSVObm5nhUjISJyc1gBlC0v8udbFBlH0llGi+clf
        JpCEsEC0RPv2n+wgtojAXyaJp5ucIYomMErM3H2VESTBJmAo0fUWpJuTg1fATmLZsm1gzSwC
        qhI/ru0DqxEViJFYvfEyO0SNoMTJmU9YQGxOAVuJe8enM4PYzAJmEvM2P4Sy5SWat86GssUl
        bj2ZzzSBUXAWkvZZSFpmIWmZhaRlASPLKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMBI2nbs
        5+YdjJc2Bh9iFOBgVOLhbdioHi3EmlhWXJl7iFGCg1lJhJfhlEa0EG9KYmVValF+fFFpTmrx
        IUZToOcmMkuJJucDozyvJN7Q1NDcwtLQ3Njc2MxCSZz3vEFllJBAemJJanZqakFqEUwfEwen
        VANj/28Ow7/Xa2ZqR3twpYv/ZU1POfds9+7Dib2vYxKfbVF/wvBldptt0PQ1xyxFHU51Rt34
        +N997ukfc13+zpxj8P7f/Z8v8yQOSsYmKJRI7In3+3yyn+Vo5rlsu19nz/I//NJ95NQfhiNG
        BloiR2bJuyy2+mLr8lV53/9r2q1r3TuOujjpFgpNVGIpzkg01GIuKk4EAG6F7p26AgAA
Message-Id: <20180619114527eucas1p154dc59055086a514a0423fc4cfb0b8c8~5jSJigH_r0719907199eucas1p1N@eucas1p1.samsung.com>
X-CMS-MailID: 20180619114527eucas1p154dc59055086a514a0423fc4cfb0b8c8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180618182314epcas1p37a2b1ba6db9a829c07abf55ca0d3d50d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180618182314epcas1p37a2b1ba6db9a829c07abf55ca0d3d50d
References: <CGME20180618182314epcas1p37a2b1ba6db9a829c07abf55ca0d3d50d@epcas1p3.samsung.com>
        <DF0025E0-5C00-4566-82D2-F3599F206210@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amit,

On 2018-06-18 20:23, Amit Chandra (amichand) wrote:
>
> Hi experts,
>
> I had a question related to CMA. I have been trying to use the CMA 
> infra to reserve and allocate physically contiguous memory dynamically 
> at runtime.
>
> I built a custom kernel based on linux-4.14.47 to invoke the cma 
> initialization apis at runtime from kernel loadable module.
>
> I invoke cma_declare_contiguous() followed by cma_init_reserved_areas().
>
> cma_declare_contiguous throws no surprises and succeeds. The issue 
> happens when cma_init_reserved_areas() is invoked post that.
>
> Here is the kernel log snippet post that call:
>
> Jun 15 03:30:31 ubuntu-quickstart kernel: [  384.593218] cma: 
> cma_declare_contiguous(size 0x0000000200000000, base 
> 0x0000000000000000, limit 0x0000000000000000 alignment 0x0000000000000000)
>
> Jun 15 03:30:31 ubuntu-quickstart kernel: [  384.593228] cma: Reserved 
> 8192 MiB at 0x0000001d4d000000
>
> Jun 15 03:30:31 ubuntu-quickstart kernel: [  384.593345] BUG: Bad page 
> state in process insmod  pfn:1d4d000
>
> Jun 15 03:30:31 ubuntu-quickstart kernel: [  384.595758] 
> page:ffffefc335340000 count:0 mapcount:-127 mapping:          (null) 
> index:0x0
>
> Jun 15 03:30:31 ubuntu-quickstart kernel: [  384.599193] flags: 
> 0x57fffc000000000()
>
> Jun 15 03:30:31 ubuntu-quickstart kernel: [  384.600751] raw: 
> 057fffc000000000 0000000000000000 0000000000000000 00000000ffffff80
>
> Jun 15 03:30:31 ubuntu-quickstart kernel: [  384.603946] raw: 
> ffffefc335330020 ffffefc335350020 000000000000000a 0000000000000000
>
> Jun 15 03:30:31 ubuntu-quickstart kernel: [  384.607152] page dumped 
> because: nonzero mapcount
>
> I am having a hard time trying to understand why the mapcount is less 
> than 0 here. I figured this is happening in the call to __free_pages() 
> from init_cma_reserved_pageblock().
>
> Any pointers here would be really helpful. If I am missing any step 
> for cma reservation, please do let me know.
>
> Thanks in advance.
>

CMA initialization is possible only on very early boot stage. CMA will 
not work as dynamic module.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

