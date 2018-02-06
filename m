Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1311000-1517927369-2-14905109788725040296
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517927369; b=V8uB9K0MF9FRo0VGXMPhN5WOiG2B2xEuXd4UJAZ/iGj3VM4
    EGBKK7krSwKzhXCwfDE5jMjRDLYkZ1GnpNCN/oJhBCa9sR4hYPT4tthdI2x9MSJ9
    gINcWn++iqke9EG2m+KC8m9MXTzRzB5bbf6G8DjghxUT7cuidN12zxaJjszEOmsu
    OREX5TndfAMKYW0bc11RsVDwuWzA/QdvUO9mT3/oYbGBGf93rauWTSbHLyPXwodI
    gXhjvungYn5tubU2DiPLHLC4QK+nwsg6z2DVqOs7oQ3LzKRFv4qVjkoGS3kCSyXB
    rt+VYjkoc6voBdpMw4G/wBn/USJAolGLAKiF4sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517927369; bh=XCgvl1+/shd1feTjYixLC6RhUahgES3koOMKKhEMv0s=; b=e
    QsCBDe7wMdootTIozwRFOjMZ2FOg7ucCj/JOkpj2yhvPC9PFY2MSzcKspZcrOZoT
    JyMftR1KoPdjjSI3BEuuWqsfULg04taTbyLP5zOkrSYUqymtmdX83K7/lbw8PjSq
    +/J6zo+yTBi2y29VUU7M8PwSVdJUcvzyK0DLfstDTsLp0CXGrlUVgzweJp/2yXa2
    gsdEAusdWBhDlb4xD9len9C3gpehrynJsqymeBYdc1IW0wkks1QweEAsCBKbxy11
    Pwb9XSfoBbDd2aFPCDXPz/q6U9jJZH/vd9X1fjd+zPOCc7TGeK3Cp67z5jo+b4rp
    O/+02atb/qCffDmd6UIcg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=VSoQ/yf6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lJwzxCPP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=VSoQ/yf6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lJwzxCPP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752493AbeBFO31 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 09:29:27 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45845 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752448AbeBFO3T (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Feb 2018 09:29:19 -0500
X-Google-Smtp-Source: AH8x225w4WpWURlouVOAIgbxe9RpzTRR1odjAf6ZkphnUx2u6rzaF+tsGj5KjbiKTnClYWwMEKJoog==
Subject: Re: [PATCH 3.18 00/36] 3.18.94-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180205182351.774761393@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <281e75f2-ee18-ed31-6953-402c3cfff29d@roeck-us.net>
Date: Tue, 6 Feb 2018 06:29:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180205182351.774761393@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/05/2018 10:23 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.94 release.
> There are 36 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb  7 18:23:41 UTC 2018.
> Anything received after that time might be too late.
> 

For v3.18.93-38-g9193bae:

Build results:
	total: 136 pass: 136 fail: 0
Qemu test results:
	total: 112 pass: 112 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
