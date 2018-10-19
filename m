Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F81AECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F0820658
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAuxXpOl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F0820658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbeJSX4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 19:56:23 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33575 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbeJSX4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 19:56:23 -0400
Received: by mail-pg1-f196.google.com with SMTP id y18-v6so15950073pge.0;
        Fri, 19 Oct 2018 08:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l4pnHJNV30xKVI6IPxgBGLVlIrJwhD5NQSzfEInztRk=;
        b=mAuxXpOl+94jWBMJPEh4hQKoFkgLkv14heva2RBI/3epPfIJ9nQTV+KFhP2pdKJwlr
         lMPqs4bX+jSMybaWN3gfMxzEF200cC9Oq9rMk1rFtFwydq7gNC0c4ROvzXZTYuOULXjn
         FST27sLhbfYz7/pkabIjFEsBwqBo6ATZyh+I+V6jKBxppIqfhnZYd1hoDU3h516rR2ae
         BYjJUTJ3Q0c8Py+5ubgyJlljtxqVESOAgeDAcdyUQWha5cfFkGWBUic4AfvEKb+t3sxz
         NwreDz6UolxVOqam39+bMDewe5g8Geo4XK2iJk6m5y9pE67ei0YgU9Ki0Yk8+NPe9sgy
         GSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=l4pnHJNV30xKVI6IPxgBGLVlIrJwhD5NQSzfEInztRk=;
        b=SSG6vwKXN8IwEfznzUD6TKW6uD/x4HiWDY9zn2YjWTG4JExp57BvPWcPZouoR45EAZ
         jPbqdUjgrJstFEsaz5QxA0XPYn/m3VV7SmONUnS+TYUBqaVwEWSwwZ43lLu1hNwkOdHU
         x5zEdoFWbWsxE4pM09lS1PqFtUFkDfK1mHk0ql1RwPlgxl1qyZjAvWHfkR1wynJnj26N
         nDwJwz+fEu/A5Fd//eQnnBc7j/WB7TaFLnc20xtH/8tIf9oQN2YHX6G2ryqgNOn48MGV
         KaM8TYY4xzq8mojmzg8gRwgjoXTXXW5cPtcxC0N+H2y/KTesPj8wTpTBlyMcgHcBL0Ll
         jRxg==
X-Gm-Message-State: ABuFfogJO/krYab/rQtOYJ4P9mxNOX7Bt3+B3lwb+LMhBNMOMRICH9Ua
        7rxzw9vbvwXGnv03uEFYBjw=
X-Google-Smtp-Source: ACcGV631B7jifxLG1tjNYNRpXKAXgnys658HCXU7tKrwIZXP+lzhBLJM9RoASAQ7ZACVPV025PhuDg==
X-Received: by 2002:a63:e70a:: with SMTP id b10-v6mr31960544pgi.363.1539964183376;
        Fri, 19 Oct 2018 08:49:43 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id t69-v6sm30620152pgd.43.2018.10.19.08.49.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 08:49:42 -0700 (PDT)
Date:   Fri, 19 Oct 2018 08:49:41 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/41] 4.14.78-stable review
Message-ID: <20181019154941.GB2992@roeck-us.net>
References: <20181018175416.718399607@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018175416.718399607@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 07:54:15PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.78 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Oct 20 17:53:55 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.14.77-42-g901b7ab9634e:

Build results:
	total: 150 pass: 150 fail: 0
Qemu test results:
	total: 318 pass: 318 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
