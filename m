Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60496ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0868620861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/GRkCNf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0868620861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbeINUKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:10:20 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36894 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbeINUKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:10:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id 2-v6so4530759pgo.4;
        Fri, 14 Sep 2018 07:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pzPXWmLraBEjJeJet2yeyh0P18GBUDwIHwvZSa7Mho8=;
        b=Z/GRkCNfk/mH6gRfmhmBdqWDqCqasa1op85hExVejFcZIa+ZHe2yjmq/uLRXZJS6JY
         kFSDF1P7FKbZd6ImIpRo+CWylVnFjMAYuwDe2y+M+MSoP23gfyPA6ABP+04WEycql4ac
         Klrq3Vmr9Hy3OZBxim7QFMbjNa+McI3NfxBmFgMlr+bp9jXQXRdruRYQkOMImQhZi/K3
         EjLiYhv89a2V7fYCHSKskkzUwPJruOlPKEdW9loYh+X29Uu9jQS5xkahphstN8cGgKLO
         NG3LhxXf5sN6Mhf/ANuDCOGomXB5Vd8W47fP8jXvAxD0Qfb2g+HhtF6OLviH1XQZ7L4r
         0ByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pzPXWmLraBEjJeJet2yeyh0P18GBUDwIHwvZSa7Mho8=;
        b=kNPPRNbbMsgWt1y9VbdyDc5PUMO5Ux93zoWPL3oonlkdId9DXz/cSR035Vu93Ecq+3
         Q43vegY1Z4Z2HF3YDAwuWTo+suG371KS2iMXnXr+ulbIHfLj3tLxTLOaZEM/5LaN3mxG
         aZDUClHS3GuAg2BZXBAJPMlsQ9jRe6tA1e/RT8yJiii15rOs4AqcW7kfRYWFRUO3cXoG
         VL119nIlyTxuSuf5++TnQg5i5f1m5nZ1B9aq2hv1kI/weM1hTmum6ui6IjBcv43P0+Kk
         SZ+WSnPvmh9UUUx6tcOGKGPbzQ5aarmPx7dyfGpq3Ao2lZ9WwpboEXLrACNWDuA3w9od
         DsDw==
X-Gm-Message-State: APzg51Cnqg2i9jNyqNsDfUHf2ZnslVPvqQuZ05ohXSA9c1dmUy0xyOTs
        bIy+rgKXD8N4bISPoeKrWAs=
X-Google-Smtp-Source: ANB0VdbKGRKbT1b3u9vMDTxIMmI8yPcGQI9HnunQQ/rLMhwvFpAXTuEhpc8K+9UwXsRVh22njV14Kw==
X-Received: by 2002:a65:6110:: with SMTP id z16-v6mr12424325pgu.412.1536936927361;
        Fri, 14 Sep 2018 07:55:27 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id d10-v6sm8021429pgo.2.2018.09.14.07.55.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 07:55:26 -0700 (PDT)
Date:   Fri, 14 Sep 2018 07:55:26 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/78] 4.9.127-stable review
Message-ID: <20180914145525.GC19599@roeck-us.net>
References: <20180913131805.732342940@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913131805.732342940@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 03:30:47PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.127 release.
> There are 78 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Sep 15 13:17:41 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 151 pass: 151 fail: 0
Qemu test results:
	total: 305 pass: 305 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
