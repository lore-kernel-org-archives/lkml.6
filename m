Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4450FC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D8E2064E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Prfxpsc+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D8E2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbeJIV04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:26:56 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:52259 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbeJIV04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:26:56 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181009140946euoutp01d7ff0403a4864571074430a4aa1c305a~b9gIB3vvQ1454414544euoutp01U
        for <linux-kernel@vger.kernel.org>; Tue,  9 Oct 2018 14:09:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181009140946euoutp01d7ff0403a4864571074430a4aa1c305a~b9gIB3vvQ1454414544euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539094186;
        bh=qzbC05Cth5m4jdpceY8Odld1qGWRFWJ59gPZmkBUSFc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Prfxpsc+jMA2fDd8isIcxoup7cCL3BlJc6yhu+svJrUYzsZ0f9E51XfQTj1Bjoq4/
         a3dw9qGcgfWXny0Pp99D0sP9I0JqftoErgLLfLYzGwg6sh0rpllrRoWjIVhY3hH2E1
         Ll4m1MTBYmpcJ64GoYt67smxPM6N02t5qtV5PHsY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181009140945eucas1p2b95e5cb4c1d0d3b8e9b9948d69af3fd9~b9gHLevix0650006500eucas1p2W;
        Tue,  9 Oct 2018 14:09:45 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id E1.06.04806.8A6BCBB5; Tue,  9
        Oct 2018 15:09:44 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181009140944eucas1p1b935c2b8b2534cb15e36d28b7f9b134b~b9gGLal7g1686816868eucas1p1T;
        Tue,  9 Oct 2018 14:09:44 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181009140943eusmtrp29e4264672f9c08182dd3b89d273a9706~b9gF6HLss1153311533eusmtrp2g;
        Tue,  9 Oct 2018 14:09:43 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-ae-5bbcb6a8f3c0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 63.A9.04128.7A6BCBB5; Tue,  9
        Oct 2018 15:09:43 +0100 (BST)
