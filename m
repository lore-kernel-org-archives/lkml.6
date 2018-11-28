Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD1CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 00:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1BD20645
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 00:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1/0wKui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D1BD20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbeK1LzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 06:55:11 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:34784 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeK1LzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 06:55:11 -0500
Received: by mail-oi1-f178.google.com with SMTP id h25so21152735oig.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 16:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:reply-to:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Skxk4zXGdhd3JlW+YRz39F+uF4dmgIQKdRjwCAIBuiA=;
        b=H1/0wKuiVAizA06iZ84nEkLbi+ZjsfoEww8+qCaVIN79lq7Dxat2cjw2t9tjBq8t/d
         ZjrVU6b8p3NjpivzyhjIisP3cg9jo08ihU1ti8rSuNLXP1f+xlx+gKEWW2rTUiJY7H1q
         OZB1wEHLVOjC1MN6yy5s7w7rRYnx2493PN5OjU5K+ddIja/ycvEKoJadkCl4+JthSEAK
         kXKMh+LJhjRdLgXDJQlgf6VCYkM8NbmdJNSGD1YtR5+I+yzMP2UPXQU+VAimDOb0lRAj
         e83oFOiHRZNnU2oJCWpR5++wemYGBsC1eVgN78Qi4VWYtjSvcz/JMdDyOLtrtL27l9tN
         Uk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=Skxk4zXGdhd3JlW+YRz39F+uF4dmgIQKdRjwCAIBuiA=;
        b=QZIqIqSOtQ68b5jHebU8ju2hZX2yZD29Qh6y1WvHXA9f6LebkrYL+oe0DBpYLrKGES
         3PrQfKC7hy52QQ13FSAbjCh9eHOQ2s4b21Fef63JPg3hU/e4yEgEzeMMgw5YFbRmX+Jh
         ThHhakLl9Vp6G+hVLTz0JTVW5gt2DxnaJjZihRc3UwrpCGAsWTxS+/7WGCvitooOBRKq
         HMeTQBoGQyieWpBz2KnBNJQ0ZnKpxyqHFIAQnfTLM7pCNaSXhDGS3tTNEkLIB6fMXhbq
         shBGligbxbAb6bxt2hIAtN8iS9qsV1q63DZEZCEYzI8vqPyhDrNRwb06WJlK1IBkUdfA
         eDkQ==
X-Gm-Message-State: AA+aEWaSodhvnfVlvmITdImrT0/PHkuaBpA1m3Fk9PFa3wGH2fF2ze/V
        Eg6fCU393ulYTEJgAAw+Ig==
X-Google-Smtp-Source: AFSGD/XxFm10XlLceCXOnFwRm1LaxrCaDZZ8IHbCt1tY/tB2oCFEBf3cB2kJjSi4nvSoimHPxrM0vw==
X-Received: by 2002:aca:db41:: with SMTP id s62mr4640131oig.349.1543366528114;
        Tue, 27 Nov 2018 16:55:28 -0800 (PST)
Received: from serve.minyard.net ([47.184.128.64])
        by smtp.gmail.com with ESMTPSA id g18sm3624797oic.9.2018.11.27.16.55.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 16:55:27 -0800 (PST)
Received: from [192.168.27.3] (t430m.minyard.net [192.168.27.3])
        by serve.minyard.net (Postfix) with ESMTPSA id 051703A3;
        Tue, 27 Nov 2018 18:55:26 -0600 (CST)
Reply-To: minyard@acm.org
Subject: Re: [Openipmi-developer] [PATCH] ipmi: kcs_bmc: handle
 devm_kasprintf() failure case
To:     "Wang, Haiyue" <haiyue.wang@linux.intel.com>,
        Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
References: <1542812905-27337-1-git-send-email-hofrat@osadl.org>
 <9320680f-679e-fc89-4349-17dbbd30bbfc@acm.org>
 <67962bdd-f7db-5a7d-e5d8-baaefd748ab5@linux.intel.com>
From:   Corey Minyard <minyard@acm.org>
Message-ID: <9f64f5dd-6689-e28d-3316-bf7feb83ba46@acm.org>
Date:   Tue, 27 Nov 2018 18:55:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <67962bdd-f7db-5a7d-e5d8-baaefd748ab5@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/18 6:54 PM, Wang, Haiyue wrote:
> [Resend for wrong reply HTML format mail]
>
> Great check for making kcs_bmc module be more stable and handle things 
> gracefully.
>
> My tag if needed.
>      Reviewed-by: Haiyue Wang<haiyue.wang@linux.intel.com>
>
Thanks for the review, it's included.

-corey


> 在 2018-11-27 21:36, Corey Minyard 写道:
>> On 11/21/18 9:08 AM, Nicholas Mc Guire wrote:
>>> devm_kasprintf() may return NULL if internal allocation failed so this
>>> assignment is not safe. Moved the error exit path and added the !NULL
>>> which then allows the devres manager to take care of cleanup.
>>
>>
>> Added the original author.  This looks correct to me, I've included 
>> it, but I would
>> like Haiyue to comment, if possible.
>>
>> Thanks,
>>
>> -corey
>>
>>
>>> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
>>> Fixes: cd2315d471f4 ("ipmi: kcs_bmc: don't change device name") 
>
>
> _______________________________________________
> Openipmi-developer mailing list
> Openipmi-developer@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openipmi-developer


