Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6024CC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 22:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E641120652
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 22:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ah4hk7/Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E641120652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbeIEDUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 23:20:01 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38683 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeIEDUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 23:20:01 -0400
Received: by mail-pf1-f195.google.com with SMTP id x17-v6so2414635pfh.5;
        Tue, 04 Sep 2018 15:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mLztJCmhNuKM0h1UBBY9X1mVBq54lPx6f0lI4q7C7Jc=;
        b=ah4hk7/YlvopbGsY/Q3CGGWLKGo/vSuKRMdCnmnofAGcEsn/GkmNdPET67BVdlvwNA
         zYOPRUxWCS4+jC4DJ63yvn0B1tktR8mU5yqtTrgKA8fGgwkkq4GHZhnHP36IrpjDgFkq
         ZVvk3X6K5AQ3gZe4wmyDxiheGiQ6RGPJx85kVYgFk62ohEpw7X0ep+g9Cqx9asZS9T2v
         HM19NFuzXbhjecuC2nnKySrXJtCaTZl0ZK4ng+k1yldTDSCEcEOoKkVitDWhOtfaX89s
         K6Mw5etfntN0bfqBQNnI7Flk5ZitUSTvPuNlouAFR5VTSjEndm5CFIrOUaEJ+dcabt6S
         j/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mLztJCmhNuKM0h1UBBY9X1mVBq54lPx6f0lI4q7C7Jc=;
        b=E2jPVCMQDGZh59jjstS9GU3/vtc5tP1LxlBpY7gHNQxB0a0NNAsCDjiy+bcDQIQ2v9
         s6Y4apgI1cxtLDc94J99v/WQMQrsaVvul8CdL7WHCj3w0rxZ7dSscne/uTvcj/gHmtrR
         3kzagUpJ2Qqh0ssJhEGYfvF46RQ2MYRXx15Wtdrr6yESWSXLcO9g2XURsIr4tpeZUjXR
         lexnykq4ohMPdHcHrpHTWbcIIMrlcuV972vPpZLHA1GogHWZ6eaxvboO1lFDB0dT2tUz
         qxGwutZUR8vLK7gr4IRgKXAQ/OTFCwN97IWcPdOJdm3aSr3kNXfYF2s1/Y/9lGgfvG0L
         hreg==
X-Gm-Message-State: APzg51B/EQQjJxR5RXBNpE3Mu5LJtKUgFLVak+sa/mSpQFkxGPaJeTqE
        cMxfWKee2sUd8UO/fD5aOK82+4cF
X-Google-Smtp-Source: ANB0VdacA4oCjfhHrZ1ecWGp3O7bmAVrxet5k9hl1z+k7TyK3ci/+rQjLZMbT9oEVQwIH9rLOI7uDQ==
X-Received: by 2002:a63:e516:: with SMTP id r22-v6mr33709725pgh.170.1536101565784;
        Tue, 04 Sep 2018 15:52:45 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id z17-v6sm70226pfl.146.2018.09.04.15.52.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 15:52:45 -0700 (PDT)
Subject: Re: [PATCH 4.14 000/165] 4.14.68-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180903165655.003605184@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <424cbc57-f7ec-a8fa-dda7-db540a93d7e4@roeck-us.net>
Date:   Tue, 4 Sep 2018 15:52:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2018 09:54 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.68 release.
> There are 165 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Sep  5 16:56:19 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 150 pass: 150 fail: 0
Qemu test results:
	total: 311 pass: 311 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
