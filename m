Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834FAC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 14:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C7ED2082E
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 14:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyQbm8gF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C7ED2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbeKCXoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 19:44:01 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40927 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728530AbeKCXoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 19:44:01 -0400
Received: by mail-pf1-f193.google.com with SMTP id g21-v6so2339518pfi.7;
        Sat, 03 Nov 2018 07:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aqEzDn6cwAFS/6JfXX7+Dv0ECEk/Tx7u85UebjBkmlg=;
        b=IyQbm8gFnWzGkMdbsmyuFb1lJkjEqmcXWPp3J2SQ2fafciknHeeEEO7tR019msaYoh
         KB7JpaoASPVT6rtfWvdMuKUHdp3dpSGNBghXesrpSpLJWTNwCkkvV7hl6CThX0bmNT4v
         mEAAVdOpuiLcwduiEX7SzxfDTJv64bQNMzzS9v3r4l4gSBl/mKxMJmTKG2R49IEBc+u0
         fdpGZkawAQ9nZKTBoxLD12erIE4GIUqkrDhcVoLm8s7LeuidYG0SxDLkmfaHT3Objrcw
         nPtypUVyK+0AC312XlxIzq5uU96vrDK0Sp39IsKmCcQy8cQofj26rE6CRLMgluw47s5a
         AMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aqEzDn6cwAFS/6JfXX7+Dv0ECEk/Tx7u85UebjBkmlg=;
        b=b824P+QtS0EVbrlP/IpSAV0aXFtSyIiVfAGyuPvCrPbUeANWfKqhTzhxqjTd6fvriJ
         9qZszk+F1YRac1P8fqzi62HIgyabaiVy//ce7kEXIfLG4G9iECKCQfOqALQuMCcY5Lqq
         5rmCle6ZQsHzt+d1m6GdqT7/rsZlGgLSRFHLTp247b2hSGFEs45/4+/Xd2JKM6HtO0gk
         H7tSnBdW2zVJydFAtS1dyYC5I7mjHVpwbZDLqZ5F12nfCZIK7UPhWDgbT05/ESbHdn7b
         h/QHlz/WBl7WSPqvq9HUvMqHXidE56wQJOSn29X1IhTpZFL4dCs1HLYOoyqGu+HN2lZv
         gbeg==
X-Gm-Message-State: AGRZ1gJH7F6KcUJI648+0zCIk8usBcOhzrAUPiwHjm1fMjoHH01m8NAN
        At5mnPFgilX4mVE3N0o3vtobUhS+
X-Google-Smtp-Source: AJdET5dz25D9PPR8FdTkCbNxKujRXKn9tIDYpH708jC1N0hTVJpsrnpu/D4BALguc5KBO2IVCsb15g==
X-Received: by 2002:a62:12d0:: with SMTP id 77-v6mr15737537pfs.140.1541255550980;
        Sat, 03 Nov 2018 07:32:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z9-v6sm12033886pfg.174.2018.11.03.07.32.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 07:32:30 -0700 (PDT)
Subject: Re: [PATCH 4.18 000/150] 4.18.17-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20181102182902.250560510@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <ae908256-bb4a-1ac1-7fdc-e1470ae2e076@roeck-us.net>
Date:   Sat, 3 Nov 2018 07:32:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/18 11:32 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.18.17 release.
> There are 150 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Nov  4 18:28:05 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 136 pass: 136 fail: 0
Qemu test results:
	total: 321 pass: 321 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter

