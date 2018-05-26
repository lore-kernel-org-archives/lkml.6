Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1452719-1527349707-2-3619312280580625708
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527349707; b=gAfG6fR0zQFWyg6enYVKmrphYnn1Ty+Yz2+u691r55kmav2kS3
    95obNITDYEu7oK91QL9Zzg58nHs9wMzKU/TAwfEi99BRvNJ6VxpOvXEHWT4R8HZx
    hs6sukoiMPp4PbW4iPp75IguHIpeJqaeOVckUFhwEMvoWBm/2spD/RCqhUiRiZjY
    4yXPBCzA9LcVQBytRKBXDm1YYQYwmEh08TCASvjuMBRq4MmvrsmmGj06z9nbO/lM
    Bze7QwNNByKbXKiFmyqgZI+Du9uP+CCo+Y7E+tRSlpKyoV5wvTW5+nquwqfdxOQv
    mX2F+L6LaTkH2XZacDs2qYS37x6HrAHRZ0mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527349707; bh=/9dvMFHZ+WAhxm6S863Em1q1Q3tNCV
    wkkrQvd8NmXO0=; b=EPOFnh/eileb7ZMpjTNTws2S2wu7MwlkEXXRVt+hpmSob/
    fP4MfSsGWQG8FzKvYf9f7WLThf09kpeqnGwDS3Fjozi/GPnmkLiLSVxtivBHC9Gq
    CMQV6/k1Jn+E/zUAH5HBWnSPBZmAe/wbDgnhNmiImTOdoLJQ7yYdJjX22xWQqBHM
    1OusqBjVXaiY8+zW8gRRIyWrJ7shvcZJKzUzKpw1qXweqlOE5dvUIE5Mu6Yki7Wu
    vyO2OGVsp+8WcEvdMDxNXDAEmp3a3VTsO1v6MTIjw6jHVGACMVFU+mG08bqB51RQ
    VxN7nV1g9X+GL6ZcvsrtW+Ycq/7mJIFDt1U2j1Nw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=D8hyC/XW x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=Y7vp68j9;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=D8hyC/XW x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=Y7vp68j9;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJX9bSg6nDEWmiAhMQ+ZQsiOxUny32nd2nMBitjx7meAgH5sJDKPIWFfFb5m8Ob5BOMB2fYw0vEhtdo7EbO/KHl9os8+TIGA18OtYnMhi7CYgJ/KXdNz
    uPEppiLHOLGO8B1lwg694W7tcB9ewXuoo5cJnwOzRmDT4xg/uNgspvAZPbJZYDpOeTCHV4ijCDa9y9TkWnxuEzVA2EMdIqUEEz5X3mZf7XuS2bVBM1T/LyeI
    MEEDxHO9jZtwRqUBoqL4AQ==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=aLjZf_mOksQA:10 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=em65UJ7koI3Hv4cHiHYA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032128AbeEZPsY (ORCPT <rfc822;linux@kroah.com>);
        Sat, 26 May 2018 11:48:24 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43744 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032125AbeEZPsX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 26 May 2018 11:48:23 -0400
X-Google-Smtp-Source: AB8JxZoBF9H7I/I1n3mojUQjudDnuvtjHasfKeY8JbPrhTWnRmiS7SHQ0jv1sv3Zt4Yhv9sWDh8ziQ==
Date: Sat, 26 May 2018 18:48:19 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Cc: kernel-hardening@lists.openwall.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] proc: prevent a task from writing on its own /proc/*/mem
Message-ID: <20180526154819.GA14016@avx2>
References: <1527346246-1334-1-git-send-email-s.mesoraca16@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1527346246-1334-1-git-send-email-s.mesoraca16@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, May 26, 2018 at 04:50:46PM +0200, Salvatore Mesoraca wrote:
> Prevent a task from opening, in "write" mode, any /proc/*/mem
> file that operates on the task's mm.
> /proc/*/mem is mainly a debugging means and, as such, it shouldn't
> be used by the inspected process itself.
> Current implementation always allow a task to access its own
> /proc/*/mem file.
> A process can use it to overwrite read-only memory, making
> pointless the use of security_file_mprotect() or other ways to
> enforce RO memory.

You can do it in security_ptrace_access_check() or security_file_open()
