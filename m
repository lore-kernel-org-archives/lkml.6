Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0BCC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 07:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 136B22083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 07:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="duy3Xu9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 136B22083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbeJANpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 09:45:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49262 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeJANpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 09:45:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9174HpO014893;
        Mon, 1 Oct 2018 07:09:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=tO0fLZJDQ/jd5/axorzx2DGl3YzgVPpgsySpENbomq8=;
 b=duy3Xu9+JVTjrp37g4hhocmBhOfYq9rZxqszn9pl8hIi0fmz19hUMsg/9vfTv5BpKvOT
 CapZvc27YsfU1FOxRpkpdgZ0FpwZV68lUfJ07fSXQb546JP36/cWqs+aYJdoZPvut8ZU
 s//n0ssQ7QyTKbTr6Gh5VcIqRDmO309eaN4CXdfCB+ULTmmPrwpF4uPg4/WoxlZqNC65
 9eV48QPmnS9BdJKfHss5NqlxdXkJA5gxDMp+/AKzAehUDEWKH0gVft9Nm4OxResoxH8c
 RXedXMvp9tjR1qNJscHfuD9TKiJivEbaPNPXqQuEkEzUQr1vIYIftZlvYMR2cRX8cYoP mA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2mt0ttd4uw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Oct 2018 07:09:16 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9179Ei5016407
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Oct 2018 07:09:15 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9179Ew5002895;
        Mon, 1 Oct 2018 07:09:14 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Oct 2018 00:09:13 -0700
Date:   Mon, 1 Oct 2018 10:09:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Maxime Desroches <desroches.maxime@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Staging: rts5208: rtsx_chip: Fixed multiple coding
 style issues
Message-ID: <20181001070907.n3cn7nkcbmftnm7q@mwanda>
References: <20180929044354.24484-1-desroches.maxime@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180929044354.24484-1-desroches.maxime@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9032 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=683
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810010074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You can't have two patches with the same subject.

On Sat, Sep 29, 2018 at 12:43:54AM -0400, Maxime Desroches wrote:
> Fixed multiple braces issues
> Signed-off-by: Maxime Desroches <desroches.maxime@gmail.com>

Put a blank line between the patch description and the Signed-off-by

regards,
dan careptner

