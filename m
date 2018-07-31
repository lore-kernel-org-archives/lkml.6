Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37795C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80C6208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G2i7cVoH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80C6208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731995AbeGaT63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 15:58:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39032 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728968AbeGaT62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 15:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=loxmHTmO7iRFwPaXnXVWvxnKb5i1A01VnDiE1/qyKOc=; b=G2i7cVoHn8DUUVxj37ogUz93L
        A9UxQytMymAZCpAysKHgd5NnB/TzQZPwHj2ABZhMxvglCN9Y+5naSkyySGV0l3cx5wEPohx6co3jQ
        kk3KB/7O7VeIrnjMviFDYMOZ8W4MwcU5s2Wm3MpXnwwEO0Rj45VQI/z3XPh4DWPCpd80jTqmaUwZv
        /1aUE9Ddqz7973YvW15asJuwyALTNc0Nw9NIGueGdmeHma8D94J2Xgxyxq5ydqyOg3QOK7Zl4HmXZ
        +Qt524qXYk2qj3OH8YKmnLL0OnSyXhWbZ25R39/2SKqeY+Q7yJqm5IM4GauU2fnSiZ2oDtO0xXN86
        uvQObViIw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkZCa-0007bJ-NN; Tue, 31 Jul 2018 18:16:56 +0000
Date:   Tue, 31 Jul 2018 11:16:56 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH 14/26] media: Convert entity ID allocation to new IDA API
Message-ID: <20180731181656.GB16794@bombadil.infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
 <20180621212835.5636-15-willy@infradead.org>
 <20180724110507.idyjc3vbbivwbxtb@valkosipuli.retiisi.org.uk>
 <20180730115521.23f7afa9@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730115521.23f7afa9@coco.lan>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 11:55:21AM -0300, Mauro Carvalho Chehab wrote:
> Em Tue, 24 Jul 2018 14:05:07 +0300
> Sakari Ailus <sakari.ailus@iki.fi> escreveu:
> 
> > On Thu, Jun 21, 2018 at 02:28:23PM -0700, Matthew Wilcox wrote:
> > > Removes a call to ida_pre_get().
> > > 
> > > Signed-off-by: Matthew Wilcox <willy@infradead.org>  
> > 
> > Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> 
> I'm assuming that the entire series will be applied together via some
> other tree. So:
> 
> Acked-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Yep, thanks.  It's in linux-next and it's all going in via my 'ida'
branch.
