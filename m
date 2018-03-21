Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3618868-1521623310-2-12891297232536623237
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
    t=1521623309; b=kaJyXab3ynPDfpVQ12ujU3rbH3iPyd81I0ud1PqLSaCMoW+
    bZJjjrAp40/TSwaiN2KAaKzNlqO1Y454OzagfCJxl/vKPhKoQ174a6Hwd4pj7XED
    H2sOvlSQi44qOszcma2t37Y6nXyGGpXorLWC64J4WIXEku6ZmRBt9r79DTu/E7ii
    T2Q4wfmndQ6TfKucaWawYisY4Cl/ebNRE0b5mAWc/eHhguSKxdLtzSi/LlGIkrbJ
    5BwSUy6zAxnC+vUKASwOxLb724cg2R9iEg2oJzdeqz86zKuzbfPviXDUUqwMIbSJ
    tYf2xKHPvPczekdXbD0iNGd7UWL1jyDSBxInQ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521623309; bh=G86wjMGnNwcsjM6t3tfKwFA1VS
    T5PMDFL6eoRvEgCaU=; b=FgnqfN/CHyUTiZOlW0Ibj+qMd52y9VROjE0VQTXvvi
    c7YVNlvZLs37Q56usWQdPueupOSjlW9UdGiE8RwsJLeDtPgl1n+nMdCRNeWnaIyJ
    vEDW47agKi/1aQMXD60gJS4LtbyD/+eHW4ZdWZYn6lpLiNiAdK5EFzd2/Gt/3Sae
    diWKb9QPESbf9Jy1zamTVhBqHf5VRW+CZlpr3ub/2taiDAn9kc/+rNFCVsWSCoVs
    XKWEXRGMfjqY/vdkNCCkAwtCa5Dy8fJWlSj9ZaMjPUuwC0Pu/YAqvLTIcO6Kfsy4
    oBKqsnVHxzaJDFKrGfdgjRH49p2q88yoR7I2xLpGDbng==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
        id S1751600AbeCUJI1 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 05:08:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:32982 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751539AbeCUJI0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Mar 2018 05:08:26 -0400
Date: Wed, 21 Mar 2018 10:08:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/28] fs: introduce new ->get_poll_head and ->poll_mask
 methods
Message-ID: <20180321090823.GE14085@kroah.com>
References: <20180321074032.14211-1-hch@lst.de>
 <20180321074032.14211-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321074032.14211-6-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 08:40:09AM +0100, Christoph Hellwig wrote:
> ->get_poll_head returns the waitqueue that the poll operation is going
> to sleep on.  Note that this means we can only use a single waitqueue
> for the poll, unlike some current drivers that use two waitqueues for
> different events.  But now that we have keyed wakeups and heavily use
> those for poll there aren't that many good reason left to keep the
> multiple waitqueues, and if there are any ->poll is still around, the
> driver just won't support aio poll.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
