Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1270479-1519212201-2-11899713998198747930
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519212201; b=jVGnMZiG2A3OwHQWu44qhFL91ICzfWkPLs7SYEbMb4mGlJc
    969iO3/trDRVgm21Hzo9X7u393jW8SVWqi5IKFbm4gpyxzHw0Kv75b22uickhR7R
    fs1zmjvKP0N6Nl30x5XJYBQO8sp7cCxFAYfXq4rFXLY7gkQncuXZbaAbVyoYBzn+
    Kc0ws2Rqr/hgsVclVFX+uSMlo4sPsrAimtF860a2zdWq4XOWeS3GHXUttTFT8kBP
    PAwofgcjAyNe560cJbB92ta3L55zlUEu6GTQ4gDoqk6SGVb0Y1GPEMLH0nfoD6sv
    X8FBLnzybGnnf+Uxpg17nzoQ+K9M6AZ5H6N/3QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519212201; bh=PSUPPqEEMdk/skkcvO3fUHcCSB
    F85Ub73W3HqIR9ebE=; b=uHtbqjLU+NbfQNRN1NyxevCZhkWRlePETKDA0lAm6h
    YFJVNhEaNTR0iQiy8Em7Z+RV6YZOKPDbiU+SK4v18UpkfpHpbC3a1vswZjfCdK9E
    BoHJ2ZcN0peGY9Jszun9dyDKm6+CQtyMi/ZMRxXkRPQsrho400ViP9py9xfAuLzq
    BLN5fXXK4frnIAgzmc2e7Hj9FF+tAs4INSakHmFyaNm+mkM5lXlmIxLv1LbXoBXw
    6sgROHJr+fUeqH4uF7S+iXmllh2LJa6b87YxHJAXF9v+OPc9OGHtBCdNXYeKcr/j
    duG5yOWTP6/2DNQQTrN+Yoc3uCjc9mRrt8/E5OfFG2jA==
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
        id S1753517AbeBULXS (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 06:23:18 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:33460 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752932AbeBULXR (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 06:23:17 -0500
Date: Wed, 21 Feb 2018 12:23:19 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Max Ivanov <ivanov.maxim@gmail.com>
Cc: Hannes Reinecke <hare@suse.de>, stable@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Kyle Fortin <kyle.fortin@oracle.com>,
        Don Brace <don.brace@microsemi.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        labbott@redhat.com
Subject: Re: iSCSI session logout regression after fbce4d97fd ("scsi: fixup
 kernel warning during rmmod()")
Message-ID: <20180221112319.GA18634@kroah.com>
References: <CALQ-8CJ8biPVCKvg+Gri9Am+TRBP0Rw-cWL42U2F_z8VvWTNfg@mail.gmail.com>
 <c35cd314-9dad-5d25-4627-1cc8687dbf7f@suse.de>
 <CALQ-8CKP7GcK-oVwaWz3ZU0qvBOj19eJTwJf0cYQz4Di1Q3n3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALQ-8CKP7GcK-oVwaWz3ZU0qvBOj19eJTwJf0cYQz4Di1Q3n3A@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 19, 2018 at 11:27:07PM +0000, Max Ivanov wrote:
> > As already explained in the previous mail, there is a fixup for this in
> > commit 81b6c9998979 ('scsi: core: check for device state in
> > __scsi_remove_target()').
> > Please check if this is applied, too.
> 
> I tested commit 81b6c9998979 cherry-picked on top of 4.14.20 and it
> indeed solves the problem.
> 
> Can it be backported to 4.14 LTS, please?

Now queued up, thanks.

greg k-h
