Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE72C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BECA20659
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QPexaSr7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BECA20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbeLCOEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:04:47 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36749 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbeLCOEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:04:46 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181203140337euoutp02cac53234bf09eb80b965af316e1e5a23~s15dmxB-J2443124431euoutp02h
        for <linux-kernel@vger.kernel.org>; Mon,  3 Dec 2018 14:03:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181203140337euoutp02cac53234bf09eb80b965af316e1e5a23~s15dmxB-J2443124431euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1543845817;
        bh=AmJ5nSWqAz6hc+JDd6DaCPMrQ5rjkp21YBSz8ad6Fv4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=QPexaSr736OcjjYje+TdEX2mzoPDG16jlFqLwx0Pvd05oAuFbh8eSWjKw9tvGjtp+
         tbAtYUAO9QZLR/gm7SaWQRwg481NLch1ZgR5oDzPKZByOIulD8qUPQIFSTdVoOy0XT
         p7ijH7YNYJN3PbFOj588aDGKEV2PbHDlJJWzHYzc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181203140336eucas1p21106355b13a86b08915ba50ff56c4f64~s15cc4Rze0262902629eucas1p2J;
        Mon,  3 Dec 2018 14:03:36 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id D7.20.04806.7B7350C5; Mon,  3
        Dec 2018 14:03:35 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181203140335eucas1p284ecf49f9d49a903f583725dd742c237~s15blstk93134731347eucas1p2D;
        Mon,  3 Dec 2018 14:03:35 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181203140335eusmtrp2157e30cb632148c6534127f2582f7cf1~s15bhhVR41302613026eusmtrp2h;
        Mon,  3 Dec 2018 14:03:35 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-58-5c0537b7a569
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 31.94.04128.7B7350C5; Mon,  3
        Dec 2018 14:03:35 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181203140334eusmtip1b2bd837b2b85c7f5abf8d8d88c38cfb9~s15anaQui0221702217eusmtip1C;
        Mon,  3 Dec 2018 14:03:34 +0000 (GMT)
Subject: Re: [PATCH 1/6] devfreq: add basic fileds supporting suspend
 functionality
