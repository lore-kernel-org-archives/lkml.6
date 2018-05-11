Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4103318-1526051424-2-4163876399551070199
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526051424; b=mtdhAgt78/nW5e9ikR6kEWJ+Wl798rQzdPEy+UjgQTjzAR0RfJ
    kW7pQeS/3z5rQbTbXxrgmcj637jE2zvk5mz3T9VOOkzEQctOWNlUaBRNGG3Xfcgr
    p0+qd0flk6q/5wkGkQXzn8me3cH780bxcTu5JhZOM4jXdzHRdQvVrF1De4jYJ83u
    tRMMyEHSXIDIatMm+wV+/RCsSN95Znl3FMgCphF9NZZYaOrw+p1HStE9K6TYix+Z
    4O2PKVC53N1UIDdngWzhXU3URg8Moy099KDt6m//FOqsRzhSgYRyXR3Xa312x8Gl
    D2irO4ZJ4RV8ZQSliziTSnBJzi1b435GHKlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:message-id:to:cc:subject:from
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526051424;
    bh=yejiybuLo7ji1FgplWVFm2Wg5tLxAkFjufDrTadx9bs=; b=nnIf7fpRfLcA
    FglupL2AtvL/0VBkpMTyGL9BBuX16n2bJnUIZpZeOaCifpVz+z88Wr9FqayRoPwB
    C5ybga1QE0YPtsoJWGUPyFNluQk2ALWpjwtONFHPa/pWgmdLsnDo4AB2CTElAvSp
    NoVP5zeLkHZjzXKcfbN/tUQXK95vbWaPsk6X4fwYQFL3MI+6dG51dCk30scc1T/z
    0A130TFPEWRJVfJlVPNJ9IekmH4aCiVYoMddcA/9j7onWH8HiCuTwbHQWaKKMdW4
    9k1bOyKW6WaAOJVV19LajpldYsjfHJifL1+P2Ts9FnY0w4OZKvtZm5TefPUblWoA
    I6CbzHVxAw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=davemloft.net header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=davemloft.net header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEiJ1qVXHXGWPQAs6p3MEtuIIuOdrCZWH5JJPNgfaN99JOlDg/i+j0VDnlIJ0Sv/nqay/J9RggSeGyTJYqGP8kA281BVyLU6rLnqdChWcQHpG8vSX+E9
    dCYHlTgHYT8ZUksBuQANzpwm5f9stSgG3CoZDh26L2t8xJ+U+0qCduGkvW9FMPMgyPINv3nqgSINlbXcLfIAHisuhQo5ovYQDtS/UXyX1ok4G8BHQYr15LRu
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=7CQSdrXTAAAA:8 a=J1Y8HTJGAAAA:8 a=2Cfmxp7ugPhldnt4tCsA:9 a=CjuIK1q_8ugA:10
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750722AbeEKPKV (ORCPT <rfc822;linux@kroah.com>);
        Fri, 11 May 2018 11:10:21 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:46782 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbeEKPKV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 May 2018 11:10:21 -0400
Date: Fri, 11 May 2018 11:10:18 -0400 (EDT)
Message-Id: <20180511.111018.1869809966358964133.davem@davemloft.net>
To: Dave.Martin@arm.com
Cc: linux-kernel@vger.kernel.org, ralf@linux-mips.org,
        jhogan@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, mingo@redhat.com, peterz@infradead.org,
        rostedt@goodmis.org, oleg@redhat.com, linux-arch@vger.kernel.org
Subject: Re: [PATCH REPOST 5/5] sparc: Use update_thread_flag()
From: David Miller <davem@davemloft.net>
In-Reply-To: <1526051104-15995-6-git-send-email-Dave.Martin@arm.com>
References: <1526051104-15995-1-git-send-email-Dave.Martin@arm.com>
        <1526051104-15995-6-git-send-email-Dave.Martin@arm.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dave Martin <Dave.Martin@arm.com>
Date: Fri, 11 May 2018 16:05:04 +0100

> This patch uses the new update_thread_flag() helper to simplify an
> if () set; else clear; construct.
> 
> No functional change.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Acked-by: David S. Miller <davem@davemloft.net>
