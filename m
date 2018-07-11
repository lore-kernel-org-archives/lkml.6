Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D52C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 06:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB9F2089B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 06:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A94kxs9t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCB9F2089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbeGKGsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 02:48:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44768 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbeGKGsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 02:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OKT9ZqgeDe9fBoOj+OJW632w6jsua0yzSyWfeY1SMm0=; b=A94kxs9t8Vne3FmkPUVx9APynM
        CB0QSv4FIghdwTP3MCDdVxMzdFvf/2vxOXiz18Az0wZr1W+lbFKWWZQSlNkE2+FqqIWKsqtvMn8HV
        li5/6BU2prpQhN4avZ2Gcy4F/nN+3MoM5q6X/1OSXXni9DVN8eDk/b+nzZclZ9+G/cvmuNWGEHlmN
        iIql1hJwX2U9zVf2PqxjTZ1YQP6zewDPELj5AvQh7wY4bMqRD7gtmy6Z0c1XF6YR8HrcnIv2lktCs
        As1517A5+C+zzJuS4TNCziU0KTKgLqTdu7O4fWkyQlyT1Dqj5YK2NhyDFi1VZU43H+xE3QUHrMBAX
        b11GK3mg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fd8sg-0003RG-Bk; Wed, 11 Jul 2018 06:45:42 +0000
Date:   Tue, 10 Jul 2018 23:45:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Tony Battersby <tonyb@cybernetics.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] SCSI fixes for 4.18-rc3
Message-ID: <20180711064542.GA7377@infradead.org>
References: <1530913134.3135.2.camel@HansenPartnership.com>
 <CA+55aFy-o3fRtkQnJU=0zv7CPUtgfKiwhfQi_05K25Y_-mx+_w@mail.gmail.com>
 <CA+55aFxQ8QzGTWsVdVQVok9cLbgZDFjG2g3JZtWJd+G9jHkYoQ@mail.gmail.com>
 <CA+55aFxAy__3hE1OoUFPKZfptLT1cXuoujsnSGXBMzJPQ+Qjzg@mail.gmail.com>
 <1530940958.3135.4.camel@HansenPartnership.com>
 <CA+55aFwg-2GP4ASTdd1pusmZkF7c8AN9febVDCaioDxzYJSLfw@mail.gmail.com>
 <70d566f0-2dda-60c2-7c7a-e09e371f8607@cybernetics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70d566f0-2dda-60c2-7c7a-e09e371f8607@cybernetics.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 05:53:18PM -0400, Tony Battersby wrote:
> At my job (https://www.cybernetics.com/), I use the write()/read()
> interface to the SCSI generic driver for access to tape drives and tape
> medium changers.  For example, the write()/read() interface is useful
> for implementing RAID-like functionality for tape drives since a single
> thread can send commands to multiple tape drives at once and poll() for
> command completion.  We have a lot of code invested in this interface,
> so it would be a huge pain for us if it were removed.  But in our case,
> everything runs as root (as the firmware of an embedded storage
> appliance), so extra permission checks should be OK.

Do you just use read/write on /dev/sg or also on /dev/bsg?  Because
I started a discussion to kill the read/write support for the latter
even before Linus brought it up here..  (and we have the same fix
pending for /dev/bsg)
