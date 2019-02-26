Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96881C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65412217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Na9G0qY5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbfBZRlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:41:13 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46395 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfBZRlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 12:41:12 -0500
Received: by mail-pf1-f195.google.com with SMTP id g6so6561875pfh.13;
        Tue, 26 Feb 2019 09:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=89Dm4Lf7PVw5AaeQfjxNKQa8UDZySpLUgDSIcWhdOhQ=;
        b=Na9G0qY5qdVByWWELXJFKjn31d+X1C9xTrs0zHTZ63cHgOI8ZDYNAXqDVopfcYT26y
         qqc5hv5ZrmYxVb3wBgl2ybwPmDCwvxw41oTbkuuwP2ZT7SKGhP7+75GzquVWLBSFQdCw
         RNyhjijuu1yY2sLIyJGAYLDywOlGI/s+Hy0EtU8I0No2deUUCmfGVZUSnUj+0ksHX7GM
         fdrEPBw5q+FPIlsreuA94plpvBwkPacTWtQ9zoSp6DO9Y849E7xYCKdE7u8bVbAY9vEr
         LZApyG5wXvm+t60nGLFquRILcnhaE+zGcV0dLuyIiUeTtwT5mYmyJSZBMlHbofVHyPry
         i65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=89Dm4Lf7PVw5AaeQfjxNKQa8UDZySpLUgDSIcWhdOhQ=;
        b=g7uSRxh3xysWyqS59zUMZu2AvawjiZfCvyaZFRO51sXsAt1mTbcG0Qn/ymCi/5jDv1
         Wa4jQX3W9WljgnU5DpBHYRitSkySX32P62C8L9XqsvfwAsBKTJ8ii1QAWTHAeU8qcg+K
         WBcwSgddAVOH2sDh+d0rlOXlIp+GmzDIhDeRGiLk4MOiM9xEdbUSij0wxeV34DnYNC2U
         qgfbhMBQdi/sjJRZ1vlLEBtuO8saLUNUog3M1lEwJKMNsbeZdvk/49BO18w1+gJV2iXx
         yIHrFEuBFI7IOeZu4CIhNAiIl+vJaOhcS0ihCDtb/q/mV5T+W9oK7EHc0J5OReaMp6it
         SDWQ==
X-Gm-Message-State: AHQUAuYU67dC9jISg0YWJj29/jjAcBnxkXmpgAGpgwMiTK4tHK+GwQ/K
        jYZWZFKWkUEXwbp1QEyjGQ8=
X-Google-Smtp-Source: AHgI3Ia8lvSXKVIdNBBhYVlSTswlUto9z7EuUz/G3agAVOG6ibDah36uAawWnGiei+yWmmkVTX3LBA==
X-Received: by 2002:aa7:8b09:: with SMTP id f9mr18559975pfd.168.1551202871685;
        Tue, 26 Feb 2019 09:41:11 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x8sm18520647pfn.137.2019.02.26.09.41.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 09:41:11 -0800 (PST)
Date:   Tue, 26 Feb 2019 09:41:09 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/63] 4.9.161-stable review
Message-ID: <20190226174109.GA8682@roeck-us.net>
References: <20190225195035.713274200@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190225195035.713274200@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 10:11:00PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.161 release.
> There are 63 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb 27 19:50:06 UTC 2019.
> Anything received after that time might be too late.
> 
Build results:
	total: 172 pass: 170 fail: 2
Failed builds: 
	powerpc:defconfig 
	powerpc:ppc6xx_defconfig
Qemu test results:
	total: 315 pass: 315 fail: 0

Same build error as with v4.4.y, plus:

arch/powerpc/platforms/pseries/hotplug-memory.c: In function ‘dlpar_memory’:
arch/powerpc/platforms/pseries/hotplug-memory.c:782:9: error:
	‘rc’ may be used uninitialized in this function

which I completely fail to understand. It doesn't seeem to affect
any other kernel version, and it looks like it is another compiler bug.
I'll see if I can find out how to avoid it (other than reverting
to an older version of gcc). Not a concern for now.

Guenter
