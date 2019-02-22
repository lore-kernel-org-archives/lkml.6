Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8A4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A61920823
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3eKh3rUG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfBVH3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 02:29:34 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44064 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbfBVH3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 02:29:34 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1M7THcx004544;
        Fri, 22 Feb 2019 07:29:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=jxHOFSxlMUw8/9hqYpmDGNjJ8Oz9YkBeNzi7Cbx/9WQ=;
 b=3eKh3rUGSS8ofkx7U9uG0rDajsR1iGypJc1f+QHwOIKvKhc00257ct/EU0PVbAn1RWZ0
 GTdde2tj0rSmilvTclzT5NiiT9L+WHIfshLbhGgoHZ1EhS8gJNHwHSBAkox2T+DzIkep
 6tEuDZrS1Pnrr9GEKC929HW1oTRToxXs3U7dmtMHBsbNJE2hK04QzgQ/kO04+r12Hxpo
 TY5Qmv6lWqVWR2eFMbjB6MoiOQF4vQ9YM1V3NlgrjHC9Qopa6eRfcJDqkCqejqjeClot
 nOEhpFBF9OIbMeuQJgFBLjRpAPJLbc3qp8ruwEPOBG86MZA4w7Gkwcvbo7qCs/22MpFZ mw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2qp9xucp27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Feb 2019 07:29:23 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1M7TNpB031535
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Feb 2019 07:29:23 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1M7TMdE031358;
        Fri, 22 Feb 2019 07:29:22 GMT
Received: from kadam (/197.157.0.19)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Feb 2019 23:29:21 -0800
Date:   Fri, 22 Feb 2019 10:29:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] test_firmware: silence underflow warning in
 test_dev_config_update_u8()
Message-ID: <20190222072913.GH1711@kadam>
References: <20190221183700.GA1737@kadam>
 <20190221183826.GA30993@kadam>
 <20190221105458.409d1968961962079c54b815@linux-foundation.org>
 <20190221191855.GB1737@kadam>
 <20190221115426.f616100906d989eda93d66dc@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221115426.f616100906d989eda93d66dc@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9174 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=685 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902220052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've looked at this some more and I don't think it's a good idea to
change the type of U8_MAX.  Right now INT_MAX is int and USHRT_MAX is
unsigned short etc.  That's the only intuitive thing for them to be.

regards,
dan carpenter
