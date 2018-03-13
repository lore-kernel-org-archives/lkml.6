Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2903400-1520938265-2-8944658330470711834
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520938265; b=YDBQXYjZbFNrqkzFoYFWPj6TPCz8hXAhnUeVGeZbw597fP6
    30POcyxRITrQ934BFHPdkdyUEWl8RGpkbQMh52uJrUah2AkcDnHuunN/JSCyMEtD
    30U7kQooJHCosRFYli3rk5cEl+ykNmPPtFWai1t4DNSvjMScb4U5x8RooVnhQ0EV
    neXFAgE6gEwivt67ZNq3hr4V1s/FWbZ51hd3KwepMSxhKdVV3fRsEpVLhh5Ge7bM
    KynY30OFfPG5Tqbfi/RVUCHgS49UVP/kfY7dMGkw6AnqYGmVPvG5ql0JaLI70tir
    Jx5k0JWqaLMXsWL7Q/iKmvsIkOndesTtKxne3VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1520938265; bh=MietROe
    lQXU70Ta+pjU6BsNRQ3fAUjEbI0F5mKyCAbQ=; b=oKpBz758W90oSCuvH5RlAVe
    WjI2TzsToRVC6+Hck3bx9tsTE7DQ2Cg8OSREe4v91NUdfz8O3SAMEVF8DplcX00v
    lfe7/Na30egG1Bgpg3y7zUef6/9hPygQV5qIYIOsUnX0M7HKdGvP6lKsIdWdz/9C
    ZH1mPvXs7zGik9cI0/HPdeQKLRZ1KdhHtmdRyBKR/wqMxE5CFlhn/x+C6yswGxBU
    Mniu85rlwkGj9+7yoEJoZ6How6mO53EVeswwo5HfFyBMqf10OqK7wqqLIVB6rrAp
    sOXSanIaEpZ6FnA1bM/620vJe4TyLhjzS/DqdVtLe1+TTDdixGoH0I3UxLZ2apw=
    =
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932669AbeCMKvE (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 06:51:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39234 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932647AbeCMKvD (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 06:51:03 -0400
Date: Tue, 13 Mar 2018 11:51:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.4 031/193] ARM: OMAP2+: Fix SRAM virt to phys
 translation for save_secure_ram_context
Message-ID: <20180313105103.GD32263@kroah.com>
References: <20180223170325.997716448@linuxfoundation.org>
 <20180223170330.941688300@linuxfoundation.org>
 <1520293551.2786.101.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1520293551.2786.101.camel@codethink.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 05, 2018 at 11:45:51PM +0000, Ben Hutchings wrote:
> On Fri, 2018-02-23 at 19:24 +0100, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Tony Lindgren <tony@atomide.com>
> > 
> > 
> > [ Upstream commit d09220a887f70368afa79e850c95e74890c0a32d ]
> [...]
> 
> This apparently breaks the build for some configurations.  Fixed by:
> 
> commit 863204cfdae98626a92535ac928ad79f4d6b74ff
> Author: Arnd Bergmann <arnd@arndb.de>
> Date:   Wed Dec 6 14:17:17 2017 +0100
> 
>     ARM: omap2: hide omap3_save_secure_ram on non-OMAP3 builds

Just queued it up, thanks.

greg k-h
