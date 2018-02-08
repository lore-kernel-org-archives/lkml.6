Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3538830-1518121475-2-6503695681801058444
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518121474; b=FSgdhDjfiEQuAM4yr85/px8illfkrqT8OPjD8gYMlVDP93I
    mFBma+u6k/PjzOCDnl/VUZhn6V+Y4iDoy+JhOxVoWGhUFKDquR2ZzZgSLXo4LQae
    9jC8ZvizkfCJhEyHiKHbftp7TUg3VNyj7EABNTROZrKCosHRGZJc5Fp90/wfFn98
    Ppu9lqend1EqvR7TaOk3g6dEEMu3ISEVZwUrrJSL3QW046E8HCT9OEtkDHklVsvS
    dcGx8kUtDMKU1ZHVYkxVshMIINQiFqrg7iXM9Juei1YNXoAEHzkkqrqYYKV/d96Y
    w9OTx1RVvWs6XqT2IfaxwCt8gQqZgLePYci96rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:message-id:to:cc:subject:from
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518121474; bh=8RUUuTwio/9I5QlI+ehyXKvw/ZWmF3draHyljl3tMJE=; b=g
    bS4SMTGURBc2lFUm4nG2rVxfgiBzoGmNFGrr4DnHMBSbXdQIYnpcCovhODyQFmLZ
    OZuGkHX6qzM4So63ywQ+y9isFCBU4hsMphWYujmVvHuukC/bSfHOcCTq/a9MacIb
    K8Vju0lBD8k0APvqSLGLFVXowzVMGk3g8mc9G5ILwYAZyNozs9msAo5msHd9h848
    LZLFi/wjnuaHlezr6Akc9vVFevyEMHqAiLZhxj/e0zXJtcHI+I6Sd+yaYJkxrS+t
    9coPaCTgdXykLF7UqmdWNzrWJwS1QU4e6aHsogQz0/3lOdHRqWXibuuFSkGvjmDz
    ZqBKPe9DFPeySPs9rPEPQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=davemloft.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=davemloft.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752172AbeBHUYc (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Feb 2018 15:24:32 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:49024 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752126AbeBHUYb (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Feb 2018 15:24:31 -0500
Date: Thu, 08 Feb 2018 15:24:30 -0500 (EST)
Message-Id: <20180208.152430.815938637029162565.davem@davemloft.net>
To: dan.j.williams@intel.com
Cc: netdev@vger.kernel.org, ebiederm@xmission.com,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mpls, nospec: Sanitize array index in mpls_label_ok()
From: David Miller <davem@davemloft.net>
In-Reply-To: <151807166425.3807.8813780890075479680.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151807166425.3807.8813780890075479680.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 07 Feb 2018 22:34:24 -0800

> mpls_label_ok() validates that the 'platform_label' array index from a
> userspace netlink message payload is valid. Under speculation the
> mpls_label_ok() result may not resolve in the CPU pipeline until after
> the index is used to access an array element. Sanitize the index to zero
> to prevent userspace-controlled arbitrary out-of-bounds speculation, a
> precursor for a speculative execution side channel vulnerability.
> 
> Cc: <stable@vger.kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Applied, thank you.
