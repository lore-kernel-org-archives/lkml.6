Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AEFC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C145521709
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BDQZS85g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C145521709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbeHGLnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 07:43:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37554 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbeHGLnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 07:43:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w779OSsp047303;
        Tue, 7 Aug 2018 09:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Fg5EgK26hAhKxXBOe2Lucf4Q/ENR3bF6H6ec3GMyoVI=;
 b=BDQZS85gCrJo6sxZGLn3Np3RTIi1TaeCnd4YUCfLYqmQvsaiy0THUoBke3N9umMQ5V/u
 k+lgyklqh+r6Jxf2tTiDZT/AnGQtH8SPXfj8rSHanV9Bxn2StEtU6kM0+xf+1Mye76Rw
 1rywb4ylxMlfj+OGJwsoCFrYjDOKizEnHEIl6MvJGq65hgguWVA/zohs3l10SsSh41tg
 gzH3NBoco1OyNer+JxvGr5W4WSWKOqQ97IED67icmpkvVWLLur0wysxPlGdHMIs2S5V9
 PlOMLOsxGSqBcrUeJq/jOX4HuP0phl+DfAXINNnoYNkMNPraELzqXGcHYveTbVFS9W6z lg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2kn4sprgpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Aug 2018 09:29:54 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w779TrHL008626
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Aug 2018 09:29:53 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w779TpFp009732;
        Tue, 7 Aug 2018 09:29:51 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Aug 2018 02:29:50 -0700
Date:   Tue, 7 Aug 2018 12:29:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mao Wenan <maowenan@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] rtmutex: Drop pointless static qualifier in
 rt_mutex_adjust_prio_chain()
Message-ID: <20180807092943.yilmjaq22mvb3ckp@mwanda>
References: <1533632163-93769-1-git-send-email-maowenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533632163-93769-1-git-send-email-maowenan@huawei.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8977 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=652
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808070096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is obviously wrong and you need to at least compile your patches...

regards,
dan carpenter