To:     myungjoo.ham@samsung.com,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     "tjakobi@math.uni-bielefeld.de" <tjakobi@math.uni-bielefeld.de>,
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
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <9af62c00-0bf5-4dfd-f7fb-f6de1ce42717@partner.samsung.com>
Date:   Mon, 3 Dec 2018 15:03:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181126081427epcms1p8801d251017da40b59d7e8391ee247fdb@epcms1p8>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaWxMYRT1vb3D8ExLbxCVCWJtCYkvtlSKvB9ijV1Sg6fKTJd5LV2IQdqp
        UpoSy1gqoYvpMFQ7XeiI6pKWmtZaS6kxiGVaaWsX9PVV9N85955zz71fPo7UnGIGceERMaIx
        QqfXMirKUfXdNb5oCr1mQlrNVHyjcDS+fMxO46LLX2j8qOMtjTMr7tB4z1k7g2/vM+CDrz6Q
        2OW6xOK63R9ZbDlcRuD8Vw9pfK/0JIPb0yoQPuZyEvhCRROLsx41EPjprlwGN9VWdvpv3aVx
        UlkFi5PzPtH4Y/1zKthfcFx10ILttA0JJ0wNlJB+sA0JZ6+9I4R8615GuH7KxgpXzu0Uflex
        QsEDMyUcKLAiITfvKyu05w9dqF6lmr5B1IdvFY1BM9eqNn1wZ5NRqaq4w5m7SRPK4FIRxwE/
        Gcz1S1ORitPwuQhqW9ophXQg8JbbCYW0I7jbXEinIp8ux+P7Sd2qHATnWk2sQrwITI/TCFnl
        yy8F83kvLTf8+FYCmjwXGZmQ/CEGSn60IDmd4QOh2BotG9T8XLBcy2FlTPHDofnMxa5BA/gV
        kPIij1E0/aHmuIeSsQ8/Hxw5DV2Y5P3hiSeTUHAAFHlPknIW8M84+F7bxip7z4bauheUgn3h
        fXVBd30I/ClRzMBLUJdiZRS8Hcw1xd2aaXCzuoGWdyb50WAvDVIebxZ4fgYosC80evsrG/SF
        DMdRUimrISVZo8wYBQX767tzBkKO7QibjrSWHndZetxi6XGL5X/sGURZkb8YKxnCRGlShLgt
        UNIZpNiIsMD1kYZ81Plpb/2u/lyMnL/WlSOeQ9o+6uBQao2G1m2V4g3lCDhS66eOiu4sqTfo
        4hNEY2SoMVYvSuVoMEdp/dWJvZpXa/gwXYy4RRSjROO/LsH5DDKhqsn7G9WR/UxlIc6wFueS
        5JbNL+O97gVZHU53nqt60j6NZXMc7Q5OXOjcWBKgvzTPNSMr+qb727ZxTacfbBxZUzk1YX72
        m9J15hGNo4JiFn1xFLo8lQMW0TNNX3uP3eE7xWZcbLcWvdbPObD8elnbodDX9SuzLbAsJHKl
        X3iQ++isYVpK2qSbOIY0Srq/Kt3cfLADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec994uB4tHwTujC6mNFy87LX0pCgOBVd6AKShi09qOSc7UxR
        v6SJXVapiZYuc4aWpqa51rSLRjKNMl1e0i5qlkKIZnmhCEzaGoHffu/z//94eeBhcM5M+jAJ
        SXpBl6ROlFFuROfii+HNTSoyyn/+A4ueP9yIGosbSNTU+JNEg/NfSWSydZMou6KBQq8vaVDe
        2CSO7Pb7NOo6O0UjY2ELhsxjAyTqe1xKobkrNoCK7a0YumcbptHtwR4MfcyqptDwq3aH39lL
        opwWG43O1f4g0dSbESLcm7c+sZJ8XVkd4G9k9hB8ft4s4CueTmC8ueYixT+7WUfzDyrP8Isd
        NG95e57gcy01gK+u/UXzc+ZVB6XH5KE6bYpeWBOvFfVhskgFUsoVIUiuDAyRKwJUx7cqg2Rb
        tofGCokJqYJuy/YT8vjJL3fwZINbWqHpLJ4JChgDkDCQDYTv+3MIA3BjOPY2gCPFncAVLIcF
        rU20iz3hwoCBcpUmARzsvkg5A0/2KDx/9xvpDLzYGQy+sd2nnQ+cLaGgdfQX7mxx7HUMjg/I
        DIBhKFYOm2tOO8dSdhc0Pq369wPBroWj5fWYk5exEbBroh64Oh7wZck44WQJux9aq3r+Mc4G
        w7IHn3EXe8MP4ybMxath07dSPB9wxiW6cYliXKIYlyjlgKgBXkKKqInTiEq5qNaIKUlx8hit
        xgwc92Lt+G1pBobpw22AZYDMXRoeTURxpDpVTNe0AcjgMi9p8mnHSBqrTs8QdNpoXUqiILaB
        IMdyV3GfZTFax/Ul6aMVQQoVClGoAlQBwUjmLbX7px/j2Di1XjglCMmC7r+HMRKfTJAwtAGT
        rEiLKzpTVp8h+EouW7LtdVm7x6J6BSI+OyzatiN2W9XOvf4RJw+8I32JvkiTt3m2tHohciL2
        0N36Tx5TfqYLmyxte2rt63rT9m3+PtMtHKnuKbI1rC/sH05/NMPdavdYpaOC/nAPr4X7KqeN
        jbnNHSvdLQJXGTrUbpmTEWK8WuGH60T1XwiwEAhFAwAA
X-CMS-MailID: 20181203140335eucas1p284ecf49f9d49a903f583725dd742c237
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181121180201eucas1p1f1f96941c3d16a96722e65d5c21bfe80
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181121180201eucas1p1f1f96941c3d16a96722e65d5c21bfe80
References: <1542823301-23563-2-git-send-email-l.luba@partner.samsung.com>
        <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181121180201eucas1p1f1f96941c3d16a96722e65d5c21bfe80@epcms1p8>
        <20181126081427epcms1p8801d251017da40b59d7e8391ee247fdb@epcms1p8>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi MyungJoo,

On 11/26/18 9:14 AM, MyungJoo Ham wrote:
>> The patch prepares devfreq device for handling suspend/resume functionality.
>> The new fields will store needed information during this process.
>> Devfreq framework handles opp-suspend DT entry and there is no need of
>> modyfications in the drivers code.
>>
>> The patch draws on Tobias Jakobi's work posted ~2 years ago, who tried to
>> solve issue with devfreq device's frequency during suspend/resume.
>> During the discussion on LKML some corner cases and comments appeared
>> related to the design. This patch address them keeping in mind suggestions
>>from Chanwoo Choi.
>>
>> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> 
> When you add new elements in a common struct (i.e., struct devfreq),
> please describe kindly in the doxygen entries so that developers
> may understand before reading all places where the new elements are
> used.
> 
> You have added three new elements and there is no explanations on them.
You are right, thank you for the review.
I will fix it in the next patch set version.

Regards,
Lukasz

> 
> 
> Cheers,
> MyungJoo
> 
> 
> 
