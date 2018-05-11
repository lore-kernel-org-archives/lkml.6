Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4047772-1526047681-2-17257178705692438509
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526047678; b=lGOmDpIlrkRhNj8mHpRGBIAG0iyIHpaF8NAWwNGnfiQmIkEHEO
    2XDnMkrA045t4NcveKQFyGg/vt05OzyVCd3k90bw0Eh34uHsNTt6mNlJ0xb09z4z
    h7nfhzgXR0shJwT0Rw6eJ/YpBrZdcumlQI1W/Zv7eykDfgRn2t13uQS+H86zop6C
    m0A1cslZwaaAowT7LhPNobhDo+QgrnrcmNr1JHb53gDTpZ/TVBZovSXIPlXa51au
    95E4/ZYW+k1ZgVgDsbqcwTC+qu5/5NRnelq/g5aFYcO/oPMsZGXZGCkP1ZSido6c
    9t6EbH4q9JCaJOhc4bv5yBZzcKlDMd2cbgqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :reply-to:references:mime-version:content-type:in-reply-to
    :sender:list-id; s=fm2; t=1526047678; bh=wJrC8FGtlGWjQN6KsyBJp7J
    b5eQbO/tKq2WHFYyT/GU=; b=dY0sRRJz05VTGxNIivWxQhPwjnHNNcgX/pjBNq2
    AjenNKX3YZPtfd4LCSKXlWZa06iWW+HiD9fEYwIERK+ZP8t0XMJ9sIcef8WTId1q
    820Ni+pUFREkpKVQV1J3jLjrojjjQg/g1xxcmSzZc48Eb/h03pSq7SrBxkdJM2Dn
    StTFNnHY0UZ533wbzVJ5WcvtuQh8cf0Am7woWzaxw2fMoGK1a/9iOmql5McvuG6B
    Ns7WEiF84K2645ChaBBjEsReYPa8/Ysq+iwTK8B+KOehVU0UmxffdDO11RmMc59C
    n9dHs5E8t+AEWTFEQEDiJMS9HgMQOsCB0qT/iCMZDfr5L9A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJp+aKVeO5shgyZtyhAR8Sgu3pZQXDo0f3AkIUXyoq/Ie/YXBjcslya5y9fDS+zsDRGhJxj+0Qf6CxLpeaUEvUZMqhXav7nTCB43SasiJMezJ5MkSh2H
    vJS4TcFe1EucYNf1C+H9xsgDzXm807siBT5bud5+Wzu1n508l4YHgg5Xfj7E3WhTwKfeGBSAU6v/qUI257yvilF3IwRBpVMabzW7dnxLnHQgNqGsYtzVAClA
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=WlY7OePRtkhipExqHFkA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753105AbeEKOHi (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 10:07:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:57305 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753063AbeEKOHg (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 11 May 2018 10:07:36 -0400
Date: Fri, 11 May 2018 16:04:51 +0200
From: David Sterba <dsterba@suse.cz>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: viro@zeniv.linux.org.uk, darrick.wong@oracle.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, clm@fb.com, jbacik@fb.com,
        dsterba@suse.com, sandeen@sandeen.net, dhowells@redhat.com,
        fliu@suse.com, jack@suse.cz, jeffm@suse.com, nborisov@suse.com,
        jake.norris@suse.com, mtk.manpages@gmail.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 4/4] btrfs: verify symlinks with append/immutable flags
Message-ID: <20180511140451.GY6649@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, "Luis R. Rodriguez" <mcgrof@kernel.org>,
        viro@zeniv.linux.org.uk, darrick.wong@oracle.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, clm@fb.com, jbacik@fb.com,
        dsterba@suse.com, sandeen@sandeen.net, dhowells@redhat.com,
        fliu@suse.com, jack@suse.cz, jeffm@suse.com, nborisov@suse.com,
        jake.norris@suse.com, mtk.manpages@gmail.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180510231359.16899-1-mcgrof@kernel.org>
 <20180510231359.16899-5-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510231359.16899-5-mcgrof@kernel.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 10, 2018 at 04:13:59PM -0700, Luis R. Rodriguez wrote:
> The Linux VFS does not allow a way to set append/immuttable
                                                   ^^^^^^^^^^

Typo, in all 3 patches.

> attributes to symlinks, this is just not possible. If this is
> detected inform the user as the filesystem must be corrupted.
> 
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> ---
>  fs/btrfs/inode.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index c4bdb597b323..d9c786be408c 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3933,6 +3933,15 @@ static int btrfs_read_locked_inode(struct inode *inode)
>  		inode->i_op = &btrfs_dir_inode_operations;
>  		break;
>  	case S_IFLNK:
> +		/* VFS does not allow setting these so must be corruption */
> +		if (IS_APPEND(inode) || IS_IMMUTABLE(inode)) {
> +			ret = -EUCLEAN;
> +			btrfs_crit(fs_info,
> +				  "corrupt symlink with append/immutable ino=%llu root=%llu\n",

no "\n" and please un-indent the string so it fits 80 columns.

> +				  btrfs_ino(BTRFS_I(inode)),
> +				  root->root_key.objectid);
> +			goto make_bad;

I found some error handling issues, before the switch, there's
btrfs_free_path and there's one more at the make_bad label.

To fix that, please set path = NULL after the first btrfs_free_path, it
can handle a NULL when it's called again.

Next thing I'm not sure about are the ACLs that get initialized in some
cases. There's cache_no_acl() that only resets the inode::i_acl and
inode::i_default_acl, so I think this should be called too. Thanks.
