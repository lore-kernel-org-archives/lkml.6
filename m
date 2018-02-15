Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033661AbeBOO5S (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 09:57:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:49182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033103AbeBOO5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 09:57:17 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990EE2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Thu, 15 Feb 2018 11:57:14 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Robert Walker <robert.walker@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Subject: Re: [PATCH 2/2] perf inject: Emit instruction records on ETM trace
 discontinuity
Message-ID: <20180215145714.GE30974@kernel.org>
References: <1518011845-24063-1-git-send-email-robert.walker@arm.com>
 <1518011845-24063-3-git-send-email-robert.walker@arm.com>
 <20180213222233.GA23553@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213222233.GA23553@xps15>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 13, 2018 at 03:22:33PM -0700, Mathieu Poirier escreveu:
> On Wed, Feb 07, 2018 at 01:57:25PM +0000, Robert Walker wrote:
> > @@ -946,20 +982,19 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
> >  		/* Run trace decoder until buffer consumed or end of trace */
> >  		do {
> >  			processed = 0;
> > -
> 
> this...
> 
> >  			err = cs_etm_decoder__process_data_block(
> >  				etmq->decoder,
> >  				etmq->offset,
> >  				&buffer.buf[buffer_used],
> >  				buffer.len - buffer_used,
> >  				&processed);
> > -
> 
> and this should have gone in the first patch.
> 
> >  			if (err)
> >  				return err;
> >  
> >  			etmq->offset += processed;
> >  			buffer_used += processed;
> >  
> > +			/* Process each packet in this chunk */
> 
> And probably this too.
> 
> With the above changes:
> 
> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Hi Robert,

	Can you please address Mathieu's comments, and if you agree with
them, resubmit?

Thanks!

- Arnaldo
