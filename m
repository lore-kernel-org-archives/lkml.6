Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA8EC43615
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E8D2154F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEdFVSWM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E8D2154F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeHWXnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 19:43:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38997 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbeHWXnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 19:43:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id m3-v6so2274831pgp.6;
        Thu, 23 Aug 2018 13:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5kT3spSwqmYLVYB5TheYN2yaXwJEMKeMjO+tWECvw7k=;
        b=eEdFVSWMArtxTZyAfmaFvJhzJUDInl9Ow7/pDkW0Ibs4NY5NHurrAmB8CJJJQ2Vtd7
         zcVkvnZQBebwiFnPMmm0zpcBu4GUHdEnGRPPnills+tpj3MozCK2doVJxIzES45wAmrQ
         3YLNseUwsqkCL+oBHEmKSKJQQmdSP1hB3VtZ1OanRDpQXLnmxmXP0d8RGimdh4C2y35K
         K7Z8cBAsCZn7wNys7NHEYfMutBxgpKOLXa8icxX5PHnk7W8j8Lr5z52Z9I/NfVlbhQCY
         HFnFRq08uCZ3IMOP5p6bf22cBRcMZi4YWddV/CmJ83/XlqKVjyAL4G4IqiyWKd/tYRBQ
         bbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5kT3spSwqmYLVYB5TheYN2yaXwJEMKeMjO+tWECvw7k=;
        b=KexNNpFKcHAPfPjcAP7/01zxBD9Kh2BjKrfwbd07xP1Qq7j1DR++O8+s/uhCx4hQMB
         hK1aBD/mCNh/oyfuQob3vPzwKp5UPcEaDJPtxHJ3bZMWN+NEXJf89dzHfTV2NXNUnJVE
         DA/yUZ+NQPCQQ7zapCKXLNlzaZrFZXQ0ZR77/UDVYppf+cO2Ze00KbQN4sK66E6Dv9A9
         iQCG8zlc7SFEDTvUuGL7qmMNaopGIyWhuDe1o9zi25GHHvThlAJttyGz1ukIVH6TFiOr
         yz3DvtmrkDGs0b1zLPqcxszZEiGgS/1e8eiUHedaVjAqHkAvv4A099T9sqxbQZsRZyHM
         KatA==
X-Gm-Message-State: APzg51B+qmAsi/e45Pqk0k/IrMvchOhoA5FQDyrxHF/Ru9JQqesQ/xO/
        Ske3t7MX2SBwnPdsZKRH1X0=
X-Google-Smtp-Source: ANB0VdZQS0ZfxoleHMCis9yO93cmBzIRKzYCbxvy4NXlj41OJR7J/zMPSYfoFGW8QvgAn9UWVEjwVQ==
X-Received: by 2002:a63:c702:: with SMTP id n2-v6mr5052974pgg.108.1535055121262;
        Thu, 23 Aug 2018 13:12:01 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id t12-v6sm6710510pgg.72.2018.08.23.13.12.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 13:12:00 -0700 (PDT)
Date:   Thu, 23 Aug 2018 13:11:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.17 000/324] 4.17.19-stable review
Message-ID: <20180823201159.GE9368@roeck-us.net>
References: <20180823074955.885811006@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 09:51:06AM +0200, Greg Kroah-Hartman wrote:
> NOTE, this is going to be the LAST 4.17.y kernel release.  Please move
> to the 4.18.y tree at this point in time if you have not already.  After
> this release, 4.17.y will be end-of-life.
> 
> This is the start of the stable review cycle for the 4.17.19 release.
> There are 324 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Aug 25 07:48:40 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 134 pass: 134 fail: 0
Qemu test results:
	total: 302 pass: 302 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
