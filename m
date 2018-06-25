Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62627C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1560A2592A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HUP1WXHe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1560A2592A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933615AbeFYMgz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:36:55 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:37588 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932392AbeFYMgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:36:54 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5PCXvXa066544;
        Mon, 25 Jun 2018 12:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=07VytpmqLKcgeHxIRqRUAdOpODuJLq6uMqpxnYJer2w=;
 b=HUP1WXHeGIng4ywf2F3b+Le0U8m1J8G96dtcRf2ATn1HNnRshsCDDYsB7j7qMcsVbB0H
 zj5//0NOCbKxk1eogwBFLi8zAW7WG7KYW3quSSH3AfQRB5nQ6qzvpJ7x1iISdlys/r4G
 4HTwfFH0KbMMGdLaCwJ2anFL7yeNjgsdc7ktm+hC41oc8TUntUpegsKtdLUGwZtEg3UZ
 ltw2nQtLMNr3JjkqwUCQLeUl8jnANu3auXdhFJmGJL43EmJMxjIu0YD3fC26D2emE+sw
 sQbRZZaDEBUabS0xtVRsVc90QtijjCnG/4Baweoq5dHR3GDhuOmFXEnBxj7gz0tme2k1 uw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2jt7nathtr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jun 2018 12:36:13 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5PCaClE001293
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jun 2018 12:36:12 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5PCaA0X016570;
        Mon, 25 Jun 2018 12:36:10 GMT
Received: from mwanda (/197.157.0.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Jun 2018 05:36:09 -0700
Date:   Mon, 25 Jun 2018 15:35:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Valentin Vidic <Valentin.Vidic@CARNet.hr>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Derek Robson <robsonde@gmail.com>,
        Michael Panzlaff <michael.panzlaff@fau.de>,
        Hugo Lefeuvre <hle@owl.eu.com>,
        Luca =?iso-8859-1?Q?S=F6the?= <luca@acul.me>,
        linux-kernel@vger.kernel.org,
        Marcin Ciupak <marcin.s.ciupak@gmail.com>,
        Marcus Wolf <linux@Wolf-Entwicklungen.de>,
        Simon =?iso-8859-1?Q?Sandstr=F6m?= <simon@nikanor.nu>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3] staging: pi433: replace simple switch statements
Message-ID: <20180625123554.dlpgejqmjm7haak4@mwanda>
References: <20180624094245.23741-1-Valentin.Vidic@CARNet.hr>
 <20180624163138.30976-1-Valentin.Vidic@CARNet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180624163138.30976-1-Valentin.Vidic@CARNet.hr>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8934 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=340
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806250147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'd still prefer if we just removed this abstraction entirely and used
OPMODE_MODE_TRANSMIT everywhere instead of bringing "transmit" into it.

I know that every author thinks their abstraction will definitely be
useful in the future, but generally kernel style is to remove
abstractions.

But I guess this code is an improvement over the original so the patch
is fine.

regards,
dan carpenter

