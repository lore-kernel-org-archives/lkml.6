Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2196896-1520015866-2-4498093399607060202
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520015865; b=UAECPVMi/AhmZ/UN6czZZ7F4oTFiw2Rr0cUzDl/0l2vodTL
    iN8M+ZEu49y4KyQwi2RkEHOJjfkkzV0B2JCtq3tAdWTFiIxrX20hy91qnxMgbmWA
    j4aqKf9csgdmT5R9g0hq4kpEUATeZ4deZ7eUimFAvJsEntRz2y3rQDsPVWwJn8kj
    TMcuavVi7n4Gzs+j+1FFWc7qVbnAL2uvaT/ZYJ7liiee1T4l6nHrycG7JIuA3ZRb
    7NQAWFaT3z07joyzVchIEfhClaWJ3gvMPNYpunMC7Mj0Xcpthffas9rxDok4oUYg
    aZS2TWDoXecXppkePf9x3KbSMwEpsF70yglvPwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520015865; bh=oCqnKKcOWN0ZV3NxI8KlUkpWK8aXcFvIHaKvGS
    BORwQ=; b=dyx8iz63sjgSDfLcYm8moiFMkxUeomXZXoe/i8Qv1BbRuSqRSxNU5t
    keaIliglkDVVJCtTHaRnH3aqX3EerQddDrjuPFMoAcXgiwN2b99kiJu4NfD2yZDv
    Uv5rhuFkwbDdRFmO55lrj5rd1Y+9sBK4H8fn0jF/2AGqhZ7Vj51DMKuvihLRX48u
    SD7krXY715z7lcQd1oiKk+O/YAgZi7T0Qr8PRFBBmba4D5/NTnzZxT2i4D/qr6Bk
    73ZjrtYFFKIzUGlThIu29QtQDrWQvnrHjQRB0oFBlNtFHV08BA1LfYn44TpIbPqs
    RZVE9upoiueBieyMh2pj+vbSkRbOdHnQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b=avO5DZ05 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EwiOSITn;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b=avO5DZ05 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EwiOSITn;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1947319AbeCBShn (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 13:37:43 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34426 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1947293AbeCBShl (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 13:37:41 -0500
X-Google-Smtp-Source: AG47ELsYl4z0vP7TKUSautJsZzsKlqsFVg1egPCHOT4fTb9LXb0RCH5ziRfkPXxG+a02XjH2nsfD4BJzWyVUZ1//YSs=
MIME-Version: 1.0
In-Reply-To: <20180302174530.GV19312@magnolia>
References: <151996281307.28483.12343847096989509127.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151996282448.28483.10415125852182473579.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180302174530.GV19312@magnolia>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 2 Mar 2018 10:37:40 -0800
Message-ID: <CAPcyv4iu32ja_vPiN=E0DP7_PFaj887XQ48EOMupE0Q4p1dCkQ@mail.gmail.com>
Subject: Re: [PATCH v5 02/12] dax: introduce IS_DEVDAX() and IS_FSDAX()
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        stable <stable@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 2, 2018 at 9:45 AM, Darrick J. Wong <darrick.wong@oracle.com> wrote:
> On Thu, Mar 01, 2018 at 07:53:44PM -0800, Dan Williams wrote:
>> The current IS_DAX() helper that checks if a file is in DAX mode serves
>> two purposes. It is a control flow branch condition for DAX vs
>> non-DAX paths and it is a mechanism to perform dead code elimination. The
>> dead code elimination is required in the CONFIG_FS_DAX=n case since
>> there are symbols in fs/dax.c that will be elided. While the
>> dead code elimination can be addressed with nop stubs for the fs/dax.c
>> symbols that does not address the need for a DAX control flow helper
>> where fs/dax.c symbols are not involved.
>>
>> Moreover, the control flow changes, in some cases, need to be cognizant
>> of whether the DAX file is a typical file or a Device-DAX special file.
>> Introduce IS_DEVDAX() and IS_FSDAX() to simultaneously address the
>> file-type control flow and dead-code elimination use cases. IS_DAX()
>> will be deleted after all sites are converted to use the file-type
>> specific helper.
>>
>> Note, this change is also a pre-requisite for fixing the definition of
>> the S_DAX inode flag in the CONFIG_FS_DAX=n + CONFIG_DEV_DAX=y case.
>> The flag needs to be defined, non-zero, if either DAX facility is
>> enabled.
>>
>> Cc: "Theodore Ts'o" <tytso@mit.edu>
>> Cc: Andreas Dilger <adilger.kernel@dilger.ca>
>> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>> Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
>> Cc: linux-xfs@vger.kernel.org
>> Cc: Matthew Wilcox <mawilcox@microsoft.com>
>> Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
>> Cc: <stable@vger.kernel.org>
>> Fixes: dee410792419 ("/dev/dax, core: file operations and dax-mmap")
>> Reported-by: Jan Kara <jack@suse.cz>
>> Reviewed-by: Jan Kara <jack@suse.cz>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>  include/linux/fs.h |   22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index 79c413985305..bd0c46880572 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -1909,6 +1909,28 @@ static inline bool sb_rdonly(const struct super_block *sb) { return sb->s_flags
>>  #define IS_WHITEOUT(inode)   (S_ISCHR(inode->i_mode) && \
>>                                (inode)->i_rdev == WHITEOUT_DEV)
>>
>> +static inline bool IS_DEVDAX(struct inode *inode)
>> +{
>> +     if (!IS_ENABLED(CONFIG_DEV_DAX))
>> +             return false;
>> +     if ((inode->i_flags & S_DAX) == 0)
>> +             return false;
>> +     if (!S_ISCHR(inode->i_mode))
>> +             return false;
>> +     return true;
>> +}
>> +
>> +static inline bool IS_FSDAX(struct inode *inode)
>> +{
>> +     if (!IS_ENABLED(CONFIG_FS_DAX))
>> +             return false;
>
> I echo Jan's complaint from the last round that the dead code
> elimination here is subtle, as compared to:
>
> #if IS_ENABLED(CONFIG_FS_DAX)
> static inline bool IS_FSDAX(struct inode *inode) { ... }
> #else
> # define IS_FSDAX(inode) (false)
> #endif
>
> But I guess even with that we're relying on dead code elimination higher
> up in the call stack...

If IS_FSDAX() was only a dead-code elimination mechanism rather than a
runtime branch condition then I agree. Otherwise I think IS_ENABLED()
is suitable and not subtle, especially when used in a header file.

>> +     if ((inode->i_flags & S_DAX) == 0)
>> +             return false;
>> +     if (S_ISCHR(inode->i_mode))
>> +             return false;
>
> I'm curious, do we have character devices with S_DAX set?

Yes, Device-DAX, see:

    ab68f2622136 /dev/dax, pmem: direct access to persistent memory

> I /think/ we're expecting that only block/char devices and files will
> ever have S_DAX set, so IS_FSDAX is only true for block devices and
> files.  Right?

We had S_DAX on block-devices for a short while, but deleted it and
went with the Device-DAX interface instead. So it's only regular files
and /dev/daxX.Y nodes these days.

> (A comment here about why S_ISCHR->false here would be helpful.)

Ok.
