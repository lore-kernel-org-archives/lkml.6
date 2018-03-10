Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3418695-1520696717-2-13061087655683278003
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520696716; b=pjr/lh0Mj6QdA/sxPjO8dESoLZh0jUl2npW65q46x8DkGtj
    ouFs4QLq/6iPQIn9DbAqLdZ9dhLzjZ9ZKN15JzTUkRXrTmO5wSEcWqeQxHMN4Jwp
    LBniBX38WkATbC5eSfvJ7OTt1soG+uY6kviT0pW8Y0GoGUNl39jXlRqy5hh5hRqI
    dRVGdGMyHuglJKx2ZU3ZOkDgEvRNUm1C7dTUKcAw+rn6XJj2dQJHZi4VVh9VLySM
    uEehabKzvleN8XZQHsfSUnHhbA6h9coKRph92iWcugYmeMB+42qj03MTueYqiZs1
    OZxDlR/u6sZJ99k3OGG2MGaLpHc0KUskPvfV3FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520696716; bh=2pkXHwUx8XjCzVazJPUrX2sCD//cCHxbaaE3DGritmo=; b=Y
    uASh9jQK1+FbeAkLIDp7oKHWq7zOo03XoyKGtYsqVCAzqqSMq+7Ug0kdWlC7gVuH
    q37xX79/JG/POOEPYTrBTt6cO07zpBzbSGtbx1shAnZMG7/i5U6uXXI9A3tIeFy6
    Lrj+KHS4288f7MGJHx0Im58285Rs8ilm9rcXiZKcCr1/OLY8jF46rhjnFu5GdB2o
    A1ZrkrDrcRpVh4SLEDBkPRAWc/G3Uf1oKhd/y3E3TbF+CqV/r6yAgH1gRu9XEwFG
    sftFaXyOWvl5Ld4GgvvnHAVDw116NtRFa9z1Yif6m3e3t9npgvk6g6yKHkRjHBjr
    ZUDHkHVq9T+SCQF8xrWeg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=NP2uu4rT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WOTnrN1L;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=NP2uu4rT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WOTnrN1L;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932359AbeCJPpO (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Mar 2018 10:45:14 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:45354 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932150AbeCJPpN (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Mar 2018 10:45:13 -0500
X-Google-Smtp-Source: AG47ELvEVR2xfELlosoueiGLqfGL19olKYa1IuOZpYrGOvZ9hBtDxuaDzHxsakeOZbtyGmyfNJMH9Q==
Subject: Re: [PATCH 4.14 0/9] 4.14.26-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180310001828.476933393@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <f7c681ac-e0e3-3fff-6f6b-a5cb1cc6aea9@roeck-us.net>
Date: Sat, 10 Mar 2018 07:45:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180310001828.476933393@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/09/2018 04:19 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.26 release.
> There are 9 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon Mar 12 00:18:16 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 141 pass: 141 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
