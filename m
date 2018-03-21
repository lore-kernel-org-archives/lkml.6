Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3618868-1521623213-5-14602372513797976379
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: yes ("Address greg@kroah.com in From header is in addressbook");
 in-addressbook; shared/fdfaecbe-d8f0-4518-a17e-0d89bf6dc529 ("Greg")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521623213; b=amiAmvqS1VskcLht84+8QdcojB5AIfPjgxf53/DoCRrTfF7
    SiDHQ/Mk+uTk+mZVhRZuj0cXClvBuW/aR6lPdbztBCPVRDbJpMbHGmLM1RKbsDon
    5eeNlv8k4XlhRQgqmw+qjUg0Y49q4mM5BgQUACb+m97uQp5XqsXDevA7/Pn0dKUl
    LByFMO2qHtQMPjx5pfOxVzbjOZ3DnKhYKY7l/ntIJGzYfR5rM96XHW9L+SXeR/bh
    bKrbY8MqzRCSuhtI+dguCCdyD6xrdCgyVQ/d9drSE4+iT2uSw4e276mk9Lqg3yA1
    MoTEq4ZmBVoSSq6PItDHQ4mg1S/nsGUfJSRKiag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521623213; bh=CcpGq232bQwRPYvxo/M1BXBfX+
    eggVVEvGQcQVWk5gc=; b=iFptgB9CtkCZwF6iM/b2t8TP8oaU/iBwoR5LyudeDE
    SbQIbsBw/I2fYDnBU/A5drc2KHkFI4aOQQQqpAejaJNJKJsAVachsTiSyc7aTTKw
    AYYAA0upYcc/e/PUMbVPkEVrsRVmMt0SvTWylZA1Pyfad9jk397+6baGVfIc6AWU
    /EfpfMkFpV7oTmwPKcegwNP5937Fx2KHF3kgYENCmLk5t54mGANaubZJhSEVzV0a
    hsfZ5z2h3HbNMTFOB1kM8CO+DnykHawOwz+eJgrKtS0X7zIGGCCEwhqExy+85DlT
    6yzi4ea1YgkbLponaQtClKC9C6LsBr6c8nuv0yV0qCjw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751701AbeCUJGc (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 05:06:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60424 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751587AbeCUJGb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Mar 2018 05:06:31 -0400
Date: Wed, 21 Mar 2018 10:06:27 +0100
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/28] fs: update documentation to mention __poll_t
Message-ID: <20180321090627.GC14085@kroah.com>
References: <20180321074032.14211-1-hch@lst.de>
 <20180321074032.14211-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321074032.14211-4-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 08:40:07AM +0100, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

