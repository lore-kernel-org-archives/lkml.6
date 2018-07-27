Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDC8C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC9420842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rbxF6mDi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC9420842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388893AbeG0SyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:54:14 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40069 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730852AbeG0SyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:54:13 -0400
Received: by mail-pg1-f196.google.com with SMTP id x5-v6so3615282pgp.7;
        Fri, 27 Jul 2018 10:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XArE9ZGfvKHJCRPcQYn1+cV+7aEcZ5gKfi1Ujb36WLY=;
        b=rbxF6mDi3mq7GIsw7M2mL5duzNlvu4gmZmyTn+RvPES6xHEfymkFFuSE5maAD8ZR8b
         /h3whKBDvsaPIOwAN7Su0UUTzMqDw3CMPbJMb54MwbShLgluvD6B9eKP3JLdeu9kYCcx
         Ia/4SKz00aCxuCemGSWmLa/PVp+yY+HGE1AGzIpFLYyL+LTLyBxJ8i0vc/UHnuiXdvnp
         AUFGDlO1GDMv+axyprYDYK2I+OiSUwWLDPLADiMXfmELof36qkjR7Q0bKR9JR+ohgAbE
         KcmNeBrSCMwgjI5QSnoGHR8SuTGGfqomvT2Zx4/Ruuqqv06TAx0/RD/p8DWaHys8HywP
         H8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XArE9ZGfvKHJCRPcQYn1+cV+7aEcZ5gKfi1Ujb36WLY=;
        b=G33xk0BE1wMNZmKSponmasVjoGD+aBUDAJuYnpEcrO/FdpH3KSILlH7L+qgICUylGI
         Qm9xlz23MhScEIYuTUlnbpaHDrp13Hq/xinLvPzPG+up6RsXY1N1mzcnWjM9QoGy+Gko
         oPqPmqawa6FDZ65w4e6DhUwZUqWlK3Tl+Q+g+KQLymyyS0fW1U/bGOzsgDbgJEiZ/FVx
         bURfrLxqGxY8c25PPgSZXHDsO1w0vAgzVGN5i2ia0Ra2km5NQsq8t94qN3Hp6469tIuP
         wnG4Mq3cxJkN5NZpasBFSxCaTkekNDNlP4DWsQRaeq0ndnQzJJkC8Rw/Pu3nowZHya4T
         v8Ag==
X-Gm-Message-State: AOUpUlHWRN2LUXcPe1QNVK4p6KXRYoQJhYGVJ3l+M6Pb0n/PbEI8ThOH
        Z9UU2e3CTvkvxAoWt0dmFlI=
X-Google-Smtp-Source: AAOMgpdo2NAD1JYSv2c3v8KP5UABm9Nem5UbZZYMy/Bv21ZnlIlI4kMr01cY0rWyOe1wBlx7H1crDg==
X-Received: by 2002:a62:a3d1:: with SMTP id q78-v6mr7504257pfl.5.1532712681360;
        Fri, 27 Jul 2018 10:31:21 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id l79-v6sm14368145pfj.179.2018.07.27.10.31.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 10:31:20 -0700 (PDT)
Date:   Fri, 27 Jul 2018 10:31:19 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/48] 4.14.59-stable review
Message-ID: <20180727173119.GD4564@roeck-us.net>
References: <20180727095918.503549522@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727095918.503549522@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 11:59:45AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.59 release.
> There are 48 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Jul 29 09:58:59 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 148 pass: 148 fail: 0
Qemu test results:
	total: 174 pass: 174 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
