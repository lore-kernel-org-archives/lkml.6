Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DD6C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 16:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A31120C0E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 16:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="hdh3qHpO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A31120C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbeHRTeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 15:34:05 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:39302 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeHRTeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 15:34:05 -0400
Received: by mail-lj1-f172.google.com with SMTP id l15-v6so8598649lji.6
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 09:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b+P7ze9ynbVeG4tVF+tLdGaa8sopq5g35tFKBv0scn0=;
        b=hdh3qHpO7HviNu50RatVJfkKNtmehbpBSH3aOatLf26A2fkMrOfPl3XtgvnWMj1Y7Y
         BtTF3Czg7Iiu/hWdthey1jx1fn2fOUGPWkaJGbqYcdmTdmiM9TdZjla7MPzWNx/fCE4Y
         uaHOJJfIaSYv7hcl3tQvfluST9oyWgXiRzoG6znutJY1pBDq/gqIIn6kzFfo+q8hTEcI
         OmShZcgrlbnJJfN7KkLhFew9dZL8B3q99s21jY021bjpHER51gWLzUDO46bWTTMcfINc
         bEYBd1YMW+dEQYLb/oH8cCoTxux9kErl9cMBKcsJRDwKVVEgjrc60k1AQvPnTv+1H6bx
         T84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=b+P7ze9ynbVeG4tVF+tLdGaa8sopq5g35tFKBv0scn0=;
        b=P3VTDRIe5RCOP6nViwS4NTPHVPzArMlWlF3xOjHXEaamEmMSpfXYpNhI94UKbZAOgz
         bguhQAr8H/TbOBTxRyCRm7Mv+5lFJKgMX4mSf1rNshqBOxSX0FRD7tppFgQfgydaqTJy
         r9vOURKP71+lkCbgSzA7sv3qoxkaNS78yKiQipLDqBT4zrGMNs+QhlPvvkXmk69LbsSB
         HdtuwVbmzodpiPMXHHiYJTQC7TsAAesV06QViHBbwK4x2xzBBJFexjXcTKcFA881O4HT
         CRmeCT+ekoxWxoaF9XKhTyqNvc1QLWm111Frv08USS4+ZcCDFJOd34PpxLiHmuBuJHlO
         MK7g==
X-Gm-Message-State: AOUpUlHuFMQorOuMHMdw+69HE/F3/ML3nV1z684VmTQldf1Qsx9MZFRO
        XCI7Gw3bwEGlC5Lf18cyNpMtf61MigM=
X-Google-Smtp-Source: AA+uWPz+EcV1LaGDjkmkege9uWBUVLikHJohN4W4IkUUhottwOxbl9oRhuvxkZPL5Tdecq/5VM972A==
X-Received: by 2002:a2e:557:: with SMTP id 84-v6mr28809929ljf.152.1534609547740;
        Sat, 18 Aug 2018 09:25:47 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.86.12])
        by smtp.gmail.com with ESMTPSA id w25-v6sm749181lfk.5.2018.08.18.09.25.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Aug 2018 09:25:46 -0700 (PDT)
Subject: Re: [PATCHv2] ide: Use NULL to compare with pointer-typed value
 rather than 0
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To:     zhong jiang <zhongjiang@huawei.com>, davem@davemloft.net
Cc:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1534572961-16423-1-git-send-email-zhongjiang@huawei.com>
 <8badfdf8-ce69-1722-a489-fee161a1f4aa@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <1e17b3d3-4e5a-7318-e6f6-c8da311e26c8@cogentembedded.com>
Date:   Sat, 18 Aug 2018 19:25:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <8badfdf8-ce69-1722-a489-fee161a1f4aa@cogentembedded.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/18/2018 06:53 PM, Sergei Shtylyov wrote:

>> We should use NULL to compare with pointer-typed value rather than
>> 0. The issue is detected with the help of Coccinelle.
> 
>    Your description stopped to match the patch in v2.

  And your subject as well...

>    Actually, this X ==  NULL to !x preference is largely spocific to netdev...

   Specific, of course. :-)

> Although, IDE maintainer is the same now person. :-)  

  "The same person now" I wanted to type. :-)

>  
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
[...]

MBR, Sergei
