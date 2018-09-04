Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE8BC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 22:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3483820652
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 22:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8x9CywM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3483820652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbeIEDTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 23:19:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45625 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbeIEDTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 23:19:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id x26-v6so2362169pge.12;
        Tue, 04 Sep 2018 15:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cQtL0TZ/z+3OgnLTRn1lomuMzjdbFwkFDkYkQhoNOpQ=;
        b=R8x9CywMttGRxU1wr2LuiCLbk8alN76qkFxgudzT6y3texI7FR6EUduzJfC0tAHCoD
         zTMJVcAxB6Axulkcl48D/XM9MgODw7habFe+RX8gNaLTMCNp2PEGRqhM9vQP4Bhvztgj
         bWAHjt1jHkJBVz0fGWQWgv4NCdquspeVsX80ZS1TUhwmjXnFyLVL/iEb20zAU1m7zv+Y
         EIYicSXDp7HMagDEqV4aLrc5YKWMu7GLsDVvSQJK2NS4SXOKi3ZKL04H3fxS0QvlBbnT
         eV4hg4H+zW1OycYodPEw+a5cwYk7MLRB2ckqfLTNwpniW93UBYPicm6l+HwiqhREpl/s
         CnLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cQtL0TZ/z+3OgnLTRn1lomuMzjdbFwkFDkYkQhoNOpQ=;
        b=KPtun1Y70VeScbjs0jMoe0JpWKF8jwtdoE4FYXk0n45kat7SD2bQP1+JY7W54j4zLK
         EkulBV1nYY+CJ9cBc4D3csqpEeQIFgy3+roHJ3bsnrdd/FCkCgEWI1owXPeimPUW6PxQ
         aossrh0BVELfDfWFRBGV3VxXUTnowRYE2XtjeAPbfT/xsSFy93yEIbMzDrNRUl7CHi+Z
         Q4bQSapNd9JQ0ieneSO1UnlQNL0zm+AucokNyNELCgBzzeETI2/bWxy6rSVAltmI8xbS
         MOfWn9Sbl6XT6ynAMQGixWt8NgS4h+Qizs6N7AoqnmLL1c7PmHO9k39lPc5zwU32rv9S
         Ibpg==
X-Gm-Message-State: APzg51D60dAb6FFjvHh2huIWDLV+VPtGdo8vLxAuAMNPeqLS3EvIti/s
        DXo5U86umglmZ3z+2jX5AZwpMULJ
X-Google-Smtp-Source: ANB0VdbI5mJDFbc6Xgipne40mSa/nR9Aoueaoklge5sQZbr9kCtTa2uzKvWZzXXSUTVIQE+Fh4hKXA==
X-Received: by 2002:a63:4702:: with SMTP id u2-v6mr32440970pga.95.1536101516595;
        Tue, 04 Sep 2018 15:51:56 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id r87-v6sm121769pfb.1.2018.09.04.15.51.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 15:51:56 -0700 (PDT)
Subject: Re: [PATCH 4.9 000/107] 4.9.125-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180903165637.293735109@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <b9ee8556-7b4d-0fce-ed4b-490c004d5169@roeck-us.net>
Date:   Tue, 4 Sep 2018 15:51:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180903165637.293735109@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2018 09:55 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.125 release.
> There are 107 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Sep  5 16:56:13 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 150 pass: 150 fail: 0
Qemu test results:
	total: 301 pass: 301 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
