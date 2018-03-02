Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2765994-1520031478-2-7256592002143751764
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520031477; b=qQ2k29I9PgcucP9xGL/7w2ZM19uUPU3HuTQIi983TGudMKT
    vxr+eEaiziRhl8zOt5tzezhNPvUiQPLIblOUOyWBAjcOKQB8FwlOnTq3rEFaibf2
    wdXu2AvHoOmSKtZf7Pn95rfmQa+pf7QgaEGkJeq/uPUl2uX4vcNIMTLcYug0eZo/
    p2SB44Nl9Ppgv1AjwXHwuMXsJA+XKXQwUrz0G7Za6PZYXdldOL/rOkO8MgwMSJUH
    Kvyegb8WttROGdHCm6Dnxitf/eRyVFZS6lBkNPinb122lCTk8efVze9BJ0XajMMH
    UHB4sjDyuibhCkSbzNRCtwnRrcAHIbZLz5z5YRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520031477; bh=u35BaRl8gNr9DdhcfjTegwN15n
    HOxeF6Na6eBymVC8M=; b=LiJJIy6CkD+8BDI3WnVYrv8cxZiLrJmKQfcX8fmvJI
    A7vkal297u2h2kHBqbhX3tEN2O1ckTENqiFzfH3CdnGObtbVseJl+lqzcvA1FBJm
    buzJlrMW7ABRcw4YbwFk4fgUPfTwF4YbF4VRTidC5aUiETrQBf55YE755KyYwdgu
    EYsrMmcGGGf8gIkfc8vzwBeb36vgPnbZW28GU1UHVQOZ7PWdY4bLBeBp2B6oSUbW
    9ZzhS0aHSiDAsm5qjId/8P+546kDRXerQlFPRjNXNsxsiN27zPas66nqhyaQYLwx
    EZSEDNBVTSrAG4HDgBE1TjJwTwtdieXbc5o5HlMHRi6Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934016AbeCBW5i (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 17:57:38 -0500
Received: from verein.lst.de ([213.95.11.211]:38367 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932836AbeCBW5h (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 2 Mar 2018 17:57:37 -0500
Date: Fri, 2 Mar 2018 23:57:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Christoph Hellwig <hch@lst.de>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
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
        Theodore Ts'o <tytso@mit.edu>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 00/12] vfio, dax: prevent long term filesystem-dax
        pins and other fixes
Message-ID: <20180302225734.GE31240@lst.de>
References: <151996281307.28483.12343847096989509127.stgit@dwillia2-desk3.amr.corp.intel.com> <20180302221020.GA30722@lst.de> <CAPcyv4gKyvkHY_qQTYvd8wrLpaXXciJyWZY+9T7Q_Eg-Zuxpgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gKyvkHY_qQTYvd8wrLpaXXciJyWZY+9T7Q_Eg-Zuxpgw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 02, 2018 at 02:21:40PM -0800, Dan Williams wrote:
> They are indeed a hodge-podge. The problem is that the current
> IS_DAX() is broken. So I'd like to propose fixing IS_DAX() with
> IS_FSDAX() + IS_DEVDAX() for 4.16-rc4 and queue up these wider reworks
> you propose for the next merge window.

The only thing broken about IS_DAX are the code elimination games
based on the CONFIG_* flags.  Remove those and just add proper stubs
for the dax routines and everything will be fine for now until we can
kill that inode flag.

IS_FSDAX and IS_DEVDAX on the other hand are a giant mess that isn't
helping anyone.
