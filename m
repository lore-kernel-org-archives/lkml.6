Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A23C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E362170E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HbSrMNyF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E362170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbeHUNCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 09:02:21 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43798 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbeHUNCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 09:02:21 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7L9gE77034199;
        Tue, 21 Aug 2018 09:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=ByZlr4Y6SgGRVFBApRmSH6YGeVwf812VOY23IBRal4o=;
 b=HbSrMNyFyDwCJOSEs7kSmBI9zKq+kjedV0s8mps7++2fuBKaehr6BoNivc14Ac3ixdy2
 /f3HFbWupJiAVJ+hipmF4ZgMzLWjsGupPDUtjogqUkqV4BJAzVljBEkd9U6WJ8bzd6CK
 xdtmHfxWJKbFjGa6m2uRx3xSWWD01Jl4t+pznsR/QcwE9f6BrupgPvuuZqOf31axcTpU
 nC8cnSE9Ti6HQiTTyaMZV9FHQDS/WbxXh4jcJC8E7qAHgjJUwraMgSTkGUHvd18H6Zvg
 PzIYM24MLFYxaoBRgOk0bYjxkg05cLOKwjXCEdPgItqo3H3nJxXRgcS0eb4fzPQxnyPP lw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2kxbdpucbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Aug 2018 09:42:52 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7L9gpOf002942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Aug 2018 09:42:51 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7L9gpKj005322;
        Tue, 21 Aug 2018 09:42:51 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Aug 2018 02:42:50 -0700
Date:   Tue, 21 Aug 2018 12:42:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Bhaskar Singh <bhaskar.kernel@gmail.com>
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8188eu: Removed code valid for 5GHz
Message-ID: <20180821094244.zjljope5hzdghfuq@mwanda>
References: <20180821013603.GA7589@Gentoo-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821013603.GA7589@Gentoo-PC>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8991 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=555
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808210103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Great.  Thanks!

regards,
dan carpenter

