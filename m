Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2020860-1524925944-2-8692174993175601146
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524925943; b=SFEskRc/STg5Hx37PeCqgfAMjZ6MpFXYIkRmpPvNQ80cWclYO6
    bXWiOOZ/vIwWUEuBeX//4Grep4WO832tPxVGdVUJLVlKEvckImONWxkISN4+SK7c
    ESF5H157tG8o7ZiUCML519dX/DG9/40VhCGhLOuccTTvR04N4nkzOwSTVGkCNpej
    Zli2dNu/3y5GzMEqXUergval41EHke5VXiL63WSNGzqpAdFVrrEM/kzjJkbmNXDF
    LqwcM2+pFn3WAdKOlDteyIdEgkfCHAn9RB6S85BdfnzBI544dpRemPBBofoqZWpX
    qZJ3w/8CRNvLfJr8utwEPqkieBYbz9JinUnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524925943;
    bh=alerWw8Uuusk6D2g16jVy8sq1s1yvfVNYk2kpPYI8Gc=; b=GCTrBkdEAIEQ
    p9Zj2I05CTY7cjoJYEZJ5/PpdNNf8EkrlfV6PU8A+gdGI5W+In848wMFekDrgxKr
    1Ao4nhXL1vS16R0eD/Igiv0GevYSRNn4uoGqyM00YK3TrYVJ8iz2Ozoe/gtn1VlP
    g/lJP9FLeMkIyKbRMfyrP/TzGjV2IuYUNF6xTXIcrkzvcpCEfTdyp1/6RTJZyhVU
    6XEwkamEn+zHWvL7FxcmBpBiD1NFQzysElmJSZ0PhOnKCroqAXb/g+WRTnsGeSC6
    iTBhbnG/zG4OKAriV0oFowwpyxEW2UuMm2gdEEKOA3FZ5TwFV7F44Aiba3H34z26
    Mn03BCr4hQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Z3qqxPp0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=L1xQbGWF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Z3qqxPp0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=L1xQbGWF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKT0m8yPDobcSSS6HeP9l0MpRio36eB81tpzQbyURMavzeEHGK8MNraFXkWIQomxKLT1HkX4GaWdWeHDYpBXbdm9Y9z/SEVBWVqDJy9dz4o4mMJwLxo+
    S/vPNq0IFZsF3U7p0De0C2bKXOdA+hzKuc8ex72kkVNdzUSB/cl0F8aDa9LDP5++5WGDr3+80NuQoIh/3MZTlYyRuKNbpP3sL0uJHsggXU140gjZWioIRXc6
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=9hA1FEcAjjIA:10
    a=Kd1tUaAdevIA:10 a=YWtRXzOXAAAA:8 a=jt2qzfFujGXgx7qftJUA:9 a=QEXdDO2ut3YA:10
    a=eX-Bu5Fvq_kA:10 a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751354AbeD1OcV (ORCPT <rfc822;greg@kroah.com>);
        Sat, 28 Apr 2018 10:32:21 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36814 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751342AbeD1OcU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 28 Apr 2018 10:32:20 -0400
X-Google-Smtp-Source: AB8JxZoZ0KpfFgy1XFul0oj8KMMHyR2/navn5jnhkvuyZiHIi+Bozx9AMpK7apmrhNlPb00zihaKNA==
Subject: Re: [PATCH 4.16 00/81] 4.16.6-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180427135743.216853156@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <fb2e3a46-bcb9-8b72-c5b5-92c9c91698ce@roeck-us.net>
Date: Sat, 28 Apr 2018 07:32:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/27/2018 06:58 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.16.6 release.
> There are 81 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Apr 29 13:57:21 UTC 2018.
> Anything received after that time might be too late.

Build results:
	total: 143 pass: 143 fail: 0
Qemu test results:
	total: 139 pass: 139 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
