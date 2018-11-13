Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB37CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 01:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E69722507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 01:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E69722507
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbeKMLCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 06:02:44 -0500
Received: from smtprelay0073.hostedemail.com ([216.40.44.73]:35040 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726111AbeKMLCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 06:02:44 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 5F2D21E2523;
        Tue, 13 Nov 2018 01:07:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rail73_202aeddeeff11
X-Filterd-Recvd-Size: 1766
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Tue, 13 Nov 2018 01:07:00 +0000 (UTC)
Message-ID: <2ac68de6b842751f771c43e0a4d8777475ace323.camel@perches.com>
Subject: Re: [PATCH v2] staging: vc04_services: bcm2835-audio: Fixed
 warnings, checks
From:   Joe Perches <joe@perches.com>
To:     Arnold Chand <arnold.chand@gmail.com>,
        "eric@anholt.net" <eric@anholt.net>
Cc:     "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Mon, 12 Nov 2018 17:06:59 -0800
In-Reply-To: <46bb5564b6bd6cad78c01b4d8026c7c72a870b15.camel@gmail.com>
References: <46bb5564b6bd6cad78c01b4d8026c7c72a870b15.camel@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-12 at 19:45 -0500, Arnold Chand wrote:
> Corrected warnings and checks provided by scripts/checkpatch.pl which
> includes: alignment of parenthesis, lines over 80 characters and mutex
> definition without comment.
[]
> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
[]
> @@ -162,7 +163,8 @@ static int snd_bcm2835_spdif_default_put(struct snd_kcontrol *kcontrol,
>  	mutex_lock(&chip->audio_mutex);
>  
>  	for (i = 0; i < 4; i++)
> -		val |= (unsigned int)ucontrol->value.iec958.status[i] << (i * 8);
> +		val |= (unsigned int)ucontrol->value.iec958.status[i] <<
> +		       (i * 8);

Perhaps this should be

	val = get_unaligned_be32(ucontrol->value.iec958.status);


