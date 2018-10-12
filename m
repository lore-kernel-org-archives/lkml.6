Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53862C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17AAE21470
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="hX/F9DkH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17AAE21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbeJLWao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:30:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38150 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728646AbeJLWan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:30:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id f29-v6so6332897pff.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 07:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8J/lXtBqwvLGG6X7sYQfCs45879z4TSlkx4QK3kUxGc=;
        b=hX/F9DkHFWT/lsXaDM04MPv8u87ulX4FJwPpwTmXAYLtBFyzpwM4xfSLvknSG9oRpw
         U7u+9QGmzk9+x57na2uU+HzpyG3yw1Pj63Udi7DPdtrmIZXqWcpP7xQC8LFZR17PQ6s4
         O+lI6AqMcmfeuoYuecBRH8wUDqVkmgQcu5dpg5lGnOF9Nth/EqJQs+aj74hIsHzq0vyJ
         hlv/hpRCVJyEdRcdo2fXFo4IBvkcikRKv7mDjm/qiApVOJYZoMQV+VZyxXSW0CuM5vFO
         gkQe++EqDsFyFHKrM9whOnrSnsTjiDjU4C2KBk8CZkgjHqKz9MDAbEizAHJjS+lSuF+f
         rOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8J/lXtBqwvLGG6X7sYQfCs45879z4TSlkx4QK3kUxGc=;
        b=nJ6W3MKjGkLbGn35whHndrPpJkbJWVO9xEqUi9U5eJG4vt8jos7R7QRJgtBg7Y6liS
         kscIwlud3NRFgfDyF7sBEC3loMBHsv8oijgLoUpqZGN8g3LGPABCKjl52f+91Taljvs6
         TfvbmKCd66XoKsPdxfaJJ6ich+v3rLMaz4xO0hzns8oeDfBOvs4uFnMxyhP1ntcFL74b
         fRznsfhEM6y6jJtD24uORQ/7pNOt87jpppO+tINkmsMUKFm3oRyRx7LCqoRfZDh+MzS0
         68+i88pvjGLhDLUGzYkBMoSaYtu5IlIVHZUEgK99p8a74nycEH/rLERUaREZl9o6/LGV
         0b8A==
X-Gm-Message-State: ABuFfog4YIfECmharPjQOvo54oc1COAk5X6tSjBy14Ook1Uy/cWRGsdW
        3RGJlvt+zCOKIDRICNG32yMEPQ==
X-Google-Smtp-Source: ACcGV61J4pvzS8PSxIYbyXjiVbw1+ChbloJThC+Hsk/IZsIXIDaoQLiNs9sG8AqwPbTJZVbn2diMZQ==
X-Received: by 2002:a63:d40c:: with SMTP id a12-v6mr5770567pgh.394.1539356272988;
        Fri, 12 Oct 2018 07:57:52 -0700 (PDT)
Received: from ?IPv6:2600:1010:b023:6e7d:49f6:3296:7822:7f09? ([2600:1010:b023:6e7d:49f6:3296:7822:7f09])
        by smtp.gmail.com with ESMTPSA id g88-v6sm3068494pfd.181.2018.10.12.07.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 07:57:51 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC-resend 1/2] x86/compat: Adjust in_compat_syscall() to generic code under !COMPAT
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <20181012134253.23266-2-dima@arista.com>
Date:   Fri, 12 Oct 2018 07:57:50 -0700
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirsky <luto@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-efi@vger.kernel.org, netdev@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <6135DDE6-C8C1-420E-A264-7FD0AB60DE82@amacapital.net>
References: <20181012134253.23266-1-dima@arista.com> <20181012134253.23266-2-dima@arista.com>
To:     Dmitry Safonov <dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 12, 2018, at 6:42 AM, Dmitry Safonov <dima@arista.com> wrote:
> 
> The result of in_compat_syscall() can be pictured as:
> 
> x86 platform:
>    ---------------------------------------------------
>    |  Arch\syscall  |  64-bit  |   ia32   |   x32    |
>    |-------------------------------------------------|
>    |     x86_64     |  false   |   true   |   true   |
>    |-------------------------------------------------|
>    |      i686      |          |  <true>  |          |
>    ---------------------------------------------------
> 
> Other platforms:
>    -------------------------------------------
>    |  Arch\syscall  |  64-bit  |   compat    |
>    |-----------------------------------------|
>    |     64-bit     |  false   |    true     |
>    |-----------------------------------------|
>    |    32-bit(?)   |          |   <false>   |
>    -------------------------------------------
> 
> 

Yikes. This is probably even my fault!

Reviewed-by: Andy Lutomirski <luto@kernel.org>

And, if you want:

Apologized-for-by: Andy Lutomirski <luto@kernel.org>
