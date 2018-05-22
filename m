Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2540971-1526996134-2-4798535290652112198
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526996133; b=hcVbBsKDLaMZwnwVoSRz6rp87AztI5XJOlmuYqLgWdfWGkr8GL
    tePmMFOV+MbLSiXcr5oGZiC7mlNKo4qZksG01ZjG0U75zg5Vjbcf3dRCokai1vfK
    myLyn/6aN6HRndIvr79zgo86zXwkiztQRB9NGa3/UJQ56GlxvjoKclTrdJkWJzVy
    UrfhUk9/PQJc9oUKvmCG6VJXWAkVdGB9D3znV1FoBb8VauZwJymKbsEWzCKEcxcF
    /7peRLQAK9unXb1uMnAH7Vhn8DAPl2ukjR8PN11lTqjwdRoEUR4rIeG3Oyba0E3+
    4kJK4/53gDkoiOc/e+NqFPdu02wJrabE1EgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526996133;
    bh=2iuZrTQUnstxrvsKq4o2PYoCF4gxuO2KunwbAV0n0LQ=; b=EUPbONXJeks7
    wF+zXRcvMCXbFgW7fnAmnCjgmQSmrz+yiqa427qoa+wx/iYD7sY/m+2QCd7ADhKp
    i6UmD3PyVlWPaLzufM0mIPpqOOPLq2fOmuWu3TKuO0Jz3amtNHk6Nhhdoymol5DZ
    iqOuOqPGClbneo8R7HxT8dAH94rIcjqo8syah8zpvy0tJB6nXcbL5+HDNGXrD3bj
    /Q7o3DeRWfUe9xm5vTiBprZvle/FmUEsZ/VGg1dswh+awYrkhYJPAx+jqAb3MxYz
    erH473yoRtQTWy77ZXRVjUO0Q07IvVMM1U1iwq2enUu7Mj1IPyWmQeJMb0/2BWhU
    h6bN1uF3uA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=DkjO4c/I x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=dAfwnF73;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=roeck-us.net header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=DkjO4c/I x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=dAfwnF73;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=roeck-us.net header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMToIG3LZr46WpI5jhaC8tcVIjiNPKejZ/cK5bML5TIDbWAiKS5JRWKKDf7XdI9B7atyV1Hmr/t0uQ6lUbrBsdYwscoLV+p4TKmB6x8FZ3lc6IPXSiu5
    uo44cz+0GA1eboX0v3Rmm/wGZkbv60axVpIlchoEsreoyUyncWvVH1wg88DrKgrqbLNAQ6q+rACqvrtAKnGINRzKFkgYL2O+nHp1ZcKpzJfszZbXt6kYkXK0
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=UIbBetWhaY0A:10
    a=VUJBJC2UJ8kA:10 a=YWtRXzOXAAAA:8 a=GsdrvpUGwH_NHCv-BOUA:9 a=QEXdDO2ut3YA:10
    a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbeEVNfa (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 09:35:30 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42491 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751275AbeEVNf3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 22 May 2018 09:35:29 -0400
X-Google-Smtp-Source: AB8JxZoAaytNhyomrU8dSHC/xGlDiN9BwLlkiKWIYeRQXebY2jIzr1JpQIniuom8eFFdgQKxLcyR7A==
Subject: Re: [PATCH 4.16 000/110] 4.16.11-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180521210503.823249477@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <1254867b-5d61-7cb3-ecb7-70107afa1233@roeck-us.net>
Date: Tue, 22 May 2018 06:35:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/21/2018 02:10 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.16.11 release.
> There are 110 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue May 22 21:04:14 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 143 pass: 141 fail: 2
Failed builds:
um:defconfig
xtensa:allmodconfig
Qemu test results:
total: 139 pass: 139 fail: 0

The um build failure is transient; it applies to all recent releases,
including upstream. Rebuilding usually solves it, and indeed solved it
here as  well. I am listing it to make people aware of it; maybe someone
has an idea how to fix it.

Building um:defconfig ... failed
--------------
Error log:
make[2]: *** No rule to make target 'archheaders'.  Stop.
make[1]: *** [archheaders] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [sub-make] Error 2
--------------

The xtensa build failure has been fixed upstream with commit
e3ca34880652 ("net/mlx5: Fix build break when CONFIG_SMP=n").

Details are available at http://kerneltests.org/builders/.

Guenter
