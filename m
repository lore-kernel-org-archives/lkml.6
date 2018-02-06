Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2329085-1517958747-2-12280039782992924457
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, DCC_CHECK 1.1, HEADER_FROM_DIFFERENT_DOMAINS 0.001,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='edu', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517958746; b=E3ffgKgnOEO0f4ovXeyU17GsEVsohEa9yrHROUYYJ7yEVFJ
    7i3HMHLJ3Gvwa5wfusLGwit7CtLY8+LwvvCJnbtDPzu5XmOUo1YM74xV53KMMKNU
    OqtUzSN5rr62zCQJLGun+ilIx3bmtIcxoGOcaM8hinMhz5bERzVqMAhrNJU/jGo9
    wdm/iOYlcX2sVgRgIIglmGcB0sGKu1k1BB2IgSNwsveskU2XJ+6iLwLPcyGIRODG
    Mw5LWLPzJ0PSlSLG45nRqyfTSv+INNb1ZqeAkeOTj83eBZNl4RWSXlLvAsxwVokX
    gW37KBqeDo5wJwRI/UwuFXvISICPH2o5TWnpd1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517958746; bh=bCQraZO5sZYuE/RWH3xi02Qj7N
    y69V69HIP5YcZhg0U=; b=OLp9CS4VyXNFnxPhXspu9BQAMnqQVjfimMfAWNxwUt
    l88eEYqwUnxjArBR0eTluP+l3Qry7EV1qQZPCGJPgNnOxYlGqwMzhmc1f6Sh5rdV
    D1fzMZj2o2z6pYjpKySBBssjc2HUmGYaF+IKX27bggiiIUzyGaJRHm9Av9A3NJgu
    W4y62X6WcnhUfGbewv6kQGgDp7+NIIcyIm7yoSiEPnm8PsYVPsSsbFyAklkpx13u
    e2yAWw/ptQJGObmRF3xwNzHQwjnXhvnjtC6l4iSauoQC83nxp9vxRP44RpfweMkH
    F+/9wSux/sCWS/EyRrEm7p/bPJLtEcCQJPstVqzhjylA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=thunk.org header.i=@thunk.org header.b=pYBaRZkj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ef5046eb;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mit.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mit.edu header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=thunk.org header.i=@thunk.org header.b=pYBaRZkj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ef5046eb;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mit.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mit.edu header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753830AbeBFXL4 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 18:11:56 -0500
Received: from imap.thunk.org ([74.207.234.97]:44044 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753815AbeBFXLz (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 6 Feb 2018 18:11:55 -0500
Date: Tue, 6 Feb 2018 18:11:49 -0500
From: Theodore Ts'o <tytso@mit.edu>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jin Qian <jinqian@android.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jin Qian <jinqian@google.com>,
        stable@vger.kernel.org
Subject: Re: [PATCHv2 1/1] ext4: don't put symlink in pagecache into highmem
Message-ID: <20180206231149.GC1977@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206203953.GC18045@kroah.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 06, 2018 at 12:39:53PM -0800, Greg KH wrote:
> On Tue, Feb 06, 2018 at 11:09:37AM -0800, Jin Qian wrote:
> > From: Jin Qian <jinqian@google.com>
> > 
> > partial backport from 21fc61c73c3903c4c312d0802da01ec2b323d174 upstream
> > to v4.4 to prevent virt_to_page on highmem.
>
> Ted, any objection to this patch?

No objections with my ext4 hat on.

It should be noted though that this is a partial backport because it
only fixes ext4, while Al's original upstream fix addressed a much
larger set of file systems.  In the Android kernel the f2fs fix had
been backported separately.  But for the upstream kernel, it *might*
be the case that we should try backporting the original commit so that
in case there is some other general purpose distribution decides (a)
to base their system on 4.4, and (b) support a 32-bit kernel, they get
the more general bug fixes which applies for btrfs, isofs, ocfs2, nfs,
etc.

I haevn't been paying attention to what LTS kernels general purpose
distro's are using, so I don't know how important this would be.  And
if there are companies like Cloudflare which are using upstream LTS
kernel, it seems unlikely they would want to use a 32-bit kernel,
so.... shrug.  Greg, I'll let you decide if you want to backport the
full commit or not.

(We had a similar discussion on the AOSP kernel, and came to the
conclusion that we only needed to make the patch support ext4.  No one
was going to test the other file systems besides ext4 and f2fs,
anyway.  But the calculus might be different might be different for
the general upstream LTS kernel.)

				- Ted