Received: from [106.120.51.16] (unknown [106.120.51.16]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181009140943eusmtip29b62b7075c168d595d5c052e7ca4a454~b9gFbAIFh2339923399eusmtip2W;
        Tue,  9 Oct 2018 14:09:43 +0000 (GMT)
Subject: Re: [PATCH v1 21/22] LSM: Multiple concurrent major security
 modules
To:     Casey Schaufler <casey@schaufler-ca.com>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        SE Linux <selinux@tycho.nsa.gov>,
        "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        James Morris <jmorris@namei.org>
Cc:     "Schaufler, Casey" <casey.schaufler@intel.com>
Newsgroups: gmane.linux.kernel,gmane.linux.kernel.lsm,gmane.comp.security.selinux
From:   Piotr Sawicki <p.sawicki2@partner.samsung.com>
Date:   Tue, 9 Oct 2018 16:09:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <42a1e879-e104-e663-2e0d-0b43eaa4c130@schaufler-ca.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe885OzuuJq9T86ErLEGKUsvIA4YYGJy+dIGocB9s6UGlXWTz
        khE00oXoLNPKmuVdW5pX5j0TZ1piKiWhaYXZkFKngpYYojmPkd9+z+3/PH94GFL2SbSDidHE
        8TqNUiWnJVRD91L/IUvDS4V/6e9j7LClgGC/Nvyh2arqYoJ9u2Ck2Xfpanaw5QnNzpnGaXY0
        K4dic1NmRGxnazHJZtttFPuxtFYcso0zGzJoLtfwnuKaK8sJrvjlT4JLz12hONNiBFfZ9gNx
        Xe1FNFefsyri5uv2nJWESY5H8qqYBF7nF3xZEm0te0HFFtLXPs+uEAaULUpDLgzgo5Bq/0Om
        IQkjwxYEFU0PN4IFBPl95SIhmEfQNZpC/BuxWgtoJ8vwMwSp9y4I7EBwt413sjs+A42VtnUl
        DzxIgsMwIXYWSHwEutMc60Ku+BxktNSTTqbXRE1VS5STKewN7dP9yMme+BK8HitcZyl2g57H
        9rUehnHBoZA3uVuQ9IIRez4h8F5odDxZ3wvYyMBY7pBYmE2AFXvNhoFQ+N6WLhbYHSbfWDd4
        F6w252/03ISM6m5aEDIhMNbn0UIhCOazrKTzCBLvh+oWPyF9AmaqOghnGrArDDvchHtcIash
        hxTSUki9LRO6D8L0nRIqE+0zbzJm3uTGvMmN+f+uAkSVIy8+Xq+O4vUBGj7RV69U6+M1Ub4R
        WnUdWnu43pU3v5rQq+UrNoQZJN8mfaRpVchEygR9ktqGgCHlHlLPxhaFTBqpTLrO67ThungV
        r7ehnQwl95KW5dUqZDhKGcdf5flYXvevSjAuOwyo9/yHskAfny9t/YspzWLLSe9l4y161tKz
        /VtNc0dl1talgPxu04Ngl9bnE1h732+kf4u2b3QgcKokJKA3M65oIPTtxTTXoK1VtGJOm3ja
        o3w1+17yqVM3NA+G6zORf8jM1NCsxaMicGe2KeSV1sh0Jmv3qOTJPk8Dg1QzYePhmXJKH608
        fIDU6ZV/AWWMgrlsAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsVy+t/xe7rLt+2JNvi6ztjixooFTBb3tv1i
        s1i3fjGTxYkvrWwWZ7pzLS7vmsNm8aHnEZvF7UnTWSxmt7xjtTi8ezGzxeQnh1gsri7dyO7A
        4zGroZfNY3bDRRaPnWtXMXks3vOSyaN79j8Wj57vyR5r975g9Di6fxGbx9bp/1k9Pm+SC+CK
        0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0MvYsmwN
        S8FCtoo77/8xNTBOZu1i5OSQEDCR2LJlAVsXIxeHkMBSRon7E6cxQSSkJOb+28sOYQtL/LnW
        BVX0mlFixuv5QAkODmEBX4ldjytB4iIC15klns3axQjSwCxgJHGs6y3YID6BQIneXVuZQWwh
        gVqJ51dPgm1mA9rcs+4nC4jNK+Am8ab7G1g9i4CKxP4358DmiApESKxe/oIVokZQ4uTMJywg
        ezkFXCTmvZKFWKUu8WfeJWYIW1zi1pP5TBC2vMT2t3OYJzAKz0LSPQtJyywkLbOQtCxgZFnF
        KJJaWpybnltspFecmFtcmpeul5yfu4kRGOvbjv3csoOx613wIUYBDkYlHt4ZebujhVgTy4or
        cw8xSnAwK4nwim7fFS3Em5JYWZValB9fVJqTWnyI0RTot4nMUqLJ+cA0lFcSb2hqaG5haWhu
        bG5sZqEkznveoDJKSCA9sSQ1OzW1ILUIpo+Jg1OqgTE97OkecYbPTsKzFlivmKLhYVKwbcXL
        XuZ3zMtK7iydtspTa30Ge5hadUsrt+LkuXfuCj6d0Kwbe3Ldi6aVggfsRayWMtll5+5R4RbO
        zHPz8DdYlhoTE/5mh/uxotIHCg67py1JmNH1Ynr1n60MZ22LZELTWdSsG6R8ZsapbGNn+9/T
        Nu1WvRJLcUaioRZzUXEiAFistvkLAwAA
Message-Id: <20181009140944eucas1p1b935c2b8b2534cb15e36d28b7f9b134b~b9gGLal7g1686816868eucas1p1T@eucas1p1.samsung.com>
X-CMS-MailID: 20181009140944eucas1p1b935c2b8b2534cb15e36d28b7f9b134b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181009140944eucas1p1b935c2b8b2534cb15e36d28b7f9b134b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181009140944eucas1p1b935c2b8b2534cb15e36d28b7f9b134b
References: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
        <42a1e879-e104-e663-2e0d-0b43eaa4c130@schaufler-ca.com>
        <CGME20181009140944eucas1p1b935c2b8b2534cb15e36d28b7f9b134b@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/16/2018 08:24 PM, Casey Schaufler wrote:
> LSM: Multiple concurrent major security modules

> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index c0d7ea0bf5b6..db72f2e38311 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -219,4 +219,8 @@ struct prctl_mm_map {
>  # define PR_SPEC_DISABLE		(1UL << 2)
>  # define PR_SPEC_FORCE_DISABLE		(1UL << 3)
>  
> +/* Control the LSM specific peer information */
> +#define	PR_GET_DISPLAY_LSM	52
> +#define	PR_SET_DISPLAY_LSM	53
> +
>  #endif /* _LINUX_PRCTL_H */

Hi,

The above two numbers for prctl() options have been reserved by
PR_GET_SPECULATION_CTRL and PR_SET_SPECULATION_CTRL.

Take a look at this commit: "prctl: Add speculation control prctls"

Regards,
Piotr
