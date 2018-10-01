Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FCBC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD65213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFD65213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbeJAWAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:00:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47090 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729488AbeJAWAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:00:49 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w91FFEXR048501
        for <linux-kernel@vger.kernel.org>; Mon, 1 Oct 2018 11:22:30 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2munkw9s5w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 11:22:29 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ubraun@linux.ibm.com>;
        Mon, 1 Oct 2018 16:22:27 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 1 Oct 2018 16:22:24 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w91FMN1o65339440
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Oct 2018 15:22:23 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D459652054;
        Mon,  1 Oct 2018 18:22:01 +0100 (BST)
Received: from oc7163163645.ibm.com (unknown [9.145.1.164])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6D5E552052;
        Mon,  1 Oct 2018 18:22:01 +0100 (BST)
Subject: Re: [PATCH net 2/5] net/smc: remove duplicate mutex_unlock
To:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@01.org
Cc:     kbuild-all@01.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, raspl@linux.ibm.com,
        linux-kernel@vger.kernel.org
References: <20180920091243.xgansymg6a4dfixg@mwanda>
From:   Ursula Braun <ubraun@linux.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=ubraun@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date:   Mon, 1 Oct 2018 17:22:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180920091243.xgansymg6a4dfixg@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18100115-0020-0000-0000-000002CDE83F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100115-0021-0000-0000-0000211C24C0
Message-Id: <c0fe2ae3-38b4-5023-9140-20f7acac6028@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810010148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/20/2018 11:12 AM, Dan Carpenter wrote:
> Hi Ursula,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on net/master]
> 
> url:    https://github.com/0day-ci/linux/commits/Ursula-Braun/net-smc-fixes-2018-09-18/20180919-080857
> 
> smatch warnings:
> net/smc/af_smc.c:1289 smc_listen_work() warn: inconsistent returns 'mutex:&smc_create_lgr_pending'.
>   Locked on:   line 1285
>   Unlocked on: line 1209
> 
> # https://github.com/0day-ci/linux/commit/c69342ef9becfe90f3778db1c386abdd80b786d1
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout c69342ef9becfe90f3778db1c386abdd80b786d1
> vim +1289 net/smc/af_smc.c
> 
> 3b2dec260 Hans Wippel   2018-05-18  1231  	/* IPSec connections opt out of SMC-R optimizations */
> 3b2dec260 Hans Wippel   2018-05-18  1232  	if (using_ipsec(new_smc)) {
> 3b2dec260 Hans Wippel   2018-05-18  1233  		smc_listen_decline(new_smc, SMC_CLC_DECL_IPSEC, 0);
> 3b2dec260 Hans Wippel   2018-05-18  1234  		return;
> 3b2dec260 Hans Wippel   2018-05-18  1235  	}
> 3b2dec260 Hans Wippel   2018-05-18  1236  
> 3b2dec260 Hans Wippel   2018-05-18  1237  	mutex_lock(&smc_create_lgr_pending);
> 3b2dec260 Hans Wippel   2018-05-18  1238  	smc_close_init(new_smc);
> 3b2dec260 Hans Wippel   2018-05-18  1239  	smc_rx_init(new_smc);
> 3b2dec260 Hans Wippel   2018-05-18  1240  	smc_tx_init(new_smc);
> 3b2dec260 Hans Wippel   2018-05-18  1241  
> 413498440 Hans Wippel   2018-06-28  1242  	/* check if ISM is available */
> 413498440 Hans Wippel   2018-06-28  1243  	if ((pclc->hdr.path == SMC_TYPE_D || pclc->hdr.path == SMC_TYPE_B) &&
> 413498440 Hans Wippel   2018-06-28  1244  	    !smc_check_ism(new_smc, &ismdev) &&
> 413498440 Hans Wippel   2018-06-28  1245  	    !smc_listen_ism_init(new_smc, pclc, ismdev, &local_contact)) {
> 413498440 Hans Wippel   2018-06-28  1246  		ism_supported = true;
> 413498440 Hans Wippel   2018-06-28  1247  	}
> 413498440 Hans Wippel   2018-06-28  1248  
> 3b2dec260 Hans Wippel   2018-05-18  1249  	/* check if RDMA is available */
> 413498440 Hans Wippel   2018-06-28  1250  	if (!ism_supported &&
> 413498440 Hans Wippel   2018-06-28  1251  	    ((pclc->hdr.path != SMC_TYPE_R && pclc->hdr.path != SMC_TYPE_B) ||
> 7005ada68 Ursula Braun  2018-07-25  1252  	     smc_vlan_by_tcpsk(new_smc->clcsock, &vlan) ||
> 7005ada68 Ursula Braun  2018-07-25  1253  	     smc_check_rdma(new_smc, &ibdev, &ibport, vlan, NULL) ||
> 3b2dec260 Hans Wippel   2018-05-18  1254  	     smc_listen_rdma_check(new_smc, pclc) ||
> 3b2dec260 Hans Wippel   2018-05-18  1255  	     smc_listen_rdma_init(new_smc, pclc, ibdev, ibport,
> 3b2dec260 Hans Wippel   2018-05-18  1256  				  &local_contact) ||
> 413498440 Hans Wippel   2018-06-28  1257  	     smc_listen_rdma_reg(new_smc, local_contact))) {
> 3b2dec260 Hans Wippel   2018-05-18  1258  		/* SMC not supported, decline */
> 145686baa Ursula Braun  2017-10-25  1259  		mutex_unlock(&smc_create_lgr_pending);
> 603cc1498 Karsten Graul 2018-07-25  1260  		smc_listen_decline(new_smc, SMC_CLC_DECL_MODEUNSUPP,
> 603cc1498 Karsten Graul 2018-07-25  1261  				   local_contact);
> 3b2dec260 Hans Wippel   2018-05-18  1262  		return;
> a046d57da Ursula Braun  2017-01-09  1263  	}
> a046d57da Ursula Braun  2017-01-09  1264  
> 3b2dec260 Hans Wippel   2018-05-18  1265  	/* send SMC Accept CLC message */
> 3b2dec260 Hans Wippel   2018-05-18  1266  	rc = smc_clc_send_accept(new_smc, local_contact);
> 3b2dec260 Hans Wippel   2018-05-18  1267  	if (rc) {
> 145686baa Ursula Braun  2017-10-25  1268  		mutex_unlock(&smc_create_lgr_pending);
> 3b2dec260 Hans Wippel   2018-05-18  1269  		smc_listen_decline(new_smc, rc, local_contact);
> 3b2dec260 Hans Wippel   2018-05-18  1270  		return;
> 3b2dec260 Hans Wippel   2018-05-18  1271  	}
> 3b2dec260 Hans Wippel   2018-05-18  1272  
> 3b2dec260 Hans Wippel   2018-05-18  1273  	/* receive SMC Confirm CLC message */
> 3b2dec260 Hans Wippel   2018-05-18  1274  	reason_code = smc_clc_wait_msg(new_smc, &cclc, sizeof(cclc),
> 3b2dec260 Hans Wippel   2018-05-18  1275  				       SMC_CLC_CONFIRM);
> 3b2dec260 Hans Wippel   2018-05-18  1276  	if (reason_code) {
> 3b2dec260 Hans Wippel   2018-05-18  1277  		mutex_unlock(&smc_create_lgr_pending);
> 3b2dec260 Hans Wippel   2018-05-18  1278  		smc_listen_decline(new_smc, reason_code, local_contact);
> 3b2dec260 Hans Wippel   2018-05-18  1279  		return;
> 3b2dec260 Hans Wippel   2018-05-18  1280  	}
> 3b2dec260 Hans Wippel   2018-05-18  1281  
> 3b2dec260 Hans Wippel   2018-05-18  1282  	/* finish worker */
> c69342ef9 Ursula Braun  2018-09-18  1283  	if (!ism_supported) {
> c69342ef9 Ursula Braun  2018-09-18  1284  		if (smc_listen_rdma_finish(new_smc, &cclc, local_contact))
> c69342ef9 Ursula Braun  2018-09-18  1285  			return;
>                                                                 ^^^^^^
> We need to mutex_unlock(&smc_create_lgr_pending); before the return.
>

The smatch warning is not necessary, since the mutex_unlock(&smc_create_lgr_pending)
for this case is done within smc_listen_rdma_finish().

> c69342ef9 Ursula Braun  2018-09-18  1286  	}
> 3b2dec260 Hans Wippel   2018-05-18  1287  	smc_conn_save_peer_info(new_smc, &cclc);
> 3b2dec260 Hans Wippel   2018-05-18  1288  	mutex_unlock(&smc_create_lgr_pending);
> 3b2dec260 Hans Wippel   2018-05-18 @1289  	smc_listen_out_connected(new_smc);
> a046d57da Ursula Braun  2017-01-09  1290  }
> a046d57da Ursula Braun  2017-01-09  1291  
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

But you could argue the code confuses smatch and other readers. Thus I could improve
readability with a patch like this:

---
 net/smc/af_smc.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1184,7 +1184,6 @@ static int smc_listen_rdma_finish(struct
 	return 0;
 
 decline:
-	mutex_unlock(&smc_create_lgr_pending);
 	smc_listen_decline(new_smc, reason_code, local_contact);
 	return reason_code;
 }
@@ -1284,8 +1283,10 @@ static void smc_listen_work(struct work_
 
 	/* finish worker */
 	if (!ism_supported) {
-		if (smc_listen_rdma_finish(new_smc, &cclc, local_contact))
+		if (smc_listen_rdma_finish(new_smc, &cclc, local_contact)) {
+			mutex_unlock(&smc_create_lgr_pending);
 			return;
+		}
 	}
 	smc_conn_save_peer_info(new_smc, &cclc);
 	mutex_unlock(&smc_create_lgr_pending);
---




