Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3106191-1517473299-2-8655461275117293984
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: yes ("Address greg@kroah.com in From header is in addressbook");
 in-addressbook; shared/fdfaecbe-d8f0-4518-a17e-0d89bf6dc529 ("Greg")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517473299; b=nPBI8MqYrZcUWp0QNQdGgYnQP2HMNbWakgx3AE8VntK7CwA
    NrqSnu/6GgKb+YIldtPpS/TnY0BQ8ox0L+P6noLzPYoABLk/ppMO1ji5UF5lezH5
    dbdSpYZ/HkdfdMkkWrwH5XTUCVmGc/nDp1TFrwsgXi0ZPF1BVYPF5WoGwIqwbPTx
    kba3ciu0ks79XMbJWEg3JkVgrweeP2YEzJ2BXLXfR+VxuHLLawP8uBd5S5qmOpmf
    yrg2EI3Nki3D2E95ce9HTIcs0xKsTD/jEDFDvA7tripIpmw813EVAdI4XciRzFJn
    tkw+Hw5El9tuSxJ2LJeSFbwm8q/SIIe+w1z9SGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517473299; bh=lCPW0HYXDU7LNH9Lfr1kdb30Kn
    V8DAyHE52cMOvE1K0=; b=SofuahYZFVLQcbto1ldqsZcBLmHQ8EwMOXfdqz19BF
    k4CaM8D2RnZHrnTNhmKHSQ+l1CY3o5agT2FulTU24xI3M6JBPq25VaoKQ66w6AHI
    f4UXRlN7vwK1rntkA6NHXIMenXEGijoQvRWZ7aMEwHRa2wCNlEWSqGpghDDNEfuH
    V+W8eR/ljbpdER/P1pAIjt7OjONNlR6IrNxOugGHpWQ/7WL3hdAJKrAXHy3LZVdQ
    J3vI7ttdJA22NNLrLxieWNlFXau6hL1sjbO5UCUVMucxwLzu58YRb+igMDWD+8nE
    mduzXPgSINOV4qbnjy2np52F9KFD7omz1JMiyf4uuTdA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=XtWBAJlc x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm1;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=XtWBAJlc x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm1;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751774AbeBAIVU (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Feb 2018 03:21:20 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:38971 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751583AbeBAIVT (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Feb 2018 03:21:19 -0500
X-ME-Sender: <xms:_c1yWirrtUPKBUMUuKsIGt4PuBYyZN6m3DowFGQfg9tHE_4rW4bvYw>
Date: Thu, 1 Feb 2018 09:21:16 +0100
From: Greg KH <greg@kroah.com>
To: Marta Rybczynska <mrybczyn@kalray.eu>
Cc: matanb@mellanox.com, leonro@mellanox.com, saeedm@mellanox.com,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, sean.hefty@intel.com,
        hal.rosenstock@gmail.com, stable@vger.kernel.org
Subject: Re: Backport Mellanox mlx5 patches to stable 4.9.y
Message-ID: <20180201082116.GG15896@kroah.com>
References: <622645763.11304810.1517303571694.JavaMail.zimbra@kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <622645763.11304810.1517303571694.JavaMail.zimbra@kalray.eu>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Jan 30, 2018 at 10:12:51AM +0100, Marta Rybczynska wrote:
> Hello Mellanox maintainers,
> I'd like to ask you to OK backporting two patches in mlx5 driver to 4.9 stable
> tree (they're in master for some time already).
> 
> We have multiple deployment in 4.9 that are running into the bug fixed by those
> patches. We're deploying patched kernels and the issue disappears.
> 
> The patches are:
> 1410a90ae449061b7e1ae19d275148f36948801b net/mlx5: Define interface bits for fencing UMR wqe
> 6e8484c5cf07c7ee632587e98c1a12d319dacb7c RDMA/mlx5: set UMR wqe fence according to HCA cap

Looks good, now queued up, thanks.

greg k-h
