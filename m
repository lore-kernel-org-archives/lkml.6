Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06873C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C018520827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ojeSEj3R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C018520827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389290AbeKGLOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 06:14:12 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:47062 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388314AbeKGLOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 06:14:12 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA71iC5Y103276;
        Wed, 7 Nov 2018 01:46:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=+K+nv7hXs+s3rlBK1dnhipZ3Frde6uhYyen66UYNk2o=;
 b=ojeSEj3RvdqAdp/dFKybKhTl9goqpcFkaNtWlBBt4dq4jqGAiFnAy7g4uIHFanwKUNhG
 aj+sLvHYpLHrhrTwbjDtAumWk0xKA93H12jCrWyLrA8LJ6hIHG6QbzB+DZfHb1f9N0pj
 A59pK7SVUdH5x54IJMtVafG6a3yW3eY+dPoW7/BLFzK+RPvDcyj8LIYF6DlncZSvKlBG
 Y8tyP6a/oQK1FyM/pdejWp/loPeiyQ1F4biol9FrWpiulLmXqjdsa5D/7y+ZZM7pSOWF
 x03URNmEpmY3TgTS3zOoB8M/y2ItB484AJ0NtXAkIboOoDRTiW2gTcKEb+LNaq9V8Hda 2g== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2nh33u0u7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Nov 2018 01:46:01 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wA71jsaW026218
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Nov 2018 01:45:55 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wA71jsqr001808;
        Wed, 7 Nov 2018 01:45:54 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 06 Nov 2018 17:45:54 -0800
To:     Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sathya.Prakash@broadcom.com, sreekanth.reddy@broadcom.com
Subject: Re: [PATCH v7 0/8] mpt3sas: some bug fixes patches
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1540992219-20291-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Date:   Tue, 06 Nov 2018 20:45:52 -0500
In-Reply-To: <1540992219-20291-1-git-send-email-suganath-prabu.subramani@broadcom.com>
        (Suganath Prabu's message of "Wed, 31 Oct 2018 18:53:31 +0530")
Message-ID: <yq1o9b13bjj.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9069 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811070014
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Suganath,

> Suganath Prabu (8):
>   mpt3sas: Added new #define variable IOC_OPERATIONAL_WAIT_COUNT
>   mpt3sas: Separate out mpt3sas_wait_for_ioc
>   mpt3sas: Refactor mpt3sas_wait_for_ioc function
>   mpt3sas: Call sas_remove_host before removing the target devices
>   mpt3sas: Fix Sync cache command failure during driver unload
>   mpt3sas: Don't modify EEDPTagMode field setting on SAS3.5 HBA devices
>   mpt3sas: Fix driver modifying persistent data in Manufacturing page11
>   mpt3sas: Bump driver version to 27.100.00.00.

Applied to 4.21/scsi-queue. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
