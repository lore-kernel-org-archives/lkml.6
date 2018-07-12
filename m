Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7EDECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2D6208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/doiNqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F2D6208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732534AbeGLURl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:17:41 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:38541 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbeGLURl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:17:41 -0400
Received: by mail-yw0-f196.google.com with SMTP id r3-v6so10920304ywc.5;
        Thu, 12 Jul 2018 13:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xk4sgPg8VnLyx1AW5j0AxElY4hhLnTW3gr+FlQh8xLw=;
        b=c/doiNqTwYgvZECF7W7Wcksun18uiDZ4aA7CQgXEUhiwg1OOvKlD+86yh6AgwNYfwE
         PMbY+NBg/o5xJe5yEEUP90mV8jurqJ+rkApt6aLmoSqlKPyvJf8VqtjHsPH8nl+IfKjg
         xwOJtLxefpltQwgVqMExrhBrUJLpoY12CYSuNjpoaYAymOi5jciDm1OdSa77bWsi6Yf3
         woobSnGcXcReM8oKVziR10ZLjKyIxmkea4sjCSBEKAZFDQKeIgRHBr8+odYDY+DeEplG
         kxav8eCZGUhAzdiRLw/NT8uUfkRcAwKQDaX39VYCLcLBQkVtWnYP2WdgeeP3NM+QFhvz
         PF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xk4sgPg8VnLyx1AW5j0AxElY4hhLnTW3gr+FlQh8xLw=;
        b=n+od9u4WZrNpdHC5y53vf9yuuKL1Nb0b9vlPuNFWQrDt8lcJiV96FlYtk3YUbXxrru
         1MiUE+psCOrjYx0olcrLAplrMv7t3Xqg2QcH8PlXh0vuY3eQGH86lOAuYtm4Mz2ihBV/
         ertQ/T53zclVeA7hxPbcnHbpWcZ04HkCGkA2knnzrIM9B0mC38vk2HUZDpxuESbKL2ls
         bnCVXUErTzc7cG3MqaT0wfpLk+8VCOtWWkQOHBVzoIM4Qj9zo3Elj6qDy61TiHw5FyBs
         /jH1f7gmjHSuaa6e3Mcfmwrxd5qvFwr0FsjYzd71Ilc9x5d+Gud9WbTNedRjEH2qTFGF
         YhBA==
X-Gm-Message-State: AOUpUlF+E5e/JOtbGl5IpLRXx0FXniyFYLonpCR8RKp5GAZP529yQ6Hf
        2jm2PBYIA8sdggS2Ovhxjgw=
X-Google-Smtp-Source: AAOMgpfzSrfVWmFd0A6te9Fba7GcyDCmZoEpxxbb0vcWK9dIfAKQ9JNnUdGXXk0Ct7Q9JaoAU06/Eg==
X-Received: by 2002:a81:708a:: with SMTP id l132-v6mr1883801ywc.485.1531425995354;
        Thu, 12 Jul 2018 13:06:35 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:a01e])
        by smtp.gmail.com with ESMTPSA id n3-v6sm4745685ywh.14.2018.07.12.13.06.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 13:06:34 -0700 (PDT)
Date:   Thu, 12 Jul 2018 13:06:33 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-ide@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ata: Only output sg element mapped number in verbose
 debug
Message-ID: <20180712200633.GM72677@devbig577.frc2.facebook.com>
References: <5474a38b-c0d7-a7f7-6447-5720f40aafbe@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5474a38b-c0d7-a7f7-6447-5720f40aafbe@molgen.mpg.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 06:31:03PM +0200, Paul Menzel wrote:
> Date: Sun, 8 Jul 2018 09:18:21 +0200
> 
> Defining `ATA_DEBUG` there are a lof of messages like below in the log.
> 
>     [   16.345472] ata_sg_setup: 1 sg elements mapped
> 
> As that is too verbose, only output these messages in verbose debug.
> 
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>

Applied to libata/for-4.19.  Thanks.

-- 
tejun
