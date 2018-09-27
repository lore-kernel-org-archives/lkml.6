Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CD0C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E3C2170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lL0J6uM8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E3C2170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbeI1F0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 01:26:30 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42913 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeI1F0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 01:26:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id i4-v6so2387082pgq.9;
        Thu, 27 Sep 2018 16:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tfu2f76bV5h6bowHMTyrbi68eq6mCD5tR1b1Cx2VVRI=;
        b=lL0J6uM8wHHXDEimgiW5Zopi+XeqkRlpZofZ8bprQOsu7veGXYGKn9UisukTX14MCZ
         ZpTLXsCZY5+u0VSSMNg8u71EOcSyWo7nJ9dbEzriHtgw+Pr4PYVYvMSj+SVpmAEkzJ3o
         bsXpFf3kvNytbz2aYOzE5qIRA+e/TdqVsMZCrcQOTj8pGl9UoLHPc+H7nPha+hjcRqgQ
         XRZesJ0WaZgUwnxLrdqMJmLIYAXDzNTT0rGS2wb6+LpLLAdhuDv0qAHZS46yU6snBgR3
         0dYqefDMf685KA353jmNXz2KiyCexg5q2Ldl1qne9SMaY2YGnh27A0WC7v6rHUS6vl+R
         g65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tfu2f76bV5h6bowHMTyrbi68eq6mCD5tR1b1Cx2VVRI=;
        b=dxbYpmgJ/85Ld4sKniO/tljnAqcj2b7pcmY/sgMfRRCN9Bt4/y6he0S/LZO48HRSH6
         bMtBahlHgswZxX0uiYFuAk1B8EXA7xWMLb0x/ybqjps6CpcvJUz0D87+9F9+YlhYTxXv
         9XjonIYXo3C9BcWNDvKJCOYmZMV51wfwSmHN7Tsixge9SzxeGU6lz8rGZE9X9PkJd1xk
         cF+ka4DUYohip0J/IOEYbQbfoDXQVzQk/4iVDTOnAIYk2YHV4jl3a7zE5IeEMiB3IJ1Z
         LvYyn8I1ZZOkSX+XWz5nLgjwNhNy/9rti5QwXMVpCz9drAyLIEBSFbpTxKLvOkc8ZZQC
         TZiA==
X-Gm-Message-State: ABuFfoiTQAbIJlAdvAbbahAnAZ18EgqU7gp/IxdkKPDjVaBDWyoKfcMA
        aso5+IUNKBY7bx9FB1GYEE/Qt0q2
X-Google-Smtp-Source: ACcGV63WTZXT8asr9e5v0FOFyhdwzgyfEp1sGGcqdIm+0Ke64ItmwzwL88Ow7hWFAxKb4Z+VzVM+tA==
X-Received: by 2002:a63:cd4c:: with SMTP id a12-v6mr12330559pgj.15.1538089550061;
        Thu, 27 Sep 2018 16:05:50 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id m15-v6sm5089994pfk.149.2018.09.27.16.05.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 16:05:49 -0700 (PDT)
Date:   Thu, 27 Sep 2018 16:05:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/28] 4.4.159-stable review
Message-ID: <20180927230548.GA29261@roeck-us.net>
References: <20180927090637.687829444@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927090637.687829444@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 11:06:24AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.159 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Sep 29 09:06:27 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 151 pass: 151 fail: 0
Qemu test results:
	total: 284 pass: 283 fail: 1
Failed tests: 
	powerpc:g3beige:ppc_book3s_defconfig:nosmp:ide:rootfs

Details are available at https://kerneltests.org/builders/.

Guenter
