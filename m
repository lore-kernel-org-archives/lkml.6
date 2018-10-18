Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9ADC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109BE2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AblWrAyZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 109BE2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbeJSCki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:40:38 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57076 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbeJSCki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:40:38 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9IIY0P2131467;
        Thu, 18 Oct 2018 18:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=dMFYcrPknZl7Hb7oMAUTjjn6CFGzS0vowUu0C66qDyk=;
 b=AblWrAyZi2CU7RkPB85hP/RcmI602a+EN4IEfFrUrsyCumNqr6Zg7btZnHcL1kNP7nC0
 qVrBGul34X3Q0jBlc6pKYVP8Y+5ykQEjt3Su+30niuO/i36ghJfV7RTomZUqwlwtkjVs
 wAAiFFptRlhyZcY97I7PtE8H+kbe3ZiwYMIDkNCZ8aazZryOJng/cYwCDCjDgL0ls5uK
 ebKzgzgPT5DHlEHCuEjye989Thz4vh8WNwGVWzhHi/PMunStUm4fJv2NmaLvctgXCZks
 HiOu1rCZdBetCIC3EhaHb5KBnskpBhnRpW1nwa3MCocLIuBTiz8wnJlyE5mnlpsFeZej Wg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2n384ugfy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Oct 2018 18:37:51 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9IIbobl032234
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Oct 2018 18:37:50 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9IIbnbe015941;
        Thu, 18 Oct 2018 18:37:49 GMT
Received: from mwanda (/129.205.6.86)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Oct 2018 11:37:48 -0700
Date:   Thu, 18 Oct 2018 21:37:40 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Stefan Popa <stefan.popa@analog.com>, jic23@kernel.org,
        devel@driverdev.osuosl.org, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de
Subject: Re: [PATCH 1/2] staging: iio: ad7606: Move out of staging
Message-ID: <20181018183740.ynxnplac6ca4wxf7@mwanda>
References: <1539853832-26534-1-git-send-email-stefan.popa@analog.com>
 <20181018125502.2hnp3s45lk6dggqt@mwanda>
 <2199f866-4c23-5424-3459-b966514414ce@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2199f866-4c23-5424-3459-b966514414ce@metafoo.de>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9050 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=778
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810180155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 07:19:36PM +0200, Lars-Peter Clausen wrote:
> On 10/18/2018 02:55 PM, Dan Carpenter wrote:
> > On Thu, Oct 18, 2018 at 12:10:32PM +0300, Stefan Popa wrote:
> >> +static int ad7606_read_samples(struct ad7606_state *st)
> >> +{
> >> +	unsigned int num = st->chip_info->num_channels;
> >> +	u16 *data = st->data;
> >> +	int ret;
> >> +
> >> +	/*
> >> +	 * The frstdata signal is set to high while and after reading the sample
> >> +	 * of the first channel and low for all other channels. This can be used
> >> +	 * to check that the incoming data is correctly aligned. During normal
> >> +	 * operation the data should never become unaligned, but some glitch or
> >> +	 * electrostatic discharge might cause an extra read or clock cycle.
> >> +	 * Monitoring the frstdata signal allows to recover from such failure
> >> +	 * situations.
> >> +	 */
> >> +
> >> +	if (st->gpio_frstdata) {
> >> +		ret = st->bops->read_block(st->dev, 1, data);
> >> +		if (ret)
> >> +			return ret;
> >> +
> >> +		if (!gpiod_get_value(st->gpio_frstdata)) {
> > 
> > This check should maybe be:
> > 
> > 		if (gpiod_get_value(st->gpio_frstdata) <= 0) {
> > 
> > (Or possibly not, I don't know the code very well).
> 
> gpiod_get_value() is only allowed to return either 0 or 1.

It looks like it can return negative error codes as well.

regards,
dan carpenter
