Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2353606-1518083026-2-12858565409578900670
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518083025; b=HKPEJuXLuhL1oJgpGyEEQHJjcLfeIHTGggLrjHZL4JMvIoc
    NI2ZCAiJYBTtq7kF+wahArZYajvI9uRmWNoAjVgcO8KGMkBcd6yrpWmdvP65IxkP
    PmOvibkILZTVq0Qg+aCKSz2FW0ZWIQhxzp4rR0g4Y71y8H/55mOEP0KMntmkvdS/
    YPxeGtDgGRkge67UFf8dh2NILIZji3t4wllBW+o85EcvbOGfVjuaoD3L5TQQPkn3
    PO2JyF9A5zyKj/mAI2AUPQMDkhopqxpY9+KaLKvPdQ5hqZ+A9H1WftAyyRIthnAI
    oiWApGG7nfJ6+qJnJfLgrqVDzEqcgVIBZJSqGbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518083025; bh=h/uKLGf45KH7Bw/oerWkpkclyBjrLudBg/s0PPZUKyE=; b=r
    pEV0WiV4oHpLI6A0E+wGOrvSVSTeGauuhO4rAFQcYaQ59YLibSIIFPT4dWdqeGNH
    iQE7pkfT0CPrSee2TSeHMEwo05ne6Y8ei1qpadbel8R601deAgMfTZEiW4F0mrmt
    xVlmC6T0hiQi1gxu3qW/v7YOV5YVk1lEpqiVqpfFdhedyGcTxn+wyC97mq1sFohC
    uy6KYlU6vSRdyRaXsvYb82zPteyYe5rFKq4qZ/fgptWQOoyJxuTKzUuHWIh5n2Ox
    CHv3djVv86dveW606kLWzCNDuTHy0iVC5OKJi04qsqhF9OU3LAqBspOrbvoIWcTX
    jseaXxbHnliYJNb+5xCfg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751984AbeBHJms (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Feb 2018 04:42:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:41083 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752154AbeBHJmZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Feb 2018 04:42:25 -0500
Subject: Re: [PATCH] xen: Fix {set,clear}_foreign_p2m_mapping on
 autotranslating guests
To: Simon Gaiser <simon@invisiblethingslab.com>,
        xen-devel@lists.xenproject.org
Cc: stable@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20180207204740.518-1-simon@invisiblethingslab.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <da5677a0-992a-03d2-d8a5-5bc5ffcef268@suse.com>
Date: Thu, 8 Feb 2018 10:42:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180207204740.518-1-simon@invisiblethingslab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 07/02/18 21:47, Simon Gaiser wrote:
> Commit 82616f9599a7 ("xen: remove tests for pvh mode in pure pv paths")
> removed the check for autotranslation from {set,clear}_foreign_p2m_mapping
> but those are called by grant-table.c also on PVH/HVM guests.
> 
> Cc: <stable@vger.kernel.org> # 4.14
> Fixes: 82616f9599a7 ("xen: remove tests for pvh mode in pure pv paths")
> Signed-off-by: Simon Gaiser <simon@invisiblethingslab.com>
> Reviewed-by: Juergen Gross <jgross@suse.com>

Committed to xen.tip for-linus-4.16


Juergen
