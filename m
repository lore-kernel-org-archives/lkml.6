Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D152EC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 774ED20866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aCH5xbSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 774ED20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbeILDw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 23:52:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58932 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbeILDw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 23:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uSFBtsGTtyxglEE+ce83oXw4stYMRDCEQWoZhgHy0KM=; b=aCH5xbSffyK9VCJgL4TcvSm77
        A4bsDcVI2gHBiuW+94AsqzTw+SxYyiLnh9Z4Bh5jpuzEj5FXErgk10lsrs526/jqWyjf+57cYYIbh
        jyIlvhIVdF2A+6U67VKep0dB9NJUuLOXhEqgAZv8CxKO5awEHqpPh1zUj6Ph1GL7zM957P8vh73QR
        IctmRcdhukQ2YvPGnH9X4Q3yyRfZ6HpwQFN81mDkqTTe7oMip6eg2vIXJ16WeFW4O+J5DbMUrnszB
        nLIqNTqaKxbdhCSBpasHwHy7xemseHhVhXRqhIe7TQPb66yhIHZSKUFMy5pdQbvWiegvIqzKLJEFU
        NHxfEKH2Q==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzrVC-0000pA-UO; Tue, 11 Sep 2018 22:51:22 +0000
Date:   Tue, 11 Sep 2018 15:51:21 -0700
From:   Darren Hart <dvhart@infradead.org>
To:     Mattia Dongili <malattia@linux.it>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: sony-laptop: Mark expected switch
 fall-through
Message-ID: <20180911225121.GE5659@wrath>
References: <20180705204703.GA12352@embeddedor.com>
 <20180706232427.GC3041@fury>
 <20180707185616.GA7168@taihen.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180707185616.GA7168@taihen.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 08, 2018 at 03:56:17AM +0900, Mattia Dongili wrote:
> On Fri, Jul 06, 2018 at 04:24:27PM -0700, Darren Hart wrote:
> > On Thu, Jul 05, 2018 at 03:47:03PM -0500, Gustavo A. R. Silva wrote:
> > > In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> > > where we are expecting to fall through.
> > > 
> > > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > > ---
> > >  drivers/platform/x86/sony-laptop.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
> > > index b205b03..e614cb7 100644
> > > --- a/drivers/platform/x86/sony-laptop.c
> > > +++ b/drivers/platform/x86/sony-laptop.c
> > > @@ -4427,6 +4427,7 @@ sony_pic_read_possible_resource(struct acpi_resource *resource, void *context)
> > >  	default:
> > >  		dprintk("Resource %d isn't an IRQ nor an IO port\n",
> > >  			resource->type);
> > > +		/* fall through */
> > 
> > Here too, I wonder if this is intentional. Either way, from what I can see, the
> > final line in the function:
> > 
> > 	return AE_CTRL_TERMINATE;
> > 
> > Is unreachable as there are no "break" statements in the switch, and the default
> > falls through to return AE_OK. Something doesn't seem right here.
> 
> I think so too. Looks to me that the default case was meant to return
> AE_CTRL_TERMINATE (i.e. swapping it to be last would do).
> 
> Having written that code aeons ago, I'm not sure if there is a good
> reason to be like that, though it still looks like a bug (that
> existed ever since...).
> 
> Want to fix it as part of this patch series? Or I can send a patch
> myself, let me know.

Mattia,

I'd prefer to decouple the fix from the implicit fall through discussion. Please
send a separate fix.

-- 
Darren Hart
VMware Open Source Technology Center
