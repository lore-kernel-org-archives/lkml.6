Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3211207-1527853342-2-296477068119839525
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527853342; b=XVyX3kFqkZKp68TWH3rLseYxG5+UD4Imgrgx6YSzXIe7rIZVyp
    K3gBrC2Qww9M9p7UQp+c2MXFSIv2CZTSrHAd6mjSF3YqewUqTldq9O5EWAFN31yE
    NVy+u+UbLB8F+ODKmj9l0dMcNV+eevtMwejD9MD14rTOxC0r3pQ1wPZLgzQ4OSCE
    e2LiUODdjSFavLMyp3ZFz7Dsp6pD7iMdL0xY+KJ1pfSucd3PEBMsj9qUMdUWaQPW
    Cu1ywOWqQwX9cBhPy6k7eNxrmZY5HxvjOu5e4lJ7dBcxVkpP4MahzBAgJJsyJUAv
    LqVns6yE/4cl3BmcNKxXqFp7Mrh3O+k289mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527853342; bh=o3DImw5XA9JwPMK0D/yzRTFJfZigko
    bSLe63pNpCNbo=; b=iewElWElat/BGdNKi9fBUDblSl88GbHhN6cIpRUXuAnf8m
    u9SjZedtfMWUDMVdwvX6FnkNkre7XATxfCrAEICC2FdVoFNUcPrQC6oV18lCfud7
    AbOHoBApoMnN8HEpbK/iIgzRpZ7RzWLAe2pFNZrHMMQySKncNzks1dadAd1YuvSx
    9Z+DzDuMHLBcyseGHhyTft8T3IwcHixEpb81Gr0f/sREwHxM6N86KlppG1zwz12U
    uaeaGo7f3d5BZ2OEj5E2tAEQq9K28xYzHOt91NfFbyK+/e9+JzAXYSHe4e7zecju
    asuwP+t+FmifwlFnX95xYc6dv2xTqvicoXOL+HLg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=BG8NiAhh
    header.a=rsa-sha256 header.s=bombadil.20170209 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=BG8NiAhh
      header.a=rsa-sha256 header.s=bombadil.20170209 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP+7/6OVphTB7IJt5UMbk8OavM1Ch9ox+Xam1DZIkFFiTMiXEFvNYu+DPHUl7kTPR56husVa3/UC16hJTa5JlPZiaF6/xzIGux/YtIZ0a6yokWb+qpI3
    tlRkXco3CrsAfHZS9onmIMWkcm5geBQIVHZdgFDMpx0I4dojs6aD3DGs7ZZBtQdKWaAVx6hc5YMe0NLJIMfZL3rW5e0mggcdVAiZkX8kAgTef43HEhbuXs6I
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=7mUfYlMuFuIA:10
    a=2cDRGb9v_WFOeer2bXMA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751767AbeFALmO (ORCPT <rfc822;linux@kroah.com>);
        Fri, 1 Jun 2018 07:42:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52906 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751942AbeFALl5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jun 2018 07:41:57 -0400
Date: Fri, 1 Jun 2018 04:41:51 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Oleg Drokin <oleg.drokin@intel.com>,
        Andreas Dilger <andreas.dilger@intel.com>,
        James Simmons <jsimmons@infradead.org>,
        lustre-devel@lists.lustre.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH] staging: lustre: delete the filesystem from the tree.
Message-ID: <20180601114151.GA25225@infradead.org>
References: <20180601091133.GA27521@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601091133.GA27521@kroah.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Thanks,

all that churn without much visible progress to a mergeable codebase
was really ennoying.

I'd recommend if people want to merge lustre they start with a managable
subset first, e.g. the fs client code with simple IP-only networking.
