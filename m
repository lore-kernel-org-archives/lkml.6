Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617E4C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1029220811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Oui2p1UQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1029220811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbeLKJgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:36:39 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46950 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeLKJgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:36:39 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBB9YDNT155691;
        Tue, 11 Dec 2018 09:36:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=oFgLjnybA59cO3bfRRcMLyFW8K3ZDze3zGo3aUVlfIY=;
 b=Oui2p1UQWXSX/F34DNyS4mh4FWVeqFXvZd6S0G528/GMxHsiN3jq6pe0SmPzXTGO4a2g
 DTk4pU0qXsE/BOuulDNUlUiIxvpBCUGl+X/wcTqs1FDQfOnAalDRK/4Lg9PKVmVwC2JA
 crjKwZ7fQu57LMZZKQkgAjrq6RCmuCiuvR+PXaf6LqZp0nxeYoFSF15ZaiiBYNfeFaGP
 WpTQP/Vt4VjvW444r3BqytccxfPca0jEew1xJzdsXpSCz11NfnUl5ukG6oRnqJtorTBf
 mAESttXezKiMHE5HkoUsMQGDIw37SCp13eeS/nLhllmdAyDH6caEeY0taPZMzb+moyoq og== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2p86kqtnes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Dec 2018 09:36:07 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBB9a2BC030882
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Dec 2018 09:36:02 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBB9a0Ho032320;
        Tue, 11 Dec 2018 09:36:00 GMT
Received: from kadam (/10.175.35.120)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Dec 2018 01:35:59 -0800
Date:   Tue, 11 Dec 2018 12:35:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Shreeya Patel <shreeya.patel23498@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] Staging: iio: adt7316: Move interrupt related code
Message-ID: <20181211093548.GA3116@kadam>
References: <20181208151638.8759-1-shreeya.patel23498@gmail.com>
 <20181208151638.8759-3-shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181208151638.8759-3-shreeya.patel23498@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9103 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=828
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812110091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08, 2018 at 08:46:37PM +0530, Shreeya Patel wrote:
> -	return irq_type;
> +	ret = devm_request_threaded_irq(&indio_dev->dev, chip->bus.irq,
> +					NULL, adt7316_event_handler,
> +					irq_type | IRQF_ONESHOT,
> +					indio_dev->name, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	if (irq_type & IRQF_TRIGGER_HIGH)
> +		chip->config1 |= ADT7316_INT_POLARITY;
> +
> +	return ret;

return 0; here.

>  }
>  
>  /*

regards,
dan carpenter
