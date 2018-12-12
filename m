Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFC8C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4919420849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="db/t3fwe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4919420849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbeLLIUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 03:20:30 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:57764 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeLLIUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 03:20:30 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBC8Iiss028445;
        Wed, 12 Dec 2018 08:20:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=pVDYWPUm65mF3QytVhHn7Mx78umiZ+uIF6ELc6pKKQU=;
 b=db/t3fwel3nHlBECaBYbDQt6aGdCr2r2LMR272K3Gazuz1afsIDPS3hrSDM5V76ADSLh
 DGLcQQ10dCqIhwsZeJjV7eWvdXRIQipzeEgeAo4IUV13w4sEHfGLcvjR7xAUosQm5aTU
 lmm9wfARyzQI0UHTw09zrpDYiEomU8b+HAJW6sTfu9znbgWBij/Jz4FfPcIB1IPWQHth
 7FquvdrALAFxu8fe8Ab9I7P5iO51VKV12frs6NNdaHVjtkLK9hrnCiFhdDOE4xgLGOY1
 ihgpBj6sX9mg+4u0rtvHW/goCfiGkmvKbAPmb0gK/47vwtt/666mpJLuIKsMUAqhwReD iw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2p86kr0acm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Dec 2018 08:20:01 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBC8Jx7J025727
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Dec 2018 08:20:00 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBC8JwQV007858;
        Wed, 12 Dec 2018 08:19:58 GMT
Received: from kadam (/197.157.0.38)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Dec 2018 00:19:58 -0800
Date:   Wed, 12 Dec 2018 11:19:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jeremy Fertic <jeremyfertic@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, devel@driverdev.osuosl.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCH 02/11] staging: iio: adt7316: invert the logic of the
 check for an ldac pin
Message-ID: <20181212081949.GH3116@kadam>
References: <20181212005503.28054-1-jeremyfertic@gmail.com>
 <20181212005503.28054-3-jeremyfertic@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212005503.28054-3-jeremyfertic@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9104 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=651
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812120074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 05:54:54PM -0700, Jeremy Fertic wrote:
> ADT7316_DA_EN_VIA_DAC_LDCA is set when the dac and ldac registers are being
> used to update the dacs instead of the ldac pin. ADT7516_SEL_AIN3 is an adc
> input that shares the ldac pin. Only set these bits if an ldac pin is not
> being used.
> 
> Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>

Huh...  This bug has always been there...

Fixes: 35f6b6b86ede ("staging: iio: new ADT7316/7/8 and ADT7516/7/9 driver")

regards,
dan carpenter


