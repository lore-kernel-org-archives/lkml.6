Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8EBC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B502082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HU+ne1BX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B502082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbeJ3C5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:57:16 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33094 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbeJ3C5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:57:16 -0400
Received: by mail-lj1-f194.google.com with SMTP id z21-v6so8762020ljz.0;
        Mon, 29 Oct 2018 11:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pR8/LuDExk9lZ2Q4gxSaTG3u4O1iTDqahE/PFUWPLp4=;
        b=HU+ne1BXKQKDeJ7KlXZjyjFG5HSyJYT3LMPsGopzs7wmO+5HWkI2BeJFJM1mepCFkq
         0bl6Z1hCPV5kixtK1DSpysHT9QEiUPzSFs52M/Nm0m9TqMSv9SnmZLRr5cvRwahtAEXE
         UMkWySvQ0t4WrKwHEeNTTF2FB5s6Wj7KyuzC8MB4axxpat18d3plGuROqqjsPHI6MrEm
         ZYop28DmO75qWecyql80IJDSuCAusWEJ0JQWYWs95t6QnviCKvdM1TuPqH4q+uvckRbq
         xYkAHE3hBvseGjV10lA2tj56Iir1QxiySL5jnZuNi3JYwDmfUfOliJQTlc7GXTzRKLDz
         R7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pR8/LuDExk9lZ2Q4gxSaTG3u4O1iTDqahE/PFUWPLp4=;
        b=VwtAwkWmBlevGE96AMY/5CHqs5tI8MtI6Yps59AXYgcUAWXw38WPO0uDo960Fwrcf4
         B0ZY8FjgcYCBMx6dXzXDfBhGFzvGTSiJOHOmwaMy58NxCSiQCCtvjKzyMZLk9e2HoImU
         sRRWmh+p51jDbDoNPA03vo37l3GQGJ0Amu7fU57ThvCg4owBbWzU4FrE9bMF79FMZSvt
         bOtMurbrv1s8jpK1ef6mSJ2nlB3m/wiCT6LBMvqn1IRWReeUniM3svhFwalruY0dv0Gv
         AZwztztVfGRH73gXeCN0qs4YC44BS1RzunW4WYBidWeb+sZPIR/2tIZ7sAj//rTvBtHx
         8qFw==
X-Gm-Message-State: AGRZ1gJ3fgPVHPAJ0dkZIljXat+PAeE8CyHCQxz3VgCX+q1Qqu3q10kt
        6CAulNZCYh+In1+ID/37XqsXdFD0irj/Yw==
X-Google-Smtp-Source: AJdET5cjCMtIIWyH960cKXiJ+KhL5HHd2z4p7RNvWsTSbIIV5oG+Gc2A0wIcDNubx1SVsvi1tblFFQ==
X-Received: by 2002:a2e:9e10:: with SMTP id e16-v6mr10080880ljk.169.1540836450960;
        Mon, 29 Oct 2018 11:07:30 -0700 (PDT)
Received: from ?IPv6:2001:14bb:52:7be:f0bf:dd2d:f008:5213? (dmkd798g-7z2-yccwcp-4.rev.dnainternet.fi. [2001:14bb:52:7be:f0bf:dd2d:f008:5213])
        by smtp.gmail.com with ESMTPSA id y127-v6sm3221546lfc.13.2018.10.29.11.07.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 11:07:30 -0700 (PDT)
Subject: Re: [PATCH 03/17] prmem: vmalloc support for dynamic allocation
To:     Dave Hansen <dave.hansen@intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     igor.stoppa@huawei.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Joe Perches <joe@perches.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-4-igor.stoppa@huawei.com>
 <489bf780-7dd2-2feb-8456-25ad5beeb3e4@intel.com>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <624caa9a-e591-a1f4-40d1-49db10a91f03@gmail.com>
Date:   Mon, 29 Oct 2018 20:07:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <489bf780-7dd2-2feb-8456-25ad5beeb3e4@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/10/2018 01:26, Dave Hansen wrote:
> On 10/23/18 2:34 PM, Igor Stoppa wrote:
>> +#define VM_PMALLOC		0x00000100	/* pmalloc area - see docs */
>> +#define VM_PMALLOC_WR		0x00000200	/* pmalloc write rare area */
>> +#define VM_PMALLOC_PROTECTED	0x00000400	/* pmalloc protected area */
> 
> Please introduce things as you use them.  It's impossible to review a
> patch that just says "see docs" that doesn't contain any docs. :)

Yes, otoh it's a big pain in the neck to keep the docs split into 
smaller patches interleaved with the code, at least while the code is 
still in a flux.

And since the docs refer to the sources, for the automated documentation 
of the API, I cannot just put the documentation at the beginning of the 
patchset.

Can I keep the docs as they are, for now, till the code is more stable?

--
igor

