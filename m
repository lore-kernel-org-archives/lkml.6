Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2091355-1517949598-2-3246800205189435783
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
    t=1517949598; b=wARd75GR4setrqslButxMnMKKRXwneXu8/ssbWV+C1y1irT
    10SMkgXl2QMJ0QFdfGfo7a5+PbEfDG2IA9kiMrtRaAxg2j2PCxsuQDfjlwCI/mRF
    zBy2wtwpRa24ICsU+qeaogw6iSn4VWiZeigHlfWsIf6ZUaJ5nsQq6YtuMIld9zTK
    OOpcl2smZMvFgWsptGYObp3Bd+vMv1S3j8H2wnCispQi0s4VKyr3bCPUJwOEDjo3
    RnAHdBKbqii4K063hk0n9UYZJoZ5Q4NYpMRwkebS21teVrRzWG/J8qZ22sB2P1Zt
    oYDDowGvjEcPZWRbcgcDxoha6eAgYwG1KcMg5HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517949598; bh=keLuI1jc24SCAvYMVyFkCVMjuf
    B9xe3mhDR/wpjkIVo=; b=LYnlcyzWbmid5u2yWb76aUIN4XNEs2P489vzfDIgJp
    TZozKIASR5LHhgTB7GG3GYZJdiYi5b5fdjPI3fvUGm6lOmyKPT073spPeVbB5kSS
    O4pr9vPnqgEYwkxWpDpyG8QnvK+h6Cx4adU07C9sN+4XN2h53rlxLozs9vvkCb+o
    FQtL3Yz0l0YjwwMYI+c5sI3fS1R8TvGEnS9NYuSbp0pJmUEJrpsYSBaB3fU6kyVf
    i8yaeKlS+9wtE4lM2VdKd9Adn1nwwXsVyPFhfoLOVUrVtJv3iSa+vJD2rmsQrDaM
    ilvLflxaeDKs38pxi8ZO/YhxBO0nDvJPFV6sk8C0iDng==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752885AbeBFUjz (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 15:39:55 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46640 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752720AbeBFUjy (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Feb 2018 15:39:54 -0500
Date: Tue, 6 Feb 2018 12:39:53 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Jin Qian <jinqian@android.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jin Qian <jinqian@google.com>,
        stable@vger.kernel.org
Subject: Re: [PATCHv2 1/1] ext4: don't put symlink in pagecache into highmem
Message-ID: <20180206203953.GC18045@kroah.com>
References: <20180206190938.172792-1-jinqian@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206190938.172792-1-jinqian@android.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 06, 2018 at 11:09:37AM -0800, Jin Qian wrote:
> From: Jin Qian <jinqian@google.com>
> 
> partial backport from 21fc61c73c3903c4c312d0802da01ec2b323d174 upstream
> to v4.4 to prevent virt_to_page on highmem.
> 
> ext4_encrypted_follow_link uses kmap() for cpage
>   caddr = kmap(cpage);
> 
> _ext4_fname_disk_to_usr calls virt_to_page on the kmapped address.
>   _ext4_fname_disk_to_usr()
>     ext4_fname_decrypt()
>       sg_init_one()
>         sg_init_one(&src_sg, iname->name, iname->len);
>           sg_set_page(sg, virt_to_page(buf), buflen, offset_in_page(buf));
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Jin Qian <jinqian@google.com>
> Signed-off-by: Jin Qian <jinqian@android.com>

Ted, any objection to this patch?

thanks,

greg k-h
