Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFA8ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80046214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80046214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbeIQOQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 10:16:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56264 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727133AbeIQOQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 10:16:15 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8H8jSt1052972
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 04:50:53 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mj7h9c0xy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 04:50:52 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ubraun@linux.ibm.com>;
        Mon, 17 Sep 2018 09:49:46 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 17 Sep 2018 09:49:44 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8H8nhSa56885420
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Sep 2018 08:49:43 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7803EAE053;
        Mon, 17 Sep 2018 11:48:53 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39474AE051;
        Mon, 17 Sep 2018 11:48:53 +0100 (BST)
Received: from oc7163163645.ibm.com (unknown [9.145.57.131])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 17 Sep 2018 11:48:53 +0100 (BST)
Subject: Re: [PATCH net-next] net/smc: cast sizeof to int for comparison
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-s390@vger.kernel.org
References: <20180915100036.20100-1-yuehaibing@huawei.com>
From:   Ursula Braun <ubraun@linux.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=ubraun@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date:   Mon, 17 Sep 2018 10:49:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180915100036.20100-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18091708-0020-0000-0000-000002C72960
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091708-0021-0000-0000-000021149629
Message-Id: <554a145a-d59d-9033-1702-4987a9c4bc94@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-17_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809170093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/15/2018 12:00 PM, YueHaibing wrote:
> Comparing an int to a size, which is unsigned, causes the int to become
> unsigned, giving the wrong result. kernel_sendmsg can return a negative
> error code.
> 

Thanks for reporting this issue!

> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  net/smc/smc_clc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
> index 83aba9a..fd0f5ce 100644
> --- a/net/smc/smc_clc.c
> +++ b/net/smc/smc_clc.c
> @@ -446,7 +446,7 @@ int smc_clc_send_proposal(struct smc_sock *smc, int smc_type,
>  	vec[i++].iov_len = sizeof(trl);
>  	/* due to the few bytes needed for clc-handshake this cannot block */
>  	len = kernel_sendmsg(smc->clcsock, &msg, vec, i, plen);
> -	if (len < sizeof(pclc)) {
> +	if (len < (int)sizeof(pclc)) {
>  		if (len >= 0) {
>  			reason_code = -ENETUNREACH;
>  			smc->sk.sk_err = -reason_code;
> 

Your fix helps, but I would like to follow the hint of Andreas Schwab, and split
the return value check like this:

---
 net/smc/smc_clc.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -446,14 +446,12 @@ int smc_clc_send_proposal(struct smc_soc
 	vec[i++].iov_len = sizeof(trl);
 	/* due to the few bytes needed for clc-handshake this cannot block */
 	len = kernel_sendmsg(smc->clcsock, &msg, vec, i, plen);
-	if (len < sizeof(pclc)) {
-		if (len >= 0) {
-			reason_code = -ENETUNREACH;
-			smc->sk.sk_err = -reason_code;
-		} else {
-			smc->sk.sk_err = smc->clcsock->sk->sk_err;
-			reason_code = -smc->sk.sk_err;
-		}
+	if (len < 0) {
+		smc->sk.sk_err = smc->clcsock->sk->sk_err;
+		reason_code = -smc->sk.sk_err;
+	} else if (len < (int)sizeof(pclc)) {
+		reason_code = -ENETUNREACH;
+		smc->sk.sk_err = -reason_code;
 	}
 
 	return reason_code;

Agreed?

Regards, Ursula

