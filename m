Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-422737-1524843812-2-15108273692892345980
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enca, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524843811; b=D8F+eIp3RfyKtqduJgKTtLBG+Noih4pe41FBA3ALe3UjhNWdcl
    2bMf8PaPOiTpqyL69f5YI+O3wDKOVl7B/r8Mv5Mz6gSNbIJsJUlI7EchnstLWjmb
    dqgxs5W71B5ci3gTGUFdekEitxH8jnPAw9oMn/jEB8aKOrc72gRStGBS7+/ElXnf
    3WuQ9MDD3poJO+wLv3s7E8+sa7UNaRm7KEAuz/mt5UDimC3Y4smOb0N8kP6yiyyi
    2ayGV81cnZc0/fNndaqjkxT4kKc7t5dauioRNNQvFqlU6VgKhgwuK9AFAxhKDr/i
    DWjl7U1yTSpGfsZ8YeB8v+prc8p/WB2bGKXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524843811; bh=xwSJlwQGwofDEV5ILGUKlyceuR1QMp
    b1uQk06BNqfQc=; b=aGeRo7Nm2WhywPUUA9lzCCc9k5Sm9cSTmYazNWnLrn8nBV
    vWLM4ZbM/imolpfZ5yLTHfevyeFSnEpvPdFH5t0S2wlyh9u7lLLjBWr+ldRcUYxH
    4ppXuwAn0zw9IprLlX8VxSOcZYpYrY0b5xrh4uMv9S+3URG46YSWCzV+SJWlaZp8
    ZEL53AzGgf2gnpstrcSqO/420k9EedXyDWOGmHZW6wp67cuoVjM3XRZxw0o6B3Mb
    eww0iJ3pn4wWMhs2CA6HQz4yWpruVK9Yz9tD1ibx9mTWcH2CfZWPa7msImC/69C7
    yf4rW9FfI1M8g0zVGzWPQjRyI6hOJR9AAH5p0vQA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=roeck-us.net header.i=@roeck-us.net header.b=pAX9ox2Q x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=roeck-us.net header.i=@roeck-us.net header.b=pAX9ox2Q x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDi2gTFDQGQINxm0HPUKwlh+2Tn0xXYxXrzM7rKJJvKd26GXcfop3VVPDAXWjvP+yIzyOodPmY2/jco9a3rI/COBvl5/0zHkhT/OHwPh8CVfgl5kQMxA
    gEiAdBEo5pzuqTyglG0QzE8xjkfJuilUVL3dxlRXZRDjl5Jd/0A1ueEIZDpZfyy+0jMe0KINgr2aE1PjZUqbjiX252CIDIDOWJESTz0pbB6RYHmNDiErGHmB
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19
    a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10 a=ag1SF4gXAAAA:8 a=QyXUC8HyAAAA:8
    a=Am4ss40yAAAA:8 a=_jlGtV7tAAAA:8 a=UrItONWs4AkHZ_witCsA:9 a=CjuIK1q_8ugA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=lf-hbUz_c89dky27wAWH:22 a=nlm17XC03S6CtCLSeiRr:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752471AbeD0Pn2 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 11:43:28 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:50672 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757437AbeD0Pn1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Apr 2018 11:43:27 -0400
Date: Fri, 27 Apr 2018 08:43:23 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kbuild test robot <lkp@intel.com>,
        "Hao, Shun" <shun.hao@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 4.14 41/80] Revert "microblaze: fix endian handling"
Message-ID: <20180427154323.GA7367@roeck-us.net>
References: <20180427135732.928644313@linuxfoundation.org>
 <20180427135735.038395432@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427135735.038395432@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 03:58:34PM +0200, Greg Kroah-Hartman wrote:
> 4.14-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> This reverts commit ac3d021048be9edb825f0794da5b42f04fefecef which is
> commit 71e7673dadfdae0605d4c1f66ecb4b045c79fe0f upstream.
> 
> kbuild reports that this causes build regressions in 4.14.y, so drop it.
> 
I thought you were going to drop this revert ? Or did I get the other emails
early ?

Thanks,
Guenter

> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: "Hao, Shun" <shun.hao@intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/microblaze/Makefile |   17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> --- a/arch/microblaze/Makefile
> +++ b/arch/microblaze/Makefile
> @@ -36,21 +36,16 @@ endif
>  CPUFLAGS-$(CONFIG_XILINX_MICROBLAZE0_USE_DIV) += -mno-xl-soft-div
>  CPUFLAGS-$(CONFIG_XILINX_MICROBLAZE0_USE_BARREL) += -mxl-barrel-shift
>  CPUFLAGS-$(CONFIG_XILINX_MICROBLAZE0_USE_PCMP_INSTR) += -mxl-pattern-compare
> -
> -ifdef CONFIG_CPU_BIG_ENDIAN
> -KBUILD_CFLAGS += -mbig-endian
> -KBUILD_AFLAGS += -mbig-endian
> -LD += -EB
> -else
> -KBUILD_CFLAGS += -mlittle-endian
> -KBUILD_AFLAGS += -mlittle-endian
> -LD += -EL
> -endif
> +CPUFLAGS-$(CONFIG_BIG_ENDIAN) += -mbig-endian
> +CPUFLAGS-$(CONFIG_LITTLE_ENDIAN) += -mlittle-endian
>  
>  CPUFLAGS-1 += $(call cc-option,-mcpu=v$(CPU_VER))
>  
>  # r31 holds current when in kernel mode
> -KBUILD_CFLAGS += -ffixed-r31 $(CPUFLAGS-y) $(CPUFLAGS-1) $(CPUFLAGS-2)
> +KBUILD_CFLAGS += -ffixed-r31 $(CPUFLAGS-1) $(CPUFLAGS-2)
> +
> +LDFLAGS		:=
> +LDFLAGS_vmlinux	:=
>  
>  head-y := arch/microblaze/kernel/head.o
>  libs-y += arch/microblaze/lib/
> 
> 
