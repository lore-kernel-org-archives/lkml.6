Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B3FC46466
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021412075B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I19ExJvP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 021412075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeKUHLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 02:11:21 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39062 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeKUHLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 02:11:21 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5-v6so1992598pla.6;
        Tue, 20 Nov 2018 12:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4emMDARWTQclKgmQSmLDT4G9BHddiJJ3ba6c1UCkcFQ=;
        b=I19ExJvPpL6tXQat8hyTLlsLn5NdLxs7mDNQDHkWZ/nNygE9w0JCqkuOWuKPWMG70q
         KPiTcFKuidnp4wGoWh1ti39BT9Jyzpn029NYD9GNEDZp17VsL2dRJubKLLkdPtc/JqH3
         sHg9W2iqLG76YK4yuIar8nyMor9WWrbd8cfUcIjZme75wwC7Pld4UBdEyQ+PHdv4HLdB
         7Yl0yVg+YCe+z+yPg4ktG5Rt3SM8DWCwrfrn0Vs0+1hDzcZ35i7b+3IIUBx9HTOXcB3h
         H6qkojb8leBA9dwU9QKoAv0eNMcIEDdqL1Ql6tSTidoZ4EmJgrrFWHIFgezrCoagb6n3
         OWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4emMDARWTQclKgmQSmLDT4G9BHddiJJ3ba6c1UCkcFQ=;
        b=nAkr5fo6xHqRdfburtqOGpgi7VyJNYbzTs9AHSzF+SEDBmZcSqHAIqcXdnB+FHEXnW
         qibKCVsCzMiFg9Fkzsco+QU8l/RZwlvA/FYmK2OuyaTiUuYwjk2hkRUdOY8VGYaRnYA1
         3nP7ENN4jOCcXMkMoGIp9/nOhuEXXecNfwZj6JIL7cni0PtrGR/jZWIDcdUoVmN1nnFE
         d8IzVF/n/gOfYlBJtI7je+PxLoun/omZBvVQK5VL6murf95O2dqBaMpiid1jp8g38MxE
         QGRz0oq0b3/dALtYqewLJ2bIEaj98jMrS/2wO550JujNAuOXvo9cNAVKVPUk4YIEep7o
         WN+w==
X-Gm-Message-State: AA+aEWbKCoGLbtWQoZrwI5RfI5c/GN7cTc2kqVKJgEfDhMF1he6QfpO3
        Lp3PoUuh+yjdNqt+SgBmulw=
X-Google-Smtp-Source: AFSGD/VMfEa7yS4OzBiutij+yDWOx4QZHUkUHmf/K/tJBsp1D9Gyt53aLugMl8CeVhdTHQQ2sHG3mQ==
X-Received: by 2002:a17:902:108a:: with SMTP id c10-v6mr3675885pla.171.1542746420897;
        Tue, 20 Nov 2018 12:40:20 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t21sm37397846pgg.24.2018.11.20.12.40.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 12:40:20 -0800 (PST)
Date:   Tue, 20 Nov 2018 12:40:19 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.18 000/171] 4.18.20-stable review
Message-ID: <20181120204019.GE19385@roeck-us.net>
References: <20181119162618.909354448@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 05:26:36PM +0100, Greg Kroah-Hartman wrote:
> ------------------
> NOTE, this is going to be the last 4.18.y release.  After this one it is
> end-of-life, please move to 4.19.y at this point in time.
> ------------------
> 
> This is the start of the stable review cycle for the 4.18.20 release.
> There are 171 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Nov 21 16:25:02 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 136 pass: 136 fail: 0
Qemu test results:
	total: 296 pass: 296 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
