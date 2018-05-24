Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2103625-1527173376-2-2834087699391519912
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527173375; b=TmRDMCveRZ91HScgMquwrjAFdn4BrE+pI6KhPp52qyN2C81iqt
    YxnjtJZ7B4hmuFPWihE7ssqddKRqykSOPivlJsMOhJQ+VwZoopuCqcQEcW2FU+IH
    A/WZN4JX9Cor50GOeX2D1TkEH7DPBS+MmWL2yLdhKX51a2zEsaacU2OEjZl0iiGG
    JHo72BDeknk+uefFP2WNqIKPbWgA7pPzXeUyqMHshjQnoeVDE+jpIaK7PBSLf33j
    h6nz50enyIgHAWQNYtN8ojDaJVumu49lSACc4l4Elc4KEO/ixo8jjOpu8DHGRTfM
    aUe56kFsSymH9Ox6lUDUz0zeLVEiKKiUICTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527173375; bh=H8n90sYUXJ6cXo2kaBkucly83skDNa
    bgk004zRy0LsM=; b=D/l7oOMjg6UPtfjd7NJjHS5w45QScmMuwVXvI7bYFq9FXA
    NQeJyEcMmKjacMQYk/YuJqG1qdKcaqR9MGuOK68vuw9EuVO6PLSH2bT2FUYI1xOm
    3kkBa+Dmg5FrxGAR/9P5NM4A/Dm4iB+JRnBcEgxXYZTz1fi+KYXE1ZWsfnkoEA3U
    7oNYYJNn6qlQ3zcfa8vrCxS0KDNSD9eUo3VuWu8tcHssh8GPHNffcisn4o2lSZ5T
    CI2Pqhb3h8RI6xt8cg2TZOhRQv4mLoTN61ky2w8NvikMudAovRa1COgslyL9DGFR
    9lammKyojYsDH4qEeOlFnYZtbIIk3buwZ86QaEMA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=TV1eK8J1 x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=mfOfQLqq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=TV1eK8J1 x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=mfOfQLqq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM+oRU/3WgBqIjNJsImXo3GTuk5p4eE7CIOjvNR9p+md0jj9CmIMZJykTVjUdegDEr7ATLXrQX6btNvgyOMYpfczPSGdLfJUNPZ2qMCq7pbDa58B+9J/
    ebI0beUgZLMJcEm9TjWE/CjXsOK+KneBnUOuYke+g/Enfts9RrQ2EWvfmf1IG90DCtnEwkyJQhirIy4ZzRGC3TkjNyO6FGYjfreOIejgXIErDhnHm0bNPmrm
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=TpujumX0jH7REod0KhDaHZOp9kI=:19
    a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=vY_346TuTMEA:10 a=6xLPOHPkGDIA:10
    a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=e4_To9XNM5qwnWtKC-EA:9
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965765AbeEXOtd (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 10:49:33 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38416 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965555AbeEXOtc (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 May 2018 10:49:32 -0400
X-Google-Smtp-Source: AB8JxZoIqWhvKkLdUaxucI6fYBn1riZfS4XXpmVY/FwvTl2OyASuNtYD3RA3Fwwn3XC3+CYT/hKBuA==
Date: Thu, 24 May 2018 07:50:08 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/165] 4.14.44-stable review
Message-ID: <20180524145008.GC9229@flashbox>
References: <20180524093621.979359379@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 24, 2018 at 11:36:46AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.44 release.
> There are 165 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat May 26 09:35:46 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.44-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled, and installed onto my Raspberry Pi 3.

No initial issues noticed in general usage or dmesg.

Thanks!
Nathan
