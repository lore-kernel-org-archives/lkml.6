Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EBEECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B0B20658
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p1fjVgYi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B0B20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbeJSXz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 19:55:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33506 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbeJSXz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 19:55:28 -0400
Received: by mail-pg1-f196.google.com with SMTP id y18-v6so15949017pge.0;
        Fri, 19 Oct 2018 08:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RP3lV235UutvfcYhCGXLH1lCk8abTi+f9ZTOJ+CAicY=;
        b=p1fjVgYik0G9Jp99hND1UA0ZuZXULrkDmoZlHvzBXSvjD1YsGFGPT+ni6/c6/8jCN/
         6XO8oQQxw0SCTDEVi7qPkBEP+YHrGygbwB52w7PDcVJ4N+ZWOY2JxbNEPeP6vuFeD0zU
         T+zaiYgw1v0UOSG/mepYQQYu+Cx0xoiN/0JJvoQ70g8NQGCZXf6wSwhVSR6pAVvlZ47/
         bUZq0HiT8ZS/zciRh9YfYUW202M3MGkeAsGMMspprPxZ+U/+9bmnr+oVPx22uNPwvVkr
         cy1hBe5rGSZrZz1koxxTGOtBLSZqechz1atmdIMFlrn9jlI6sOwNaSDGUmOo6xQNcpKr
         m92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RP3lV235UutvfcYhCGXLH1lCk8abTi+f9ZTOJ+CAicY=;
        b=C7RVgn/QkPXRwqcKE6Olhd3Xfq4qoeK6xY8jqJwnrwcsW9YZV+Sfb2rx+A8aaryar2
         y6E0tsEuEH+IyasfbtZarNqgRAAvDLM8eKp5ZFdT7pOgNIddFIRyKF2oqPR21xrmnrOf
         qduAXNTN7jYSQOOkrajzS25HTZUTXPaGAlP27wDTumPerZ3N6H1ni78PSzaHgux9E0lZ
         XuThJNMdZ40Strbb2iGG/P19NXIQ+WS2n2pJmZ0jFegEcdhA3MpUSBcvLjfyDVAZFkmc
         nKoZMimbT/KllCPBksbd9zSrtbo4aG3x/wB0/VMNU5FCIln788xLlJ7uMruzwa/q1Hxs
         t30A==
X-Gm-Message-State: ABuFfohNzAiTzGfLXQhVrUQaSejx/alKg14ZhG0cFL3KhBoURhIBsOA1
        0yFX6CfcbJUemsol+ok5cE8=
X-Google-Smtp-Source: ACcGV61ZJBG44fwmVKLiZlSJI75l2Bfm//D35Jnt/3Y6XcYT0AzzpFSn6OajiKeKRPJ4djlOvc9BtA==
X-Received: by 2002:a63:5558:: with SMTP id f24-v6mr33922209pgm.37.1539964128387;
        Fri, 19 Oct 2018 08:48:48 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 126-v6sm9668643pff.105.2018.10.19.08.48.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 08:48:47 -0700 (PDT)
Date:   Fri, 19 Oct 2018 08:48:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/35] 4.9.135-stable review
Message-ID: <20181019154845.GA2992@roeck-us.net>
References: <20181018175422.506152522@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018175422.506152522@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 07:54:29PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.135 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Oct 20 17:54:00 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.9.134-36-g199d569d5f73:

Build results:
	total: 150 pass: 150 fail: 0
Qemu test results:
	total: 308 pass: 308 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
