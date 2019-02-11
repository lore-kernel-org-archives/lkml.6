Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7E9C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AAA8217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfBKVD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:03:29 -0500
Received: from mout.gmx.net ([212.227.15.15]:33757 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbfBKVD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 16:03:29 -0500
Received: from localhost ([178.7.117.106]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MPlsg-1gyGXR0Vu6-0050Sz; Mon, 11
 Feb 2019 22:02:35 +0100
Date:   Mon, 11 Feb 2019 22:02:30 +0100
From:   Peter Seiderer <ps.report@gmx.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, b-ak <anur.bhargav@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org
Subject: Re: [RFC v1] tlv320aic32x4: delay i2c access by 1 ms after hardware
 reset
Message-ID: <20190211220230.7cd7b559@gmx.net>
In-Reply-To: <20190211150425.GE22391@sirena.org.uk>
References: <20190210154519.2506-1-ps.report@gmx.net>
        <20190211150425.GE22391@sirena.org.uk>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:mCXkl4nnOeZcbWEiiMtora/1vcLNzBERAn+4jKu9juWeX47PtBP
 W+Xdvd0p9++YfprM/T8o1Bj9h4SCGvaako3zfUZxZ2/KL+25VcsMXg0dA/Nr3B3LWtFZCwm
 wkaSlXjWjM2F/2ZWbYBCZ+hoz6yPyFRyJCzju9DBVNKQ3djAeHbrO16Hp//1RNcDQG8jyRx
 BEo/hs/rxcWFFVMdcUjyw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aUnxlxBakCo=:go98AzJ42TYTq1A5CJfm8b
 IygNXQmtI6XeYsNRy1IDP8MYPtGEp9BDgranmHFb2Whqog3Gu+bVCd5/OAYOwDTBKXkR+yAs2
 JT3+6qtt9Xc+HZWzoOT2Pqt/LIVvsOFwdZEhP8SIYmkj7PZN8jxGwC+7iXPpcHfxFBkcgwcY6
 Ra77hY8mghdKIbrOWMV/Ac8GZRksOcoZcogQOuOm77N00x16LBEKL0gVHdZpZuokPt5pugq7f
 v8+pJM6CvJlGLsIoTNZt/DmAAsuYU4GQltltMrSZerjjAVN6uhTmF4D29TX1sHP8b+SAgJr3K
 NbTHYzBe1nuCpI04wjsPwCKTbKZVJQfd+OV6X+u/2kuY5D9NK+u+Fw9/j0MsjNuuhvbrnM7+y
 jArPefq/JlZN40aoD5tgvud0uqyDWTBznmibhFbCiYk6Jdv+tSi+SKwS9Fk9LRPbCS+RQITqK
 D9w6/Mpp+9SDaJfCoTx0ZLjv3hZ0/xwFr2zvPfLjbHL2CM9TlSZuLa5KT+1maxGYOaIPho4vG
 dNBpNJeeA/sJ7H2A7c1DoRPHF+gM5LddPjzVChlaMP5wkTOt2+Se1aJ1V20uYxnXbNhKuIFL2
 HcAAWyVzOmA+ii5PdZ1eX9Tg2jFEv+NRRNlaBiu20OxDx4xu1PWz1SLTqC3qaXz75a2Lfjw2l
 h8eOTPs4Vpiu+85XyFKPi8OtIYbnkSJOqPJyM6Ibb/y3LTMNoUg4KdrRjM0sPsFKaOgbeWr+E
 OUmand4CU8FmDtOTikeTSJb5idk05n6fU5xagJ66FbZhxQ2Vz0beCOkSBU0mgcTCOWF8rK7P3
 4IWLAn8NgtGPNhW2n7PSmclJ1ENuA/xK48pJqQDH4JjSHSTQS7xaAVkx/AztxXb7jkqqC0Izr
 R6clDap946I8PU792VwkMBRkjA7GT9ZZhSdfxelS+2NhGb6zMIi+x/Zoej2jDWUANuqa/PSPx
 z4qgtXC/ukg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

On Mon, 11 Feb 2019 15:04:25 +0000, Mark Brown <broonie@kernel.org> wrote:

> On Sun, Feb 10, 2019 at 04:45:19PM +0100, Peter Seiderer wrote:
> 
> > @@ -972,6 +972,8 @@ static int aic32x4_component_probe(struct snd_soc_component *component)
> >  		gpio_set_value(aic32x4->rstn_gpio, 1);
> >  	}
> >  
> > +	mdelay(1);
> > +  
> 
> Perhaps only do this if we toggled the GPIO?  If the device wasn't in
> reset then there's no need to wait.

You are absolutely right with this, will re-spin the patch with
the suggested change, thanks for review...

Regards,
Peter
