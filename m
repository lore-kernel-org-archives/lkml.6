Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863F2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526A420C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ld7kaj+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbfB0Nz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 08:55:57 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:57346 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730114AbfB0Nz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 08:55:57 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1RDmt8A087166;
        Wed, 27 Feb 2019 13:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=bYlnsFPrzl6ALLJxgnTt/afgguviQLErYwFKSlCOrU4=;
 b=Ld7kaj+WA36KoRqXMxWu0wnUVMtb+aBkDJFPImL2p9eay3vxzXaDypEPpOEDWjRNwVyZ
 2iEoI2n7alp5VnFPJX7+jUx1tOusK7pJhKWMvnszeP3MDAkDOFmpuGHHHxS77SF0SzZh
 eHTMIB1Qw3aQBTOtj9/PmST/S2gxCLj15+yjomrbQ9MUQQjAP5nfBvOpHY3+XyZRq8Cu
 MaPcOg748bJ5iZ1bTw0/HQVlExstSEZ5ikuhOzDq46WuDYSn6Tlbj3FGjoGOVMNZVQEc
 CZet8JqEqgpYp2klqdUFW12J6PYu7MDHuSiNm/TeSXo9HWOjMbdUUrWJOvjF/TxWNWSQ 9A== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2qtxtrtuww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Feb 2019 13:55:39 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1RDtXR4027229
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Feb 2019 13:55:33 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1RDtVMT017131;
        Wed, 27 Feb 2019 13:55:31 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Feb 2019 05:55:31 -0800
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
        Bart Van Assche <bart.vanassche@wdc.com>,
        Stanislav Nijnikov <stanislav.nijnikov@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>,
        Ohad Sharabi <ohad.sharabi@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Kyuho Choi <kyuho.choi@sk.com>,
        Martin Petersen <martin.petersen@oracle.com>
Subject: Re: [PATCH v6 0/2] Clean up UFSHC driver
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <dac49928-1346-21dc-f0dd-4773272f78cd@free.fr>
Date:   Wed, 27 Feb 2019 08:55:27 -0500
In-Reply-To: <dac49928-1346-21dc-f0dd-4773272f78cd@free.fr> (Marc Gonzalez's
        message of "Wed, 27 Feb 2019 11:39:43 +0100")
Message-ID: <yq17edlbak0.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9179 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=512 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902270093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Marc,

> This mini-series removes the "disable-VCCQ-power-rail-for-some-Flash-chips"
> quirk, and cleans up after the dust settles.

Applied to 5.1/scsi-queue. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
