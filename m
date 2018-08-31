Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3CBC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 00:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F8720839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 00:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3CTr0UY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8F8720839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbeHaEy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 00:54:59 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36248 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbeHaEy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 00:54:59 -0400
Received: by mail-oi0-f68.google.com with SMTP id r69-v6so18846619oie.3;
        Thu, 30 Aug 2018 17:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:reply-to:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ky4ozylIXHPDa3p8r9mPn98rUxLwfXYc9aSEfZIwzj4=;
        b=G3CTr0UYdPfkv9DsAR2lPQoacGYw8Dw0XiJdXI/8FwMdCXsSAG76BtMPGwMEezGEXY
         oJLtvSDp/pmm7G93BL8DarGk9alaV7LKyqyZkbq5/5w8RAbfiR7vluNp/0JdIMH+F4/o
         c2qyn64RBcCpOTBB0MFjvT9rY4VGXdSDLBdW7GgxDcHe7YaO5tW3F0LV1ZNrjTPPiD7i
         5ATlQcvGGiDJSKGNp0ZxHlSrZ+4vDDtKlJE8YFxlGC3x7l1cMvDviu6hvkGkM98EDr9I
         BfPw3/COFUB5OHcoBMUN/Av43XInzYcof6CDto8em/KhT30hC3eR6c8ASLW+udMzU3rM
         ESyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=ky4ozylIXHPDa3p8r9mPn98rUxLwfXYc9aSEfZIwzj4=;
        b=mitHu9GCJziacSH9OBoSF92uwMWeWJ2f0PapdI8RO/Uvu5HJKKjkTxSCtLm+vftelA
         Ao37oGlWbaOeLTZTGAVvyOjkRAKThE7ccdm6/HQY+u+wA4cr75eo/79ah/pXab7BVEMn
         RZrNh/GxvfpKRpntszbDjSz2/S3HX/mZsG3YO9yldDsIUu4xBGNZzh6UvSHvaObW9hrJ
         DdqLr3noLJWWal1WBy1bbF+82gNJV0dA3Ht4cj5iaDrUfrtXl2VHBho3AazLSwxs0Rf3
         dQAdd9gkXaS5VLGtr5prBycSWNsm4NxKWU4eg9PG1m8uEfGYSMEVJltY72gJ52n6J41k
         3WWw==
X-Gm-Message-State: APzg51BAt9mm7mIseDpkXku/cHKC4y9xFLWMfJz8Z+VfdnmOR7VR0bJF
        D25r97kvjW6UZH1Cx1QLeg==
X-Google-Smtp-Source: ANB0VdYqQ8/ghxdClTdvh35n8XDT0a117Ct4b+o7olZScWoLNg5talVGHajYVeNUd3Szi6//duxW7A==
X-Received: by 2002:aca:6b15:: with SMTP id g21-v6mr5205067oic.149.1535676609901;
        Thu, 30 Aug 2018 17:50:09 -0700 (PDT)
Received: from serve.minyard.net ([47.184.170.128])
        by smtp.gmail.com with ESMTPSA id a8-v6sm5474293oia.24.2018.08.30.17.50.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 17:50:08 -0700 (PDT)
Received: from [IPv6:2001:470:b8f6:1b:9498:12d2:b5d9:7f7b] (unknown [IPv6:2001:470:b8f6:1b:9498:12d2:b5d9:7f7b])
        by serve.minyard.net (Postfix) with ESMTPSA id BDB7E79A;
        Thu, 30 Aug 2018 19:50:07 -0500 (CDT)
Reply-To: minyard@acm.org
Subject: Re: linux-next: Signed-off-by missing for commit in the ipmi tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Corey Minyard <cminyard@mvista.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180831073725.2cf9081d@canb.auug.org.au>
From:   Corey Minyard <minyard@acm.org>
Message-ID: <b5bb57c8-52fa-180f-37a7-5f6a35fc0140@acm.org>
Date:   Thu, 30 Aug 2018 19:50:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180831073725.2cf9081d@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/2018 04:37 PM, Stephen Rothwell wrote:
> Hi Corey,
>
> Commit
>
>    6320fd2c65b5 ("ipmi: fix return value of ipmi_set_my_LUN")
>
> is missing a Signed-off-by from its committer.
>
Thanks, got it.

-corey

