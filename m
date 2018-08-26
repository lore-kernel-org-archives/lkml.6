Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CCFC433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 13:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07178208EB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 13:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZG/Q1hn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07178208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbeHZRTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 13:19:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39148 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbeHZRTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 13:19:07 -0400
Received: by mail-pg1-f193.google.com with SMTP id m3-v6so5317944pgp.6;
        Sun, 26 Aug 2018 06:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IXAXmjb8Fe7dZW81RGBe+cg9uB7iMIe1gJdq2wETffw=;
        b=LZG/Q1hnDYZ2RFXp2MW6O01zv7Nm1IMAxRedVCsR4kgp2M+ws77Y2GXaZkLQ9zTQMM
         /jrUurjOBPedHpcZBGWizoFhxnAE6bAF8gmknqNQm1hLKydxpPMqDtw/4VrnaC1vYOnV
         TZetAOPSSa/ceuFz4+HZwlfUlitcr5tGqeyizhX+AObIRvLr53MeEdawmJnPnR7zOQq9
         J/EcrOmOahQRrUv6ONqFIbAnj3wYnEyAG1ZkTncHCtffsl+VUcVUjUBVVa2kJGcs7CrC
         kVWNpDI9GWYHcoGjwd5yu1V96UBeyfCH+g9DTbhwSKC2VfejNMsg467lsi6mYV1+KAsH
         fJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IXAXmjb8Fe7dZW81RGBe+cg9uB7iMIe1gJdq2wETffw=;
        b=XW7324UymJzg28PlR+J4SRbVOflGk362TA0kMUtO71/Cn4JyPOFlyC8GWIAsnhwQOr
         Tvfo7MAWo0ScKGp+2vJMcGjBvXqlksJfXQxo3wzGN1lo3gR2HlRJFZP7nwc5WLF4Txju
         sdU75BPUMpwnL9GP8xzoR18ugM+3ZIJa3mw8DEqboITIu3WqqrksSEvjMYDWh/kj5zNX
         PR5IZUjq10tLOFJ3Tqx1LRQR+10yY3kIOiuVv8LNY2UAc+N54OH48BIrzHX0JDUxR1Ub
         SZ1TVlXgbvEyisGbovb0GNTjFtDtaPwxG8KfE+8BxzvitOlQB+AoV2bCvhXQM8EMCN49
         b4UQ==
X-Gm-Message-State: APzg51DNBajaITUQyKSbrfZw1tXqPW3cdgUGpbMqC1mbCC3CQlm3d73K
        JtQz9x98CxopF9khNJNU1Z4RW7gr
X-Google-Smtp-Source: ANB0VdZxbaWPYps0P5BY3M7Ek61OOY+b5vcfBgIGpAwpMM1Kr4jw3tj1jblFY77UuR/gAcHyEPRwqw==
X-Received: by 2002:a62:6948:: with SMTP id e69-v6mr10072563pfc.166.1535290591620;
        Sun, 26 Aug 2018 06:36:31 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id z22-v6sm19218205pgc.67.2018.08.26.06.36.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 06:36:30 -0700 (PDT)
Subject: Re: [PATCH 4.4 0/5] 4.4.153-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180826064102.584749876@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <556ddf8a-718a-a995-3633-861a6210cfa1@roeck-us.net>
Date:   Sun, 26 Aug 2018 06:36:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180826064102.584749876@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/25/2018 11:42 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.153 release.
> There are 5 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue Aug 28 06:40:50 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 148 pass: 148 fail: 0
Qemu test results:
	total: 269 pass: 269 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
