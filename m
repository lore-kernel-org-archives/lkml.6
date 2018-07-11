Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B48DC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D3020BF2
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uetD+obU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41D3020BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388129AbeGKNpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:45:52 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38431 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388116AbeGKNpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:45:52 -0400
Received: by mail-pf0-f195.google.com with SMTP id x13-v6so8520925pfh.5;
        Wed, 11 Jul 2018 06:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q3Ai1JRueEBHbI6xcWBiPY+QFzxu1d6Efx6DB86bwzA=;
        b=uetD+obUDQOFAaTuVbdnNotogm0oJHdplYDgMu6dOQb9qRyFrVgHv3gEC2K+ugifdS
         yZ7UoxSOrvDZW0yTQXSwiUxkAkmrvyqxkRUlfg/BB+ON0V9f5Eo6hIjIPNSra5PgQzn9
         aine7jA8ulgaTn+xMco3/QXjk+umNrJFZ9nrkzRGS3JegNFAex7Xd6v2j7tROlmuszEO
         pRUFizjMpGCJY7RRDMtfDIQYPbxJ9KTir2+gmbvdF2JmjKgwRZDHQaX6HYsfBOkJckmu
         oeJzRrrXmSibLuOZbFISw+998L4FEc/ynEQnc10KiAJXfsB4znCNMkoYzc6egtQ97DwL
         1mOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q3Ai1JRueEBHbI6xcWBiPY+QFzxu1d6Efx6DB86bwzA=;
        b=ECIvmBqQKUmp3ySSv5hSNPML9TXmhWO5HWxEXcc3DPlnO0fe1tinOk8SanN06bXMPe
         tYS6JYBSNnioajeWsUxZxrUmxVs2ciXw004tXVDbzR6IEPUZk7NjRtWejI9GCme2edwk
         ToLCGztbdl2TTv/4uaCPDmobrXgq6IwSH6jB9+4NAdGJAppIU4QxvbqmRER//hoJ8nov
         Pm/zFD4qLNXvLZvw59wLPKJbX1zv0irsXbwRACUSV9qNhWlvV7YzQWauRKtOakH8E1+B
         +4Lg3r/SGYtsaLrg1Xa70GI22EvxxLsiNq+PTb/kKXm2nLyptsTTGbM6Dpr1H6dafZye
         uaAw==
X-Gm-Message-State: APt69E1ssUfkW6k+gut15InRBf6CuEnamwQtJ92uorJfwFrfBWForLRI
        tiw6R9e1AYlxWPPLMBb1aB7Kgg==
X-Google-Smtp-Source: AAOMgpe57heevWCcJf9amPn1mtjyTmjQOcG8l+KfRRMaFujnlY1TbamRw0TlJ+cGxSjcTmzH3dltXA==
X-Received: by 2002:a63:3686:: with SMTP id d128-v6mr25886771pga.18.1531316487321;
        Wed, 11 Jul 2018 06:41:27 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id j75-v6sm4271049pfj.102.2018.07.11.06.41.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 06:41:26 -0700 (PDT)
Subject: Re: [PATCH 4.14 00/53] 4.14.55-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180710182458.736721865@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <1bc7328c-d3b8-76f7-52dc-5de1c2e94b61@roeck-us.net>
Date:   Wed, 11 Jul 2018 06:41:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180710182458.736721865@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2018 11:24 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.55 release.
> There are 53 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Jul 12 18:24:36 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 148 pass: 148 fail: 0
Qemu test results:
	total: 160 pass: 160 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
