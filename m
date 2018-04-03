Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2519967-1522791526-2-8478240799240048283
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522791525; b=HOElaTF7+sHBxT6giL6u5nWHLUZREhM7hJI8qjBmLbgt2JuEPt
    gcGnl/I/SHKgH5Z2XYr+22bDUGX1MkwkLLFp62vwUmb2jRcRxsUQKQOB7pGkkztu
    O1ppMD8YkYLr9u6UZvmrfo7YIUuv/YYAyyiYkuhqlh2EDkaM57STYYSRFLzaEp+8
    b7nhXI6duZBVoN9MxM/vV7oCQ8kTQDzrZ30bqSn+pq+0cUzqQEFZzpVJvMDiwfNn
    wW6BxK5gw3Ok0p9uescHAfVYvmPBuPz+8WTPqygBYEQOF4elGULs9ZnukjD+rItz
    N50yhPvtypfcplk/1EhTMGzb7ZZdHiLDVO/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522791525;
    bh=wmMVarQwgppZlXIg6MJG1eMXGA3q7aEzDdTnLVi3Ppw=; b=Z0Od3z1qZm18
    rveGXZ/j40GYUyp/Ate1icsYzCmkHwWRdofZGo7crpCbReLaekNWjXpWWtK8TN8s
    xmJrAQFlZMmtbGjBr/3y5CIcBkHgfJ7KDPDeFIU1ahi7Cok3gMiH9kK4CTYVUTpn
    yhudmgAmIj8D3bAjreHhoeCltXdJvlqDK3mJMhiYSS5HwcIn5doIxnEsqJ1C0eWH
    Z9WZOai0p1WJ8YUsjNy1qG/BFBn0RbD+HadaWfUZ0uFz1Hwan0XZccfVlE0ccoi9
    hP9UNwOUGQ1A6UUd+sqmaJcTojEAVcpwNd8iciff+0fnsggVJwfN+FHP9P80//4V
    Jxn0ZGNvJw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH3fYD6BywAbK9V9xYQqNlLl0Imb/TkY3U8exBKsQrrdYQGZpLGrkrL1KUrZz63fdIDqznxC10yvAQ3sLN13HE2CVZape7uEPMQeoGKXDtgbf6gpK2D2
    3w/VBwgpCIIjDZcZhcUtLEHvEVX8sfGMo8/iOgGTBTqW9nXIACIH1U1zAlAb+q1w3EE0c7OCpO2IGJ0GPZj8Fbpfbf9mFC9/qs4GzNT9FgbCzatSb35Zg2yL
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=doffJ-M7DsTEhnf_Q4AA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753598AbeDCVim (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 17:38:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40060 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753160AbeDCVij (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 3 Apr 2018 17:38:39 -0400
Date: Tue, 3 Apr 2018 14:38:38 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: nagarathnam.muthusamy@oracle.com
Cc: linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        ebiederm@xmission.com, khlebnikov@yandex-team.ru,
        serge.hallyn@ubuntu.com, oleg@redhat.com, luto@amacapital.net,
        jannh@google.com, prakash.sangappa@oracle.com
Subject: Re: [RESEND PATCH V4] pidns: introduce syscall translate_pid
Message-Id: <20180403143838.614ecc083835d07d409a699c@linux-foundation.org>
In-Reply-To: <1522706249-11578-1-git-send-email-nagarathnam.muthusamy@oracle.com>
References: <1522706249-11578-1-git-send-email-nagarathnam.muthusamy@oracle.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon,  2 Apr 2018 15:57:29 -0600 nagarathnam.muthusamy@oracle.com wrote:

> pid_t translate_pid(pid_t pid, int source, int target);
> 
> This syscall converts pid from source pid-ns into pid in target pid-ns.
> If pid is unreachable from target pid-ns it returns zero.
> 
> Pid-namespaces are referred file descriptors opened to proc files
> /proc/[pid]/ns/pid or /proc/[pid]/ns/pid_for_children. Negative argument
> refers to current pid namespace, same as file /proc/self/ns/pid.
> 
> Kernel expose virtual pids in /proc/[pid]/status:NSpid, but backward
> translation requires scanning all tasks. Also pids could be translated
> by sending them through unix socket between namespaces, this method is
> slow and insecure because other side is exposed inside pid namespace.
> 
> Examples:
> translate_pid(pid, ns, -1)      - get pid in our pid namespace
> translate_pid(pid, -1, ns)      - get pid in other pid namespace
> translate_pid(1, ns, -1)        - get pid of init task for namespace
> translate_pid(pid, -1, ns) > 0  - is pid is reachable from ns?
> translate_pid(1, ns1, ns2) > 0  - is ns1 inside ns2?
> translate_pid(1, ns1, ns2) == 0 - is ns1 outside ns2?
> translate_pid(1, ns1, ns2) == 1 - is ns1 equal ns2?
> 
> Error codes:
> EBADF    - file descriptor is closed
> EINVAL   - file descriptor isn't pid-namespace
> ESRCH    - task not found in @source namespace

Presumably a manpage is planned?

This changelog doesn't explain what the value is to our users.  I
assume it is a performance optimization because "backward translation
requires scanning all tasks"?  If so, please show us real-world
examples of the performance benefit from this patch, and please go to
great lengths to explain to us why this optimisation is needed by our
users.

