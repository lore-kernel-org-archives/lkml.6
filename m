Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68413C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E4E217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="04kC3EaQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfBZOou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 09:44:50 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:53548 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfBZOot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 09:44:49 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1QEYQ60136144;
        Tue, 26 Feb 2019 14:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=FvqUS6HLcwbvGiWMYvMUjculPVb3zQRPYyerqmWMhBU=;
 b=04kC3EaQt2SnxjzBnrzcjHqIHgE3JzIvW9VFackxtKqLMFzVNhY7LPOJltg6I3Ci/yjk
 WuvVCVSYm697Dct7WN3/ZtDLGOG7AotYb4UifYHOvXvr0Qzzm4yKB8ZMUbBE8Y/+heK3
 OSlJyLD+S6NvpFrvjtmkI9ZkyXPqc7hznnTdYJVIJvlgl1C0MZbspdyWQU4MAVWWW4uX
 /edF2WRC5sfwVlghGzsDwL08pRTPUcln1aXnvVpzItTJUnSArpgLEgSrlrrVqwnlLsd/
 HTIl7g0Zsa9/R4w+iL8mi4BScKcBOxjnb6CETSaSCRQK5FHZfKkbayVmnPQ1aS0k1Ft3 Cg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2qtxtrmvpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Feb 2019 14:44:31 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1QEiUeV011074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Feb 2019 14:44:30 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1QEiQI3010451;
        Tue, 26 Feb 2019 14:44:27 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Feb 2019 06:44:26 -0800
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     SCSI <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Stanislav Nijnikov <stanislav.nijnikov@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>,
        Ohad Sharabi <ohad.sharabi@wdc.com>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Yaniv Gardi <ygardi@codeaurora.org>,
        Gilad Broner <gbroner@codeaurora.org>,
        Raviv Shvili <rshvili@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>, Kyuho Choi <kyuho.choi@sk.com>,
        Martin Petersen <martin.petersen@oracle.com>
Subject: Re: [PATCH v5 1/2] scsi: ufs: Do not disable vccq in UFSHC driver
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <494cd639-89a7-8868-b63a-ea7cdcba9777@free.fr>
        <be3ef9bf-438b-4e8a-62c4-f75458e8ecc0@free.fr>
Date:   Tue, 26 Feb 2019 09:44:21 -0500
In-Reply-To: <be3ef9bf-438b-4e8a-62c4-f75458e8ecc0@free.fr> (Marc Gonzalez's
        message of "Mon, 11 Feb 2019 14:32:15 +0100")
Message-ID: <yq1ftsad2yi.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9178 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=662 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902260107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marc,

> Commit 60f0187031c0 ("disable vccq if it's not needed by UFS device")
> introduced a small power optimization as a driver quirk: ignore the
> vccq load specified in the UFSHC DT node when said host controller
> is connected to specific Flash chips (Samsung and Hynix currently).

[...]

> Revert the original patch, and clean up loose ends in the next patch.

This commit isn't a revert. Why not?

-- 
Martin K. Petersen	Oracle Linux Engineering
