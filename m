Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF07DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91CF620989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91CF620989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbeKUUpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:45:54 -0500
Received: from smtprelay0198.hostedemail.com ([216.40.44.198]:54559 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726048AbeKUUoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:44:54 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 49208837F24A;
        Wed, 21 Nov 2018 10:11:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tax71_90b58eb99762
X-Filterd-Recvd-Size: 3008
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Wed, 21 Nov 2018 10:11:02 +0000 (UTC)
Message-ID: <9704b8ad06e556fc3d412d8b4962baf2f38e8818.camel@perches.com>
Subject: Re: [PATCH] staging: greybus: Parenthesis alignment
From:   Joe Perches <joe@perches.com>
To:     NeilBrown <neilb@suse.com>,
        Cristian Sicilia <sicilia.cristian@gmail.com>,
        Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        David Lin <dtwlin@gmail.com>
Cc:     Viresh Kumar <vireshk@kernel.org>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        linux-kernel@vger.kernel.org
Date:   Wed, 21 Nov 2018 02:11:00 -0800
In-Reply-To: <87zhu3auwi.fsf@notabene.neil.brown.name>
References: <1542569289-19899-1-git-send-email-sicilia.cristian@gmail.com>
         <0d630c2b5d234eb4131b8021b345edbf080b2c52.camel@perches.com>
         <87zhu3auwi.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-11-21 at 15:58 +1100, NeilBrown wrote:
> On Sun, Nov 18 2018, Joe Perches wrote:
> 
> > On Sun, 2018-11-18 at 20:28 +0100, Cristian Sicilia wrote:
> > > Some parameters are aligned with parentheses.
> > > Some parentheses are opened at end of line.
> > 
> > Given the very long identifier lengths, I wouldn't
> > consider many of these appropriate.
> > 
> > 80 column line lengths and long identifiers don't
> > play well together.
> > 
> > > diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
> > 
> > []
> > > @@ -70,7 +70,7 @@ static int gbaudio_module_enable_tx(struct gbaudio_codec_info *codec,
> > >  		i2s_port = 0;	/* fixed for now */
> > >  		cportid = data->connection->hd_cport_id;
> > >  		ret = gb_audio_apbridgea_register_cport(data->connection,
> > > -						i2s_port, cportid,
> > > +							i2s_port, cportid,
> > >  						AUDIO_APBRIDGEA_DIRECTION_TX);
> 
> My preferred formatting in this situation is
> 
>   		ret = gb_audio_apbridgea_register_cport(
>                 	data->connection,
>  			i2s_port, cportid,
> 			AUDIO_APBRIDGEA_DIRECTION_TX);

Odd mixing of spacing and tabs in your example here.

> but checkpatch doesn't like the '(' at the end of the line.
> Do you know why that is?

Generally to avoid function declarations like

static int foo(
	int bar,
	int baz)
{
	...
}

But this also is meant for function calls.

And this obviously does not work well with excessively
long identifiers where a statement or declaration could
not fit in 80 columns.

Perhaps some logic could be added to suggest use of
shorter than some specific longish identifier length.

cheers, Joe

