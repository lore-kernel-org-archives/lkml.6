Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284C5C2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 005B020870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbfAUQjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 11:39:25 -0500
Received: from smtprelay0066.hostedemail.com ([216.40.44.66]:51151 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729130AbfAUQjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 11:39:24 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 364EF180A8CB5;
        Mon, 21 Jan 2019 16:39:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: base76_6ee5bcb64cf0b
X-Filterd-Recvd-Size: 2264
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Mon, 21 Jan 2019 16:39:21 +0000 (UTC)
Message-ID: <a6b96055a16da89a3cc20c145b65beb61c55f0a1.camel@perches.com>
Subject: Re: [PATCH 1/3] PM / devfreq: fix indentation in
 devfreq_add_device()
From:   Joe Perches <joe@perches.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Yangtao Li <tiny.windzz@gmail.com>, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 21 Jan 2019 08:39:20 -0800
In-Reply-To: <e45d38da-1dc4-c1ca-83d4-0efeb64acef1@samsung.com>
References: <CGME20190119183407epcas1p4958e4526d07c36605307c49b0c0e2e2c@epcas1p4.samsung.com>
         <20190119160454.23151-1-tiny.windzz@gmail.com>
         <e45d38da-1dc4-c1ca-83d4-0efeb64acef1@samsung.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-01-21 at 10:58 +0900, Chanwoo Choi wrote:
> On 19. 1. 20. 오전 1:04, Yangtao Li wrote:
> > To beautify the code format.

I believe half of the changes are actually _less_ beautiful.

> > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
[]
> > @@ -683,16 +683,15 @@ struct devfreq *devfreq_add_device(struct device *dev,
> >  		goto err_out;
> >  	}
> >  
> > -	devfreq->trans_table =
> > -		devm_kzalloc(&devfreq->dev,
> > -			     array3_size(sizeof(unsigned int),
> > -					 devfreq->profile->max_state,
> > -					 devfreq->profile->max_state),
> > -			     GFP_KERNEL);
> > +	devfreq->trans_table = devm_kzalloc(&devfreq->dev,
> > +					    array3_size(sizeof(unsigned int),
> > +					    devfreq->profile->max_state,
> > +					    devfreq->profile->max_state),
> > +					    GFP_KERNEL);

I think this bit is worse because the array3_size arguments
are no longer aligned.

> >  	devfreq->time_in_state = devm_kcalloc(&devfreq->dev,
> > -						devfreq->profile->max_state,
> > -						sizeof(unsigned long),
> > -						GFP_KERNEL);
> > +					      devfreq->profile->max_state,
> > +					      sizeof(unsigned long),
> > +					      GFP_KERNEL);

and this bit is better.


