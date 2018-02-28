Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-848153-1519845740-2-16746011179844573487
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519845740; b=cFMIAfayQ49TSXTw2vT2vOY/94JgrwOVr7Aq5Iy3lj5vv0I
    YkbhOguOnLWRKo47/ax8K0gcpbhJGy47WPC7llkrbwHbXFy2Q7M5JgMIfuQ6UHZ9
    xY3TYEjPSyLbiab+9ouBpCPdJL3sTqevfqSJNEr4jbsEBeiBGjzJAp98m5KffI2y
    tecxlyyws2uDKpNt3k9nTaBUFU9GTr6NMEycXGHaoDDcnc+YbVOdZrn2QQdLmzLo
    f/nUiXrhi/K63BSLJS96nC3jrGo/DeMMQWhb+iXMytwv6vywD3UVjXoYus0q3seD
    gljSsLB23oXVMzApagK1LpPxJbCBki6L1oHrV+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519845740; bh=wN9bp+O0muhcb8BTqFuES8Rj1PfyFXouUlbfZbjpO24=; b=K
    5JgWcLZqMqeqk4du8cNZib7Ue6MwDK7tFOZ6MUetXO/WpfPVU1jtCAUvfpUm+Gjg
    tPJb73x+fckReE7TV8Ypk1/0IgicTqlwTmGQEMV1n7+gUJUEpGGieazXeQ1Q/+7r
    tc0QzS4unwqEPfMj4Vq/nLsfaJAJDhai6xERPC7cOTxVN4kS/HvjCUu+s4/YQ/Y9
    wQmZPyCWcYIHdgeW+tnbpoKHKUjo9WjDO2th4jiP5jfbvrNNJWr9V4dsiOrpuA4v
    ik5nYPsicu1jcD0rUsdcMmgZ+FxDtvX5FjyPEZ+1cKa3WGaasc6WVDc39TiZaD9t
    60uyHAjif09rfoDqmSmuA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933466AbeB1TWF (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 14:22:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:43099 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933197AbeB1TWD (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 28 Feb 2018 14:22:03 -0500
Subject: Re: [PATCH] xen/pirq: fix error path cleanup when binding MSIs
To: Roger Pau Monne <roger.pau@citrix.com>,
        linux-kernel@vger.kernel.org
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Amit Shah <aams@amazon.com>, stable@vger.kernel.org,
        xen-devel@lists.xenproject.org
References: <20180228091903.99889-1-roger.pau@citrix.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <bede6e55-88d3-3f61-f196-c53212abc66a@suse.com>
Date: Wed, 28 Feb 2018 20:22:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228091903.99889-1-roger.pau@citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 28/02/18 10:19, Roger Pau Monne wrote:
> Current cleanup in the error path of xen_bind_pirq_msi_to_irq is
> wrong. First of all there's an off-by-one in the cleanup loop, which
> can lead to unbinding wrong IRQs.
> 
> Secondly IRQs not bound won't be freed, thus leaking IRQ numbers.
> 
> Note that there's no need to differentiate between bound and unbound
> IRQs when freeing them, __unbind_from_irq will deal with both of them
> correctly.
> 
> Fixes: 4892c9b4ada9f9 ("xen: add support for MSI message groups")
> Reported-by: Hooman Mirhadi <mirhadih@amazon.com>
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>

Committed to xen/tip for-linus-4.16a


Juergen
