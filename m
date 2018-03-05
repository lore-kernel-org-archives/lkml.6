Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-780251-1520229767-2-2757324151829991367
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520229766; b=McejX+1zwUeuTZYnzDe84cXEW7EUxZBRPvzLRMAC9a/F0ML
    fCtQEo2+4OwGB7bYvNMrSm2With+7DS+1d0uNxbUqEtc8FYvYXkljVBZyMDuj8IX
    fWmxzw9SlgGRgOL0Nc9jvip0Ps+/ESUJAgP/bLmzhdfQJoghDNGxRaUXUd3K3V4p
    ul4Wu3DDlClCTH3L0kQuO43NzuNT39Bk9RqX1xqjaB0dc8GEiACfKfxLN8WA1iWM
    93v3VB/vKdXu+yzIKukvlzLq9hZLi9NG5HJ7yzksomRQRg7xsA9Yq+BtsjkmuFfy
    670KWzW3w5BdyWeQEj+x8GQKKce6YL8gzeVPj+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1520229766; bh=fnlnpXe
    uB1O2qjpg5TkkuhUTRDDbxWQbM++Sb00ROGo=; b=VUJDk7J0yIM00QGA/F9K7Ec
    qhJXgbM5mZclwAcyV1m48KlgJ88rIgbw/w+Wo/XPBHhBEPVCE9wI3doTmr1XZHsH
    SCR8Bf3+mh3Ei6N6nix8ALFolpnmGeqepoHLqAmoILR+vHfw3VprC7X7S78zJSa1
    WOiXzpKmBLfYNgtfbtU/C/Ua3CXphVDYu1n/1m8qNwpzcL8OKqgbhVoa3yBZMM/Y
    oi9xNeEitNLfZ7kk4cd5MRPHvFeTd8MlHnkafPSgWydRx93+3UltFANTYb7vMOlr
    NMOD4SbQQ2XRCuAL5ylqvkXuJ2KgklGS/mLeAuo34SoG6d2h60FjtHN2YE+TgpA=
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
        id S1751388AbeCEGCp (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 01:02:45 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36554 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751144AbeCEGCo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Mar 2018 01:02:44 -0500
Date: Mon, 5 Mar 2018 07:02:45 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jin Qian <jinqian@google.com>, Jin Qian <jinqian@android.com>
Subject: Re: [PATCH 4.4 035/108] dont put symlink bodies in pagecache into
 highmem
Message-ID: <20180305060245.GE6670@kroah.com>
References: <20180215151222.267507937@linuxfoundation.org>
 <20180215151227.323543261@linuxfoundation.org>
 <1520210279.2786.53.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1520210279.2786.53.camel@codethink.co.uk>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 05, 2018 at 12:37:59AM +0000, Ben Hutchings wrote:
> On Thu, 2018-02-15 at 16:16 +0100, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Al Viro <viro@zeniv.linux.org.uk>
> > 
> > commit 21fc61c73c3903c4c312d0802da01ec2b323d174 upstream.
> > 
> > kmap() in page_follow_link_light() needed to go - allowing to hold
> > an arbitrary number of kmaps for long is a great way to deadlocking
> > the system.
> > 
> > new helper (inode_nohighmem(inode)) needs to be used for pagecache
> > symlinks inodes; done for all in-tree cases.  page_follow_link_light()
> > instrumented to yell about anything missed.
> 
> Except that this backport only updates ext4 and f2fs (and doesn't add
> the warning).  I suppose that's all matters for Android, but it would
> be nice to get a more complete backport into 4.4-stable...

That should be all the in-tree users of this, for 4.4, right?  If not,
ick.  Jin, can you look into this?

thanks,

greg k-h
