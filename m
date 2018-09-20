Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABF8C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF0E20880
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YeLc12nr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF0E20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387562AbeITOzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 10:55:25 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45340 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbeITOzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 10:55:25 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8K94LiM063706;
        Thu, 20 Sep 2018 09:12:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=ZJzXhHZu4DQLeCne+c2+zbLxF9+JRf53rSP6QNSn16o=;
 b=YeLc12nrcazXJ0s6se8c1T4gE3ig7oYek2TvvcRbzw+rvPHJrQdzIgmncuUCmLujkIJM
 FxlVbtRtKT2jOZtDrmMIoL5WNJVrXVfy+fVggBsQqhpUTRcBNPNod+YHMtJYSB5GMTf7
 cUGe7lCCcev8AmTJxT1wIfLnwo8HBhTb6/0haTj1DtW6fPlXNrv4WrybbknyRKId0gPm
 KZHY4nRrWAYqDs8R66cFQlRZaMTsxUC54gEUGqM++w11RbaHQZcpD7a43LhIvC4QWGpC
 qo25HWBssuJ0+wO7ohqhMD2UjzrxQdNr0BgJlDxhv46tPlgJJ1KfsvWnYM2I0vfA+QQQ uQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2mgt1q1fh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Sep 2018 09:12:51 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8K9CpxP030487
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Sep 2018 09:12:51 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8K9CpeL032039;
        Thu, 20 Sep 2018 09:12:51 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Sep 2018 02:12:50 -0700
Date:   Thu, 20 Sep 2018 12:12:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, Ursula Braun <ubraun@linux.ibm.com>
Cc:     kbuild-all@01.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, raspl@linux.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/5] net/smc: remove duplicate mutex_unlock
Message-ID: <20180920091243.xgansymg6a4dfixg@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918134638.90271-3-ubraun@linux.ibm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9021 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809200094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ursula,

I love your patch! Perhaps something to improve:

[auto build test WARNING on net/master]

url:    https://github.com/0day-ci/linux/commits/Ursula-Braun/net-smc-fixes-2018-09-18/20180919-080857

smatch warnings:
net/smc/af_smc.c:1289 smc_listen_work() warn: inconsistent returns 'mutex:&smc_create_lgr_pending'.
  Locked on:   line 1285
  Unlocked on: line 1209

# https://github.com/0day-ci/linux/commit/c69342ef9becfe90f3778db1c386abdd80b786d1
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout c69342ef9becfe90f3778db1c386abdd80b786d1
vim +1289 net/smc/af_smc.c

