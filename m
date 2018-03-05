Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2498535-1520281998-2-7071318241602048313
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  FSL_HELO_FAKE 3.2, HEADER_FROM_DIFFERENT_DOMAINS 0.249,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520281997; b=mMyplpfUATCV3WhcjbImskNxGDOIuutm3wQmG84pYA7pWA2
    xWbfqZc6PZ1OtgRn3ZFVSIQQNuUmbbWAkAXhkzQaS93cBfk0KSHq9dplS3BU7woj
    GPAhmnYPUWceYW2XTpYUJjH8WtAe6JcYKjF2c9bbPp1/73OGE6NAUcR+1ebLDEHL
    Lu67iN3xxxbHNJ5+g7TBXIcbjyKbddDP3z25gWOX+cNRv8KVvxD6NxxPo/qvtVJy
    mYoq6+/6hqDaqghBEGou/U0jJgIa12rllokeEQCmv8HOUlJKZR9IEJ6d0YP3OZFK
    yHYQzrKfXITjU4w5kjof3oYkSzN+iD66Hk4CphQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1520281997; bh=oINjiUW
    eJnoCpUsvqeBztEQDeDG/F0F5RQ00oE4mcxY=; b=okbT2vX8agSiFQvz/3ym3hR
    uMmJ/QPpFnDIKbWu4V/MgKgNSyYbY8IqRfexs72jpeSwzewPValXV42cQdRMCyVQ
    BCx2loZ/oSFCE1YyYLf+bFjBzg8WI7jr3qCzmH1a47zhfrNzWbs2fz3121sRFxZU
    nk8tSNnNo6CmCN8C20bsnWehQTOQ9Qr05wdQcxloVd/TKae3ctAAo4CypsYbITa1
    89G0dhqdtwpBRJH1NZW+ydFUrvEyNTqtoCRDovRDnei4XGV+zsgMsawbORtJqNmc
    8f6i2ktTfYDIlLFja/gUUtkSqNwbSZjOP/a3BHA1uaWct69oceI5XyVNmt/iw/w=
    =
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=f/Lz3tMR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OQ+ioINo;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=f/Lz3tMR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OQ+ioINo;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752162AbeCEUdQ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 15:33:16 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:55072 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751764AbeCEUdQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Mar 2018 15:33:16 -0500
X-Google-Smtp-Source: AG47ELufnreIkXcUBXaMdvqelQbSLxylB5rVp8Lm/7VyQO5sQglQNKhAuEKWobfljpQ2X/AswVCCxg==
Date: Mon, 5 Mar 2018 12:33:12 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jin Qian <jinqian@google.com>, Jin Qian <jinqian@android.com>
Subject: Re: [PATCH 4.4 035/108] dont put symlink bodies in pagecache into
 highmem
Message-ID: <20180305203312.GA144846@gmail.com>
References: <20180215151222.267507937@linuxfoundation.org>
 <20180215151227.323543261@linuxfoundation.org>
 <1520210279.2786.53.camel@codethink.co.uk>
 <20180305060245.GE6670@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180305060245.GE6670@kroah.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 05, 2018 at 07:02:45AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Mar 05, 2018 at 12:37:59AM +0000, Ben Hutchings wrote:
> > On Thu, 2018-02-15 at 16:16 +0100, Greg Kroah-Hartman wrote:
> > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > From: Al Viro <viro@zeniv.linux.org.uk>
> > > 
> > > commit 21fc61c73c3903c4c312d0802da01ec2b323d174 upstream.
> > > 
> > > kmap() in page_follow_link_light() needed to go - allowing to hold
> > > an arbitrary number of kmaps for long is a great way to deadlocking
> > > the system.
> > > 
> > > new helper (inode_nohighmem(inode)) needs to be used for pagecache
> > > symlinks inodes; done for all in-tree cases.  page_follow_link_light()
> > > instrumented to yell about anything missed.
> > 
> > Except that this backport only updates ext4 and f2fs (and doesn't add
> > the warning).  I suppose that's all matters for Android, but it would
> > be nice to get a more complete backport into 4.4-stable...
> 
> That should be all the in-tree users of this, for 4.4, right?  If not,
> ick.  Jin, can you look into this?
> 
> thanks,
> 
> greg k-h

This was discussed already; see https://patchwork.kernel.org/patch/10203819/.
It turns out that Al's original commit incidentally fixed symlink decryption for
ext4 and f2fs on 32-bit systems, so the backport is wanted for that reason.  And
pulling in the rest of the commit, while it could be done, would have broken
things and required additional follow-on patches.  Jin and Greg, it would have
been helpful if the discussion had been captured in the commit message, so that
people like Ben who are watching the stable commits aren't left wondering.

Eric
