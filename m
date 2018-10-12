Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700A4C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3478E20868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="af5Ob5DO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3478E20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbeJLXPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:15:42 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:34162 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728884AbeJLXPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:15:42 -0400
Received: by mail-pl1-f174.google.com with SMTP id f18-v6so6126390plr.1;
        Fri, 12 Oct 2018 08:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OjMMwVHcv4dXt3qMLiEW3TxMLzxRxyKPJ+wVwv4YRzc=;
        b=af5Ob5DO24ArmaAOgRS8U3RVRUKu5qp702QovKi86/1GgZQ7ZMzu1fSrpPDpzR8rwa
         JOCLX6/nW0h7t1qtb7QV1L8Jvr6lwnpgzzj68Hf9zaweyinIa0X6SULN/+e/IrUDtS2S
         YdBmEngFZYY4dZwa57Lr2wG5mJnzSRly1YtWQ4xj1qTVUjwu+fCgUJRlbHc5NI+yKwtP
         OIz/maNLqXVV5UjG53DLalt7LKtg3UCV2cbLRA0pJajdlsR8lH2abslc1aMiqOMsG3i0
         PmLjLV0Sdv5tHYX6iIHBF3iRhyejHJ9Wh32w+j3SF3va+LHMS1/eXJjqAR8ZSGugTtbK
         9nlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OjMMwVHcv4dXt3qMLiEW3TxMLzxRxyKPJ+wVwv4YRzc=;
        b=KoMQY7jXVz2Xv8myMAOVv1JKDnUzSnL2Q8Oc6j2bAuIRuST8iLFgyx1cZ8XUHRsIQn
         Il+ku+Txcy7RUAXFq6cr5UivhVwDCLjyskBiy4/FlhYYlS0lr3yc2dHv1P1jOJnLE9vl
         UsCI1kO1wzA1l85M0gKkWshXHg/vC8LMLM/BoYTokKCMNhKi7a6UqOUTkzvdQRItAEby
         nciiaXFIbm5nXif3dQ/LNUR9y7ivCPyDxhk9UFIzEXL56MmCy4yt5nDqAShESR89l+uZ
         gpDX6u7q5VdCGGcS/bld75yqHaZtc6KHPwQL6/UQmWUH+osiVFMsAk1bwmMaR1UyAq9x
         npxg==
X-Gm-Message-State: ABuFfohb7jRK+9Buupsf2tHDNNmOpdnpgUQub3kW7XSzyj0KTUhEFqIH
        bOkNIt8QZQjmyh9AuQhR6oUCMqsC
X-Google-Smtp-Source: ACcGV60fANQ9OKVapxY+fi06vnUk2oZenxT54HD78a56O8vzKQCfE04jS6a9AbiqdSBl71QfO+AOgA==
X-Received: by 2002:a17:902:ac8e:: with SMTP id h14-v6mr6309595plr.300.1539358958889;
        Fri, 12 Oct 2018 08:42:38 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id a5-v6sm2447196pfo.53.2018.10.12.08.42.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 08:42:38 -0700 (PDT)
Date:   Fri, 12 Oct 2018 08:42:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/27] 4.4.161-stable review
Message-ID: <20181012154237.GA13377@roeck-us.net>
References: <20181011152534.014964888@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011152534.014964888@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 05:34:47PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.161 release.
> There are 27 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Oct 13 15:25:23 UTC 2018.
> Anything received after that time might be too late.
> 
Build results:
	total: 150 pass: 150 fail: 0
Qemu test results:
	total: 285 pass: 285 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
