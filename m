Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3621199-1521623833-2-1425063660439339898
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
    t=1521623832; b=meU3gGUMxRpgvQOs74rKiQZOHwM84O1aEww+O+ebh7ed2tM
    r+kRetXfWSa1UiJKuX7N+6Yb+zoHRGPfQi5QkJE/79bfRzOC19YpxWDlW+/ccmQO
    S+16sQsCKmygSIVXRHj15xJAVEwPdK+GlbkjrsYGGjH2KfjDZpeJ3Mgmq50gBOBL
    BycYOXnHOQ41WTrvtysOSoA0ACngcwPdL6fkdChpchYfIqDnHIZuaCcpB6S0K4PX
    Eskc9Nqz9hG8NwHDvCJPAF7GmNYPM5lJhzSEMQ9NztjfQozDicoXWMmF2kIj73ZZ
    1REAkNDgM9PQKwvYcp3/qgRQY89iKiHxhqit79A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521623832; bh=18mV+G8LZ4EAa1UFC01XG/UCuD
    Y+w/lzqTV2t1rgaE4=; b=Z5vAtI0ygHWCiKjbWTuunnB1GedzHKCVX8VtiYsCZK
    egHunxX+1BD9FdV51zFztj8v2fYLTpEBc7yZuJo4o/yWpT30xiO2vb1KQwBkAexx
    UqCM5vX+OxpdWwVFXM4P7QS5Fou+gM/y0augRySwGRN1vXz8c4wTGBKNtTw/sbo4
    CcQ2N5mn4MoGkOu4cVX/GyiU1KYaK9nPb3pzQcr19kHq172yW++lg3RsFrauIOkV
    Y6pWd2sT7TMtXjZnL2Nj86YedWNX98fOxXa2UbUjrYWF7kj5Nd4HBugp8JKPCfKd
    YD7qpe0vnV32vPfl3prop8Wd+H9U8Iy8VxB6T/ZkUI4Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
        id S1751691AbeCUJRL (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 05:17:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35970 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751551AbeCUJRL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Mar 2018 05:17:11 -0400
Date: Wed, 21 Mar 2018 10:17:08 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] aio: simplify cancellation
Message-ID: <20180321091708.GM14085@kroah.com>
References: <20180321073232.13366-1-hch@lst.de>
 <20180321073232.13366-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321073232.13366-6-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 08:32:28AM +0100, Christoph Hellwig wrote:
> With the current aio code there is no need for the magic KIOCB_CANCELLED
> value, as a cancelation just kicks the driver to queue the completion
> ASAP, with all actual completion handling done in another thread. Given
> that both the completion path and cancelation take the context lock there
> is no need for magic cmpxchg loops either.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Moyer <jmoyer@redhat.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

