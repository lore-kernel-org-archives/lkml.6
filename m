Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2753128-1517969794-2-6896181094347454147
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='edu', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517969793; b=sjZhT613FKsd+YOTpPOlISJmeIH0TgUUqrCdKFR2/eyie9x
    1GnUOCgxsWHBAxFv0UN2ojKqLlFGKEORa+akvucGKvJ0FQO8/vFmBYQUusIxUubV
    XLiYK/WA73v0mivt56p/QW4K1p+QpCjzwJ2623U2WRCGrNwpixRyhGaMs9QOb0AO
    qR4TPqIWfdv+wKd4WEVcv456umd6RzrV1sCClkBZjGCh3isRe0pjedTsEipR6GOT
    IaPQ9M4OXaFc4pyBDN/hAPLCz2s1g0DX3hlixonnIl7x+Fu4kq6mnpF3Fr8eRJbM
    q8aRHqulKqcWsYRJHScUqU5CuIqmbIRICXnKARw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517969793; bh=9IeOISo4AY+eTLTP8C07r0TokL
    dTx6TJoV/uHxhlREY=; b=foayYQlzynCefZu+P9p5ciVjWGTbevB0Ub0sMNO2gp
    ACnRqs1hBH7s/8c0IgvqppJ6ymYbHF2sexT9ALHv1IXWIivYJOhAQF1myK33F/C/
    k0zqaUcB62jO4owLtfL2W1plMPY8lMhVOPl45cZQRZ+oPufumRivShSoAilkJHg/
    ObMKnKSxgxf9Q/xBQ4N5GmpSe4gz0FT+D1rlWgwk2S8yPieqGEMAQNisfvGzFUg2
    naJZ4NsoxEQt48bMy4QTxSZ06ObKZ/EuqV/Aati4RXA18s/0UXzfY7dYdy5Y95Ft
    rBCzikCBF0vaUhXQKoNNQPttu+du8HtpGUcH+8ShH/Gw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=thunk.org header.i=@thunk.org header.b=CvkzW0UT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ef5046eb;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mit.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mit.edu header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=thunk.org header.i=@thunk.org header.b=CvkzW0UT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ef5046eb;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mit.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mit.edu header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752952AbeBGCQb (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 21:16:31 -0500
Received: from imap.thunk.org ([74.207.234.97]:44660 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752786AbeBGCQ3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 6 Feb 2018 21:16:29 -0500
Date: Tue, 6 Feb 2018 21:16:17 -0500
From: Theodore Ts'o <tytso@mit.edu>
To: Eric Biggers <ebiggers3@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
        Jin Qian <jinqian@android.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jin Qian <jinqian@google.com>,
        stable@vger.kernel.org
Subject: Re: [PATCHv2 1/1] ext4: don't put symlink in pagecache into highmem
Message-ID: <20180207021617.GD1977@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Eric Biggers <ebiggers3@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jin Qian <jinqian@android.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jin Qian <jinqian@google.com>,
        stable@vger.kernel.org
References: <20180206190938.172792-1-jinqian@android.com>
 <20180206203953.GC18045@kroah.com>
 <20180206231149.GC1977@thunk.org>
 <20180206233809.GA159960@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206233809.GA159960@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 06, 2018 at 03:38:09PM -0800, Eric Biggers wrote:
> I don't think backporting this change for other filesystems is particularly
> important, since if I understand correctly, the reasons that Al made the change
> originally were:
> 
> - to allow following symlinks in RCU mode, but that's not implemented in old
>   kernels

Yup.

> - to prevent a process from using up all kmaps and deadlocking the system, which
>   I'm not sure is a real problem (someone would need to try to put together a
>   reproducer), but if so it would probably just be a local device of service.

.. and *that's* only a problem on 32-bit systems.  And aside from
Android, it's unclear to me how much we need to support 32-bit systems
on upstream LTS kernels.  I suppose there might be Rasperry PI's which
are 32-bits and which might want to use btrfs.  Personally I'm not
sure we should care all that much, but others who care more about LTS
kernels and 32-bit systems might have a different opinion.

> Also if we actually backported the full commit there are follow-on fixes such as
> e8ecde25f5e that would be needed as well but might be missed.

Good point.

					- Ted
