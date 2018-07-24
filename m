Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B60C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42CB02088E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="peFfrOB6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42CB02088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388612AbeGXRFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:05:44 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46652 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388413AbeGXRFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:05:44 -0400
Received: by mail-pl0-f65.google.com with SMTP id t17-v6so1957871ply.13;
        Tue, 24 Jul 2018 08:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6n8yl6FRI0fkHzjMFbDBq+xZybIkToh0sLxCIkQ3E5Y=;
        b=peFfrOB6PVtxLWkg+n40o+sazsFt/AjO5oc5qwCE3Whfv5k340f+fXvJysNK1mL5Da
         b9jQ+Y42BFzEfP6ziSH+ppiGd+nB86829dmRnWhzpGnHiZsnNFF4G+TyOu2Fd5lsb1zZ
         9p3ehuhJIpkMeajYInYEwviHCUp/iGvlCsizWxEEF77sGIDgCPBF0GTVDHogXXBwpXt+
         awbkQOzRVmz0SOUg5gC9MuVKEwG81LmzNZX4xNyxxhU+X0uj+kJKPiRMYhlc387qszVh
         hNyNyTNjsU/KssuBoJvjhxmYBbW724WToOQR52tPrUDWH6ZewfofrRQrUAQFu46xQ4/8
         i4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6n8yl6FRI0fkHzjMFbDBq+xZybIkToh0sLxCIkQ3E5Y=;
        b=nLVvrNJEUzMlbePWpJ+A9PXSGyA3qMfM6k6eOpjFwZ6FPjb5nA14EeUm1yHjiwWEmo
         PwJx9FhgdXhxR7qUkpUaIqpPdVQbtW+Rqqck+HcP6r1VSJQBtzd/LeMQwetpmkoMxF23
         DL/RFi9RFaAxBqBcpv463ItXSrpmXklQ+eL3+1XUwKXw6NNUEKIQKcN12D5pvDtoWHff
         NYrr2C6evz69uSjpDP9ZAf37COvhqhnquj38FnC8fsL+KQmW/dr1jTu6c+enNDKjQF1w
         2/OdmyT+X/gVkT/qJOYXlXj79/OUMk9vCEvJoa+B1QAfJS4KjA7i7SVjxUILktmAz0iU
         S6xQ==
X-Gm-Message-State: AOUpUlHWUdGwBeBjub+d6b9u28pzPLRE0uHDZ8uuqvTa2EETtPAqIJpP
        LlM/MlFDOf34PTp4QK7dwFw=
X-Google-Smtp-Source: AAOMgpcFEGowoCEcKAeGTQxuv0mh82oyPW05jAjlglHJX/hl8uQSgFyY3cExZUku3ZVHVeSYtDfNUw==
X-Received: by 2002:a17:902:1d4a:: with SMTP id u10-v6mr17790329plu.267.1532447916567;
        Tue, 24 Jul 2018 08:58:36 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id c131-v6sm36114396pga.69.2018.07.24.08.58.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 08:58:36 -0700 (PDT)
Date:   Tue, 24 Jul 2018 08:58:35 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.17 00/63] 4.17.10-stable review
Message-ID: <20180724155835.GF917@roeck-us.net>
References: <20180723122446.351334162@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723122446.351334162@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 02:24:06PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.17.10 release.
> There are 63 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Jul 25 12:24:28 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 134 pass: 134 fail: 0
Qemu test results:
	total: 172 pass: 172 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
