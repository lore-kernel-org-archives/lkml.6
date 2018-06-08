Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id FRS7H+TeGVs6GAAAmS7hNA
	; Fri, 08 Jun 2018 01:42:58 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 41F306074D; Fri,  8 Jun 2018 01:42:58 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DzMwGgEr"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A1C0960290;
	Fri,  8 Jun 2018 01:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A1C0960290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752653AbeFHBmz (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 21:42:55 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46160 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752433AbeFHBmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 21:42:53 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w581fv53093719;
        Fri, 8 Jun 2018 01:42:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2017-10-26;
 bh=hc7aQ/RK06Car3nTLCO/jp48Tg+f0iwXTpyMKFJt1s4=;
 b=DzMwGgErqBKN0duwDBMpGFGj2AbJxTDCetD3mzReLjcXnReoYypDa48W6LGbQ1DR2gnF
 0HI900eQMfcQjIiX0Cin+t4ipgKVlJAohsTBsxL3+vkrRyULBx4Lbyd487HGTEGZnvJ9
 oOuVFZTymQNIsE6e4KBoxjiUn4yK0Vl0zV6Y1meETTI5jJKyb9TunCkuAbrkkARJMCkD
 df1akeE0JS6GbFSbYtq55Hd0bcxSCMFsAIUNIV8uNEcoQLps7msQVd0XSJWhhgWJDr/K
 uKRJw8J9UNSL5cCkxjspkFTZh3QrH6qx7CyY2vozxTXR5vrry5V6DlX+uo2dRsP9jr56 4Q==
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2jbvypb5as-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jun 2018 01:42:46 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w581gjgm021674
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Jun 2018 01:42:45 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w581gj6H030253;
        Fri, 8 Jun 2018 01:42:45 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Jun 2018 18:42:45 -0700
To: John Garry <john.garry@huawei.com>
Cc: <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/9] hisi_sas: some misc changes
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1527771050-200916-1-git-send-email-john.garry@huawei.com>
Date: Thu, 07 Jun 2018 21:42:42 -0400
In-Reply-To: <1527771050-200916-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Thu, 31 May 2018 20:50:41 +0800")
Message-ID: <yq1lgbq6okt.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8917 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=505
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806080016
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> This patchset introduces some more minor misc changes to the driver.

Applied to 4.19/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
