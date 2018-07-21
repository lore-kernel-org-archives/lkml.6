Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14057ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0ABF2086A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceBDcIjC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0ABF2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbeGUOdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 10:33:40 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35847 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbeGUOdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 10:33:40 -0400
Received: by mail-pg1-f194.google.com with SMTP id s7-v6so5638319pgv.3;
        Sat, 21 Jul 2018 06:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W7P6F1saFXTiwPxF2MUp+sZ09wADrLgcDZFTpfYgdd0=;
        b=ceBDcIjCmZ513CZmThuWyU98jzjRgH03HH1ChnqofwltlvxufdU77/bgCsTyHgXp69
         dacMZ4Nc/IX/F+R+443opzO73sdQFAWhC9xeZTYYSipNugKYqfBGCLixBs56hffEuGUk
         IcRV4gfGf13ddmPthqrSUlljdJbem38MYgWJE+ZkBInCequPr4z31T2ep7OfuwzfHDxG
         +c/P/JPk5vLF5W5MbCK3mmfcJbbYk9PC/+ZNm5Y351/lwlBncmY9tXxpauhPnN9E3XhU
         MMWFneVjNWPkiS8JqodRL6bUOK1ObTh+m6gASqjPeU+Tc+xx077E8xOmoIr7MvgGAB+i
         dFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W7P6F1saFXTiwPxF2MUp+sZ09wADrLgcDZFTpfYgdd0=;
        b=JTEQCgThJ/RRUSU/cMrbR2D//mF8YNWkMpgZNJiEA1NaerjtToyUe2K9gxlzfbcYu8
         kcQ4VhEwAHNWuZ2AmTdZPoDsWxaQGcrZN9tuODbJgZKEpkkUHlCfA4ywVDxo6Z/5DBOs
         Hf0w3LnHkPsYmxcl+V724wuyfp6FLigz0YHoj0x4xquGwBkmmchjGghMeJ3A9XqWs5GE
         nbjsIkakW4NqLrBEzoHsbdq3tCq75WYXMJucpq17/bjYptyf8745wDq53Di/2jP74+qd
         A/OG1xiGyKoN78kU9dKxOtZeVR9w89YOQf0TvRPH4wGY03jvMRPAfP8n8/+Gfo5XFLui
         C8LQ==
X-Gm-Message-State: AOUpUlH0ddsugXyAoiBbFPR7ajEyqeIYu8E8pHyo1VAG2BbBhKwFGwO6
        SdHz2E4gin5Wf4GlvRaEVLCytC2h
X-Google-Smtp-Source: AAOMgpdHSQ/BxZz3rxABjpTDYByIdnLkejmU5B40Sov8prXK6wL+a4Kl1eKZnhL0891dkwjhubiNuA==
X-Received: by 2002:a63:dd09:: with SMTP id t9-v6mr5766497pgg.370.1532180451118;
        Sat, 21 Jul 2018 06:40:51 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id n5-v6sm6085924pgr.24.2018.07.21.06.40.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 06:40:50 -0700 (PDT)
Subject: Re: [PATCH 4.9 00/66] 4.9.114-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180720121407.228772286@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <cad35061-2079-43bc-724e-a8e0e7fe5f93@roeck-us.net>
Date:   Sat, 21 Jul 2018 06:40:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180720121407.228772286@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/20/2018 05:13 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.114 release.
> There are 66 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Jul 22 12:13:47 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 148 pass: 148 fail: 0
Qemu test results:
	total: 166 pass: 166 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
