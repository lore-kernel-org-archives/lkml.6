Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3618868-1521623852-2-14724647319931360300
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
    t=1521623852; b=IwSeMSQUO1yvxF0PebGEVY9MKxt4Tv+ilMh/HOslcG1gh68
    gCWbQFEj9AntQ7CP9htvOxjaZMHwgEVmZjC81yBMAQjKMpLKRLJN6DX9a8z6qQhY
    vB47xffSYzQuHwBn2tytgHuMIlQxWouqps4inkGbrcXHvDBYDQ1SVtIZ2u5ma/fJ
    Eb08H2oNgfBNH//WJPF6UpsM7eDY5oAuXt2ZOWEOcMiX2PxkfFO3c1oJphz54f+E
    TWd7ZxeTvusv9VRlDmHUi7MuNxewyARCKzZR1rbSiFDV2ENO1o5omg1bTc7G3faM
    2ACv64OSvH6GmWCPu9mUCys89/8wsYkB5zhfIww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521623852; bh=um5SEia9QRD0juvDKz3U2+l0ht
    6wi4y4va2XqxQ2M+g=; b=tP+/JQzZaZ4AXtcGbJX2IF4mooB9IfhFyJR9tUx7wO
    OhsY3z/b1n4+Nt9XbrM1gCnGInolA9vcrkS0FNO5coe15TdPcD4h/fs0+Wo/YvXB
    8qlJEPUHbe8u6OV5rWnw/G2m2TaQWLB/4/HIkujoBrbAwklq0fVoWHjvN+RPqfnH
    gqL75QtiTXjt2G/4zraDZ65f8U975JZ752Q5ZAFm8Dy3/65yRHri33Y4cGen2sYP
    laXFjXtcz0fyw06IlcHIQkcgmHcbRup5dFkNLwCNuYFedB1+JqNX7EhPPw1PYXwO
    xIKdXt8ZfMD57U3rFU00VUuQX0wfFpo4vVZn5dmbLkHg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
        id S1751551AbeCUJRa (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 05:17:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36024 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbeCUJR3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Mar 2018 05:17:29 -0400
Date: Wed, 21 Mar 2018 10:17:25 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] aio: delete iocbs from the active_reqs list in
 kiocb_cancel
Message-ID: <20180321091725.GN14085@kroah.com>
References: <20180321073232.13366-1-hch@lst.de>
 <20180321073232.13366-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321073232.13366-7-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 08:32:29AM +0100, Christoph Hellwig wrote:
> One we cancel an iocb there is no reason to keep it on the active_reqs
> list, given that the list is only used to look for cancelation candidates.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Moyer <jmoyer@redhat.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

