Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D3AC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4532434A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mYEq7MxO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C4532434A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934181AbeFYNoV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:44:21 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42176 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933144AbeFYNoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:44:20 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5PDhfmb053447;
        Mon, 25 Jun 2018 13:43:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=U/W9wW0A2OB3STQ+uiD1A0aL3wqAjz1EcSPd1m1+81M=;
 b=mYEq7MxO4aQlZAQmESQCIC61DwtQGZH7idgnVSjxD7KegvF/QeYjeKQowO870kqHpFcJ
 GmCuDp21IcEm6PrMQQpvulXaxvqsVgCuYHFnCr5jT8Z0MWyHAgSeMtfOXF74FELarTRb
 feUxn7N26bU6GCtjwjwJLz49PbKnjxpBh00TuaqBxH9exoTwcVQFXcA9kAImAIbTylXe
 X7+JgbVJSsTPOKDYhVg6s9E2OtkqvtzFSdRWFu3k18kISXiesoES9auevUWeBCcGWlPQ
 BDgJJEZ6WDdQty8+5k2kYAYep+VelWwPTghNqew2G+/nj2veUdjiLzRXLgPKjdD/Q9+t GA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2jt7mpau7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jun 2018 13:43:41 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5PDhfEb012150
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jun 2018 13:43:41 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5PDheEF025898;
        Mon, 25 Jun 2018 13:43:40 GMT
Received: from mwanda (/197.157.0.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Jun 2018 06:43:39 -0700
Date:   Mon, 25 Jun 2018 16:43:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     marcus.wolf@smarthome-wolf.de
Cc:     Valentin.Vidic@CARNet.hr, devel@driverdev.osuosl.org,
        robsonde@gmail.com, michael.panzlaff@fau.de, hle@owl.eu.com,
        gregkh@linuxfoundation.org, luca@acul.me,
        linux-kernel@vger.kernel.org, marcin.s.ciupak@gmail.com,
        linux@Wolf-Entwicklungen.de, simon@nikanor.nu, joe@perches.com
Subject: Re: [PATCH v3] staging: pi433: replace simple switch statements
Message-ID: <20180625134329.wdbu5o73qzqhbjto@mwanda>
References: <20180624094245.23741-1-Valentin.Vidic@CARNet.hr>
 <20180624163138.30976-1-Valentin.Vidic@CARNet.hr>
 <20180625123554.dlpgejqmjm7haak4@mwanda>
 <20180625132758.D724A2CE0120@dd39320.kasserver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625132758.D724A2CE0120@dd39320.kasserver.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8934 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=362
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806250161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there are going to be actual users in the specific near term then
that's fine.  Otherwise if we're talking a year out, then it's too far
away to predict what will happen a year from now so we should delete
the dead weight.

regards,
dan carpenter

