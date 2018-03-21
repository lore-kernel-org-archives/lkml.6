Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3621199-1521623585-2-837839937890075756
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
    t=1521623584; b=Y7xsqI0ueCw3w/+as1bdLVmPfOu5Oq9G/m4fkwqkMkkjmdq
    HhCzZVGJwxia37CTKi769iQJhpLXp1W4k2OfwYbqK+wVNhTFSkFUswev6S2vUibn
    WK69Gy980B/gKkFaOczwfeyiyBpin/feJbi9sE468EgvbKsn7p/90H6S8En7gqL9
    FJiLV6FKVDUbLMk9JpfAOQvikng4zOXTNjgk6RzDMbGFzys/EdHsEIJl2fQ/wmzf
    uQw3yATJo2I8zs0KaKog1shnDFJs4cQub/TPz5yjK/EGc4Cq1sfbqWEWGXLTWIGe
    Z41G4bm6oU0ifkr5vsNBuyDyg920Zos+pJQrKaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521623584; bh=R6z5AJhBoRKai3ma288lhZLwwv
    eaREKdyNN9qpxLgU8=; b=EJ3TqUzoL5cOd6Q3ZmfZ2EqoS29lAdEZmyFjLADpOE
    MRaqNKFEj3R/4Fe0YXjesHXmqNfTTJLTyfk9YbRcURjB0QfHNoumMX0ITsPfldNO
    WLJHQsOImpeyFi6K74OjmuxDa7zmM56l+6XR+EOUPeXY1DY0o8rDbMTbTnwxJzoR
    0eJooaX7u96XtOgUimkCRgd1k+3ev5s6cfuzu4ohUckdXQTbannRbZ0vtu7R23//
    jgTzBIo20eLROHcSNPJBYpWOgIHpP8Q2efLwfjPkK/1q8Pc3e92Vbpoe81sodMRK
    eniourSOY1b16tF8pIUkeLkj9aN0UoAUpD+w5nCvcoaw==
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
        id S1751545AbeCUJNC (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 05:13:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34100 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751514AbeCUJNB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Mar 2018 05:13:01 -0400
Date: Wed, 21 Mar 2018 10:12:57 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] aio: don't print the page size at boot time
Message-ID: <20180321091257.GI14085@kroah.com>
References: <20180321073232.13366-1-hch@lst.de>
 <20180321073232.13366-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321073232.13366-2-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 08:32:24AM +0100, Christoph Hellwig wrote:
> The page size is in no way related to the aio code, and printing it in
> the (debug) dmesg at every boot serves no purpose.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Moyer <jmoyer@redhat.com>
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
