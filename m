Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EFEC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E5D21736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KaEUNAhz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730715AbfAGNCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:02:01 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36590 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730703AbfAGNB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:01:58 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x07CxGbc192797;
        Mon, 7 Jan 2019 13:01:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=XeOxxPE8gHPFF+8V0A8yogE7RtyF4fxtsk0vVH6YS4M=;
 b=KaEUNAhz5Dd8FAY9tWU0OxYpgPaXSlNgePKYJhoQ2pMkKs/JUNjhb+R1W0wY1OwZ0DNe
 LHln0I9sd9bTZsSjnxyEd7S6trRHWHd9/U7I/ggQlFoRW5kuDjdVUOydtbIsKvwoZRrH
 enZBZrhzfnDlRQ83eEWcSxzRkGMw9l3ihyDgc7yMjbdeNTAJ4Ixt6Xog4inf2gv8ACil
 ZYZLk0ZIxY0tvdSVyZ4o26CYye4EcPsj0M3RENIMotW7OtGOCoCMtpcTztTHs6DmDir+
 ZujO6r012Q4sQotKdT8zOjEqm1WR3T6f7/x/ycJfAiKb3kqfnh+v4IOuDPsawS5L35Sn zQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2ptn7qnfcd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jan 2019 13:01:51 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x07D1o4T001578
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Jan 2019 13:01:50 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x07D1oUh018507;
        Mon, 7 Jan 2019 13:01:50 GMT
Received: from kadam (/197.157.0.45)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Jan 2019 05:01:49 -0800
Date:   Mon, 7 Jan 2019 16:00:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Aditya Pakki <pakki001@umn.edu>,
        Arushi Singhal <arushisinghal19971997@gmail.com>,
        devel@driverdev.osuosl.org, kjlu@umn.edu,
        linux-kernel@vger.kernel.org,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Quytelda Kahja <quytelda@tamalin.org>,
        Wen Yang <wen.yang99@zte.com.cn>
Subject: Re: [PATCH] v2 staging: rtl8723bs: Clean up dead code
Message-ID: <20190107130051.GC3200@kadam>
References: <20190106162101.9176-1-pakki001@umn.edu>
 <20190107101649.GA2750@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107101649.GA2750@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9128 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=680
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901070115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, put the v2 inside the square brackets.  [PATCH v3].  That way it
gets handled correctly by `cat raw_email.txt | git am`.

regards,
dan carpenter

