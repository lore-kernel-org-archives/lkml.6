Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE1DC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5834820652
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LhPX/Ak2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5834820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbeH2QMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:12:32 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44442 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbeH2QMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:12:31 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7TC9UO8066461;
        Wed, 29 Aug 2018 12:15:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=1gmm7XDTtUp4mnPAv5nrBYSzAN8ZqS2l/kp6fMjZ7ao=;
 b=LhPX/Ak2GKyNSf1xQUBcD4cVCh/EQLyJQmsUmrs/CgYqxo8iazRM4GeqKNV62T/mbeYU
 CxwqHOPArduksNky0XyTXfzz6zhuTrumXqJRV5DQpxXE5BFuCZSwppLtKE3HmrNuLvOu
 U0k8/9wOj2GN8695vIyN1iggO3ZRraJxnPtRdvbNaL9Ry/f0GHV3uJQzNJiimBVNZ+FS
 k+x6cJ58ko25sl3+ZpHhkUy7X/+GJv/7AOsjnS3HhyIwpi0cLUk9hoLSL2ySg4nLv+zN
 +X6vMeGZUdFiu35LdCIKlnZv/CKeyzuNeNVSxnb2a3MiKP5myFLu11YHESLPQYIWwQMC 9Q== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2m2xhtsdtv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Aug 2018 12:15:38 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7TCFcAJ007341
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Aug 2018 12:15:38 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7TCFbOu004889;
        Wed, 29 Aug 2018 12:15:37 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Aug 2018 05:15:36 -0700
Date:   Wed, 29 Aug 2018 15:15:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        Horia Geanta <horia.geanta@nxp.com>,
        Madalin-cristian Bucur <madalin.bucur@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [PATCH net-next v2 0/2] dpaa2-eth: Move DPAA2 Ethernet driver
Message-ID: <20180829121527.w3jflnbp3by7yp36@mwanda>
References: <20180829094240.27242-1-ruxandra.radulescu@nxp.com>
 <20180829110739.3xzbdtelwjlhun2v@mwanda>
 <AM3PR04MB338A141EDC007FF47B510C094090@AM3PR04MB338.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM3PR04MB338A141EDC007FF47B510C094090@AM3PR04MB338.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8999 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=780
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808290132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 12:06:44PM +0000, Ioana Ciocoi Radulescu wrote:
> > 
> > There are a few static checker warnings for the driver but only the
> > first one looks like a possibly real bug.
> 
> Thanks for the report, what tool did you use to get these warnings?
> 

These are Smatch warnings, but you need to build the cross function DB
to see the warnings.

regards,
dan carpenter

