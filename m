Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9A8F8182E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A1021748
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 16:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="t9E0Eo8L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A1021748
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=aol.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbeIMV5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 17:57:16 -0400
Received: from sonic316-8.consmr.mail.gq1.yahoo.com ([98.137.69.32]:42705 "EHLO
        sonic316-8.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726970AbeIMV5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 17:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1536857217; bh=P6oRiqw+KKbs714dxslVuStB+Tym/3AkwSISdPpPNXA=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=t9E0Eo8LMQ3Eh0LvR2+G9XhhKrH3kgbDMnKXdy8VzfCDdcg7Bclmii+yTcWiGN91XLlS7eJuIThZMdJT9UcFGYC+X4uMjyQrxLZh5EjDpo+pNlTzlI0ZpVbFZEmoUzdwRZYThSDT4lY8OnxWQ/uSkEZwbg/ItIoziT8mC9H5xqtaLV6pk1VimIFQLYePyf3yXYjaG8B3XnWo/7MEVKKGhYD2mAPSoddLUh+5191RyVepOltp6smnFvsgggwKMckFZJpguRRLqOG7qmFuTNEZwrbha1s+jQ7Mfe+9SmXdNS0SoeyQ4uWVdpwnwcwHDJerRn7Z0n+KZnP5FSZCTO5c4g==
X-YMail-OSG: arDBBgQVM1lEPXG4bkh2gcmWzpXX75FoQENUzs_3YHp73AbIcw7LFbSX0xDZXBH
 qRNt4LcLO.IQFw3Pdr_wlxbKeTQfn6URLAX6ccpQkN.AmpMuX9ll1BErRtc4GCVdkyAlqMXTnZyI
 aonEfuIYOjWZbxAA2H6WRzpCDDWTL2rhXrulCAgEViD7QpL3Y5DkQWVNAv1ySYsgMTNUmH57Y2xN
 Q4TTe6ymTI7s1iwDSYdL6glJUtNX.sprfM5EOSFj4queJxdn1gurSMSzYjlg4CUoVCdFCi2gd2dI
 MSUv4AuGlAExETNnqfEQH.USREHnhyhn5NWNuh0PMSJSQOZvPihrV_u8LtdYM_i9ReYvlW6rLXkT
 CBL6OJ0wDlJMSCV99ozfQYokuQmYZg0kMWuxadbP84T96DLbRzpOUgqZRayghyyejh6olGRaBXrZ
 .Hj.cA0KXYH0XJwi6kCjCy_YcSTOIrhH6fPDEBt1AgEqsR1pG5tsRY778vIryfgTWfDFd7d4Ga7c
 9667QSKqvGUUDyeVabRxUoClll_bYrazxuBkD2CEQaVdjsAYRZsBTK3aUMgPUmeHvXR4U1lsVz57
 fAo059GfgFcLaaBwxSeiF5sAnhMHLy.SbmUeAh5mVTuQa9b6SyYiLOmZZ.GichxjUjeYMrAh7Zht
 aPXyZdVGva5Qoy_VpLPTYktP_HJMWakrLko4GXXIb_J6naXu8HQ3pVxK8hb.fYCi5_s3JNLz3Y58
 WT.PFu.xi5a7DokfqXmwgmB6uoe.r7VN1agVSGscQWbCE7QvxxC2VQap4.9VP8Ks.4shD9C1f4yG
 qM1UxqcZIH8Ko4pNOFeWWEWCOl_aAkejqSLRILNsHHPYjDp56MdzIcVLYDNr_b6dLYcRnybO2vcV
 dE7rYCUdGvRbeX2S4l4.I72Wgf3zgC1qk1iUkUYfAmQuf24vz_I2hHynf05FaYAGKDKthLIq7ihh
 BXkPnnPqUpxH9N_l_gyr08zt7jwExiGAkBH8Be89DpOW6dN7QIMo5XV8KQJRaN3n_4w--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Thu, 13 Sep 2018 16:46:57 +0000
Received: from 116.226.250.90 (EHLO [192.168.1.8]) ([116.226.250.90])
          by smtp418.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 2ca2e2eaf72606c4553db2091f3fa4be;
          Thu, 13 Sep 2018 16:46:52 +0000 (UTC)
Subject: Re: [PATCH v4] staging: erofs: use explicit unsigned int type
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>
Cc:     Gao Xiang <gaoxiang25@huawei.com>, devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chao Yu <yuchao0@huawei.com>, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <23218dc6-8aba-a4e6-7c18-64380082f747@kernel.org>
 <20180910194114.13314-1-linux@weissschuh.net>
 <94678bbe-4d9b-67a7-c3a4-b711fe32c432@huawei.com>
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <74596044-aceb-74e3-e70d-fe9a717e44c4@aol.com>
Date:   Fri, 14 Sep 2018 00:46:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <94678bbe-4d9b-67a7-c3a4-b711fe32c432@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

ping...

On 2018/9/12 14:21, Gao Xiang wrote:
> Hi Thomas,
> 
> On 2018/9/11 3:41, Thomas Weißschuh wrote:
>> Hi Chao,
>>
>> On Mon, 2018-09-10T23:59+0800, Chao Yu wrote:
>>> [...]
>>>>> I was not aware of this tree and worked off of staging / next.
>>>>> A patch is attached to this message that adds the tree to the MAINTAINERS file.
>>>> Hi Chao,
>>>>
>>>> I think this tree has some PREVIEW patches which preview in linux-erofs mailing list only and
>>>> doesn't send to staging mailing list and LKML,
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/log/?h=erofs
>>>>
>>>> so erofs tree is actually Greg's staging tree.
>>> Thomas,
>>>
>>> I confirmed that erofs git repository for linux upstream is Greg's staging tree.
>>>
>>> Let me explain, in order to avoid sending buggy or preview patch, Xiang and me
>>> plan to review patches in erofs mailing list first, and then cache reviewed
>>> patches in my git tree before sending them to Greg and staging mailing list.
>>>
>>> Based on that, I'm trying to serialize all erofs patches, expecting that can
>>> help those patches sent to staging mailing list can be merged by Greg with
>>> lesser conflict. But I made a mistake that my erofs branch has merged some
>>> pending patches, result in failing to merge yours, that mislead me to ask you to
>>> rebase the code, sorry about that.
>> Thank you for clearing this up! And I am sorry for causing you all this work
>> for what is essentially a very small style cleanup.
>>
>>> Now I can confirm that your v2 patch can apply on Greg's staging-next, so fixing
>>> warning reported by checkpatch.pl on your v2 patch is enough. :)
>> The patch follows.
>>
>> Thomas
> 
> Could you please resend your patch seperately? Because it will be easier for Greg to merge.
> 
>>
>>
>> Changes since v1:
>>
>> * Removed changes that conflicted with
>>   [PATCH 1/6] staging: erofs: formatting fix in unzip_vle_lz4.c
>> * Added patch description
>>
>> Changes since v2:
>>
>> * Fixed conflicts with other patchsets
>> * Don't introduce new style issues
>>
>> Changes since v3:
>>
>> * Fixed conflicts with other patchsets
>>
>> Note: This patchset should be applied with the "git am --scissors", to
>> remove the historic information and this note.
>>
>> -- >8 --
> 
> I personally think that is not the correct kernel patch style.
> 
> Just as Greg's said,
>> These changes belong below the --- line, not above it.
> 
> LINK: https://lists.ozlabs.org/pipermail/linux-erofs/2018-August/000367.html
> 
> For reference, it will help the patch quickly get merged. ;)
> 
> and you could add,
> Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
> 
> Thanks,
> Gao Xiang
> 

and HUAWEI email server cannot send my all emails to your mailbox successfully.
Since you change a lot of files,I need to rebase my rest preview patches one by one right now.

Could you please resend a acceptable independent final patch for Greg? :)

Thanks,
Gao Xiang

>>
>> Fix coding style issue "Prefer 'unsigned int' to bare use of 'unsigned'"
>> detected by checkpatch.pl.
>>
>> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> _______________________________________________
> devel mailing list
> devel@linuxdriverproject.org
> http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
> 
