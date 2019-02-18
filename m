Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43423C00319
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126DE2176F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbfBRVB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 16:01:28 -0500
Received: from smtprelay0022.hostedemail.com ([216.40.44.22]:43696 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729486AbfBRVB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 16:01:27 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id EB3DF837F24C;
        Mon, 18 Feb 2019 21:01:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: comb75_6396683d9720e
X-Filterd-Recvd-Size: 1640
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Mon, 18 Feb 2019 21:01:24 +0000 (UTC)
Message-ID: <d5d88a5acc984554240047944cb3071371025085.camel@perches.com>
Subject: Re: [PATCH 5/5] iio:potentiostat:lmp91000: add '\n' on dev_err
From:   Joe Perches <joe@perches.com>
To:     Lucas Oshiro <lucasseikioshiro@gmail.com>, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com,
        Anderson Reis <andersonreisrosa@gmail.com>
Date:   Mon, 18 Feb 2019 13:01:23 -0800
In-Reply-To: <20190218172236.7781-6-lucasseikioshiro@gmail.com>
References: <20190218172236.7781-1-lucasseikioshiro@gmail.com>
         <20190218172236.7781-6-lucasseikioshiro@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-02-18 at 14:22 -0300, Lucas Oshiro wrote:
> Add missing '\n' at the end of dev_err message on line 215.
[]
> diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
[]
> @@ -212,7 +212,7 @@ static int lmp91000_read_config(struct lmp91000_data *data)
>  	ret = of_property_read_u32(np, "ti,tia-gain-ohm", &val);
>  	if (ret) {
>  		if (!of_property_read_bool(np, "ti,external-tia-resistor")) {
> -			dev_err(dev, "no ti,tia-gain-ohm defined");
> +			dev_err(dev, "no ti,tia-gain-ohm defined\n");

Perhaps a copy/paste error as the test is for
external-tia-resistor and not tia-gain-ohm


