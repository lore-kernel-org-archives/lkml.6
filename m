Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A504C07E85
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 02:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D354521104
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 02:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NNE2phcO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D354521104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbeLHC5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 21:57:55 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:35710 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbeLHC5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 21:57:55 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB82sx1W079606;
        Sat, 8 Dec 2018 02:57:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=uoq/wcbvESasZtn05pknBR26uyH2qGgTXo+a9XW9/30=;
 b=NNE2phcOKLRZ202mxVc2EyWU3+kP1lA0MakOIbJP/V7EdvEi4SktfFVcWz1L60eFTCOm
 bE9VWlv8fA55EOAuYeG6LgM5kND0H51i71c8wuNFayVCUWXRRo8P5gJ1gulS9v0OUcx9
 FbIgMsu1pHmaWyssM2FPkuia/iYgwR3r8hSEHVSWSJlOVO0OYA8PXnHT6OYr3g2bmatY
 pCnqJvo81N9nbmRw11vnWTtTn3vEX3jTgbuV4w/vDxaKbMXPM/ONjejAYP8GVprQR6OS
 Dhzh0FacRoYfji2e97Sam5Aba5gv+a/dSNE6UaDjQSXHu+jOE/03i2O89e+HITOdCpyc xA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2p85ctr0d1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Dec 2018 02:57:52 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB82vo2j006010
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 8 Dec 2018 02:57:51 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB82vnAg018800;
        Sat, 8 Dec 2018 02:57:50 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Dec 2018 18:57:49 -0800
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: Use of_node_name_eq for node name comparisons
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20181205195050.4759-23-robh@kernel.org>
Date:   Fri, 07 Dec 2018 21:57:47 -0500
In-Reply-To: <20181205195050.4759-23-robh@kernel.org> (Rob Herring's message
        of "Wed, 5 Dec 2018 13:50:39 -0600")
Message-ID: <yq1zhtglo7o.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9100 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=676
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812080025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Rob,

> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.

Applied to 4.21/scsi-queue, thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
