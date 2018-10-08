Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA0EC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 05:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4301C2077C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 05:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4301C2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbeJHMLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 08:11:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57958 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725946AbeJHMLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 08:11:30 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w984wmbj109143
        for <linux-kernel@vger.kernel.org>; Mon, 8 Oct 2018 01:01:41 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2myxnkd0h4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 01:01:41 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Mon, 8 Oct 2018 06:01:38 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 8 Oct 2018 06:01:35 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9851Xp164815146
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Oct 2018 05:01:33 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C0D14C044;
        Mon,  8 Oct 2018 08:01:11 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57F2B4C058;
        Mon,  8 Oct 2018 08:01:11 +0100 (BST)
Received: from osiris (unknown [9.152.212.171])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  8 Oct 2018 08:01:11 +0100 (BST)
Date:   Mon, 8 Oct 2018 07:01:30 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>, Julian Wiedmann <jwi@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "open list:S390 NETWORK DRIVERS" <linux-s390@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] s390/qeth: fix a missing-check bug
References: <1538842104-26018-1-git-send-email-wang6495@umn.edu>
MIME-Version: 1.0
In-Reply-To: <1538842104-26018-1-git-send-email-wang6495@umn.edu>
X-TM-AS-GCONF: 00
x-cbid: 18100805-0028-0000-0000-00000303DA6D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100805-0029-0000-0000-000023BE244B
Message-Id: <20181008050130.GA4148@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-08_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=942 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810080051
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 06, 2018 at 11:08:23AM -0500, Wenwen Wang wrote:
> In qeth_snmp_command(), the length of the user request is firstly copied
> from the user-space buffer 'udata' to the kernel variable 'req_len' and
> checked to see whether it is too large. If the check fails, an error code
> EINVAL is returned. Otherwise, the execution continues and the whole buffer
> is copied again from 'udata' and saved to the kernel buffer 'ureq'.
> However, after the second copy, no re-check is enforced on the newly-copied
> request length. Given that the buffer 'udata' is in the user space, a
> malicious user can race to change the request length between the two
> copies. In this way, the attacker can supply malicious data to the kernel
> and cause undefined behavior.
> 
> This patch adds a re-check on the request length after the second copy from
> the buffer 'udata'. If the newly-copied value is different from the value
> obtained in the first copy, i.e., 'req_len', an error code EINVAL will be
> returned after the buffer 'ureq' is freed.
> 
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> ---
>  drivers/s390/net/qeth_core_main.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
> index de82824..6199743 100644
> --- a/drivers/s390/net/qeth_core_main.c
> +++ b/drivers/s390/net/qeth_core_main.c
> @@ -4613,6 +4613,10 @@ static int qeth_snmp_command(struct qeth_card *card, char __user *udata)
>  		QETH_CARD_TEXT(card, 2, "snmpnome");
>  		return PTR_ERR(ureq);
>  	}
> +	if (ureq->hdr.req_len != req_len) {
> +		kfree(ureq);
> +		return -EINVAL;
> +	}

ureq->hdr.req_len is not used anywhere in the code, so could you please
explain what the undefined behavior is?

You could argue that adding a second sanity check may help to avoid
potential future bugs, but currently the code looks sane to me.

