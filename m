Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2455934-1517960314-2-9564645471790805734
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  FSL_HELO_FAKE 3.2, HEADER_FROM_DIFFERENT_DOMAINS 0.001,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517960313; b=Q6G64FFV4HlLi9jQ35Li5xMT4gwexHJWfP38cdWbHTk2qpH
    XHBhaIj1vQ6dlvpzmpCbbKmeGJjQmmbpKTgrdbxj5tbJWGT15h1MHdLCcdvx3crQ
    ip/CQFXCOEu3OTXL7JunAH5Qslb7XDkzAyCQlfZ6Tvd0LsP8BBRBf76Gy+NpbufT
    KQE9GP7FWkkfZR/0k234CLeVxLto/gY+wUJqo1M0sJ3YuBu4Qh/ncSprz8g++ygt
    Nvt8ljZIpYUOWeJ7QuyUCdDeYi9KHgOtvyZ684BYUDyl55pBD7qM/6QN9LSBJ2Ji
    p1uLJ0c04bHj8uHsZrEuX3vvE8/oTxWc3WBfQsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517960313; bh=oWqiZH/wlMAkbfLhVizO1xhwWi
    tlH0ccFUOqsdW3alA=; b=tWYUDSvp6RnwNPdTu9xqToAz0YVtBciG6uShzVvROI
    AzLftg13vUlgXcrlU9UnTuDAJ4dpBEueqccQrukVOEnSgHoi+TA2PwUMr1fyFXah
    rDLASmZBjVO/STb/duO8cs8pTQtW5Y/79rtFdtrGURg5Tq7gUB4cZgj8esbqrFyj
    AJm0LQ2sSub/UEKr73cmCkOsxM/Pm+uW4OMh7jCj+r3B3o/v77Bqblwk3D1LIh5+
    WgggjSwnCy33mI5kX5rblNOkQaSqIwoikv1GXtzRXX4Zd7MM1B318YAT4MV+E1Lm
    xW44FqrUII/FRn5w9o1VjoDgbCIYomo5ZhxQHRGG5OKw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=KCTXKvJD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gLp3erNg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=KCTXKvJD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gLp3erNg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754185AbeBFXiO (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 18:38:14 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:41337 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754019AbeBFXiN (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Feb 2018 18:38:13 -0500
X-Google-Smtp-Source: AH8x225a4t29k+YbUFxOyDcEntfRwPjlp3lnPW2Ttyqf5BjetspYrRK5zN5hwQ9lxCWoBGwNusDCrg==
Date: Tue, 6 Feb 2018 15:38:09 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: Theodore Ts'o <tytso@mit.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jin Qian <jinqian@android.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jin Qian <jinqian@google.com>,
        stable@vger.kernel.org
Subject: Re: [PATCHv2 1/1] ext4: don't put symlink in pagecache into highmem
Message-ID: <20180206233809.GA159960@gmail.com>
References: <20180206190938.172792-1-jinqian@android.com>
 <20180206203953.GC18045@kroah.com>
 <20180206231149.GC1977@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206231149.GC1977@thunk.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 06, 2018 at 06:11:49PM -0500, Theodore Ts'o wrote:
> On Tue, Feb 06, 2018 at 12:39:53PM -0800, Greg KH wrote:
> > On Tue, Feb 06, 2018 at 11:09:37AM -0800, Jin Qian wrote:
> > > From: Jin Qian <jinqian@google.com>
> > > 
> > > partial backport from 21fc61c73c3903c4c312d0802da01ec2b323d174 upstream
> > > to v4.4 to prevent virt_to_page on highmem.
> >
> > Ted, any objection to this patch?
> 
> No objections with my ext4 hat on.
> 
> It should be noted though that this is a partial backport because it
> only fixes ext4, while Al's original upstream fix addressed a much
> larger set of file systems.  In the Android kernel the f2fs fix had
> been backported separately.  But for the upstream kernel, it *might*
> be the case that we should try backporting the original commit so that
> in case there is some other general purpose distribution decides (a)
> to base their system on 4.4, and (b) support a 32-bit kernel, they get
> the more general bug fixes which applies for btrfs, isofs, ocfs2, nfs,
> etc.
> 
> I haevn't been paying attention to what LTS kernels general purpose
> distro's are using, so I don't know how important this would be.  And
> if there are companies like Cloudflare which are using upstream LTS
> kernel, it seems unlikely they would want to use a 32-bit kernel,
> so.... shrug.  Greg, I'll let you decide if you want to backport the
> full commit or not.
> 
> (We had a similar discussion on the AOSP kernel, and came to the
> conclusion that we only needed to make the patch support ext4.  No one
> was going to test the other file systems besides ext4 and f2fs,
> anyway.  But the calculus might be different might be different for
> the general upstream LTS kernel.)
> 

Well, the main point of backporting this change is to fix symlink decryption on
32-bit systems.  So, it would be needed on both ext4 and f2fs.  Jin, it might be
a good idea to fix f2fs in this patch at well, since unlike the AOSP kernels,
the LTS kernels do not have the latest f2fs backported to them.

I don't think backporting this change for other filesystems is particularly
important, since if I understand correctly, the reasons that Al made the change
originally were:

- to allow following symlinks in RCU mode, but that's not implemented in old
  kernels

- to prevent a process from using up all kmaps and deadlocking the system, which
  I'm not sure is a real problem (someone would need to try to put together a
  reproducer), but if so it would probably just be a local device of service.

Also if we actually backported the full commit there are follow-on fixes such as
e8ecde25f5e that would be needed as well but might be missed.

Thanks,

- Eric
