Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BFAC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEEEF208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpN+q+5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEEEF208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388870AbeG0SvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:51:02 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45368 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730636AbeG0SvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:51:02 -0400
Received: by mail-pf1-f195.google.com with SMTP id i26-v6so1953052pfo.12;
        Fri, 27 Jul 2018 10:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lu5uNvCNKFpl8a45NYxZJ25NJ0fkllp0TspSZPkPc9k=;
        b=IpN+q+5cpFQ7QjYgKmE3zwkD04UWMeDMzf94Lqwc7h/JaulosEzYZnoFRtToy7IqgD
         Vwc2HdZtVDabuuWLMZRIbA1bDSsBKgSQBB88jJK72gDj8cRUSQVlaJEkWddeVyvmszei
         ZUXF7noqCeF9YVOnpLWR0fIc7smYsFTiM47uHGpIJrvd/SPwgVI4p7lLA7zHaAUYq8ZO
         oLPP0dXMLUQ6WihIAHk8PIVv8NC/Tn5JDhFzZx9U2a8cgkakljp9c2LT6+SqAehyrYd2
         /izjEFVD51RW7/deo5Pl0L4iq96PuYjhAypwLcbTlsnF917bEYb9hMtXcbvtHw+kQ7uk
         0i2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=lu5uNvCNKFpl8a45NYxZJ25NJ0fkllp0TspSZPkPc9k=;
        b=A47WHh1DTjtymp5T6H6f8Jw/1MUiyIeyCZUEhGPDMNfcFwbh9C5e8IJET6wnwY26Fa
         /uvBbbMZsZ6+z+Ze2eKvnZiKGgiNmOLKSF2ZQwG/C6FxJ3xzwUeyGtzyhG3iF9R40xPW
         mmzo5LxolBW7eFGStRnvgtNfLI4t0StGhhLj0a8XnnQbqKo0hpgVpaXQwgnULDeo8Evc
         EGsBxTaPb2XxvKShoMpGs4sttuk0iGkJ/qe+CJAk3z3vbdjhu8bblvSa/yw14VdFdoJJ
         MLyBh2vCmG0R8UA0Wub6XRNudgJMCtL5HU8g4FIf+0fldlMDRyRnMfLGPzpiRrl552vm
         iT5Q==
X-Gm-Message-State: AOUpUlFKSxTeTvsYTsWIrGzTKdvX7lv1I6f9ee/uYj+a+cjV0yUrWN4R
        BezNl8OQt+D/DMpiIXm/sqQ=
X-Google-Smtp-Source: AAOMgpfUTg1eJzMSovp8qsP+G0SLxHWPXskiCQ4LnU8S6kPiMDkk/5qIzdKIgtRcxQYjntLbCJtUfg==
X-Received: by 2002:a63:b43:: with SMTP id a3-v6mr6884330pgl.50.1532712490816;
        Fri, 27 Jul 2018 10:28:10 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id x19-v6sm8423205pfe.129.2018.07.27.10.28.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 10:28:09 -0700 (PDT)
Date:   Fri, 27 Jul 2018 10:28:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/27] 3.18.117-stable review
Message-ID: <20180727172808.GA4564@roeck-us.net>
References: <20180727102649.049641021@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727102649.049641021@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 12:26:37PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.117 release.
> There are 27 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Jul 29 10:26:38 UTC 2018.
> Anything received after that time might be too late.
> 

For v3.18.116-28-geb91dc3:

Build results:
	total: 138 pass: 138 fail: 0
Qemu test results:
	total: 132 pass: 132 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
