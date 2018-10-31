Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932D4ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 20:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B18520657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 20:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="lwwtlawa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B18520657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kudzu.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbeKAFjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 01:39:35 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43053 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729361AbeKAFjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 01:39:35 -0400
Received: by mail-yw1-f66.google.com with SMTP id j75-v6so7046364ywj.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 13:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ag4afwnhR8XA7llS/tQw37jN52nk9/rKkgOf/Fc7jjY=;
        b=lwwtlawamrBUOKa0k51eAUywWnV2ma/ETey5VpOyZdx65bhXGGvo2RuygS9N6zvOEC
         OhOrZibdOs+PSuxUyE4bIDIXWIGM9y5ogAYnc4lhnlk3mGhbF/+G++kt4tCffU9Nv8do
         3KKLF0Mtr1rtu2siu66qxNdwRyoO1FEmbbHAZy7BRP83i1faXnfpOcHyIU+/cDbx+D1t
         jXJSEEG1VZxKICohFcUNBIDz+gDUqPcRRNz939s85mynBDrZ4kXu7r81ig4yX3GXhjgm
         bW03DSgKNRf3KVvh7UCu6ImEIc7TS0IWIvC3CduFQt9KFgUkWcM59tr01YhMp5UvUMXy
         WPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ag4afwnhR8XA7llS/tQw37jN52nk9/rKkgOf/Fc7jjY=;
        b=HWFIyqKw84jNH2zs3sbuLt0DeRmI562QxwHERAuHhasD9dnxMEour8D5E42rvGo+T9
         PL12ujW6TzvfqOG/CYTLBXS+MXwKw6FBaZu9KBlMqaxCNYvX+S1mW1bp1s1aGuP3VJH9
         FMJeTWZ+g8j2p6nJjxmS6DGMyVcTzulrfNAyXBL4qU4oMHcmMIa2Xo4Qb5TDn395hdcc
         kO7yaHfD2KdsUtkYUg/bxAyqZ2qPibw9g8ZgkhL8FcgRB1DWYM/rYDOVd9+HG5VMxFsz
         EKtY3Psy+IE+hOWiTJ+Frgp0//ApGLLEotnRwjcFgzEUpbPY36ztw13LptC/ufP+/5YR
         wS2Q==
X-Gm-Message-State: AGRZ1gLffY3knny/Mv7B+v0H7DzeGs3XGe7amLTKjxu85NK5rnELZOor
        WoCdfYxqEfOtE0pNYZ+cNUwz1w==
X-Google-Smtp-Source: AJdET5cEUXYNlHaBY5FXvu1zcQN9VPJ/3mPBrfvHajDmrOCIs2SSAzz8/JQHR7RGgMe6SP3V/iQibQ==
X-Received: by 2002:a81:ad58:: with SMTP id l24-v6mr4623632ywk.64.1541018394458;
        Wed, 31 Oct 2018 13:39:54 -0700 (PDT)
Received: from kudzu.us (76-230-155-4.lightspeed.rlghnc.sbcglobal.net. [76.230.155.4])
        by smtp.gmail.com with ESMTPSA id n62-v6sm6635749ywf.105.2018.10.31.13.39.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 13:39:53 -0700 (PDT)
Date:   Wed, 31 Oct 2018 16:39:52 -0400
From:   Jon Mason <jdmason@kudzu.us>
To:     Allen Hubbe <allenbh@gmail.com>
Cc:     gustavo@embeddedor.com, dave.jiang@intel.com,
        linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntb: ntb_transport: Mark expected switch fall-throughs
Message-ID: <20181031203951.GC22474@kudzu.us>
References: <20181005071234.GA8803@embeddedor.com>
 <CAJ80sasrMXyC4jDGG+-wDLLXSApM6-HdgmgGwNMtH7AMwPdCUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ80sasrMXyC4jDGG+-wDLLXSApM6-HdgmgGwNMtH7AMwPdCUg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 01:03:01PM -0400, Allen Hubbe wrote:
> On Fri, Oct 5, 2018 at 3:12 AM Gustavo A. R. Silva
> <gustavo@embeddedor.com> wrote:
> > In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> > where we are expecting to fall through.
> >
> > Addresses-Coverity-ID: 1373888 ("Missing break in switch")
> > Addresses-Coverity-ID: 1373889 ("Missing break in switch")
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Acked-by: Allen Hubbe <allenbh@gmail.com>

Applied

Thanks,
Jon

> 
> > ---
> >  drivers/ntb/ntb_transport.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > index 9398959..c643b9c 100644
> > --- a/drivers/ntb/ntb_transport.c
> > +++ b/drivers/ntb/ntb_transport.c
> > @@ -1278,6 +1278,7 @@ static void ntb_rx_copy_callback(void *data,
> >                 case DMA_TRANS_READ_FAILED:
> >                 case DMA_TRANS_WRITE_FAILED:
> >                         entry->errors++;
> > +                       /* fall through */
> >                 case DMA_TRANS_ABORTED:
> >                 {
> >                         struct ntb_transport_qp *qp = entry->qp;
> > @@ -1533,6 +1534,7 @@ static void ntb_tx_copy_callback(void *data,
> >                 case DMA_TRANS_READ_FAILED:
> >                 case DMA_TRANS_WRITE_FAILED:
> >                         entry->errors++;
> > +                       /* fall through */
> >                 case DMA_TRANS_ABORTED:
> >                 {
> >                         void __iomem *offset =
> > --
> > 2.7.4
