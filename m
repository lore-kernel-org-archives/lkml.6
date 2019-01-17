Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5968C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D84205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YeNRvKAy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfAQNfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 08:35:05 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:45570 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfAQNfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 08:35:04 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0HDT18b135863;
        Thu, 17 Jan 2019 13:35:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=YgiXfR0YDfmMcNpposBtWEwYr7+ChAYYja6xFzQZolA=;
 b=YeNRvKAytVuFIn5qfpg0tTV8xSnAaX54veEcjNir5hNwS0BZxAa5sKfuOlQSKIw+tbLa
 bQ7CItQ885g0of7gtZUFvIE7SdzL9UnsgW3gpajQbPzwA5UcPqih99DY74YG6BotRN1d
 3ctixiwGpgnbLY+XAXAuuuF1ORH3JUGj2ufdbaOc1AvwI3kqAePW/CjocWsXwTl0ccT2
 YFJue781RY7lC0KrNqPXeWKFD65IrWezAHkrGP/RxbLpX72QQNWL+6O9tJsZje1DCAgL
 IXXxwx9ew86E+KOTw+qvpuGKLWSPOV+mLuZefJh1Q9vXvhEyycE8v1JzyWxKPqyPD9xm 7g== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2pybkcqwdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jan 2019 13:35:00 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0HDYxVq016418
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jan 2019 13:35:00 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0HDYwY0021281;
        Thu, 17 Jan 2019 13:34:59 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Jan 2019 05:34:58 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] mm/page_alloc: check return value of
 memblock_alloc_node_nopanic()
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20190117112611.GB3710@rapoport-lnx>
Date:   Thu, 17 Jan 2019 06:34:57 -0700
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <971266DB-8F42-4189-A561-2C8A708A4D1B@oracle.com>
References: <1547621481-8374-1-git-send-email-rppt@linux.ibm.com>
 <5195030D-7ED9-4074-AB6C-92A3AFF11E00@oracle.com>
 <20190117112611.GB3710@rapoport-lnx>
To:     Mike Rapoport <rppt@linux.ibm.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9138 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901170099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 17, 2019, at 4:26 AM, Mike Rapoport <rppt@linux.ibm.com> wrote:
> 
> On Thu, Jan 17, 2019 at 03:19:35AM -0700, William Kucharski wrote:
>> 
>> This seems very reasonable, but if the code is just going to panic if the
>> allocation fails, why not call memblock_alloc_node() instead?
> 
> I've sent patches [1] that remove panic() from memblock_alloc*() and drop
> _nopanic variants. After they will be (hopefully) merged,
> memblock_alloc_node() will return NULL on error.
> 
>> If there is a reason we'd prefer to call memblock_alloc_node_nopanic(),
>> I'd like to see pgdat->nodeid printed in the panic message as well.
> 
> Sure.

Thanks for the quick response.

Reviewed-by: William Kucharski <william.kucharski@oracle.com>
