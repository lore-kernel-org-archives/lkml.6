Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2262623-1518347974-2-2053210471170293615
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
    t=1518347973; b=B1XH6aiY5IPUJdL2WwS7zF6wpZtmI+vm3A84zrGhplr45Do
    FUechIkZny2PjBr0V/93g4Y4azggUHj9HzlT/E4OKvTXAdxUiqLdiOP471/sHrUt
    d/P+zqextiCX4UzxCyX20lZY+X5F23NRlnlekP/QHUVc6wihBP+bqlg7Icuo5Ypu
    h/G1UuHK2hqgoWKm70Jzvjn02DQyj6o4cWuh0qwXeQx2DyIVeQbLWZSJ4eHxM/EF
    Os53upONXZX67Ql9k+3x1Yy+PeejM5zkuTIvXA9stDVVRUNAvDxWKJc9fUGUOqIQ
    jXZRUhx8phnfa5YrWk080nlEW0l4ZvHb6hI/xuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518347973; bh=fWQ2Qb5nOXv6cVLFAzxQnCpUpS8AyBV7CJmW0pJyR3E=; b=Q
    vto8j0gpMIJ7FetNmHBGZX+UPVWH6i2O+QAcMaE/4X7pvSvY1EoOV5OkKYldQll3
    HY0e+cGra7HJJQFyZp+YQqtXBLy3aRdYW0W6nnkGCQm7ncIE1RztLzZQa9KuLTNt
    6ma5MNEqhUQtt3WMYetlhAE8Rv+r/BD7P9RXNdOZVHoU0Seja8Ps+WA67jfU4h6K
    cEEsxPy1X7VTky8DU/eR7TbhougmlgugDAF9n26qbtw0yd5H2y7DUBE3aqHxiSnC
    MJkJXHgfc6Zh/HTTBsSkMp2tLCGO9fqoLrvfLaGe0fRcRP8kvIRSNw6ShUdV2mX6
    rhspDadf7iv9i/AXDGPdw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=UBxD/TSX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QKITfdMJ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=UBxD/TSX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QKITfdMJ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753440AbeBKLTc (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 06:19:32 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:43041 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753092AbeBKLTT (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Feb 2018 06:19:19 -0500
X-Google-Smtp-Source: AH8x227Ov278Mkd2C9yjJDup/1TPsHdrlXry4tANdMISBLjhFBnAnEholBoDTikOJeiOwfRMQOajAQ==
Subject: Re: [PATCH 3.16 000/136] 3.16.54-rc1 review
To: Ben Hutchings <ben@decadent.org.uk>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org
References: <lsq.1518323469.348919605@decadent.org.uk>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <6cf9290b-6a68-f39e-3473-e97dffdcaf8b@roeck-us.net>
Date: Sun, 11 Feb 2018 03:19:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/10/2018 08:31 PM, Ben Hutchings wrote:
> This is the start of the stable review cycle for the 3.16.54 release.
> There are 136 patches in this series, which will be posted as responses
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue Feb 13 12:00:00 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 136 pass: 136 fail: 0
Qemu test results:
	total: 108 pass: 108 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
