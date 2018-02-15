Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162525AbeBOPW7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 10:22:59 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55828 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161910AbeBOPW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:22:56 -0500
From: "Robert Walker" <robert.walker@arm.com>
To: "'Arnaldo Carvalho de Melo'" <acme@kernel.org>,
        "'Mathieu Poirier'" <mathieu.poirier@linaro.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>
References: <1518011845-24063-1-git-send-email-robert.walker@arm.com> <1518011845-24063-3-git-send-email-robert.walker@arm.com> <20180213222233.GA23553@xps15> <20180215145714.GE30974@kernel.org>
In-Reply-To: <20180215145714.GE30974@kernel.org>
Subject: RE: [PATCH 2/2] perf inject: Emit instruction records on ETM trace discontinuity
Date: Thu, 15 Feb 2018 15:22:52 -0000
Message-ID: <001901d3a670$da940cc0$8fbc2640$@arm.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHToBus32ZkxvA8D0eur/a0bJtkoKOi8hGAgAKoPgCAAAbagA==
Content-Language: en-gb
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Arnaldo Carvalho de Melo [mailto:acme@kernel.org]
> Sent: 15 February 2018 14:57
> To: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Robert Walker <Robert.Walker@arm.com>; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> coresight@lists.linaro.org
> Subject: Re: [PATCH 2/2] perf inject: Emit instruction records on ETM
trace
> discontinuity
> 
> Em Tue, Feb 13, 2018 at 03:22:33PM -0700, Mathieu Poirier escreveu:
> > On Wed, Feb 07, 2018 at 01:57:25PM +0000, Robert Walker wrote:
> > > @@ -946,20 +982,19 @@ static int cs_etm__run_decoder(struct
> cs_etm_queue *etmq)
> > >  		/* Run trace decoder until buffer consumed or end of trace
> */
> > >  		do {
> > >  			processed = 0;
> > > -
> >
> > this...
> >
> > >  			err = cs_etm_decoder__process_data_block(
> > >  				etmq->decoder,
> > >  				etmq->offset,
> > >  				&buffer.buf[buffer_used],
> > >  				buffer.len - buffer_used,
> > >  				&processed);
> > > -
> >
> > and this should have gone in the first patch.
> >
> > >  			if (err)
> > >  				return err;
> > >
> > >  			etmq->offset += processed;
> > >  			buffer_used += processed;
> > >
> > > +			/* Process each packet in this chunk */
> >
> > And probably this too.
> >
> > With the above changes:
> >
> > Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> Hi Robert,
> 
> 	Can you please address Mathieu's comments, and if you agree with
> them, resubmit?
> 
> Thanks!
> 
> - Arnaldo

Hi Arnaldo,

I've addressed Mathieu's comments and resubmitted them yesterday
(https://lkml.org/lkml/2018/2/14/185).

Regards

Rob
