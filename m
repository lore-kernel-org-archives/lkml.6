Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1874556-1527163622-2-10550793824449596895
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527163621; b=I8HOV12yterKevIcXK5D5DFgu7UVwLqZE5rKcS4ZzGR9Xmkz3+
    NNm+nMGyJy6rzNtfhpOF+kR34T3fYjzGzneYyO1HAzCMWgy+TJQZ2IoU8lMBvRrW
    kWldHU7CntzKG0mTVVeZuEHkrFmcZkVw224J1/aJ/5WGDhCmOoRZySuP3f1myx0W
    yWfq2O1nN1XpbaHmVuuG95/3ttMY81DWeXHB/40u+nCP9JKSvhMYrsqf216QLwHA
    8wPHq2KgNzDu34acaLKJIq10w+TIdlmAhe0r9EyuyJrIayVjDkHsR1JEvIM6VrKy
    wlyfr9+kpaK3sNWqkatIbCRV8E+yRM8yf4xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527163621; bh=SoTpalWWio3yWzx9QuRiqJ20rTXX7S
    hQh1S7NX7qfmg=; b=AHK9DQJSmC+WhOy2xM49xtmbhnBB3IPfDRkJwh+pzNhFJ+
    ISOa3xA/8AKaeGldUneTcQRBxZodE8N+SjngXRmqpGCe2Qhpb9IO84emJ98pY8ha
    Dvgh/aqkuRn+bRbRClw1Jh8/D+b6YVQc1shgC8eEz3qw5Um/Dbe9R2iMtIkVkKCe
    l3bKuOebOxgVhE4DN4aVnzpmskR98R4b+CiVnTED3W39kKmJERtWFa77p2n0sDYc
    mJVk7Utolq4T2b2k8rWlnXoitWWBPVDW9sr41NISxlPZx2bz/8KWVvXQVeQFYds4
    sMCrdSSBJss8gEWQ5Pq7bnEkMCrlJi/nYbgN2CdQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=ROy5MLc0 x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=ROy5MLc0 x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN771fWK+xcBCGdZUWgLRZEJPNtuR0pnqN1U74nxYpGaXPC3DUXk9UQwHaIDJdsY77FaYBfUXrwmyBHfnTa2y378Nn2gJ2cF2KE/vKbk0OKBjgp+l66T
    rTg/U+PDyIz+t6vQt1lW+dqFOKJ7CyDsyJgWo8vt7BMO4zdt8f1/hfIby1A22fCcnNoe0orPkMw2eREwMgMZNsbVPCjT0b708737XuPzeoSp7ya1c6DEJKMX
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=1XWaLZrsAAAA:8
    a=VnNF1IyMAAAA:8 a=QyXUC8HyAAAA:8 a=Z4Rwk6OoAAAA:8 a=ag1SF4gXAAAA:8
    a=Vzieo5wEOH1YgFP_dogA:9 a=QEXdDO2ut3YA:10 a=8n0cvFGaGY4A:10
    a=AjGcO6oz07-iQ99wixmX:22 a=HkZW87K1Qel5hWWM3VKY:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966347AbeEXMGn (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 08:06:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966562AbeEXJn7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:43:59 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, zhongjiang <zhongjiang@huawei.com>,
        Oleg Nesterov <oleg@redhat.com>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Xishi Qiu <qiuxishi@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 32/92] kernel/exit.c: avoid undefined behaviour when calling wait4()
Date: Thu, 24 May 2018 11:38:09 +0200
Message-Id: <20180524093202.008627270@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: zhongjiang <zhongjiang@huawei.com>

commit dd83c161fbcc5d8be637ab159c0de015cbff5ba4 upstream.

wait4(-2147483648, 0x20, 0, 0xdd0000) triggers:
UBSAN: Undefined behaviour in kernel/exit.c:1651:9

The related calltrace is as follows:

  negation of -2147483648 cannot be represented in type 'int':
  CPU: 9 PID: 16482 Comm: zj Tainted: G    B          ---- -------   3.10.0-327.53.58.71.x86_64+ #66
  Hardware name: Huawei Technologies Co., Ltd. Tecal RH2285          /BC11BTSA              , BIOS CTSAV036 04/27/2011
  Call Trace:
    dump_stack+0x19/0x1b
    ubsan_epilogue+0xd/0x50
    __ubsan_handle_negate_overflow+0x109/0x14e
    SyS_wait4+0x1cb/0x1e0
    system_call_fastpath+0x16/0x1b

Exclude the overflow to avoid the UBSAN warning.

Link: http://lkml.kernel.org/r/1497264618-20212-1-git-send-email-zhongjiang@huawei.com
Signed-off-by: zhongjiang <zhongjiang@huawei.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Xishi Qiu <qiuxishi@huawei.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/exit.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1608,6 +1608,10 @@ SYSCALL_DEFINE4(wait4, pid_t, upid, int
 			__WNOTHREAD|__WCLONE|__WALL))
 		return -EINVAL;
 
+	/* -INT_MIN is not defined */
+	if (upid == INT_MIN)
+		return -ESRCH;
+
 	if (upid == -1)
 		type = PIDTYPE_MAX;
 	else if (upid < 0) {
