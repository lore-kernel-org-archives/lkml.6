Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E465C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC7D821A39
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhfvkv/H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC7D821A39
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbeHQUVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 16:21:46 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36028 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbeHQUVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 16:21:46 -0400
Received: by mail-oi0-f67.google.com with SMTP id n21-v6so15231914oig.3;
        Fri, 17 Aug 2018 10:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OzCPph1QVBB8J8xq03eP3xaL2L5/dlN5HfrBU43tSKw=;
        b=nhfvkv/HJRTbuLpDuZhyEoQqvfj336B9G/VYheX0TqOM8CZlL8Oj/2AVoTL6qZvbn0
         KJZKBdetJ9x7WQWV4QoLgAbKO7vrTd4+/RxmqpTSl/a7OXxhmrDGQSP5GKS31aNevPcs
         qvdt6h9Z8Kx2o65qU1mSJNocnj9TcRLJGOSgofOKxM/iSIjy7y0/pBtvW5SRZk6c+VDr
         MAAF6xQOfv+QvTiXYOSJNs8VAn0q5bAB/CBy09CE/GETNgLhqVaCrQgyEWHp8sKrh5lS
         feYv9xi0ycrasvFCSmFVPPD8DHJTP+O1n2cPdUq7VA1P6F/+iPTGy8IhfQoZHRAIDVdH
         HZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OzCPph1QVBB8J8xq03eP3xaL2L5/dlN5HfrBU43tSKw=;
        b=bUjQPQQDR1kkDc/IF/MPwd8grMrF8xzd1ACerBYxwJnd1gybh5SfgD+zG6a86ZhqUb
         uwb/VPj8ZUus85BbdGa15zPu19nk8QPc968beuY7dCdWikqx+yqCOrEf0aBNNSDipKig
         bxezpxPzSclrOwL8rDLlJQvnk3Qba2x6rvfTYqNTMI0tAEj58MID3xaxATyTPluv/Wlo
         u88n6raT3LeDW6be823ObeBUHDz/gQyZkNVadbCQCRHHYRLYas2pQOnnauL0yN73t6LC
         PBqVbMSov6Gp15ftnjcpzKNagYsFlPwE16DPxwQMWeSNe+m/e5xDqEX2AzEGa486ZTJI
         V/tA==
X-Gm-Message-State: AOUpUlHC/1awzeNUT8HuQ+b2pRSmDmOQCJUYqshjlUzs0LoQqB4RmVVb
        4S1HtW7POesq/JqmKuAfeXEzpa3t
X-Google-Smtp-Source: AA+uWPxG5woOcdX/wSkq3K3S6FAy0TdKp8D4VZ0//s8TdT5ga6oib1MV/8LPdYUJ7Hl95c2OYcOshA==
X-Received: by 2002:aca:acc8:: with SMTP id v191-v6mr3145101oie.354.1534526255233;
        Fri, 17 Aug 2018 10:17:35 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id f4-v6sm3523487oic.52.2018.08.17.10.17.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 10:17:34 -0700 (PDT)
Date:   Fri, 17 Aug 2018 10:17:33 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/15] 4.9.121-stable review
Message-ID: <20180817171733.GC11442@roeck-us.net>
References: <20180816171625.340082081@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816171625.340082081@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 08:41:53PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.121 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Aug 18 17:16:11 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 148 pass: 148 fail: 0
Qemu test results:
	total: 289 pass: 289 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
