Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAB8C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362DB2150E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqhaFQg1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 362DB2150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730594AbeIRVyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 17:54:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36523 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbeIRVyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 17:54:07 -0400
Received: by mail-pf1-f194.google.com with SMTP id b11-v6so1265420pfo.3;
        Tue, 18 Sep 2018 09:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JslNkVSsdMQNMIeAc4dmokYjmUU9hleA75qKKk3FRyA=;
        b=QqhaFQg1uSF09TJZUbxXOYALlgqRKkZiRUlSH+sRUPF97O9QLOMncK8MGWSDI27Blz
         xrJq8AMYEALAh71c+iMCQOuGYi6L9MM41MgNBXDPYxErWLBtEJUo+QgUvGcVr2qa08pT
         UpxY3qxGcsHzCaBzLztmcZzcYiQ4q9ITXwfjYj3AF1Oqn2vx4XARCXlkyJUfvNjbC+zl
         88t1AUId7ZMcchlPxw8rcRMAybIzPURqEBviENq6eyQg8PSEYdGEM2B2pk1I9LDAW2ke
         ukG3+crEyvOmpyM+DGf+7Ia376VmkWXXrzqUopK0vNMDwK3U8hDlWg5YOQJyyJmRMS/W
         BM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JslNkVSsdMQNMIeAc4dmokYjmUU9hleA75qKKk3FRyA=;
        b=ZBFSh/4tbmxj5dWtIeYrzvWPGIO2auLVhhICKlpXZkoNnYrxKs1cvT7ZRSWw6DP7Yu
         wAs6SVqhndD2zsq9JyyAso86IOCP5TydoMHQcBWa9FaWhy6vCfz+aOmRzi3kuZF1x3MP
         DRbrfliJB7iXrW+QZ0+APKchSaD9G2hr8SsFLfRGjLe4RZ8tqZQI6EvjXtmA+DuU020p
         nSz8YuLafzW8vPdxtj2UtAmLuiQUH5gvZ5113+2rjzN3wrQGzkyNzojp95PZgiDSBZ5W
         w7BsOsZ4IJ7IYil9TOttsJWrfrM83pjGAItY+6xZ9BpXRziWwBh+cShHFuNImpSvJaGS
         Ddyg==
X-Gm-Message-State: APzg51DDjJ4my2+FmrZ+Em8/ALYsKteskM9Oga+u00nOQ4re+ENMsxAW
        mAIRcha4oYqKrzJ3IjbJGZQ=
X-Google-Smtp-Source: ANB0VdYmZ6timjyOPan/io3JantVjO6GMvs39xhOXk/sNRdtOqAbEKBgsstk9oDVex5kOWjnNG8uYg==
X-Received: by 2002:a62:6547:: with SMTP id z68-v6mr31518054pfb.20.1537287647915;
        Tue, 18 Sep 2018 09:20:47 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id x9-v6sm28909329pfd.31.2018.09.18.09.20.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 09:20:47 -0700 (PDT)
Date:   Tue, 18 Sep 2018 09:20:46 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/126] 4.14.71-stable review
Message-ID: <20180918162046.GC28152@roeck-us.net>
References: <20180917211703.481236999@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917211703.481236999@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 12:40:48AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.71 release.
> There are 126 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Sep 19 21:16:12 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 151 pass: 151 fail: 0
Qemu test results:
	total: 315 pass: 315 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
