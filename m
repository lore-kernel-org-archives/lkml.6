Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF616C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881382075B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9A1/dh9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 881382075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbeJLXQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:16:34 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:46375 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729112AbeJLXQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:16:33 -0400
Received: by mail-pf1-f173.google.com with SMTP id r64-v6so6379246pfb.13;
        Fri, 12 Oct 2018 08:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TIhVfszhQ3OB4Akjm+tYWa/nECjrT9qw/k0nQDwvkQ0=;
        b=d9A1/dh9u3VyqWPI2jMQSDFfiwWVoi4bNmke5DrxaOl4uAQKTVv6mrFaAHXfp/6ua9
         87d1f7sFubEifQLfSsSIoXJo8UzmmIl4yRPdnkJnbebSJRKnxz9mqhE+4tF1H8P0p17w
         z2TVNQxvMUWr2Ijpl4gAVqHoEKzonYbsAL867mV6RbZEG+FhJ6L/GL9keAjCRJUlMMl5
         HB8oXMDn6O/JHZblLqWvYVKWtC84wPcRNvXcY0FzrD08oRrbTcFX6F5nBO95C15u0RMH
         yW/bT881B1cQcf0F+4g9ssV6fLoZOX4pPLH3mS3WgefqiA50qFneP1Pi0cNILs0wncGN
         WfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TIhVfszhQ3OB4Akjm+tYWa/nECjrT9qw/k0nQDwvkQ0=;
        b=dQWKG9lSZvCqA4duVKv68vovhTqzgoXJ0oYWtKT+++Bz1k5tuPvsWkT1Upz7L6RKAV
         jpgUfF29vRQ8bL8RbnbW4iI9CtJ2fJLqgFy4dGIfZ2aJz6Thj4KeZB3DN4QDVTlZLDIl
         r+f03xG4WSLiWSKjsY3xCuJImlIrSsJioBhDNgZOWK+FMaUU35ZETrx5z/NPd3UYP6CS
         E6nBSaKyXUGgyNXIMOT2sfCo7Q5rL94pfCdcM00y9Mu574CWN37qsENoIGI/f2C69dIr
         ulDcFyEQ8d28B82L0yJeHO1Qk4XPrqDA2J3bcPrhyF/NoNLIFC68hURYAqucHCMKme/6
         Rm9g==
X-Gm-Message-State: ABuFfohaka90TgLxPwXGqAOZjsiS04x/iqYPgXU+zLIaP1fBE1ZLPxRS
        HQ6gyn2j/FndmzN/xskzVXY=
X-Google-Smtp-Source: ACcGV61oTohoJW0BYFiGWHxg2wdnxMRmC7wygwRR/dBax86TRY3lgAHiudyfxTMqEAJlaM4eyHDs7w==
X-Received: by 2002:a62:b286:: with SMTP id z6-v6mr6718506pfl.79.1539359009955;
        Fri, 12 Oct 2018 08:43:29 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id u1-v6sm2074902pgr.61.2018.10.12.08.43.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 08:43:29 -0700 (PDT)
Date:   Fri, 12 Oct 2018 08:43:28 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/45] 4.14.76-stable review
Message-ID: <20181012154328.GB13377@roeck-us.net>
References: <20181011152508.885515042@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011152508.885515042@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 05:39:27PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.76 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Oct 13 15:24:53 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.14.75-45-g69707cc:

Build results:
	total: 150 pass: 150 fail: 0
Qemu test results:
	total: 318 pass: 318 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
