Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67A7C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 10:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DFF620848
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 10:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XZXAs3bc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DFF620848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbeJZSlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 14:41:40 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42840 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeJZSlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 14:41:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9Q9wtAK098725;
        Fri, 26 Oct 2018 10:04:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Wsj5/8QDwK08mozjt7PQ/9KjsstK8akmd5TCS7h+aFQ=;
 b=XZXAs3bcNVRaVKlM4+s7Mg7qu9V3uSfWSNFRy0Dszt052MCKEEDl9IKRyILEd90X3xPA
 ohqnsRdU7idiP7g2g/nZhu3vm5GCJNZINjWAuiRzInXTWe432OtjjaMIUI0ev6lk9RwL
 xHEi8liyMGjs/z/s/xdKlUKzM7tfRa/ZNV2tE4Q8fXq7wxHZ1kyeuhc8jsIlQ+VHaamW
 91O7oQOfXEplhnT8EqEhfuJ+Py1ieEra4XmpWkJ1z4l6QKmYDaNmroKcnX6nM2NsX440
 w50VSXTVYK4u1m3hSX9AKi6xHQYK48omfVrfpGlMt59Wrz8hlefWITiFNIsQUWTg7HnO BQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2n7vaqecrm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Oct 2018 10:04:39 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9QA4Xkn008096
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Oct 2018 10:04:33 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9QA4W8A006695;
        Fri, 26 Oct 2018 10:04:32 GMT
Received: from mwanda (/129.205.6.86)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 26 Oct 2018 03:04:31 -0700
Date:   Fri, 26 Oct 2018 13:04:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        Victor Colombo <victorcolombo@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH 5/6] staging:iio:ad2s90: Add IIO_CHAN_INFO_SCALE to
 channel spec and read_raw
Message-ID: <20181026100422.lvz2avowd6ddix54@mwanda>
References: <20181026004512.31012-1-matheus.bernardino@usp.br>
 <20181026004512.31012-6-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181026004512.31012-6-matheus.bernardino@usp.br>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9057 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=569
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810260089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 09:45:11PM -0300, Matheus Tavares wrote:
> From: Victor Colombo <victorcolombo@gmail.com>
> 
> This patch adds the IIO_CHAN_INFO_SCALE mask to ad2s90_chan and
> implements the relative read behavior at ad2s90_read_raw.
> 
> Signed-off-by: Victor Colombo <victorcolombo@gmail.com>
> ---

You should be adding your S-o-B here as well because the patch is
passing through your hands.

regards,
dan carpenter

