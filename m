Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42020C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF25B20878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:46:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF25B20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbeJBN2a convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 09:28:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39562 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726492AbeJBN2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 09:28:30 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w926iJVm034115
        for <linux-kernel@vger.kernel.org>; Tue, 2 Oct 2018 02:46:49 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mv10hn37t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 02:46:48 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Tue, 2 Oct 2018 07:46:46 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 2 Oct 2018 07:46:43 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w926kgmR62652492
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Oct 2018 06:46:42 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 243DA42047;
        Tue,  2 Oct 2018 09:46:23 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C97724204B;
        Tue,  2 Oct 2018 09:46:22 +0100 (BST)
Received: from osiris (unknown [9.152.212.171])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  2 Oct 2018 09:46:22 +0100 (BST)
Date:   Tue, 2 Oct 2018 08:46:40 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Ursula Braun <ubraun@linux.ibm.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@01.org,
        kbuild-all@01.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, schwidefsky@de.ibm.com,
        raspl@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/5] net/smc: remove duplicate mutex_unlock
References: <20180920091243.xgansymg6a4dfixg@mwanda>
 <c0fe2ae3-38b4-5023-9140-20f7acac6028@linux.ibm.com>
In-Reply-To: <c0fe2ae3-38b4-5023-9140-20f7acac6028@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18100206-0016-0000-0000-0000020D25A0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100206-0017-0000-0000-000032646183
Message-Id: <20181002064640.GA16762@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-02_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=956 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810020069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 05:22:22PM +0200, Ursula Braun wrote:
> 
> > 3b2dec260 Hans Wippel   2018-05-18  1282  	/* finish worker */
> > c69342ef9 Ursula Braun  2018-09-18  1283  	if (!ism_supported) {
> > c69342ef9 Ursula Braun  2018-09-18  1284  		if (smc_listen_rdma_finish(new_smc, &cclc, local_contact))
> > c69342ef9 Ursula Braun  2018-09-18  1285  			return;
> >                                                                 ^^^^^^
> > We need to mutex_unlock(&smc_create_lgr_pending); before the return.
> >
> 
> The smatch warning is not necessary, since the mutex_unlock(&smc_create_lgr_pending)
> for this case is done within smc_listen_rdma_finish().
> 
> > c69342ef9 Ursula Braun  2018-09-18  1286  	}
> > 3b2dec260 Hans Wippel   2018-05-18  1287  	smc_conn_save_peer_info(new_smc, &cclc);
> > 3b2dec260 Hans Wippel   2018-05-18  1288  	mutex_unlock(&smc_create_lgr_pending);
> > 3b2dec260 Hans Wippel   2018-05-18 @1289  	smc_listen_out_connected(new_smc);
> > a046d57da Ursula Braun  2017-01-09  1290  }
> > a046d57da Ursula Braun  2017-01-09  1291  
> > 
> > ---
> > 0-DAY kernel test infrastructure                Open Source Technology Center
> > https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> > 
> 
> But you could argue the code confuses smatch and other readers. Thus I could improve
> readability with a patch like this:

Yes, please.

> ---
>  net/smc/af_smc.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -1184,7 +1184,6 @@ static int smc_listen_rdma_finish(struct
>  	return 0;
>  
>  decline:
> -	mutex_unlock(&smc_create_lgr_pending);
>  	smc_listen_decline(new_smc, reason_code, local_contact);
>  	return reason_code;
>  }

The lonely mutex_unlock() also _looks_ like a bug ;)

