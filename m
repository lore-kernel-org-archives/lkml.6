Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D25AC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C211D2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="dKcVCec4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C211D2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389436AbeKGCQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 21:16:25 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32847 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389418AbeKGCQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 21:16:25 -0500
Received: by mail-pg1-f194.google.com with SMTP id q5-v6so6072247pgv.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 08:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=bQU53e3wvFihHKJi4h+ozpqI0TiL3gb/NhekbPw4mgo=;
        b=dKcVCec4Z5UKXaZKCK3hTbPzEW8Aecb2qP1pP0zeQ7Dp5Py9gfLF9E3pZG9WVVebfE
         9YvpHfnuCEhAJNOGUdi+yTXGkrSZgZ9KbM9DWFxTbgabn391GonKLosrFwLYo+07hdS5
         J5jFBKH92977eTeniZcgTTcFTSYMeDwt3wlkgCp6vzBktZasyOPGG7221CDcggIL+uuF
         Ppk2e30SwyjhpIzzKPf+NMacBgEO6JcXxQwngx2huAPjEavfP0tUioeAQvibD0X/wJvV
         IOvN7wl/luQD0SHxBI7FS6zUohu5HmaBWCBSEpQJ9fgcwBcAWIk8ozHoTOEuBn/M5yHa
         b8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bQU53e3wvFihHKJi4h+ozpqI0TiL3gb/NhekbPw4mgo=;
        b=emSzg4KqiO18Qhmlpg4StZRNpYlnwHuU24taO9PGRKs3x7LUC8BCAC111hgoIbTEEp
         RXr233IJ7IvrPUTWiqquieMp1gnXtGZ9tHnbHZqoL2w8UWccP4Q6zCys8nHYNdDY5bDQ
         +cLEC+ZMH/Qfi7TSp1l3IiH/RGVQj3Csi1u4WlyUb58yZrQfPzjj8m09VaBXdajQbHAn
         wxjCRjadg/QdXvSoBsd0oVnReeFTuT5rwGvRHECieBRsgWv7uIt0Mga+CJRdHGyiVGyM
         3beTxUAsPs/AyiOtboeoE2T3FN6byufmWM4bixFExi6XfrjY7nMnvO1ts81h0JEuwxj+
         8EqA==
X-Gm-Message-State: AGRZ1gKs3y4bUCh5BMN3ACeZIC0auMCVNkWUT0BfGzPya0B9qvtSlQwb
        YhH9u9Q/CGSF5CvEKFXHU+bIJaGlzK4=
X-Google-Smtp-Source: AJdET5ctw2BlLnjZhx89xm6+7dmbieuTTqOO3yqi4gLigihaABx2vDG0J3/X4zJjING34MOZMXeMRA==
X-Received: by 2002:a62:4e86:: with SMTP id c128-v6mr27182930pfb.101.1541523018951;
        Tue, 06 Nov 2018 08:50:18 -0800 (PST)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.googlemail.com with ESMTPSA id v189-v6sm58690753pfb.54.2018.11.06.08.50.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 08:50:18 -0800 (PST)
Subject: Re: [PATCH v6 2/2] overlayfs: override_creds=off option bypass
 creator_cred
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-doc@vger.kernel.org, kernel-team@android.com
References: <20181105182146.233025-1-salyzyn@android.com>
 <20181105182146.233025-3-salyzyn@android.com>
 <CAOQ4uxjK5UUr7gZ8fOV7A09c+fKG2EnYGhKwty9OXxfjsWSDAA@mail.gmail.com>
 <CAJfpeguesUtcSVsjkG1aT_bW03+HYpLrmP4w4Zo8MYiz1udrcQ@mail.gmail.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <8beaf21a-2242-3c60-4de7-76190b71842b@android.com>
Date:   Tue, 6 Nov 2018 08:50:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAJfpeguesUtcSVsjkG1aT_bW03+HYpLrmP4w4Zo8MYiz1udrcQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2018 12:39 AM, Miklos Szeredi wrote:
> On Mon, Nov 5, 2018 at 7:47 PM, Amir Goldstein <amir73il@gmail.com> wrote:
>> On Mon, Nov 5, 2018 at 8:22 PM Mark Salyzyn <salyzyn@android.com> wrote:
>>> @@ -1549,7 +1569,8 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
>>>                         ovl_dentry_lower(root_dentry), NULL);
>>>
>>>          sb->s_root = root_dentry;
>>> -
>>> +       if (!ofs->config.override_creds)
>>> +               pr_warn("overlayfs: override_creds=off, caller credentials may not be enough to delete file or directories, create nodes, or search directories.\n");
>> The audience is someone that has this feature on by mistake or someone
>> that turn it
>> on without understanding what it does. I am not sure that this is
>> scary enough, but
>> I don't have a better suggestion.
>> Will let others state their opinion.
> I don't think we need any warning message, writing down the rules in
> the documentation should be enough.
I would be pleased to remove them, but maybe more historical background 
is required in the documentation (see below [TL;DR])? I have been told 
to not talk rationalization, history, use cases; but only about side 
effects in the documentation.

Yes, the documentation (in the v7 patch set) cites this problem, so can 
remove this pr_warn in a v8 respin. Does anyone disagree? will respin by 
EOD if nothing said.

[TL;DR]

In 4.4 the default behaviour was effectively !override_creds since the 
mounter or creator MAC and DAC credentials wrapping the existing caller 
credentials had not yet been added until later. Except at that time the 
capabilities were temporarily elevated inside the overlayfs driver 
during the cited operations to (blindly) permit these few.

When the mounter's MAC and DAC credentials were added (later), security 
was greatly improved by not counting on the elevated DAC, but it broke 
the expected 4.4 user space API. So in 4.9 and higher Android will 
require this patch to restore the behaviour that supports 
non-overlapping MAC credentials. But we chose _not_ to re-add the 
(inadvisable) hard coded elevated credentials for these specific 
accesses thus requiring the caller to _have_ the DAC credentials to 
perform them.

- For those using the 4.4 way of doing things, these noted operations work.
- For those using the 4.9 way of doing things, the non-overlapping 
creator and caller MAC credentials broke.
- For latest, this patch brought back the support for non-overlapping 
MAC credentials, without the security issues of the 4.4 implementation, 
but alas breaks the 4.4 way of doing things as noted in this warning 
message.

-- Mark


