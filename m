Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458EFECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 000DB2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnyBhbFR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 000DB2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730930AbeGQQXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:23:31 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43859 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729989AbeGQQXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:23:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id v13-v6so616773pgr.10;
        Tue, 17 Jul 2018 08:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tmdeya33M3TN1qgKcfgqI0C2u7Txyfsj2mrl629ZQCc=;
        b=dnyBhbFRGgKCgBzRS0ujYRTjOOr0qW7HVmUNC98K2SEeop4C+6rXWuNLQBJgE/08To
         2Dleifj2wuxRDPzhypqeVXVsn4+kHd+E+6c2aRUPKe2Tn/KKo/Kpbj2WnVu18jHLeZKM
         wGHLBjEQR5gUotJtxHXvABPPXDwQkq1gDjkbo6zpWCW5TS2wFrBAwS5fw4BY1Jg9J/iP
         blUKc3R+ljwKm6AAGM+Wv4q0OWoxTfoOSwUn7UKuOp+xiXkBsrkdp0MDonwEJf20K9t/
         68r2j4F6Sd54QIcOFeX5mq1G9MD+lnK7unErNEgZBXqTQu/6xRVLb91Y5NcWhKW4FFXx
         L/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tmdeya33M3TN1qgKcfgqI0C2u7Txyfsj2mrl629ZQCc=;
        b=U5Egz7O60V6j6MAO86roPrX5KgI8/gayW8EOoTHEjhD66pgmCgLBXbGuYJNkzw+5tM
         +883u+8EFMytIhAe4IAIaFP1CztOh7TKotInuywSvLwzo9czSTjjh8OWoIpoPCJkxOy5
         192lg4+l4OKziDq7vmnX3/3dCaRF8vvOfuGk0+z5t6EjtMoImJoERtZFz7ojyVIru+L3
         XaL5vzNYctd16Tkp6wpTHmcz4E8ssvnTI2XD8RnJeIuqLinXnkmn1HS+rNyGfXdWDQGH
         97BdW66LkMZ++vdrnPqVJS4yH+wVslNRzyGl77x0KPx5DIC5/JIVhWrbDM1KgYxDHO40
         8n3w==
X-Gm-Message-State: AOUpUlGNnr6HSpwWOnRT8RmIh9OtAED14mfcQT9dvwoj/Cs8lXeR0UXP
        TVDEecTeuh0wJGl2zsaRAMOGig==
X-Google-Smtp-Source: AAOMgpd/40CXUn2MryZ1zyUUYdFLccwbkYepyMbbQVzPo/bHqLQblNXILdBWxALy4jaP0GH5nfS6CA==
X-Received: by 2002:a62:5984:: with SMTP id k4-v6mr1238833pfj.116.1531842614139;
        Tue, 17 Jul 2018 08:50:14 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id i6-v6sm2080943pfo.107.2018.07.17.08.50.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 08:50:13 -0700 (PDT)
Date:   Tue, 17 Jul 2018 08:50:11 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.17 0/1] 4.17.8-stable review
Message-ID: <20180717155011.GA29933@roeck-us.net>
References: <20180717114728.444937016@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717114728.444937016@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 01:47:59PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.17.8 release.
> There are 1 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Jul 19 11:47:15 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 134 pass: 134 fail: 0
Qemu test results:
	total: 172 pass: 172 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
