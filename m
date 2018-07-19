Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63894ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 175A120673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhOvpB4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 175A120673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731752AbeGSOcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:32:20 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43281 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeGSOcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:32:20 -0400
Received: by mail-pl0-f68.google.com with SMTP id o7-v6so3687813plk.10;
        Thu, 19 Jul 2018 06:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RDr2lzy4kiimHrbYZrYxI4YENqdhNgJFV3K+CvPWvwk=;
        b=VhOvpB4S7L6Ss0HBlAUyDkdz191QfvdhhrpSC7fj2EcK9Gbts3nWjimDAvdRgRNKgR
         XT0sTS+PRnbD2fvMdTyzsCbTYBamHJOyXlko1Ox4z6A7MePsjZZm6ZlR+I7m81V+4i4f
         D/dvH4+b1MBOIUR+Zzj5KqSVpLFYSxNiwY0yzc/kLwIRmPqifCza70snaz6FSx18jLC0
         31uubRJjb9+SCEPkH8e1Z22P/khNdP1HX4A/MGZspvCS8Bi8RZ3ckhx72iSA0eSigQBc
         l7/HpSFHMYIcms3DkwkGGQnNC3PdxH7uouLrTtNtjZpwXdnvYGhyl6LLyKF1TqwT9j2k
         i1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RDr2lzy4kiimHrbYZrYxI4YENqdhNgJFV3K+CvPWvwk=;
        b=cRX+CuOr9zrD2xCEjcLCfmeys05Vo531TM2/si9QG2Z3Pcal3YFPi+iLpdNCQNf819
         lBXDBn2gVBp3jT5+Av7pqooNBLF7KLOyFy58WM1Do+QG0YyI45eJPinX5c1gy1AzmEwo
         HPFXcaimAsyi+er0DWCWUgEZXDkG21vUD1W2BCIv9xyMa2dq4LZS2m0N0C3EBR+LFiX9
         rPdXTtH+buF+rHF7aup/nyTP5VHVfh+6rZch2evTYla1cBwJoyFhkdVGmFHAwCioGzZZ
         e1RmTja9IJEfXS3zhQm84kv8YS2AbNwqNe5o8suXJJ4LUhbjrgD0vV4SBZWVXZKs3OCg
         9Nfg==
X-Gm-Message-State: AOUpUlEOj+jDrqWG6IcWTQlGCwNwzQr9RjYQBzlQNf8O1dUP2age/caI
        +/9vyQvQ7734Q2dazDWrU0RRggBX
X-Google-Smtp-Source: AAOMgpeT/MDAxAmCzT0T184WIrJZSoW5xfN9KtTDiEm0QGvji5BtBf2iJKd/MSjbkWta9wuiDK6/Ew==
X-Received: by 2002:a17:902:6b84:: with SMTP id p4-v6mr10228359plk.272.1532008144133;
        Thu, 19 Jul 2018 06:49:04 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id z20-v6sm13688269pfd.99.2018.07.19.06.49.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 06:49:03 -0700 (PDT)
Subject: Re: linux-next: build warning after merge of the net-next tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Lunn <andrew@lunn.ch>
References: <20180719120447.6e7ba23d@canb.auug.org.au>
 <cbc20089-6847-c0eb-5b5a-735245986be1@roeck-us.net>
 <20180719152940.0720e9c1@canb.auug.org.au>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <6dabf12b-e3db-dfe8-101c-02772039e21a@roeck-us.net>
Date:   Thu, 19 Jul 2018 06:49:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180719152940.0720e9c1@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/18/2018 10:29 PM, Stephen Rothwell wrote:
> Hi Guenter,
> 
> On Wed, 18 Jul 2018 20:52:56 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 07/18/2018 07:04 PM, Stephen Rothwell wrote:
>>>
>>> After merging the net-next tree, today's linux-next build (x86_64
>>> allmodconfig) produced this warning:
>>>
>>> *
>>> * Restart config...
>>> *
>>> ....
>>>
>>> This is output by my "make allmodconfig" and only started after merging
>>> the net-next tree today.  It has continued for further merges/builds.
>>>
>>> I suspect commit
>>>
>>>     1323061a018a ("net: phy: sfp: Add HWMON support for module sensors")
>>>
>>> which added an "imply" clause.
>>>    
>> I thought "imply" was better than "depends on HWMON || HWMON=n", but maybe
>> not. Is that a caveat when using "imply", and does it mean that "imply"
>> should better not be used ?
> 
> I don't know, sorry.  It was just my best guess from what I could see
> had changed.
> 
> I wonder if it makes a difference that I am doing my "make
> allmodconfig" on top of a previous "make allmodconfig" and some symbols
> are marked as "NEW" (though they are not symbols related to the changes
> that happened during the net-next tree merge)?
> 

I tried to reproduce the problem, but I don't see the message.

What I do see, though, is that "make allmodconfig" on a clean tree,
followed by "make menuconfig", results in configuration changes.
Specifically,

 > CONFIG_ARC_EMAC_CORE=m
 > CONFIG_ARC_EMAC=m
 > CONFIG_EMAC_ROCKCHIP=m

is removed by menuconfig, and a large number of "# ... is not set"
configuration lines are added. Weird and bad, since several of the
disabled configurations _should_ be enabled by "make allmodconfig",
and a large number of hwmon drivers are affected. Bisect does point
to "net: phy: sfp: Add HWMON support for module sensors", meaning
"imply hwmon" does have severe side effects and can not be used.

I'll try to find a fix.

Guenter
