Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC17C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 21:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A81CE206BB
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 21:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRxZG9qt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A81CE206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbeIICDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 22:03:49 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41656 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbeIICDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 22:03:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id s15-v6so8599603pgv.8;
        Sat, 08 Sep 2018 14:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aRh0XaNXG08KMXSX9mhIc/ORui+AtY8VhklIMlpum3c=;
        b=jRxZG9qt9axyEfTren5AVidnNOBwSdEfkpI8sKW0t7j+7Fs157qAZaZTO0S1YvLsJK
         QK4EKTbnqd3UsCQPHO05mRUL7ck6ZAsVvqpn21E7xm7EBxe5CN57lAurXJDwHnjwk6VE
         2VL5C+yFGpTXEu0mnsjcEMX/359PKH2mKFxJ8zJz1/Jryd6Axb3CqcJJAsjUsSVGIwsp
         AEPIh0W8fL5pgE99PIuFXYmIS9TGMvT91e/+XpVbVce9pjvwmlbRKu3mLDTdhVfkq3rp
         Cki326CV9F8gHQ6kUUVuGID+8CHPnWjiCwxgGp/nT6XKgEdTOnlENtC6RTjkyCXjBDyl
         kUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aRh0XaNXG08KMXSX9mhIc/ORui+AtY8VhklIMlpum3c=;
        b=aX0ps1RH4wvFXphvunJGwNNTrADPtv+92+FulV4R++/V+fwz2rvOUq6yQAbNtJTQ4v
         dO9zVVwdTr4+zw4VXMBJD/pphC/8SWEETnnSOjMU9ps4fjQWB4O5Z3gMdj6ChCYrq7T5
         wg8PGkT4f7rZ5dykXdq1j3L0/Q8Iu6BFRbjLvngP9vS7anaxef+pydxvCnYcrPf1A4eW
         t50OmnSvM2F52qtcJruZBN8KKhhVaXG6L2k44frGWVz1MBBlXCUvHXf1o3D3Vq7P7FEs
         pjaYN2ICT3lwkfMIX854WlToU7O/PP3v4HyOX2SLmqeU2p5mKX8rhp5Y2fA1zeIVWCYM
         xK2Q==
X-Gm-Message-State: APzg51Ab691LdCyOs2n6RV5GEfprMGpzd4J6DglReQpxEYbk1EpSARTj
        d1HIgEwQzLZ+D4tWMbO0N+bvlwnk
X-Google-Smtp-Source: ANB0VdZMBurbkCJDkJAx+F2xhO0+6Xhz2cTXypyQlJhQE5xXjMDSe3JG9/8Av98QmHB/N48D0NSqog==
X-Received: by 2002:a63:ce43:: with SMTP id r3-v6mr15308123pgi.439.1536441401982;
        Sat, 08 Sep 2018 14:16:41 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id t70-v6sm13340896pgd.54.2018.09.08.14.16.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 14:16:41 -0700 (PDT)
Subject: Re: [PATCH 4.18 000/145] 4.18.7-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180907210903.617721278@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <7bf345b0-13b5-7ad3-94a0-7b1652c70c23@roeck-us.net>
Date:   Sat, 8 Sep 2018 14:16:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2018 02:07 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.18.7 release.
> There are 145 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Sep  9 21:08:26 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 137 pass: 137 fail: 0
Qemu test results:
	total: 314 pass: 314 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
