Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3151962-1526006576-2-8013576096579266324
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526006576; b=FVRCMByQKpY1z6Sjq6iFqkSIYOaL88cJhnLckDKJa84YVtgruJ
    onqeMH5xCsn42XYqgZAaF3jUwawWqfXfcP5BgRxCLtu4c0KWwWxoXZFlVi4iaC1w
    gQ04DhzoI+UsbdDDGmnJWK4K535mh6uaXVMvum5MBx0LTzCJpHOev86PPHjJWdh2
    c7oIIEw24JPzM545XkNAOTxaLJqUwQuSgTxp6wD76X50Mmkv5pjtDHDo4wUYxYlh
    cX4c+SpH8UwMBm+qAffCpavmF32zMcKv/ABkfTw7gVc3aOWuFfwAUWYWUxXJUb6q
    40UjAQdGWIp1FiKsOxEMlxppSGRr2AN/8Zdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526006576; bh=gKec0UdPS2UZo+3jthYj3h88pgxlV+
    8muOCW8/66nf4=; b=WSBHu+1g+5nhrj4PynAfa/K7geNZjT55gNCvlRF8WKw8Qo
    uummZZmOZahMh/YW8IDM7obuK2h6qKeqiW90FybfIt9pj89DsF4IVd7IvRmKsT+F
    7uM3PZPFmYqB8Ab3iANRBu3hrnmOl5lJ5bWtf0NkDpflSKHA0QjqilLB9Aldmid0
    7ic0yaPKRcZs1h0ct4Oh5IDMEApcxf3Zpvgapynu4oXnXN3GzVZSJlCEEIB6FHIo
    Yfvmdhp6H3kyj1tObomOBvfFxkFcElSI5aVyl15jLKbH3I4gpx7nnWy5lnjJTrqI
    vl8kZj6vkPfE5a5Wjb6IR+5e77EbT24j7nSudvTQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=zeniv.linux.org.uk header.mx.error=NOERROR
    header.result=warn header_org.domain=linux.org.uk
    header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=zeniv.linux.org.uk header.mx.error=NOERROR
      header.result=warn header_org.domain=linux.org.uk
      header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMAZlKzVtjVMOwKbKHXrBHwidXLlUwyj0A5GoBZ9gt/+yH7eUY5OfyrYeegA6NVdf9U/RLMhxo6FITG2wpDX2jU8sHPK6bRxEfLluBm/LkWzz566tvOj
    YxQDSd5nLIbRtigXsNllsJl2YDxEg5HDheg26fNq6jTl5quTeezSQBTHSvcMlkk3ac2wnBKKdvrUKF5GVWLzu2NAHMNuKn98Ll9rCHvfUT7zjlMVTGbH3A9L
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=hNBWFjliFMwE7A_psCQA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751943AbeEKCmk (ORCPT <rfc822;greg@kroah.com>);
        Thu, 10 May 2018 22:42:40 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36048 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbeEKCmj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 May 2018 22:42:39 -0400
Date: Fri, 11 May 2018 03:42:35 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        sandeen@sandeen.net, darrick.wong@oracle.com, dhowells@redhat.com,
        tytso@mit.edu, fliu@suse.com, jack@suse.cz, jeffm@suse.com,
        nborisov@suse.com, jake.norris@suse.com, mtk.manpages@gmail.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] vfs: skip extra attributes check on removal for symlinks
Message-ID: <20180511024234.GA30522@ZenIV.linux.org.uk>
References: <20180426234639.12480-1-mcgrof@kernel.org>
 <20180510204807.GV30522@ZenIV.linux.org.uk>
 <20180510230551.GE27853@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510230551.GE27853@wotan.suse.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 10, 2018 at 11:05:51PM +0000, Luis R. Rodriguez wrote:
> On Thu, May 10, 2018 at 09:48:07PM +0100, Al Viro wrote:
> > On Thu, Apr 26, 2018 at 04:46:39PM -0700, Luis R. Rodriguez wrote:
> > 
> > > Since we cannot set these attributes we should special-case the
> > > immutable/append on delete for symlinks, this would be consistent with
> > > what we *do* allow on Linux for all filesystems.
> > 
> > Er...  So why not simply sanity-check it in places that set it on
> > inodes? 
> 
> The patch is not about sanity-checks on setters though as *that* is in place
> already. Its about the case where the filesystem gets corrupted and the VFS
> *still* does process these attributes for symlinks and still prevents
> deletion because of these attributes.

... and this corrupted fs ends up setting those flags on in-core inodes.
Which is where we ought to block that.  Seriously, let's make sure that
->i_flags manipulations are done by inode_set_flags() (e.g. btrfs open-codes
that, apparently) and let's make _that_ check and reject those.
