Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856D6C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 410F020652
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="nIB7YMwt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 410F020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=aol.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbeICIl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 04:41:57 -0400
Received: from sonic306-21.consmr.mail.gq1.yahoo.com ([98.137.68.84]:41227
        "EHLO sonic306-21.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725854AbeICIl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 04:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1535948616; bh=D9VS4DxzO917O1wlFuX6wraqlp2UoHYCOpQRoIGi1Kk=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=nIB7YMwtLjsF4dk2YXKblyopU4JxtDTkjElvHoFcDYJLRxfCgVbahZHAgsU3r+8Ewh3UV4vbhFqOPhcPeZ4f6Z/rdFd/VcIQgzUHm763tiSn+16+l6oYQgaihYCauTfU6NQv/Q/p7oaYSXRHlDaHt4Cw0N1SfQ6ySU3rM7/+RhIUhwcPLzl5oaVkDYnIKbewlYeN5Y7hVtp3Xn+y4Zv2tFWR6OSFpxT1ZN+8KCmIsCAYRPxwD7jQI+tVefKkPyuYuzE+7GZMSTicBrC76Taid3nlF4QtoRyGO8Lk7gtjydOB2S+aRwf60mX8hMtpanjsHtcLKvBhlAaK5iClEGweSQ==
X-YMail-OSG: IKp43LYVM1mojpuKjn.4zx9Oa.FhIbpaZozP51guVRcNKIEliHU1AxRtt72CfpQ
 _GA.dxS36Z.abFY4f3I77V1sX6nwsbTeNZninheIuy1cXF_VZS9jCt1Hs86jQU2fEikC7PJhY8wU
 cy1eZ_Pl_PhHZgC5r8YicJBnqO5e.iJlVsfMOsKTt1s_q527YLcy8W7Hv8IUoxqtF3e28Yaz5MJe
 wiHhLDYZb7ow8sNjSxRnI.DUzjZDXKAtiDzpXbQoDF6Movlfy0X9_ZkBERtogZoFTDZyKWEBDWGx
 GSIjQp7Wf_uLVynO81YZvDcCWEUqhoqlN.sTYhp646atdoA2fQ5HUBcxuFhCNpxDUyJ9XSaR4Dm8
 uehh8XsQSDSze4BzFQNamZbhGixg2a0zVi_D19OZyqUqWG4G6SJWrw6tCtaWWnwpL33yIExL2Mv0
 JiJL1UFHUtFSiZdkL3oWsJyBTAm23K0LnRFNURd1xWx9yT33hXcWHJ0EJmbAelnaMVnlzAuPiU.h
 .V31b3YPa7H8t7fvK2V70yHi5dCIozaomNoLNI1iiXH2kT.gZP0n8lE5olVwQ4XZ5ERaXa.xxQ7Q
 Tr7cMm3CFyb3mCKOLy0vjBGQIVvsKKgY9KTyzqWLWSfKlhGXHgXv1N9n3Cbb0O3aKaYn0VRz81bH
 VRtXxytLx.Nx53sHYz79C_Ubws6UNs2KHirXzYSY6h_hAGCkHRaT_Js5zeOQBi7GO1_Vl1P0tA2r
 bTApOFV2JL1_9uX2kB9B7lh1ZCgveOVcGqPkQJMPN26rIIg0fTFNQ2woii4aYvpTF.S0ewmYx5ip
 .xJkoSbDRe_rREI0SOR5qHwFLou9ndVSvqVBTdg7F17a5ZuwQHt_CdnZg2.9knY6aITs.IPTT.Vt
 X72s88j5gGGedSECzMwAziyj4Mpub9Idq3tGI7I2akdS3ZqTet0skwzifu9kjddEPKgcQqNDeXNR
 Q58kkoCoHGx.noqUuOdDHiwc.damom4Ui1QUEu2PcLxL30SOnvX9NUpJDIP4hCwuzMjN_gCWTU15
 F
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.gq1.yahoo.com with HTTP; Mon, 3 Sep 2018 04:23:36 +0000
Received: from 112.65.61.168 (EHLO [192.168.43.103]) ([112.65.61.168])
          by smtp408.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID cb56ccf92d0556136042acfb97de4611;
          Mon, 03 Sep 2018 04:23:35 +0000 (UTC)
Subject: Re: [PATCH 2/6] staging: erofs: formatting fix to NULL comparison
To:     Chao Yu <yuchao0@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Pavel Zemlyanoy <zemlyanoy@ispras.ru>,
        ldv-project@linuxtesting.org, devel@driverdev.osuosl.org,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1535642042-5336-1-git-send-email-zemlyanoy@ispras.ru>
 <1535642042-5336-2-git-send-email-zemlyanoy@ispras.ru>
 <747d9c74-02cd-fa39-9870-ae17dbddf366@aol.com>
 <44d6e603-fe1d-6853-c474-760c0a2ed4ec@aol.com>
 <47c7d469-c807-760d-7e28-ae8108a46af5@huawei.com>
 <20180831094106.sxwsd5v2mmn3cux6@mwanda>
 <9172e7b7-ff42-85ca-f546-a369b8698d27@huawei.com>
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <83ebc210-63cf-993c-4204-6860edf205f5@aol.com>
Date:   Mon, 3 Sep 2018 12:23:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9172e7b7-ff42-85ca-f546-a369b8698d27@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018/9/3 9:59, Chao Yu wrote:
> On 2018/8/31 17:41, Dan Carpenter wrote:
>> On Fri, Aug 31, 2018 at 11:29:03AM +0800, Chao Yu wrote:
>>>
>>> Hi Xiang,
>>>
>>> I'm not against this change which follows checkpatch's rule, since I think this
>>> can help to unify coding style in different modules of Linux. Maybe cleanup in
>>> other filesystem is needed as well.
>>>
>>
>> That code is old, and those filesystems are not in staging so we're not
>> going to change them.
> 
> Yup, anyway, it can be decided by their maintainer if they want the cleanup.
> 
>>
>> Let's just apply the patch and not spend any time thinking about it.
>> Part of the point of style guidelines is so that we don't have to
>> repeat all these discussions over and over...
>>
>> Btw, I have a rename_rev.pl patch for reviewing these.  I've attached
>> it.  rename_rev.pl -r NULL.  I've seen some people screw up the
>> conversion so having an automated review is nice.
> 
> Cool, thanks very much for providing this tools, it actually can help to save
> some time during review. :)
> 

I am traveling in Tibet. Sorry for the late response.

OK, that is fine. I will follow the new kernel coding style strictly
for the upcoming code.

Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>

Thanks,
Gao Xiang

>>
>> regards,
>> dan carpenter
>>
> 
