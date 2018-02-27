Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1654150-1519743350-2-9234189600964173386
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519743350; b=wwdSurvZHb9Vpzyh391fUdaDpQJN1YC3E2Kogu3S0v+pxwb
    7MoKDRj6MReVLrL5Hbcd2aPRs3507YE8nq9dwXIofUi6cupgBPsH1wSGkrIf11A+
    bKnmdfY6cb0zygeBOvu0p1Bxz9PNPVsYTBI2hJMrKjckdr9aA9OT/sTR4oV1xhcc
    mZaeSW9a9is/LBmYy0pFOUD3MtBN9VR8ULuGKRWHMY78Y+2Thx5J3ehr/viUFoPe
    qRvqFdBlswlXrEteUF2HfzOew0lCEeJfcYBMlVUoelTtatoL8X0I9zXXPcRqpjYr
    S/91IOOZxfWDtp0LcqqoXUsYpagqdkrPzRWDBeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519743350; bh=3Yd19ov4w+NMyuOVTAx+t2zaxyCg8F65uoecc9lcsiU=; b=M
    WQBmn7hvARQqH5RGcbKwyOTEag7DGrIU2q71keie8qwE8UCeymYLwRnuoS0/MiiK
    li4JyrjSKkUa3VBLHj5YZwXJBiMg9qNR2tGzFSVoH0LyKrcCMR0h4B7IuHirDraY
    HmfgNlhuqQxAvSr2BW+FBrU1DaPpB1q2WEPSMbgivRQpBZOrkbnBs68EDnnfdJMu
    cNu2RgEimXzhVmrKjaBe0/DezD8ZgPjeQP6Ufj1LBE60Tqqaah+QSNoyTjJ+c9ms
    xwjO2teyQgKySmwKyxn8Vc2196RiH44oGtiyW6fC9PvNk9XEC1FQy9JcTdMV9t4F
    axUQRabFr0pqVYDMERdXw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Np95t91L x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=L1So4Qns;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Np95t91L x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=L1So4Qns;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753167AbeB0Ozh (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 09:55:37 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35668 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752798AbeB0Ozf (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 09:55:35 -0500
X-Google-Smtp-Source: AH8x224yRd+ni50Dedpp97ZoTIJIn5NouFGNZK2tHPKb0/uLk8zSs1OVJxFl37kDOfhMu9PEnaCCig==
Subject: Re: [PATCH 4.4 00/22] 4.4.119-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180226201558.681421374@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <0e990947-c343-4b4b-f9dc-a6d945b27170@roeck-us.net>
Date: Tue, 27 Feb 2018 06:55:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226201558.681421374@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/26/2018 12:16 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.119 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb 28 20:15:48 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 145 pass: 144 fail: 1
Failed builds:
	xtensa:allmodconfig
Qemu test results:
	total: 118 pass: 114 fail: 4
Failed tests:
	xtensa:dc232b:lx60:generic_kc705_defconfig
	xtensa:dc232b:kc705:generic_kc705_defconfig
	xtensa:dc233c:ml605:generic_kc705_defconfig
	xtensa:dc233c:kc705:generic_kc705_defconfig

Same failure as with 3.18; presumably the xtensa patch does not apply.

Details are available at http://kerneltests.org/builders.

Guenter
