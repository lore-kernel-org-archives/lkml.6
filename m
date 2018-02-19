Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-391510-1519055764-2-9296639052344613204
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519055764; b=rxDf/44a4cYpnzlUkMoc39PSz70i9JrdBODrFGfX65yZ/Yi
    MMn7G/69LhmX6oxwvxo9c9O9jo9IHMFUAAuO0Wch/h9K3Jmy23MlInzVoPP5PZRP
    DuukZPYagF6+6iB8enSSvY5lFSrF9ZLnw1hgGw173ohD8KjEINcunh/TcBrIALis
    u1byzrfBaz0VKzDUbSRUa4DpjVnqLZdSkT7J3a9PV3MmcYiPK3dQP+4/8xzGB/yl
    UzT7gv3t+/OvaVdmIYrBQCMi9Pf1wFfIqHpyc3b9gZBHdx0i+MHdirLuz6GkbTjw
    bD6OSn34i9/8E+d2YfgMR5yIohshkCgApbXPoRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519055764; bh=t6U5qqCQcqioBymX5eI6O004/L
    alN49c3oitWqhjxDE=; b=g9E4RC9GJ/NYY2vN0Xl0ihiY00280W5nRVXzMTmdS5
    msWx7MN39zdjSGV5PFpedEAwIRPvF+sfzEHUDh+a19qjSgO9p4AXh43+2+x6CjrY
    1Rbr+L1gf7iNrwfJ+0COEpVOAUkWUHRMxZSYJ0LGwLVNfmgvcSTzUAxPb97HA66U
    T0xgRZH9d+nD8Iybp7K0E+dJLQ0vDNIuA8KX9LJi+TRrWLFuxZWMyW0XNPiRoHzF
    dtQZ7XzeAxsCEsHlFvbRHR5UrBI4iEz9UblGCeajtuc9GVv7OMQcmITBMJfrsAfX
    QPRGhuf1siW9YY72Yhdx4RDA+1GwKmc0WcOOegHuItUQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753064AbeBSP4B (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Feb 2018 10:56:01 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46554 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751701AbeBSP4B (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Feb 2018 10:56:01 -0500
Date: Mon, 19 Feb 2018 16:55:54 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Andres Bertens <abertensu@yahoo.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, ben@decadent.org.uk
Subject: Re: Linux 3.16.54: suspend stops working.
Message-ID: <20180219155554.GA23271@kroah.com>
References: <02c917a9-83ad-6510-fe7d-9ab8b4519041@yahoo.com>
 <s5hmv05hush.wl-tiwai@suse.de>
 <2f37c140-3cd4-e1e6-9c41-631b637d4883@yahoo.com>
 <s5hinathtii.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hinathtii.wl-tiwai@suse.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 19, 2018 at 04:46:29PM +0100, Takashi Iwai wrote:
> On Mon, 19 Feb 2018 16:36:03 +0100,
> Andres Bertens wrote:
> > 
> > Hi,
> > 
> > Yes sir, supend works with the attached patch!
> > 
> > As for using some sequencer audio stuff, I have enabled
> > CONFIG_SND_SEQUENCER and some others *SEQ* as modules in my kernel
> > config. Nothing else to my knowledge.
> 
> Good to hear!
> 
> Greg, could you revert the previous one and apply the new one instead?
> Below is with a more description explaining the difference.
> 
> Or if you prefer an incremental patch instead of revert and re-apply,
> let me know.  I'll cook it.

Incremental would be best, but I don't handle 3.16.y, Ben does :)

thanks,

greg k-h
