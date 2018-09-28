Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137BEC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C1920671
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3yetvsX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C1920671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbeI2EjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:39:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36109 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbeI2EjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:39:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id l10-v6so7857325wrp.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 15:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sg516m4dbymHNg8RVNuut2Y+rwmFzvZI6nvToz1ph10=;
        b=g3yetvsXaQj/lhU6Iz82dpnyP6zQJEg2QkbN3oWiu0QC1xOW5fRFmUYEl4dkJ1xQqB
         7RkCqmiAdsQMXfeVvZf7HT7iJKEEd37H1wqZMemBClOEX+9l8B+DrN7XS1a9kbMqdJ8n
         dDwvRJo4E7iBkRn5tMoO8m2uPzrissTMUu8WPPrb1llmUiyr6Ec1SLcXMWUCv00uZiC7
         pTKPn9cHipbfsRvk4rz84QLwl2DddK8woNl/doqPiwqNuBfsdjjMGTEHAvl5SbV398BO
         +jK78QRehN0WuRSpwWTTaqXZkWBAb9pdfsSDHvWtj/+8T0fcseO950bQD/yytXxxh5zB
         HlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sg516m4dbymHNg8RVNuut2Y+rwmFzvZI6nvToz1ph10=;
        b=FtP3whVCcPB2/H/x1C2MPPIGEKZf3KORNHGrHZFsqKSLftFPbPfJEkFSqxan4Fw3XR
         irWsI13n6DpYwduP+h26Xok1ceAjpGchb6Je3YL4hPNai10lt53USYgrlvijMPMhE/tx
         ypbDNtgRuotmiGbwWOmuABpHX1JBQMk3nc2ZXMGCke2gYt46UG4nqIQSsy2Q9pDL8YmW
         /qKdzqobktJQPidLQ/lh7VwC0UpJhiWOWD2abFAri/N4uCsFCk68ukGOVadLe16wQpjq
         pf1YETrBNFIPYC70xkg8ShUrfbn862kY4fqUwonT6e+qi5u4xdC3ZteK9s38LGLMyDQh
         yvew==
X-Gm-Message-State: ABuFfoih2tMogThpR2tSmiup7cZnzGCBiY5fsPVDPmFB6gBLpvLKYCcw
        Due0BXzwCMNfvW23VbInHBk67zEYiOI=
X-Google-Smtp-Source: ACcGV61yVZ8yyau0lRcnR9slheUlnPyf869grRtlBeb+lFkctgjXenQxYUhh2j1v0rgMrQK/SO1STg==
X-Received: by 2002:adf:e752:: with SMTP id c18-v6mr372378wrn.143.1538172806068;
        Fri, 28 Sep 2018 15:13:26 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bc0:ba00:74d6:1665:45bd:df46? (p200300EA8BC0BA0074D6166545BDDF46.dip0.t-ipconnect.de. [2003:ea:8bc0:ba00:74d6:1665:45bd:df46])
        by smtp.googlemail.com with ESMTPSA id l8-v6sm6900760wrs.63.2018.09.28.15.13.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 15:13:25 -0700 (PDT)
Subject: Re: R8169: Network lockups in 4.18.{8,9,10} (and 4.19 dev)
To:     Chris Clayton <chris2553@googlemail.com>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Azat Khuzhin <a3at.mail@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <54d8d7e9-a80d-dc2b-5628-22f9dc14e2ee@maciej.szmigiero.name>
 <535f42c7-6c3b-8e5a-49de-5dc975879b21@googlemail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <98680351-5123-761f-982a-726098da9716@gmail.com>
Date:   Sat, 29 Sep 2018 00:13:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <535f42c7-6c3b-8e5a-49de-5dc975879b21@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.09.2018 00:00, Chris Clayton wrote:
> Thanks Maciej.
> 
> On 28/09/2018 16:54, Maciej S. Szmigiero wrote:
>> Hi,
>>
>>> Hi,
>>>
>>> I upgraded my kernel to 4.18.10 recently and have since been experiencing network problems after resuming from a
>>> suspend to RAM or disk. I previously had 4.18.6 and that was OK.
>>>
>>> The pattern of the problem is that when I first boot, the network is fine. But, after resume from suspend I find that
>>> the time taken for a ping of one of my ISP's nameservers increases from 14-15ms to more than 1000ms. Moreover, when I
>>> open a browser (chromium or firefox), it fails to retrieve my home page (https://www.google.co.uk) and pings of the
>>> nameserver fail with the message "Destination Host Unreachable". Often, I can revive the network by stopping it with
>>> /sbin/if(down,up} but sometimes it is necessary to also remove the r8169 module and load it again.
>>
>> Please have a look at the following thread:
>> https://lkml.org/lkml/2018/9/25/1118
>>
> 
> I applied your patch for the 4.18 stable kernels to 4.18.10, but the problem is not solved by it. Similarly, I applied
> Heiner's patch to the 4.19, but again the problem is not solved.
> 
I think we talk about two different issues here. The one the fix is for has no link to suspend/resume.

Chris, the lspci output doesn't provide enough detail to determine the exact chip version.
Can you provide the dmesg part with the XID?
According to your lspci output neither MSI nor MSI-X is active.
Do you have to use nomsi for whatever reason?

Heiner

>> Maciej
>>
> Chris
> 

