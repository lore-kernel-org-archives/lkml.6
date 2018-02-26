Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3229654-1519661845-2-16662407191769476834
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519661844; b=fdJfqYQZebvmb01g+583DTLi6H3+Fk4d17ttMcGNeAyMMcl
    5/la1/Frd5YysUifhg9PuhrQt2PMJh6wRC/Xmgme3qnpCieeZCAUP3HoxVQDgMjt
    BM1qkXeMl29Rb2q/+W07phyrVwVtB+Sfolq1Tc5OuEjJe6HhWuAlT9UzLGxZDw2C
    N4Ckio9cSqMWxalPNeOqDZKGTFWxk3DGV65m1of8HQS1I1l85H1/3eL8jFDGNrbr
    XvimJiZaugctF7k3JVKaG/8jMPm1nk+hXYSfdjVBQ60HcyTCg9gKpPUj0IRHx1xq
    gejbQltnFlWyjiPHdDala8qkIhfv5ZbAk6E72aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:date:from:to:cc:subject
    :references:in-reply-to:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519661844; bh=cgrP7PgDiPPHfJDQaTt1rmkPUnF0ybqqSFfyT5/H+hU=; b=L
    kNZYlx9RkQycjukdRH5tuDcY68Fi+7/yp2S4RE5U4wkrUegJ8ufAImkWQ0UlX7Wa
    /5WFLsrFp8njuOw6fj6cARjyim094UkOhKSLtypJ+inok3/czsN/orhUJ/wKbZLY
    0Q/S5BxVa/bVYYZZtxstNmif9O+LSPLYoEEVOr5b8sTc20a7ahSE2Yg7io1F9WSS
    7+0M2kbreJRZFJ43A43LUUJFgppCBYHN8slojM8foKZzWQ+KfUSkpHYMF54L2k6i
    YPFm+MlkK9r6RxqiG2P+YFWoDjdoQ2hyQDTBSzsjwCKSOzTO6YtvC5goajZDENHU
    fCkmwyuhGXNsIAfUXofdg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751446AbeBZQRW convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Mon, 26 Feb 2018 11:17:22 -0500
Received: from prv-mh.provo.novell.com ([137.65.248.74]:46828 "EHLO
        prv-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbeBZQRV (ORCPT
        <rfc822;groupwise-stable@vger.kernel.org:7:2>);
        Mon, 26 Feb 2018 11:17:21 -0500
Message-Id: <5A94411C02000078001ABDF1@prv-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Mon, 26 Feb 2018 09:17:16 -0700
From: "Jan Beulich" <JBeulich@suse.com>
To: "Juergen Gross" <jgross@suse.com>
Cc: <x86@kernel.org>, <tglx@linutronix.de>,
        <xen-devel@lists.xenproject.org>, <boris.ostrovsky@oracle.com>,
        <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, <hpa@zytor.com>
Subject: Re: [PATCH] x86/xen: zero MSR_IA32_SPEC_CTRL before suspend
References: <20180226140818.4849-1-jgross@suse.com>
In-Reply-To: <20180226140818.4849-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>>> On 26.02.18 at 15:08, <jgross@suse.com> wrote:
> Older Xen versions (4.5 and before) might have problems migrating pv
> guests with MSR_IA32_SPEC_CTRL having a non-zero value. So before
> suspending zero that MSR and restore it after being resumed.
> 
> Cc: stable@vger.kernel.org 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Jan Beulich <jbeulich@suse.com>
