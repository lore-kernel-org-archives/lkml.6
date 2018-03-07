Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3563148-1520436672-2-16724060629939883039
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520436672; b=GPPhnHLGjtppCCYLBn6IulnNcPKyvnm8Sa1PMGV54yT9lY4
    IX3168/iteLO5WdwCtHTUrzSopL+raeCktAV+SOttTcX+Ggiin7rpKmbQotaw1SM
    emoA+wlUyXH6SLeNhpOcsGNu+ME5ERl+Zb56DKZYV6n2J/UUvWsGDS7DaDbIhISN
    ilw31i1YqjHSX1/I1kF/tDte7JkBZSi2BKg+29r2SEx533kE2MSOojO4l3qi70el
    XrxDfvDpq/aVpceUSfLeNDgtB/sxnwV2t72m78HbBICjUUK6Lmzvex78qsEf6L2v
    8HUDVu/FwG8dnuhmmg1ZX3FnoTY0/06qFs3+ZxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520436672; bh=K4q8N76yb6MTlxcBHRCM0puNoCC04HnLZ5tBqkPrM68=; b=R
    BYgdLHVJhN6l4GJz5ht3VAu69qZkuPE/wx9SE0/hvMRH4TL/6xvabMlOZmmt/h8r
    D2EKaMgZkkFLpksEMsOBr8CL0fA6Ti6qFBO1NyOD8ESEjKHOCvdNyh+wzUdmTLYZ
    nhlDcO0qKYCp3gYi11MgmA/7Qs3SIQPPI1WIfN+dDEUzhWDXLgrBKeEOjsNHyuq/
    sSDPuR4tOkFHkFWw57buB3q0ZY66TLAxEEN91eKj1ME60sLQUiTHuUJrqsm8b5B9
    Z1FOhl8klzve87jFLPgcP7h+EIPrXQMDuux99iUKGomE3dXPXQ4ozKmqmih3XtBg
    UhzQGxTw7lxqyYi0W2+8Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933842AbeCGPao (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 10:30:44 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:52979 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933335AbeCGPan (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 10:30:43 -0500
Message-ID: <1520436639.23626.31.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 16/34] led: core: Fix brightness setting when
 setting delay_off=0
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Date: Wed, 07 Mar 2018 15:30:39 +0000
In-Reply-To: <20180302084437.007951262@linuxfoundation.org>
References: <20180302084435.842679610@linuxfoundation.org>
         <20180302084437.007951262@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-03-02 at 09:51 +0100, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Matthieu CASTET <matthieu.castet@parrot.com>
> 
> 
> [ Upstream commit 2b83ff96f51d0b039c4561b9f95c824d7bddb85c ]
> 
> With the current code, the following sequence won't work :
> echo timer > trigger
> 
> echo 0 >  delay_off
> * at this point we call
> ** led_delay_off_store
> ** led_blink_set
[...]

The commit message got cut truncated here, but the upstream commit
message refers to a LED_BLINK_SW flag which is not used in 4.4.  So
this fix probably isn't needed, though I can't tell whether it does any
harm.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
