Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C06C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F1D720874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GduYeh9y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F1D720874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388560AbeGXRE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:04:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45418 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388398AbeGXRE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:04:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id f1-v6so3191868pgq.12;
        Tue, 24 Jul 2018 08:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HhBm1JzhnI+KNJAHJNH82lt3iAAm7DQG5WCdXQIJrw0=;
        b=GduYeh9yeagYZs84K2kkZqidI0oyv0FcB8D6PCZQ2dqWlf8XuxnS/7x/7H2dMZiHbr
         s1nP6uuC2smyMWc0AJUzk9s7pRNDXWpVXof1Nv1GYzV72lavL7GhuAvf92XEWn2Gdqlb
         9dGDPlRlSOGoP+sGcUmcNNxkzhQdf7SjD0P4SbijrgJWH/6/HeA7VEYPiNcF7PeOVxQ1
         vNz+7AJVcTvWc2syBv18vKKTjtcemqEmuS7JCa7PC4fUlaE2qEKEciowj756A63YAgWY
         HobBSBwWQrr5cNYsUOB/LToxLvYKwkIdv0PXTZN3G3uCGKkCynL/ls8MtjKTPdJGmXKq
         Wnqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=HhBm1JzhnI+KNJAHJNH82lt3iAAm7DQG5WCdXQIJrw0=;
        b=hjARkq8S/tS7mZZImaECVi9EdKCOxrPm8wiPimwP0sVByvqSFoTB2Oq1/Srm5tKQ9w
         XeFFZbsT+qNcm1lP50UX/JC4hUBYIdgtDQShpuDAkOck02ZAs/DOvIzRCxkM42uutv0k
         8MrAqfrHvGcpqCcK49CkX5axjhwSu6SfOEigMBWazQLRnKslHOMCA92u9QUvXjqUd5bo
         2MCX5nMAy4mnU3jxdnkTK3ADp1VXfDqa6/P8V0fGFmu3p5bX5UV6wENHfadN9lFljnuP
         dszL/9Zbm05ZZU2obpAub4kAlpFji6GVeT6Nxn04Wae0j8q53oUDRJwMArqGsnhmnQLh
         /EJg==
X-Gm-Message-State: AOUpUlE9GuIcfJa4b/uPJ7EckuUSfhYbu6QgpMhu+6Ta4tA7qpIqqAM1
        BK77oVgNAUkdZEQXwJvgGTHEulvI
X-Google-Smtp-Source: AAOMgpfSLW0fnSb01IBuodzUsRp3txokj5KOXQEb3tZpypCr1tiAozK4uZSYU2Wh4PD4OSEKDK0uZw==
X-Received: by 2002:a63:b40e:: with SMTP id s14-v6mr17105258pgf.9.1532447841773;
        Tue, 24 Jul 2018 08:57:21 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id x2-v6sm22665971pfi.166.2018.07.24.08.57.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 08:57:21 -0700 (PDT)
Date:   Tue, 24 Jul 2018 08:57:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 000/107] 4.4.144-stable review
Message-ID: <20180724155720.GC917@roeck-us.net>
References: <20180723122413.003644357@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723122413.003644357@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 02:40:54PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.144 release.
> There are 107 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Jul 25 12:23:53 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 148 pass: 148 fail: 0
Qemu test results:
	total: 149 pass: 149 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
