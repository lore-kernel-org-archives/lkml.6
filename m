Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBB9C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183C2214C5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+aEJexm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 183C2214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbeIZCv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:51:27 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46135 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbeIZCv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:51:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id b129-v6so12388539pga.13;
        Tue, 25 Sep 2018 13:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vE7rQkHijYA1nP+3HlVN26qwEajLYFGyxMlVvBm4U0E=;
        b=L+aEJexmXksF2D7zmVlFwq9gfm0MeDSdi5fHqx7SurQ5wRg1DmNrjhZdnhOoIBZXau
         ihCTpmrky2WL2daYhGEO0NdUUEKZf1lhrBD9EbrgfeplDrPpC6lAtjhUvHjMLco/XHDS
         7h7M2wAQ8I1L3BP0LDZDSvM2hpmRlSsHiaVvrt6AS5OLcczaDns4cH0iwLdqFZwKpwk1
         YMudAeEw8KzkD29fndpQbhBPtAOaOF7h9JwQrGanRRL1ntFdNATDsDkOApf8wEQkfAJ8
         /8CgBEOkgpqUtybL5NM1jjQNdjfO7nsrVSIk0TdpWZa0RNlckVtJnd3IsrMjp9rNN39R
         xFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vE7rQkHijYA1nP+3HlVN26qwEajLYFGyxMlVvBm4U0E=;
        b=POLIiyvok+ryHatZTFUyeCGf11YvfslyxCqz2DDIchZxLwh3WwmnTXDoieRTFAPN0Y
         nbqfli4QGKq+LAR24x17waVaU70Oqmta3EPuaph26CMR4azVZe4a1yml3+Ne8oHq1ZJ3
         WQwT+FwEPJ7uXidURxuGL+ffz/c80mspplv89rRNCmKQGfNYZMyl9qB/ajZEjJUd41dx
         9bJuOHJaNbCVH0pvJOgMT/ir1HpzTMg9vLCRRt2c+IMbu6A+VLydyI8LhaIIzCuvpDq9
         YaueUeLsL9IvoqPAmoKNLtMbmtoM3v/GmRtcT+YcSSpDQecTdcC2bkZkqOO9SF16qGQ6
         U0JQ==
X-Gm-Message-State: ABuFfoigQk4BV36LP6nvI1iE+V+y9VpsI/Wmakkriw5Jz/Gpzfx/n7N4
        eopIZu7GljoNBf87lpcOytU=
X-Google-Smtp-Source: ACcGV62xPUlfKLlOGz9YEmRQ5vMPzDI2WdEjVks+UPfggh2XBvIL9kdLbVsSX0KeCIRUKAzVBAZQIQ==
X-Received: by 2002:a62:6283:: with SMTP id w125-v6mr2840008pfb.108.1537908125512;
        Tue, 25 Sep 2018 13:42:05 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id b73-v6sm6858525pfj.93.2018.09.25.13.42.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 13:42:05 -0700 (PDT)
Date:   Tue, 25 Sep 2018 13:42:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 000/111] 4.9.129-stable review
Message-ID: <20180925204204.GB13170@roeck-us.net>
References: <20180924113103.337261320@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924113103.337261320@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 01:51:27PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.129 release.
> There are 111 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Sep 26 11:30:16 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 151 pass: 151 fail: 0
Qemu test results:
	total: 305 pass: 304 fail: 1
Failed tests: 
	powerpc:g3beige:ppc_book3s_defconfig:nosmp:ide:rootfs

The failed test is the result of a crash in devicetree unittest code. 
It affects all branches. Nothing to worry about; fix is being worked on.

Details are available at https://kerneltests.org/builders/.

Guenter
