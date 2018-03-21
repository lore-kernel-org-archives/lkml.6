Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3618868-1521623193-3-3380759752067894919
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: yes ("Address greg@kroah.com in From header is in addressbook");
 in-addressbook; shared/fdfaecbe-d8f0-4518-a17e-0d89bf6dc529 ("Greg")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521623193; b=ruA2Qt7LEbfbw92M6Ix9npI9zGs3NlPF2P6y75tQue/ejvV
    Y0vsBA/YCIFcdcZmeTYPIOc1D6k3HwxMSeNrREPfqkSGVsxen10wZaZeBQ2rwUvS
    TZH/lIAriPZV8SgAQIEn+qknezEQRXUkHPCo8PB0pNn5SpM6q/M6PY+yowb00bsP
    QfmGyhw4yALkJtuTJ9CEsAANOsu+d+iHpJaUYgfo4IT8CpL3T/dtXMC7CcMg3LRd
    a/fs8S1mFX5Xo6o8jmFmWOUDxNN89x9wznn/PiYB5H+Q9eFX+u7+wtz1e321jAPq
    c1tdIp9f13XwlyGVUaTU/atgdHMD/h9BNkxebuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521623193; bh=PCdo4xDfRTX0mqR9lBI6Y/I64W
    2ndXhQCwpGUTN6VEU=; b=FC1jbfQS0dtMXvRza1zmFHAzLzQ5SLSvFqtsphNGXH
    YfRF6WxApIny3WmBT0MN5VVXnS3l+XkfFY83phVVspHVBllVTUxF8+f6mSIsLXAe
    wL3bVom3Ei/TxO1Pvzope0Cz2G3IUfmMww9ByocduuXw16CD+HioB1NhF+izMG4d
    D0f/bY+j+WANxoPRdj7CY/bKjfkddtFrgg5ORXp7I6WNV5Yjq9G3BvEwjT9L4Av4
    6RZiIi0WilVWnPHRBTXquOYtEpxMqck03E43awQZvq/3o0HMtEEg8KNdmA2QA7tm
    G+nST8RzmgK9afC5d1DMGKCmt/Ns50brmA3VVlmYBzAA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
        id S1751801AbeCUJGL (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 05:06:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60394 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751587AbeCUJGI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Mar 2018 05:06:08 -0400
Date: Wed, 21 Mar 2018 10:06:05 +0100
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/28] fs: cleanup do_pollfd
Message-ID: <20180321090605.GB14085@kroah.com>
References: <20180321074032.14211-1-hch@lst.de>
 <20180321074032.14211-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321074032.14211-3-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 08:40:06AM +0100, Christoph Hellwig wrote:
> Use straigline code with failure handling gotos instead of a lot

"straightline"?  :)

> of nested conditionals.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
