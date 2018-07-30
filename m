Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642F6C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 20:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1095520894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 20:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HWKc7qEy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1095520894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbeG3V43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 17:56:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54572 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730613AbeG3V42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 17:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0jzlo2XvfdBx4uTUgZbKywXhhgTkV69hkAyYmocRTRA=; b=HWKc7qEyuSuGW8AhLVC/lE4K6
        HG1lIuGtRaYQNbMKNOPOThay6CvTk289UglXOso/Z2JH7hKwKbYm00q5i/W5LFfaFUU8mMGgNo+k0
        +yZC3ctpWisUqtLRlddXXINj2rEbSmx35KEpcwM56rKAjxzpok0b71DsEkdmw8Jcr47Krxh7rVUtA
        WBDLhYJh0InmJ2mCorQrXLRdQ4wZVExp9W4Fwq/u6hTqAtbxicPNFSI0S/ER+5OpYPGctdryE5fAW
        VnBcWVeFSDADmomtIgzH9GuEGSd0iVVTnwQplfV2iv3p5CAn9XviYAEyDdBkjkNzbxdwa/Y2OlEaA
        9bcCaR65A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkEdv-00052c-KM; Mon, 30 Jul 2018 20:19:47 +0000
Date:   Mon, 30 Jul 2018 13:19:47 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     Christoph Hellwig <hch@infradead.org>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        arve@android.com, tkjos@android.com, maco@android.com,
        rlove@google.com, ben@decadent.org.uk
Subject: Re: [RFC PATCH 0/4] file: export functions for binder module
Message-ID: <20180730201947.GB12962@bombadil.infradead.org>
References: <20180730143710.14413-1-christian@brauner.io>
 <20180730163452.GE27761@infradead.org>
 <20180730201224.GA1081@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730201224.GA1081@mailbox.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 10:12:24PM +0200, Christian Brauner wrote:
> > I don't expect this patch to be mergeable but rather to kick-off a
> > discussion if we can either simply export them as they are or how we can
> > get supportable exports that allow access to struct files_struct.
> 
> Maybe that wasn't obvious from the first message. Is there any way we
> can come up with a way to have versions of these functions that you
> would be fine with exporting?
> The point is that otherwise we would have to either duplicate the code
> or come up with something way more complex. If you have any pointer that
> would already help.

He said in the first reply this should probably be using an anonfd.
If you do that, I think all four of these exports go away.

And there was really no reason to post each of the four exports as
separate patches.  That just makes review harder on everyone.
