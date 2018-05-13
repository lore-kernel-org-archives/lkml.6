Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3250283-1526227958-2-6257128186984213252
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526227958; b=B5PEKhrbfYXrHUZX1v2QtdCvk4q9pLsR6ZBkMXJpUACO0Cnptn
    IeyqWLQ5h71zulYvJYIQOsGcMAZVkTEL94rli/QVxu8+tJy+5ppBvgikFfHl+QBu
    bNRGZ0TvSgs7VLY0lGnaxGEWGxPjHQRhPZvD0swiNxphrwbaSD56uDHAYWAM5TQM
    zN5XzOwwnawgMS6dmKLXb9leoE0bR573fqT3lzHXEaRf6RWA2xf95XGcNTM5nc2r
    EVS8SJirGpn9GKtMthy9WiCk0IWmTDlKD68ZWn0o4gcoRB6FP6ISygkzF/tcUrc2
    zXLbOPuNSY61ScnzQWinEHsRb8erDz7GY/FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526227958; bh=o4WrIY3doLkyuucpjimggyLsb/ZnI0
    2hzF8aSNouEik=; b=ERq0IHuFIhhlJD9irzxpeA1ETRiFoqUPNTZkdMgb0gFXZ9
    M+M+P2WplZy0Z/BcWgwnLWCHN15pCrMuqaisfaThEtFVApWOFH6EUmHjrRFyYyq9
    ZS5LOsnka3gWOeaor82mmc762kQ7TEcIABuYNogHdUAV6Pme3RpdKSjJm5Ur3qfN
    YDujUh+9NP+L+e1OMn0Yzmuq/htBxcCi4HRfVHu7ewtvLz4ySMMTxlNGFLDW7eJ7
    T9HwTpxpzLAFGlR01l0DL9nQZDdkSTOqeU6yWXcus4IeOHO4sjeUw7x9yVqwTKzZ
    r2nK0zpnv+QmwAcQZaY1b1jlXdJJ53yMr3g+Lorg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLnoNJ/G9+wL8mcI5xfKsLzw8lAzxHWIxw6/bvSioB/a8F6IwRnBSJgw/kZxbhcKGHT41M5x/sC3VYxjlMOxXWAEaupZm8ZNqBjk3860bFr+kR9gnyXe
    9YbcXLue00WkHxOdc2YRXS/tV4vG58f99soDaV6ztdr6vxS6FJene+bp3Nx8IiKVAWujLueWrBmaxy/tALkbW/7yYiT+515cTeXVeH9VS6O3TRlPZOMLgyVt
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=7CQSdrXTAAAA:8 a=20KFwNOVAAAA:8 a=JfrnYn6hAAAA:8 a=meVymXHHAAAA:8
    a=XIR3xAj1sbsUUEFr3eUA:9 a=CjuIK1q_8ugA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=2JgSa4NbpEOStq-L5dxp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbeEMQMg (ORCPT <rfc822;linux@kroah.com>);
        Sun, 13 May 2018 12:12:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48240 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751617AbeEMQMg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 13 May 2018 12:12:36 -0400
Date: Sun, 13 May 2018 18:12:32 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH REPOST 1/5] thread_info: Port core code to use
 update_thread_flag() helpers
Message-ID: <20180513161231.GA25642@redhat.com>
References: <1526051104-15995-1-git-send-email-Dave.Martin@arm.com>
 <1526051104-15995-2-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526051104-15995-2-git-send-email-Dave.Martin@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/11, Dave Martin wrote:
>
> This patch ports a couple of relevant bits of the core kernel to
> use the new update_thread_flag() helpers.
>
> No functional change.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> ---
>  include/trace/syscall.h |  6 ++----
>  kernel/ptrace.c         | 13 +++++--------
>  2 files changed, 7 insertions(+), 12 deletions(-)

Acked-by: Oleg Nesterov <oleg@redhat.com>
