Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3618868-1521623234-5-10972987769012402171
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521623234; b=fHQLS/QC1TBJZqrjs5xcKrr4mAz2ZBvmXWBN7FTOAh3b7K0
    sPoRMAJU9O8uHtlGYDrm8tu1t7Reqx7SpnMQ1+T/YODd02HIbded4AM5ZNk3QOfT
    wSou9p6JjvRV1hFnn2iqlZ1zOvYSlmvaVoZP23O77a8ZrKONBgtwPOjIcpnlyJQU
    MOPDGcVugoMpvwzeG7Pk9iDv6RlbwHzBJ//zV/ZSd71Un+dBdDWD0hxquPETJpvn
    DU1tFrtYELy1mIyOWCxArdoxZjdkCUkU6XzqU7ao/9fMVtOdijNoN0lQJhaHyRW2
    OOFWc+YXs0gUzeg/jWX3rhobUYocz/93vetNiqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521623234; bh=rK8vGbmR3AQM8JlO6JpVZ0FxdN
    /ugkBrBPr+FXhVKlA=; b=KyLR7JDqMpvRlf3+xscTghtrYPgSSbaK+ebr+bz4ai
    Ddwkojf5QNB1Tkh3KUGHT5yJEdvwDppWyugT7h+HZBbSuvPnBkVpwDG372/KKp/3
    dzGX+kWInzgdhDvzI8lz4OlC/NK87DC0KsfeJWj21V0SMbSXQg3aip2oZBmDgulx
    jOW2usIWoC40400OZyNeMqws4n3Nycnoqc/70MAHls5Ldg4/IcJtfR/u0QUFwVwQ
    HQuqv9lWXo6xjQ+HOnNpodnG3wJDVMjb37Bnci+p9eg56l93CY/km1p/ahAspP3d
    BZ9ANEaJO12jS9PPmSXOkMP6VNTkYXysc5EIfnnTCfaw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751615AbeCUJHM (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 05:07:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60512 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751539AbeCUJHL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Mar 2018 05:07:11 -0400
Date: Wed, 21 Mar 2018 10:07:07 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/28] fs: add new vfs_poll and file_can_poll helpers
Message-ID: <20180321090707.GD14085@kroah.com>
References: <20180321074032.14211-1-hch@lst.de>
 <20180321074032.14211-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321074032.14211-5-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 08:40:08AM +0100, Christoph Hellwig wrote:
> These abstract out calls to the poll method in preparation for changes
> in how we poll.

Yeah!!!

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

