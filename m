Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27043C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E007621476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EAenmawy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E007621476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeJRU4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 16:56:38 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53842 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbeJRU4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 16:56:38 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9ICrs9q020945;
        Thu, 18 Oct 2018 12:55:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=mpTSJSTZy2SgXDLU7XtscBMs1joiE6esQLCrfW63jfo=;
 b=EAenmawyMMsxii0gqtwFJf9xGs6rQ/ySXrgjcKtNo4zIAtUqH1HNG0zFOPHyQ/z6e/0n
 FZyCvAPMpHUw8q1bITOrTcbAdHLauHeA9K+zOUD53QRA9AsL7871autPT8toHBcCKDAh
 RpSQYMSNfz8ObvGbg3fvuNn7xHhFAE5ldxeVI3NgyhNCktpRGlw6FOZ0ZRxfgDP4lH+G
 ZmW1f2LkMuePR1ZCCWWbYqFQcvkohm8cDlErVbuyu6h0m12MMupuIM/Nw/YPGFxpau+v
 58mPjObtAuVcJK4cste90Ga864rxqL9ztOja0IpB+eWzx6S0yYtgLfW7iETLLLfxIFZL IA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2n384uefmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Oct 2018 12:55:16 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9ICtBsG026915
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Oct 2018 12:55:11 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9ICtAHt019565;
        Thu, 18 Oct 2018 12:55:10 GMT
Received: from mwanda (/129.205.6.86)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Oct 2018 05:55:09 -0700
Date:   Thu, 18 Oct 2018 15:55:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     jic23@kernel.org, devel@driverdev.osuosl.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        pmeerw@pmeerw.net, knaack.h@gmx.de
Subject: Re: [PATCH 1/2] staging: iio: ad7606: Move out of staging
Message-ID: <20181018125502.2hnp3s45lk6dggqt@mwanda>
References: <1539853832-26534-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539853832-26534-1-git-send-email-stefan.popa@analog.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9049 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=821
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810180116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 12:10:32PM +0300, Stefan Popa wrote:
> +static int ad7606_read_samples(struct ad7606_state *st)
> +{
> +	unsigned int num = st->chip_info->num_channels;
> +	u16 *data = st->data;
> +	int ret;
> +
> +	/*
> +	 * The frstdata signal is set to high while and after reading the sample
> +	 * of the first channel and low for all other channels. This can be used
> +	 * to check that the incoming data is correctly aligned. During normal
> +	 * operation the data should never become unaligned, but some glitch or
> +	 * electrostatic discharge might cause an extra read or clock cycle.
> +	 * Monitoring the frstdata signal allows to recover from such failure
> +	 * situations.
> +	 */
> +
> +	if (st->gpio_frstdata) {
> +		ret = st->bops->read_block(st->dev, 1, data);
> +		if (ret)
> +			return ret;
> +
> +		if (!gpiod_get_value(st->gpio_frstdata)) {

This check should maybe be:

		if (gpiod_get_value(st->gpio_frstdata) <= 0) {

(Or possibly not, I don't know the code very well).

> +			ad7606_reset(st);
> +			return -EIO;
> +		}
> +
> +		data++;
> +		num--;
> +	}
> +
> +	return st->bops->read_block(st->dev, num, data);
> +}

regards,
dan carpenter
