Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BD5C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A4620827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvRpiVs2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A4620827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbeKHA22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:28:28 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35613 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbeKHA22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:28:28 -0500
Received: by mail-pf1-f196.google.com with SMTP id v9-v6so5500737pff.2;
        Wed, 07 Nov 2018 06:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yWpREYK2l3wwDZUw0wnv/+jhqdCA4YFRpIk44FmVWeY=;
        b=DvRpiVs2qLmj8ED0FattvUBafkC/6cPlaKucnxySA3z6BZG/TU/vV9BufmcRs04g7E
         y3aMNEvLBqCZzkyOttzBStnkRetz7Ac5SjQoU86Jom1A4onIrc1T4n1U73lSRdGsab/u
         zKv5IPNrz0PUefUvLvDAAaSgHuHgY8wfxbZQZzKiuYwybBVPRsFROc8r/hG1z4QNMkF7
         kRoaYvve6XNRm/edQBGlmwNkT1om2rKBmom0eXghg2xjPihRK42We+3NgUxWrjvaLTH7
         VN2jZV6jdxyoPQwjbOH9TJ6EdQBWZ9y3pIC+Q4oh31oIhKjogMfFkOnL7u3mJT0gggWm
         EDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yWpREYK2l3wwDZUw0wnv/+jhqdCA4YFRpIk44FmVWeY=;
        b=ekya5bTTiFCcFbhef2fBELAKOrropzp8NO2ZNCle6qlB4sys+FuBWi9756QIaOkHXL
         oovY9uzZFTxxwbhrT6CRzE1SlLHTXsY4EUhB1Vy1KDWUTZKTd+Pa0weHHKffan0+P6+O
         3YNnM2sHhyqMMVHq5a7uF5ck9h074t6TWJB1rZbH4q50FmWZiI0KFuMO6wEdLky1vxYF
         b94K0iBwc7MQ6N0C3cW1oCvYtyfTWJjA9UZQQNeUbNLyza7IewWGMgCMkPefjKrBwgqq
         g1btsTguv7wodJad7SyF25X3T9yrEJ/DsmItYLohXPQv1uTZD5rS6fT6ZxKqHo23xeYI
         3Wig==
X-Gm-Message-State: AGRZ1gJGGHN6BAhMS540bpl+x26ZFckQQMCGJVO9ueTEg9NkLtmHK5Hj
        nWhozJmYXN1c1fBXoJUdMlw=
X-Google-Smtp-Source: AJdET5eCaRUYk1ni2rDMktHUnbUsPD+fibFsGzfIEiuYjLLU/xfmIiEx69U0owBhATH/0MtbdQPxyQ==
X-Received: by 2002:a62:1b4f:: with SMTP id b76-v6mr552210pfb.96.1541602666079;
        Wed, 07 Nov 2018 06:57:46 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id u5-v6sm800456pgk.46.2018.11.07.06.57.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 06:57:45 -0800 (PST)
Subject: Re: [PATCH v6 03/18] of: overlay: add missing of_node_get() in
 __of_attach_node_sysfs
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
References: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
 <1541431515-25197-4-git-send-email-frowand.list@gmail.com>
 <87pnvhqe3k.fsf@concordia.ellerman.id.au>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <2b742254-3b54-d862-5126-95ae7d5056f9@gmail.com>
Date:   Wed, 7 Nov 2018 06:57:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <87pnvhqe3k.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/18 4:14 AM, Michael Ellerman wrote:
> frowand.list@gmail.com writes:
> 
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> There is a matching of_node_put() in __of_detach_node_sysfs()
>>
>> Remove misleading comment from function header comment for
>> of_detach_node().
>>
>> This patch may result in memory leaks from code that directly calls
>> the dynamic node add and delete functions directly instead of
>> using changesets.
>>
>> Tested-by: Alan Tull <atull@kernel.org>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> 
> This seems sensible to me. I guess we could argue about whether the
> sysfs code needs its own reference, but it certainly doesn't hurt that
> it does, as long as it's handled symmetrically - which it is now.
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
> 
>> ---
>>
>> This patch should result in powerpc systems that dynamically
>> allocate a node, then later deallocate the node to have a
>> memory leak when the node is deallocated.
>>
>> The next patch in the series will fix the leak.
> 
> I think this should go in the changelog, it's useful information that we
> don't want to lose track of once this is applied.

Will do.

-Frank

> 
> Either that or we actually squash the two patches together when applying
> to avoid the bisection break.
> 
> cheers
> 
>>  drivers/of/dynamic.c | 3 ---
>>  drivers/of/kobj.c    | 4 +++-
>>  2 files changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
>> index 12c3f9a15e94..146681540487 100644
>> --- a/drivers/of/dynamic.c
>> +++ b/drivers/of/dynamic.c
>> @@ -272,9 +272,6 @@ void __of_detach_node(struct device_node *np)
>>  
>>  /**
>>   * of_detach_node() - "Unplug" a node from the device tree.
>> - *
>> - * The caller must hold a reference to the node.  The memory associated with
>> - * the node is not freed until its refcount goes to zero.
>>   */
>>  int of_detach_node(struct device_node *np)
>>  {
>> diff --git a/drivers/of/kobj.c b/drivers/of/kobj.c
>> index 7a0a18980b98..c72eef988041 100644
>> --- a/drivers/of/kobj.c
>> +++ b/drivers/of/kobj.c
>> @@ -133,6 +133,9 @@ int __of_attach_node_sysfs(struct device_node *np)
>>  	}
>>  	if (!name)
>>  		return -ENOMEM;
>> +
>> +	of_node_get(np);
>> +
>>  	rc = kobject_add(&np->kobj, parent, "%s", name);
>>  	kfree(name);
>>  	if (rc)
>> @@ -159,6 +162,5 @@ void __of_detach_node_sysfs(struct device_node *np)
>>  		kobject_del(&np->kobj);
>>  	}
>>  
>> -	/* finally remove the kobj_init ref */
>>  	of_node_put(np);
>>  }
>> -- 
>> Frank Rowand <frank.rowand@sony.com>
> 

