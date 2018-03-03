Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2979411-1520043563-2-8133042926655713136
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
    t=1520043563; b=w/HAvvimiKgJZTLTCpj0GLf9CA8jbSBveeHQnJbup2DBlM9
    Pv45/VfxbT0TktbZjFlmML9FhhKep+ZuCoi8IxGAH4ItpCPEEp1ygENwJSY2lUsD
    H/RhOuKS3DQ1uU9XUs8UN6wDD19jXw6h2rGYH3w1e9R4LSu8WzowwwiaY3s7UIP7
    kZlXh1bdzMYV1747HMPYRn5Yp9LA0zIyzgXa+W/TX/C3wzx7iT5AQBM41PayTLQp
    SJtFSj5nVwOHSMKO+c9MY1h29lmLjA4zv8mqEXWgBRQ1V1me0QZIdVYpm+3pDIkC
    dmPt/MeZMFjzZWf7zXub7tnGV35M+w5VDXdOG9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520043563; bh=qjpsXh8moTIrfIc1Nxa1kTTCCLW/kJC9SUxsEs
    D+Lxs=; b=uVp39kEWcicqYeirGYFX0pwgtLjYBTlEvVxbmjFtvRYU+jXOTF1Hsw
    msP49a2Is7OALB9NGg9bfzhZ5NQHRfyfoYlabg4Ypr379sKamoFUKcyM8WcXe4i/
    S7u5dnsgGC+cFKDgQu+72nNJjSCUzpVNcknOcnnbjxNnvuUhTKFjqvGW4WujORg8
    K9rJVDMo0vVOI9WxMMGqWV0aJZnDQ9ljhv9N1q2mOtoktsoLi9H/Fh5KAQBBP1Rx
    PvqzxEne8BVg676GsbQQ2Ms46e6vviC7kyHMCamcLAoblaexFbYUmMyeA4PxdCQu
    hp//nryPjOn7vlvzOK90D6MQmS56i1Jw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b=vu2+Vq9n x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bfQzPlgf;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b=vu2+Vq9n x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bfQzPlgf;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935740AbeCCCTT (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 21:19:19 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46551 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933609AbeCCCTR (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 21:19:17 -0500
X-Google-Smtp-Source: AG47ELv8zz4lHxTJ/JltNXKlHV7jcjK8FQe+hPwi3bXp6k/ufbaUIIM2xPay/IuJ6p+YtV2f0wXxOlBGTjkalUSuw0o=
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jM=N=wjnK4gWxHu0Fk9VXnfReLf6shW6mbzvf3sahjrQ@mail.gmail.com>
References: <151996281307.28483.12343847096989509127.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180302221020.GA30722@lst.de> <CAPcyv4gKyvkHY_qQTYvd8wrLpaXXciJyWZY+9T7Q_Eg-Zuxpgw@mail.gmail.com>
 <20180302225734.GE31240@lst.de> <CAPcyv4jM=N=wjnK4gWxHu0Fk9VXnfReLf6shW6mbzvf3sahjrQ@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 2 Mar 2018 18:19:16 -0800
Message-ID: <CAPcyv4iZ3QCR5qjvEdBEZ3PikEujJbWK62TiKoceEoG2N+dUzw@mail.gmail.com>
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

On Fri, Mar 2, 2018 at 3:49 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> On Fri, Mar 2, 2018 at 2:57 PM, Christoph Hellwig <hch@lst.de> wrote:
>> On Fri, Mar 02, 2018 at 02:21:40PM -0800, Dan Williams wrote:
>>> They are indeed a hodge-podge. The problem is that the current
>>> IS_DAX() is broken. So I'd like to propose fixing IS_DAX() with
>>> IS_FSDAX() + IS_DEVDAX() for 4.16-rc4 and queue up these wider reworks
>>> you propose for the next merge window.
>>
>> The only thing broken about IS_DAX are the code elimination games
>> based on the CONFIG_* flags.  Remove those and just add proper stubs
>> for the dax routines and everything will be fine for now until we can
>> kill that inode flag.
>>
>> IS_FSDAX and IS_DEVDAX on the other hand are a giant mess that isn't
>> helping anyone.
>
> Ok, I'll take another shot at something suitable for 4.16, but without
> these new helpers...

I'll drop patches 2-11 for now, and just get the high priority fixes
in for the next rc.
