Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id yZ4zFkTNGVtNJwAAmS7hNA
	; Fri, 08 Jun 2018 00:26:44 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3AAC26074D; Fri,  8 Jun 2018 00:26:44 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rkTqgOVX"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B49EE601D2;
	Fri,  8 Jun 2018 00:26:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B49EE601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752615AbeFHA0l (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 20:26:41 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:33060 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752300AbeFHA0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 20:26:39 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w580Q4UW048412;
        Fri, 8 Jun 2018 00:26:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2017-10-26;
 bh=XK0IBtxBwR7jNpuOeM9IxFd0kW4AzVdGO5Fhy3TkBiA=;
 b=rkTqgOVXb7dwAnZMT44Kacg+JXOpJIgiUBR6zGwWMkI5jix0V4FXDBotTonJ0bBUKu+j
 6AAQQDtizOXvbti1SgJvQ68sNHTm+FoXPmd+TseovSB8q0Y7ng4P56Ao6Qd3Lt7vxO0D
 j/WK+IUHYiu5rESipBZPTQQHSVcAh2H+y9fNjLM+X2kBMQG3bUySWcjrY1Ikqhu33bny
 0DYoTdDt87nScmwMBGPOiMDEBRwNo3r/dS2t25BxNnR8HAYclF34cRaKcKOlBMTOzmfM
 jIScVuROxTnVVE0ZBYIvwULD9gHWQEN9h1EOjAoUgK/GSJAp8yIrY6YEGEMSMYi/+IzP Jg==
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2jbvypb0ea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jun 2018 00:26:36 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w580Qai7006939
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Jun 2018 00:26:36 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w580Qapb010448;
        Fri, 8 Jun 2018 00:26:36 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Jun 2018 17:26:35 -0700
To: "Rodrigo R. Galvao" <rosattig@linux.vnet.ibm.com>
Cc: maurosr@linux.vnet.ibm.com, kernel@gpiccoli.net,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: qla2xxx: Fix crash on qla2x00_mailbox_command
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <1527530324-32359-1-git-send-email-rosattig@linux.vnet.ibm.com>
        (Rodrigo R. Galvao's message of "Mon, 28 May 2018 14:58:44 -0300")
Organization: Oracle Corporation
References: <1527530324-32359-1-git-send-email-rosattig@linux.vnet.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
Date: Thu, 07 Jun 2018 20:26:33 -0400
Message-ID: <yq1sh5y86o6.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8917 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=512
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806080003
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Rodrigo,

> This patch fixes a crash on qla2x00_mailbox_command caused when the
> driver is on UNLOADING state and tries to call qla2x00_poll, which
> triggers a NULL pointer dereference.

Applied to 4.18/scsi-fixes. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
