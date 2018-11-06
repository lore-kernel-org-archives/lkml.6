Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D583CC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 07:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 914082085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 07:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OeZlf9u7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 914082085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387667AbeKFQhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 11:37:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60164 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387397AbeKFQhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 11:37:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=52Uw9UTCp368eDtHyqduuo1cg5P/3UO0sHb8dhbVkNQ=; b=OeZlf9u7m2uMdUZ63xLxBUNmp
        PkRwibB4RQ/bYgZAN1yx4XtzRbmDMRwTYlnJTztNl23HIf2uvtaT1dRN8IFwudy4CANipOw5nPe/Z
        W6HFMuT/DGtWIt0CNw1DBmTxoFCgJIeQxSpNejoF67eBPMe/ufAivuDpksMnjypIWJy3xWcUxoXHH
        R29/+IvaSdInSnkorNUkI124Pj/aRoksSEa2sLHSDwhkP8iO1YmAp+Q9nHk/CJQLwBp3bSRlexWPo
        lYntX7U/XX/uNLQMA9rhqJmqVmTiuxxUo3UPseGloZgMxEv6FlLl8FFg2rT3SVq3QjgCETI31Uvi8
        w91Nl1sJw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJvYb-0001v8-6J; Tue, 06 Nov 2018 07:13:49 +0000
Date:   Mon, 5 Nov 2018 23:13:49 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Vitaly Mayatskih <v.mayatskih@gmail.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, stefanha@redhat.com
Subject: Re: [PATCH 0/1] vhost: add vhost_blk driver
Message-ID: <20181106071349.GA5526@infradead.org>
References: <20181102182123.29420-1-v.mayatskih@gmail.com>
 <6a7f1668-bf2d-0caa-2efd-c8fab5f1db24@redhat.com>
 <CAGF4SLg6+nt+zV4haXys4Wz2dWPDyx7xHXuA+h01NcQ94j0E1A@mail.gmail.com>
 <57eefa62-7e66-786d-441c-5dd6b0d451a5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57eefa62-7e66-786d-441c-5dd6b0d451a5@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 10:45:08AM +0800, Jason Wang wrote:
> > Storage industry is shifting away from SCSI, which has a scaling
> > problem.
> 
> 
> Know little about storage. For scaling, do you mean SCSI protocol itself? If
> not, it's probably not a real issue for virtio-scsi itself.

The above is utter bullshit.  There is a big NVMe hype, but it is not
because "SCSI has a scaling problem", but because the industry can sell
a new thing, and the standardization body seems easier to work with.
