Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2667167-1520029305-2-17816871591294811657
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
    t=1520029304; b=nCs6MCLfkkWTacT745Vzm067fomhODcqcA2f671dIWOb1d2
    PV5vDRkpjVIs+cyAl3cBPr2sSja3tAuxUUqz5cwC0fNbEgbLZuMatt+VFQjS+/Bc
    nUz24CqYnbmwPtPcuUSyqp4lQmt9M8S5RN6w6uc+x6T8v/Wxyz1c3gz5dYJptV6G
    PZSlY/6PTeqv9DhLrxbKIOlJMPNRwKzarNqii48vkc+oNnstfR9PpmmqzY57ej3a
    vEYWgxyY4lu5Aj52xnj5C8h0cKSrQaduvT7a6NbqD2V1TL0L4/IlIaLMsJA2DVtx
    mLN03pkbnmQR7GMxW0AX8g7ubLFkPpfgItJtJbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520029304; bh=z70g2VGzpNjaOHYPEYfTdJFSxj0ZN2Vfb6IZaX
    qJ+r4=; b=uvc4r27XxZ9B2b85ePK+NfzJBni1xKcz6S8CxNB78Hhpgw6O6L1Dg4
    4j8r2dO82X+cX2vrmDOWEakD/G1qzijHopQit2v/U/tGIxRnEsNiX8nVg7NCAeua
    RouI2EqLMNjUqq6sukAFNc6I9ZSIdjNbRXWfb1dygpYmXiHEWoIdz/Pc2sHWL1Wv
    0zqduX2YoFbNn2kPmXxyvNrpbdijMBGkLrB43UHkzpIwNf4U7J+wb4J4kE7Vgmq9
    OQ1HbXOOr14bJke7gHd8Uf+5JVV3esW8P1Slnxf4DiW3IxEhGDYEp9zA2y65Leqc
    +8f9swfCRgD5wlTOmBDkt2sJEWumHpbg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b=2BseVqP/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=MD78MWhn;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b=2BseVqP/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=MD78MWhn;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752850AbeCBWVn (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 17:21:43 -0500
Received: from mail-oi0-f53.google.com ([209.85.218.53]:42346 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751608AbeCBWVl (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 17:21:41 -0500
X-Google-Smtp-Source: AG47ELsIo1M8rXeanEqknYMz1WIpfcqUFO5HRUX0WZ1dABl+M8hyVDog6u87AoJ/sUuEYqH+uAqV3Pcbt9FL/lemPgQ=
MIME-Version: 1.0
In-Reply-To: <20180302221020.GA30722@lst.de>
References: <151996281307.28483.12343847096989509127.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180302221020.GA30722@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 2 Mar 2018 14:21:40 -0800
Message-ID: <CAPcyv4gKyvkHY_qQTYvd8wrLpaXXciJyWZY+9T7Q_Eg-Zuxpgw@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] vfio, dax: prevent long term filesystem-dax pins
 and other fixes
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        KVM list <kvm@vger.kernel.org>,
        Haozhong Zhang <haozhong.zhang@intel.com>,
        Jane Chu <jane.chu@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Gerd Rausch <gerd.rausch@oracle.com>,
        stable <stable@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 2, 2018 at 2:10 PM, Christoph Hellwig <hch@lst.de> wrote:
> I really don't like these IS_DEVDAX and IS_FSDAX flags.  We should
> stop pretending DAX is a global per-inode choice and get rid of these
> magic flags entirely.  So please convert the instances inside the
> various file systems to checking the file system mount options instead.
>
> For the core ones we'll need to differentiate:
>
>  - the checks in generic_file_read_iter and __generic_file_write_iter
>    seem to not be needed anymore at all since we stopped abusing the
>    direct I/O code for DAX, so they should probably be removed.
>  - io_is_direct is a weird check and should probably just go away,
>    as there is not point in always setting IOCB_DIRECT for DAX I/O
>  - fadvise should either become a file op, or a flag on the inode that
>    fadvice is supported instead of the nasty noop_backing_dev_info or
>    DAX check.
>  - Ditto for madvise
>  - vma_is_dax should probably be replaced with a VMA flag.
>  - thp_get_unmapped_area I don't really understand why we have a dax
>    check there.
>  - dax_mapping will be much harder to sort out.
>
> But all these DAX flags certainly look like a major hodge podge to me.

They are indeed a hodge-podge. The problem is that the current
IS_DAX() is broken. So I'd like to propose fixing IS_DAX() with
IS_FSDAX() + IS_DEVDAX() for 4.16-rc4 and queue up these wider reworks
you propose for the next merge window.

Acceptable?
