Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2835548-1520034600-2-16026145717476423587
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
    t=1520034600; b=RP6XJl3KubE0EKlfP3FcfXjFo6k6wZhbJeqE9WJjz1AaYKU
    XcrTbAdJw6hNHbbUNKSXkyM7FpOkYNpxHuXCFtEh1hftDsTJIMjQR1Wh/OPjg4id
    1+8c22aYbibLbnmyOWJn4QpDzSnAl+4liQV/VrW6CtS8mcTLyY6L0Smirb69GaGd
    9Cyf2q8eQGXxCtpeKUiG6PjOhvLj3yEQkU38VMQyRIrw+yH9mOth7xr0/mZgOAcN
    qKli0aiwnx2Z+tPcakp8+5GHMIJ6Xj/rpUZb/nUQj4ghACLHlD2gcnNPqA9wXX8B
    +584UhFJjuAH8KNUvE7+pTBsUrT50UNykX0kvyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520034600; bh=urjZkcb2GAQ2TrO9uTJ4CzRTLWv85tzExX21wa
    pSCBQ=; b=mStMn076WRqtL/9EcN3GD/m3+En1xsneJTLS/VdwFbObVGdUlRP4OE
    m3Mft6Ka3DDIGt+qbDALJeVDCNdYlILaZOVuz/yvKRmMb9oQPncEAyIjVYinJwCA
    YwAQGYInNnnCiKJKFZgLUtp8HCZuJZaCwrOrR3nzxlm3df58cKgpBfjvS8JPz0Z1
    UsFwUgv8WzY1v8b0Su5yXFYXkq73SxBlwL6DlRtqwNm1iTsuW8wFDGyQ/CeVIK1R
    2KkvhSolnXiL2Hk2G5WjAgv47H4vSCYTy15ADjLPdonPE1IEz5PtIL6PDQPDhNLD
    wuXesbuhfohQyU954qisijLrYOF7f0fg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b=HWczYa5q x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dkb8P4dD;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b=HWczYa5q x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dkb8P4dD;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935105AbeCBXts (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 18:49:48 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34344 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935099AbeCBXtq (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 18:49:46 -0500
X-Google-Smtp-Source: AG47ELv8PoxUyLDELlfVGlStUsghoRvg3kvKLuQoPfDUfq4YvzwtXtphvHy+Y7K9sDQRQnD9qXcCwjbOzPiPVwzD1xQ=
MIME-Version: 1.0
In-Reply-To: <20180302225734.GE31240@lst.de>
References: <151996281307.28483.12343847096989509127.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180302221020.GA30722@lst.de> <CAPcyv4gKyvkHY_qQTYvd8wrLpaXXciJyWZY+9T7Q_Eg-Zuxpgw@mail.gmail.com>
 <20180302225734.GE31240@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 2 Mar 2018 15:49:45 -0800
Message-ID: <CAPcyv4jM=N=wjnK4gWxHu0Fk9VXnfReLf6shW6mbzvf3sahjrQ@mail.gmail.com>
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

On Fri, Mar 2, 2018 at 2:57 PM, Christoph Hellwig <hch@lst.de> wrote:
> On Fri, Mar 02, 2018 at 02:21:40PM -0800, Dan Williams wrote:
>> They are indeed a hodge-podge. The problem is that the current
>> IS_DAX() is broken. So I'd like to propose fixing IS_DAX() with
>> IS_FSDAX() + IS_DEVDAX() for 4.16-rc4 and queue up these wider reworks
>> you propose for the next merge window.
>
> The only thing broken about IS_DAX are the code elimination games
> based on the CONFIG_* flags.  Remove those and just add proper stubs
> for the dax routines and everything will be fine for now until we can
> kill that inode flag.
>
> IS_FSDAX and IS_DEVDAX on the other hand are a giant mess that isn't
> helping anyone.

Ok, I'll take another shot at something suitable for 4.16, but without
these new helpers...
