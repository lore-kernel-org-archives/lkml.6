Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-842223-1518038354-2-12010146649455679516
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, DCC_CHECK 1.1, HEADER_FROM_DIFFERENT_DOMAINS 0.001,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518038354; b=HseVuvp/FhN8SahkN/Xui9HFqAeA3AxbHd8i7hFgHSAQ9uo
    Hxdaex0MX8bAdMNzCxsPdxwY3OAWnuh/zik2NlJu6qOb40V1/LfRy9hMD8BWFv8d
    2n24cgO1VoTTBNKgNxpao4mJoqgwxjN8CSy6MbaZP5267zu1KLdJ8Two3M/M9sPh
    LgTyR6TH8perBqfCqbptcN/PXyNw/Fhz6cZ3dSyFT3/QHvgLrejV2My4hy51BgVd
    3UdinOwn5ibsZcDEL//CATAf3Fwdah8c7zz+OBxnGdumIXNp01WpZUbP/Wy8w1oX
    Eb1VD5InaWKwB2YFIyqDehH8vd9O9sriWyht4JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518038354; bh=JtYea5jTYE9flXmijpA5fWGzO4
    B3BTQtGpOwWJ/jTBU=; b=qAuUQvg7jj/P61eGA9csseaJTprh7R173I3X7gAkqm
    2NVxMZaGCNBcKYqWPV8C14K9bFDlnAnroT/EiP23+23iP5yOajVFlQ4Yh0EmeDCn
    RBfRXW/b7rICTKKYl7Eeg4OO+VkHXiEbTuubdFn6RwTcuSidBYJlX0z6XCh+2bUY
    VwWtluUB93NAdswmafcdeDNdImPi4eMBoqfmYvavTbl5ugN7QbneRYrLtuIG6Ptf
    cvdk56YGI5lIfeWrHnXphlMs7jxLU6vRSbkwwJjMUJnO43nLhEP/PVNo15LzwO37
    hxbWkb2bDybDi6y02Ca0wrAonl64IaXuuPtlnZGorbJQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755096AbeBGVSl (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Feb 2018 16:18:41 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35410 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755023AbeBGVSi (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Feb 2018 16:18:38 -0500
Date: Wed, 7 Feb 2018 12:06:04 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Jin Qian <jinqian@android.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Changman Lee <cm224.lee@samsung.com>,
        Chao Yu <chao2.yu@samsung.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Jin Qian <jinqian@google.com>,
        linux-stable <stable@vger.kernel.org>
Subject: Re: [PATCHv2 1/1] ext4/f2fs: don't put symlink in pagecache into
 highmem
Message-ID: <20180207200604.GB15309@kroah.com>
References: <20180206235354.79591-1-jinqian@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206235354.79591-1-jinqian@android.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Some minor nits for when you send your next patch for stable:

On Tue, Feb 06, 2018 at 03:53:53PM -0800, Jin Qian wrote:
> From: Jin Qian <jinqian@google.com>

The original patch was written by Al Viro, please do not take the
original authorship off, that's not good.

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
> Cc: linux-stable <stable@vger.kernel.org> # 4.4.y
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Jin Qian <jinqian@google.com>
> Signed-off-by: Jin Qian <jinqian@android.com>

Why did you sign off on this twice?

thanks,

greg k-h
