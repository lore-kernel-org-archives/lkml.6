Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-617694-1519837077-2-12720571713033473812
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519837077; b=B+LPQM8Nj+2wAf/8y8G0DgfMboclT8kqoHmk5MMzFK9ucHS
    To1ZHs258BZRbD95J/hZNycdC1MkJF5HxfhHs9KgFYiRTDGnJe2KQBxfqZCbIgID
    4SLWtPfwa7tSzhxrJu0nOyjXSAhqordzv90w/3Zj0KwYgYdipBniQgAyFsIU/9sA
    5JjuzgjFxANWfMOASRIsgACwZu4vSOJyS8PsxPl18YbFGGyO1DhLngOaZ2KJ8WgX
    9en8yqMsQ82I9Sd4eVpxBp8DERrpoVAIuWFtFnaWmjNllNJ5SsYQ6vt0u13py5GY
    +k7d4uY+zoK1MPoX+DlzU4prifgSOtdMjlTJUQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519837077; bh=GM4Vfo8TKL/ExlYkx85wjzqrHJ
    r3Y5tVSbCoYCzcEnI=; b=eiH58ybJifBzJ/xeGKhf8XxCGYbVzp6dUzBNO2+r7r
    +4RSLTUP7MQKaXYylok7jkWt9kZXiJFvhKvRRVTSGuMJF1eLeeba2XtC3gUS2LNL
    qg7HgYjioR8GhL4T1js8MpFxfmPS2e5+DUnVUTaYFIwkdt+JG+z2TV/XFXPA/wXe
    M7xtwJeJh7T8rSRFWgT/oQzozD2gqsaHyFIaFRKV5J2CyL98avDsDjpuajkquWwU
    5JOxAbWZr/wHN+3YUY04EXWLO5jpL5IWY+E4qjqmAcW1V8VgfNkk5ojciudo2ve0
    XY70XtPh2tjLu7cA5BSZu0vhCzZ8uuanjm2rhbQk83KQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=dmJGSZPD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=d8+EpFPv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=dmJGSZPD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=d8+EpFPv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932257AbeB1Q5l (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:57:41 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:42008 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932738AbeB1Q5j (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:57:39 -0500
X-Google-Smtp-Source: AH8x227KJSIn51ZRTnmRPg3dmFi2yL93QjVk1g0yPp4Mrdz3tSdnAHbbWG1xMsc7D69I7EpohWZzHw==
Date: Wed, 28 Feb 2018 08:57:37 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org
Subject: Re: [PATCH 3.16 000/254] 3.16.55-rc1 review
Message-ID: <20180228165737.GB15218@roeck-us.net>
References: <lsq.1519831217.271785318@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 03:20:17PM +0000, Ben Hutchings wrote:
> This is the start of the stable review cycle for the 3.16.55 release.
> There are 254 patches in this series, which will be posted as responses
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Mar 02 18:00:00 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 136 pass: 136 fail: 0
Qemu test results:
	total: 108 pass: 108 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
