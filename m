Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3958489-1526649730-2-7127879103023840930
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
    1526649729; b=j+ePfq9xC8ZxDuy8aXbu1uvrxejt1fH+8AoTzHCGvZbt9CwKwv
    6QbOJMf+7CaqoEbGjGUTrG7cEhzfcauJvudiLNSdvebN11tJk3e2JkIt4mVjWD6u
    NHfxHuz7jVQtdv9sTLnymNHt7nxeFeybVpofvCdq6GWCDdYeU1H0cFv4KgnUdmhs
    3utWPRdORxRa+PCSOjk6lHk4TrqX3LHzfRq4qUDGY31kr3ZXsxhltIOEElFvCP1I
    4TkTo/EkjuW6oG8huXk/UfGZEX1g2TYVGcX9xMpMll4RK6FkGZuNuCc7mth3B6W7
    NmN0NQanokA9TCuN3qoBcscXVH0iYWY6+eBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526649729;
    bh=wpG1nMLpMLwz9U67yiw4GWj/obLishEt8+ap5FcxXXs=; b=YFeVwGfPE9fo
    gWM67NrjnzOcSrhL6Lsfdv7iITozqFVOK1RDMGL2BR0Rip3tpjAwlF7eX9xQXa60
    Lyxt+mcUM0o4yaNTMzhURpHB6s4wN1yc9PHJ1Ih5MhLRpw45YjlGOoxJUxQfkk7m
    GM9/oLfbQLp/PMrMzQLrfQfwxqw0wK7W1hKxOuXWoIRa4UTnqDmsMTxUVG/dWnVQ
    TTIi1/yrJ4Rqhut13j0z2/ajpbKwT8nqYMCv3DX6a1DpWD7ohpsHoqyHR7miYY9B
    ESJB0vxbLErPg1x3kmp+VHzg/JCv7itxa7rre6bS8KFwrqOnf17gl3qAYObJoZEn
    CqEhz9Za1w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=mwjefdBb x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=sUK0tBC0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=roeck-us.net header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=mwjefdBb x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=sUK0tBC0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=roeck-us.net header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDvHggIL8CDbp7UTykl49hnTtnUlNU2gunzIwxw0DcqiSdyfY3+WFcCdSpXcx9NgxeoIVvctKRpk9G2grQyU4uNJY2vxtwYgFQskSmRLpvPThOuotytW
    cns//RqOZmZQd/uo2R4In5ybSqeamGNBYq4JW2BRvuJVcTPVXN6Fn17VM+8kwOGZTR5plJSKWmithfPFVFDAc+QErGm4DJ8DCIEqj/jRgTvqJSynOl4RLuzE
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=WWs0EKWmijYA:10
    a=VUJBJC2UJ8kA:10 a=YWtRXzOXAAAA:8 a=TAwBDCPsCRFZJ-5S5_AA:9 a=QEXdDO2ut3YA:10
    a=eX-Bu5Fvq_kA:10 a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752160AbeERNWI (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 09:22:08 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:44814 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751909AbeERNWH (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 18 May 2018 09:22:07 -0400
X-Google-Smtp-Source: AB8JxZr+izH5yBh6Dxa61I8154TeSJdQX5k7WKLeIlPTKP4rQqUPTM0J1zMWy4+mc5W70sjf3Brsmw==
Subject: Re: [PATCH 4.14 00/45] 4.14.42-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180518081530.331586165@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <e2786da8-7421-2e55-86b1-fa07d94f7664@roeck-us.net>
Date: Fri, 18 May 2018 06:22:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180518081530.331586165@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/18/2018 01:15 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.42 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun May 20 08:15:14 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.14.41-46-g879085a:

Build results:
	total: 146 pass: 146 fail: 0
Qemu test results:
	total: 141 pass: 141 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
