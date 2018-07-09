Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F4EC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2F3208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nCsE4kZ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2F3208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754574AbeGIT2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 15:28:24 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54998 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754475AbeGIT2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 15:28:23 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w69JNwAQ173539;
        Mon, 9 Jul 2018 19:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=epZgxKcg1ldwIJxVQOgtuOmT0In19i/OopvyYoShPPI=;
 b=nCsE4kZ4aAYs2mW3Zz4YyeEab437Sg90xdSgc2kmetmcrpVW2EYTHjShZn6oqtyo5zbQ
 QQY08fv0pGuS2WOwZNJUSOJDtmCZ2U8AK/CZZz1ek9yAc+ax5YAyEIU2oLY+9PxZwY37
 zUlK3pkyKjt2Amiaa7RKUqWXRIaSLiA4/fRisDlV5MX+iZvKuWt9Ij/XjUVIOQCrl7f9
 A3ThcGJKHzMaNuxVhxImUVwbIdVlEoaAr875Poeyg1Hbugkd0IW/hBHPG9SnIq8vnar6
 Yb0jlApYFzvL05HDJNpMC0qtrVqCYGSlsrhhdLmQmlZvGsv/QlQ79nOe29Z2vv0PMGGa aw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2k2p7dnmbm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jul 2018 19:28:18 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w69JSIs9018624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Jul 2018 19:28:18 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w69JSHcL028770;
        Mon, 9 Jul 2018 19:28:17 GMT
Received: from mwanda (/197.157.34.168)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Jul 2018 12:28:17 -0700
Date:   Mon, 9 Jul 2018 22:28:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ioana Radulescu <ruxandra.radulescu@nxp.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, ioana.ciornei@nxp.com
Subject: Re: [PATCH 5/5] staging: fsl-dpaa2/eth: Remove Rx frame size check
Message-ID: <20180709192809.msmwmtmgj4yxrhme@mwanda>
References: <20180709150111.8875-1-ruxandra.radulescu@nxp.com>
 <20180709150111.8875-6-ruxandra.radulescu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709150111.8875-6-ruxandra.radulescu@nxp.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8949 signatures=668705
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=919
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807090219
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 10:01:11AM -0500, Ioana Radulescu wrote:
> @@ -2385,6 +2365,12 @@ static int netdev_init(struct net_device *net_dev)
>  
>  	/* Set MTU upper limit; lower limit is 68B (default value) */
>  	net_dev->max_mtu = DPAA2_ETH_MAX_MTU;
> +	err = dpni_set_max_frame_length(priv->mc_io, 0, priv->mc_token,
> +					(u16)DPAA2_ETH_MFL);

The cast was there in the original code so this is not a comment on this
particular patch (which seems fine) but there is no need to cast.

Generally it's best to avoid unnecessary casts.  As a human reader, I
find the cast confusing.  It indicates that DPAA2_ETH_MFL somehow
requires special handling.  Perhaps it's negative or we are trying to
truncate away the high bits.  But neither of those things really make
sense.

From a static analysis perspective if DPAA2_ETH_MFL doesn't fit nicely
then we would want to generate a warning.  But the cast explicitly
disables the check.

regards,
dan carpenter