3b2dec260 Hans Wippel   2018-05-18  1231  	/* IPSec connections opt out of SMC-R optimizations */
3b2dec260 Hans Wippel   2018-05-18  1232  	if (using_ipsec(new_smc)) {
3b2dec260 Hans Wippel   2018-05-18  1233  		smc_listen_decline(new_smc, SMC_CLC_DECL_IPSEC, 0);
3b2dec260 Hans Wippel   2018-05-18  1234  		return;
3b2dec260 Hans Wippel   2018-05-18  1235  	}
3b2dec260 Hans Wippel   2018-05-18  1236  
3b2dec260 Hans Wippel   2018-05-18  1237  	mutex_lock(&smc_create_lgr_pending);
3b2dec260 Hans Wippel   2018-05-18  1238  	smc_close_init(new_smc);
3b2dec260 Hans Wippel   2018-05-18  1239  	smc_rx_init(new_smc);
3b2dec260 Hans Wippel   2018-05-18  1240  	smc_tx_init(new_smc);
3b2dec260 Hans Wippel   2018-05-18  1241  
413498440 Hans Wippel   2018-06-28  1242  	/* check if ISM is available */
413498440 Hans Wippel   2018-06-28  1243  	if ((pclc->hdr.path == SMC_TYPE_D || pclc->hdr.path == SMC_TYPE_B) &&
413498440 Hans Wippel   2018-06-28  1244  	    !smc_check_ism(new_smc, &ismdev) &&
413498440 Hans Wippel   2018-06-28  1245  	    !smc_listen_ism_init(new_smc, pclc, ismdev, &local_contact)) {
413498440 Hans Wippel   2018-06-28  1246  		ism_supported = true;
413498440 Hans Wippel   2018-06-28  1247  	}
413498440 Hans Wippel   2018-06-28  1248  
3b2dec260 Hans Wippel   2018-05-18  1249  	/* check if RDMA is available */
413498440 Hans Wippel   2018-06-28  1250  	if (!ism_supported &&
413498440 Hans Wippel   2018-06-28  1251  	    ((pclc->hdr.path != SMC_TYPE_R && pclc->hdr.path != SMC_TYPE_B) ||
7005ada68 Ursula Braun  2018-07-25  1252  	     smc_vlan_by_tcpsk(new_smc->clcsock, &vlan) ||
7005ada68 Ursula Braun  2018-07-25  1253  	     smc_check_rdma(new_smc, &ibdev, &ibport, vlan, NULL) ||
3b2dec260 Hans Wippel   2018-05-18  1254  	     smc_listen_rdma_check(new_smc, pclc) ||
3b2dec260 Hans Wippel   2018-05-18  1255  	     smc_listen_rdma_init(new_smc, pclc, ibdev, ibport,
3b2dec260 Hans Wippel   2018-05-18  1256  				  &local_contact) ||
413498440 Hans Wippel   2018-06-28  1257  	     smc_listen_rdma_reg(new_smc, local_contact))) {
3b2dec260 Hans Wippel   2018-05-18  1258  		/* SMC not supported, decline */
145686baa Ursula Braun  2017-10-25  1259  		mutex_unlock(&smc_create_lgr_pending);
603cc1498 Karsten Graul 2018-07-25  1260  		smc_listen_decline(new_smc, SMC_CLC_DECL_MODEUNSUPP,
603cc1498 Karsten Graul 2018-07-25  1261  				   local_contact);
3b2dec260 Hans Wippel   2018-05-18  1262  		return;
a046d57da Ursula Braun  2017-01-09  1263  	}
a046d57da Ursula Braun  2017-01-09  1264  
3b2dec260 Hans Wippel   2018-05-18  1265  	/* send SMC Accept CLC message */
3b2dec260 Hans Wippel   2018-05-18  1266  	rc = smc_clc_send_accept(new_smc, local_contact);
3b2dec260 Hans Wippel   2018-05-18  1267  	if (rc) {
145686baa Ursula Braun  2017-10-25  1268  		mutex_unlock(&smc_create_lgr_pending);
3b2dec260 Hans Wippel   2018-05-18  1269  		smc_listen_decline(new_smc, rc, local_contact);
3b2dec260 Hans Wippel   2018-05-18  1270  		return;
3b2dec260 Hans Wippel   2018-05-18  1271  	}
3b2dec260 Hans Wippel   2018-05-18  1272  
3b2dec260 Hans Wippel   2018-05-18  1273  	/* receive SMC Confirm CLC message */
3b2dec260 Hans Wippel   2018-05-18  1274  	reason_code = smc_clc_wait_msg(new_smc, &cclc, sizeof(cclc),
3b2dec260 Hans Wippel   2018-05-18  1275  				       SMC_CLC_CONFIRM);
3b2dec260 Hans Wippel   2018-05-18  1276  	if (reason_code) {
3b2dec260 Hans Wippel   2018-05-18  1277  		mutex_unlock(&smc_create_lgr_pending);
3b2dec260 Hans Wippel   2018-05-18  1278  		smc_listen_decline(new_smc, reason_code, local_contact);
3b2dec260 Hans Wippel   2018-05-18  1279  		return;
3b2dec260 Hans Wippel   2018-05-18  1280  	}
3b2dec260 Hans Wippel   2018-05-18  1281  
3b2dec260 Hans Wippel   2018-05-18  1282  	/* finish worker */
c69342ef9 Ursula Braun  2018-09-18  1283  	if (!ism_supported) {
c69342ef9 Ursula Braun  2018-09-18  1284  		if (smc_listen_rdma_finish(new_smc, &cclc, local_contact))
c69342ef9 Ursula Braun  2018-09-18  1285  			return;
                                                                ^^^^^^
We need to mutex_unlock(&smc_create_lgr_pending); before the return.

c69342ef9 Ursula Braun  2018-09-18  1286  	}
3b2dec260 Hans Wippel   2018-05-18  1287  	smc_conn_save_peer_info(new_smc, &cclc);
3b2dec260 Hans Wippel   2018-05-18  1288  	mutex_unlock(&smc_create_lgr_pending);
3b2dec260 Hans Wippel   2018-05-18 @1289  	smc_listen_out_connected(new_smc);
a046d57da Ursula Braun  2017-01-09  1290  }
a046d57da Ursula Braun  2017-01-09  1291  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
