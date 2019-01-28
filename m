Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3314BC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F302921917
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BFuvZ8YD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfA1MzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 07:55:22 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:33800 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbfA1MzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 07:55:22 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0SCSYxo026326;
        Mon, 28 Jan 2019 12:54:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=ty+oDqCF72Ap8JwvZRllH7Lg7RZJslz8F/8pyO958aU=;
 b=BFuvZ8YD3NGfXoSw1YzJwi7TCjDxCP067fqOulXvovAVfM5TTskWlfU/YSI2OK6mBVvB
 zWzw/aq2mwPpQolkOUQ6ybvDm+Pm22dpxTFLZyT5MTmSn82wbdnmKbhjNb9c+wiSj9w7
 5xb1IADw7B2FiSlBRAec5LeeOnz8zKyxxaR3n6vx6WWizZDbjw9yMMq3DS47k+AurpDb
 yDH5qPgOsqjXwcQsJr3jzBKnmfxePdn4bfjfqcOJS099oX0ZYKb4NKDuW2/kUKmQds0P
 mHIhIe1uc5uB+UD8fWJeR9/Wx3zMUFt5zGKM7p1BCtajmy1r6Wlh5pe1hDZhpiNSL5Oe 5A== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2q8d2dx3b9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jan 2019 12:54:46 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0SCsebZ028645
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jan 2019 12:54:40 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0SCsdRP023335;
        Mon, 28 Jan 2019 12:54:39 GMT
Received: from kadam (/197.157.34.178)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Jan 2019 04:54:39 -0800
Date:   Mon, 28 Jan 2019 15:54:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Renato Lui Geh <renatogeh@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        giuliano.belinassi@usp.br, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH v2 2/2] staging: iio: ad7780: moving ad7780 out of staging
Message-ID: <20190128125426.GG1795@kadam>
References: <20190127203344.ofryhhrae2wjn6j2@renatolg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190127203344.ofryhhrae2wjn6j2@renatolg>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9149 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=608
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901280100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27, 2019 at 06:33:52PM -0200, Renato Lui Geh wrote:
> +	st->reg = devm_regulator_get(&spi->dev, "avdd");
> +	if (IS_ERR(st->reg))
> +		return PTR_ERR(st->reg);
> +
> +	ret = regulator_enable(st->reg);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to enable specified AVdd supply\n");
> +		goto error_disable_reg;
> +	}

We don't need to disable the regulator if enabling it failed (probably,
I haven't looked at the code).


> +
> +	ret = ad_sd_setup_buffer_and_trigger(indio_dev);
> +	if (ret)
> +		goto error_disable_reg;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret)
> +		goto error_cleanup_buffer_and_trigger;
> +
> +	return 0;
> +
> +error_cleanup_buffer_and_trigger:
> +	ad_sd_cleanup_buffer_and_trigger(indio_dev);
> +error_disable_reg:
> +	regulator_disable(st->reg);
> +

Well chosen label names, btw.  Very easy to review.

> +	return ret;
> +}
> +

regards,
dan carpenter
