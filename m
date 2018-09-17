Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A82ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 10:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB7F21508
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 10:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MjZ0rv7R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FB7F21508
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeIQQFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 12:05:02 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51197 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbeIQQFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 12:05:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id s12-v6so8971744wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 03:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZPGMLI2qTVvw/Oi7gQAUjb67cNca3UheEryMKIJwUqk=;
        b=MjZ0rv7RrL8rClScn4ON564sxVjh5TMWg2anX0BAr2HEUMFrB2/LBdbEYic5oTb94i
         qXt9O1eIrQogGDNeN/DR/A5J1Loicu5DtmWsfnJnW9WmSgXRvQt6I7zg7pYSuEFI2bZY
         JQS3dEOCw5WriyRvGVK3ELb+aJuK6ci8RRVWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZPGMLI2qTVvw/Oi7gQAUjb67cNca3UheEryMKIJwUqk=;
        b=o/V2ZjFUIdcKLteirSqoWRLF7v8cHg6Al10HpKWvjaEdJDoYTceAOJFWiNi4H1GlXP
         DOjdH92WD2YlQtN40/F2C9rMiYaBnK1l5jGaw8cL6BvAIXBqXbetmQN6+Nr0E4FDjiRl
         FCx43BD4oRBUbviAZNa8yoGNMPV8eePftcHfz7CE+GRWfU974rnkdxDbscIIy+Jzt2BS
         4ocHZjA/mSatXHmgViuXSaF17utnbqlOWzXsTz4ahJe45SQ6qrUIyjYuvaQBEnPMOg6E
         OGol+zMRc5rC0WHy//SM6eVIUCh3dGNJXsR8hEGaupSDfSz9ggDs7VZeproQNoMads/4
         z7Uw==
X-Gm-Message-State: APzg51AeERb5B2ATXfI8KhcmL68jWs9PGm647igBv4zbeRS4kodzWNcm
        EaLJbReDpkdDzkUy5B5yaBtprJ/dg6jNAA==
X-Google-Smtp-Source: ANB0VdbgK2eHe90NOsWkrJcGy09B0y/Zf/QjJzrDpd6r0cCBzAXBw6K6RG+CJWwWeN0RfVoe1m4KPg==
X-Received: by 2002:a1c:a90:: with SMTP id 138-v6mr10259664wmk.98.1537180691782;
        Mon, 17 Sep 2018 03:38:11 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id p89-v6sm34343880wrc.97.2018.09.17.03.38.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 03:38:10 -0700 (PDT)
Subject: Re: [PATCH] interconnect: Fix a GCC compiler warning
To:     Greg KH <gregkh@linuxfoundation.org>,
        zhong jiang <zhongjiang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <1537108310-2086-1-git-send-email-zhongjiang@huawei.com>
 <5B9F6B8B.7020100@huawei.com> <20180917085954.GA23740@kroah.com>
 <5B9F7196.1070203@huawei.com> <20180917092429.GB25662@kroah.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <8c15512f-47f4-7895-c567-3241177077fb@linaro.org>
Date:   Mon, 17 Sep 2018 03:38:06 -0700
MIME-Version: 1.0
In-Reply-To: <20180917092429.GB25662@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhong and Greg,

On 09/17/2018 02:24 AM, Greg KH wrote:
> On Mon, Sep 17, 2018 at 05:19:18PM +0800, zhong jiang wrote:
>> On 2018/9/17 16:59, Greg KH wrote:
>>> On Mon, Sep 17, 2018 at 04:53:31PM +0800, zhong jiang wrote:
>>>> +to Greg and Andrew.
>>>>
>>>> On 2018/9/16 22:31, zhong jiang wrote:
>>>>> Fix the following compile warning:
>>>>>
>>>>> drivers/interconnect/core.c:26:23: warning: 'icc_debugfs_dir' defined but not used [-Wunused-variable]
>>>>>  static struct dentry *icc_debugfs_dir;
>>>>>
>>>>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>>>>> ---
>>>>>  drivers/interconnect/core.c | 3 +++
>>> This file is not in a released tree, where are you seeing it?
>> I see it in linux-next.

Yes, it has been recently pulled into linux-next for wider testing
coverage. Thank you Zhong for reporting this.

> 
> Then please contact the owner of the branch where it came from.  They
> are the only ones that can handle such a patch, not anyone else.
> 
>>>>>  1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
>>>>> index 2740f1a..9ea9959 100644
>>>>> --- a/drivers/interconnect/core.c
>>>>> +++ b/drivers/interconnect/core.c
>>>>> @@ -23,7 +23,10 @@
>>>>>  static DEFINE_IDR(icc_idr);
>>>>>  static LIST_HEAD(icc_provider_list);
>>>>>  static DEFINE_MUTEX(icc_lock);
>>>>> +
>>>>> +#ifdef CONFIG_DEBUG_FS
>>>>>  static struct dentry *icc_debugfs_dir;
>>>>> +#endif
>>> Why not move the variable to where it is used?  It should be able to go
>>> under an existing #ifdef section, right?
>> Because the variable need to be used in __init and __exit.  So it should be identified as
>> a gloabl variable.  I fix it under the #ifdef condition.
> 
> If the variable is being used this way, then the code is written
> incorrectly, such an #ifdef should not be needed for any debugfs
> calls/variables.

Thanks for the comments. Will improve it.

BR,
Georgi
