Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC4BC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD4572064D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="n+/FpwDe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4572064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731746AbeGZQb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 12:31:27 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33297 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729801AbeGZQb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 12:31:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id r5-v6so1368478pgv.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 08:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=YhHi/dVQWSm1RFv0JuicmB9BtQrPGV4rHFVPofAhMb0=;
        b=n+/FpwDeNyU+NKym7VPjZfPxaR4fFlSEW11XEteNsdfILN4t5Gu/r003e9M7TgBjnf
         yuEmeWEG89CQBIiho4bH1ZNhPcbD7wgMfbOIHSkem05VTSKNLVJfVbqHr/2Huj8LaKeV
         rrRBBXmZg3txosIM8PQWLmR0U7P9HMJvfZzvXTzPSlGg9TIyloZL1S/pnDbff9ycGEuz
         oyfJWKXdLrMC+aYoQ6OD7PDWj6XChyhQ4WOrmuD67v5MIjq89CjZGlH0HtPi0jtFmHnE
         Yp+aUDhQYzlKMwD0nUZhDfMtUaAVaCnmCsGuumF4uae0OPOwo0B6x5mfc4jtbJ2ypbyp
         U9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YhHi/dVQWSm1RFv0JuicmB9BtQrPGV4rHFVPofAhMb0=;
        b=arZLc+p4agjoB3DZPl0AegcMoewaphj3OC8ZIPOfbqNceMuEwvU32XgNSOAGAjV7Gg
         3C0sIMLHL3wEnQU/Z3RNd0i2qHZTb6eGV1FqLR0BmIK6tMWWxb2TydGMsTRQZSHG7fBA
         JTltNy0CzigP11aebS+qJmp6aMvOquMmY/amuru7Rzgmizv/R7yGuBNT3lEZajpZA7RS
         iGls/qEmutFvYxae7RwivzqeuYrRbCOxwYjyCz05Y5CNtbJIMu8kzmk/ag3lM8QBKUsJ
         cCikNG14coKeIWU8RjSH4X6m1uvJHhxrtu1t8uwBpSrtjN4qmZc09nRVYdpI+MDNENLx
         OUZg==
X-Gm-Message-State: AOUpUlETlfwmiFMTPm0hBYIjcGhGGBjGArrRz1uslPYS38jh5Zxm3H/R
        3gQykO/vUsdXv2A3lL8CLzvfJQ==
X-Google-Smtp-Source: AAOMgpdKnliykPFKWLKvw05Za0n5KQsi/of1hJT3MSNuNJ3Rgg90ZsteC2M1WcPkDdJdMZ5acHK7Ug==
X-Received: by 2002:a63:291:: with SMTP id 139-v6mr2343488pgc.365.1532618049586;
        Thu, 26 Jul 2018 08:14:09 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1611:8fc3:703d:7635:5997])
        by smtp.googlemail.com with ESMTPSA id b192-v6sm2934942pga.2.2018.07.26.08.14.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 08:14:09 -0700 (PDT)
Subject: Re: [PATCH] tracing: do not leak kernel addresses
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ingo Molnar <mingo@redhat.com>, kernel-team@android.com,
        stable@vger.kernel.org
References: <20180725202238.165314-1-salyzyn@android.com>
 <20180725210717.3b807191@vmware.local.home>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <11437c3e-5131-7190-c496-7b51eb7fcc2a@android.com>
Date:   Thu, 26 Jul 2018 08:14:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180725210717.3b807191@vmware.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/25/2018 06:07 PM, Steven Rostedt wrote:
> On Wed, 25 Jul 2018 13:22:36 -0700
> Mark Salyzyn <salyzyn@android.com> wrote:
>
>> From: Nick Desaulniers <ndesaulniers@google.com>
>>
>> Switch from 0x%lx to 0x%pK to print the kernel addresses.
>>
>> Fixes: CVE-2017-0630
> Wait!!!! This breaks perf and trace-cmd! They require this to be able
> to print various strings in trace events. This file is root read only,
> as the CVE says.
>
> NAK for this fix. Come up with something that doesn't break perf and
> trace-cmd. That will not be trivial, as the format is stored in the
> ring buffer with an address, then referenced directly. It also handles
> trace_printk() functions that simply point to the string format itself.
>
> A fix would require having a pointer be the same that is referenced
> inside the kernel as well as in this file. Maybe make the format string
> placed in a location that doesn't leak where the rest of the kernel
> exists?
>
> -- Steve
Thank you Steve, much appreciated feedback, I have asked the security 
developers to keep this in mind and come up with a correct fix.

The correct fix that meets your guidelines would _not_ be suitable for 
stable due to the invasiveness it sounds, only for the latest will such 
a rework make sense. As such, the fix proposed in this patch is the only 
one that meets the bar for stable patch simplicity, and merely(!) needs 
to state that if the fix is taken, perf and trace are broken.

Posting this patch publicly on the lists, that may never be applied, may 
be the limit of our responsibility for a fix to stable kernel releases, 
to be optionally applied by vendors concerned with this CVE criteria?

-- Mark
