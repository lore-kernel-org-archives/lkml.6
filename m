Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3618868-1521623420-2-553472361569353363
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
    t=1521623420; b=Wt9ZMfgdJNrcrkM6Pffcjr0pyQ6p2AcPDOp3A6NzMO0T2yJ
    c8jXR2ZogsgPZoQ5ZLdgAJcDP9Jx/nE+O4TmVUtqCcJvc5hd6qysQMsQhcTV/9Am
    I9uFbnKnQkmhiBsIZYlA66TF1wio6ThZX/XAumoLVtyHrY4IHffWDLLFdV0lb/AF
    lx45FMiVIbyQfyAGKQMA8TJjMDd4W0scnYnp+OBvNRq/zzIwu6ZADPtilcFDsRap
    Cj++06Kr2mqFgOsJd2ikIUVs6nE1Lp9A2fArzcuy7BzrJuLAudDpgvgzo9XFzujE
    kDOGqxOipzmSaqV2U4XiC3ugC/fNElm7QrfPkkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521623420; bh=xxXqv7tmPnZi90PeSedqRK0Pk+
    viwBZMUddcvqWM3NU=; b=On2SNpiJsJ7Uo9ilEo5DNqg+pnVEsJncND929T892S
    IJ8TqfzmGugvv4iomRuKosyqCD0RGkElVAz+DcbQzHvliyZtjFf8z9YEV6A7ZzQa
    OsPj+VgWQOdr3REkTEy/93BzhOpG1z6ncTwcAVdU4cLb1qYePUdfSrmEIZa4h4mY
    YnwIJOLEedro0SOAdcsE/VoKS+gaSi8/pNamGIMLfrwyMT+EP9Zy4PgYLmSc7Fes
    QEAQAJ4sv+xRglHDiro3JaTnSYgDKviAoTGSUi45eoOUDfBUU7BpzTIhdVWkkwM4
    lKofQw/qo9LUk4X6A2Qpqy8JlL2sVvewc0lZIw9ICLXg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
        id S1751464AbeCUJJ7 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 05:09:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33284 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbeCUJJ6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Mar 2018 05:09:58 -0400
Date: Wed, 21 Mar 2018 10:09:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/28] aio: implement IOCB_CMD_POLL
Message-ID: <20180321090954.GF14085@kroah.com>
References: <20180321074032.14211-1-hch@lst.de>
 <20180321074032.14211-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321074032.14211-7-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 08:40:10AM +0100, Christoph Hellwig wrote:
> Simple one-shot poll through the io_submit() interface.  To poll for
> a file descriptor the application should submit an iocb of type
> IOCB_CMD_POLL.  It will poll the fd for the events specified in the
> the first 32 bits of the aio_buf field of the iocb.
> 
> Unlike poll or epoll without EPOLLONESHOT this interface always works
> in one shot mode, that is once the iocb is completed, it will have to be
> resubmitted.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Moyer <jmoyer@redhat.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

