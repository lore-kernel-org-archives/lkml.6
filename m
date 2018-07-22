Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36C1C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 08:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53EF720874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 08:29:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53EF720874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbeGVJZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 05:25:05 -0400
Received: from smtprelay0080.hostedemail.com ([216.40.44.80]:43863 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727837AbeGVJZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 05:25:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id E891A100E86C0;
        Sun, 22 Jul 2018 08:29:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: ray10_15c48b1055637
X-Filterd-Recvd-Size: 1689
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Sun, 22 Jul 2018 08:29:09 +0000 (UTC)
Message-ID: <726de8d70365597715ed62c0d99bf2a7adaa3362.camel@perches.com>
Subject: Re: [PATCH 02/11] touchscreen: ad7877: Use octal permissions
From:   Joe Perches <joe@perches.com>
To:     dev-harsh1998 <harshitjain6751@gmail.com>, trivial@kernel.org
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Simon Budig <simon.budig@kernelconcepts.de>,
        Andi Shyti <andi@etezian.org>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 22 Jul 2018 01:29:07 -0700
In-Reply-To: <20180721191029.25658-1-harshitjain6751@gmail.com>
References: <20180721191029.25658-1-harshitjain6751@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-07-22 at 00:39 +0530, dev-harsh1998 wrote:
> WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
> +static DEVICE_ATTR(name, S_IRUGO, name ## _show, NULL);
[]
> diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchscreen/ad7877.c
[]
> @@ -461,7 +461,7 @@ name ## _show(struct device *dev, struct device_attribute *attr, char *buf) \
>  		return v; \
>  	return sprintf(buf, "%u\n", (unsigned) v); \
>  } \
> -static DEVICE_ATTR(name, S_IRUGO, name ## _show, NULL);
> +static DEVICE_ATTR(name, 0444, name ## _show, NULL);

I believe this could be

static DEVICE_ATTR_RO(name)

