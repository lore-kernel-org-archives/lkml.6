Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6D6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42DFF20879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nGboNWTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbfAJToP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 14:44:15 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41864 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfAJToP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 14:44:15 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0AJciJJ167136;
        Thu, 10 Jan 2019 19:44:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=S6BmiYnkNetnAUKo8Bj39i5K8Y8JiLyQGKw382HHSZE=;
 b=nGboNWTIHL62s+FuGW06Kt5tQKR21L/TxuV90fHD8e6Y2ZrTexatpRu90sHeslLF2nky
 vg6b8v0+zDBCySxioPYag1aSJXZTpL+IQ/TrOeJEt2Z8m6JpZ9Na5O3Mqnz8AMm/caOH
 7IkkaN31SqFGAO2W3izi3xfQmwVxpyezWL1/7fAIqXm8QlFInOhv7GgWQqbLr5SQ/d7E
 TBuZHJMYAEebCucXj9NUzuI7+Hxc0OIXnw0f2jKkrXy8PsddnLlbN86z+dPyJ2ZWs5CU
 p2aCEK1J5fLKdHcBR6SefvU3GsibBnjs0lufxnxcPYMzwaw5zqOX1SwCpoh0n73qfzJh 5A== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2ptm0uha1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jan 2019 19:44:11 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0AJiA4U016874
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jan 2019 19:44:10 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0AJi9H2010247;
        Thu, 10 Jan 2019 19:44:10 GMT
Received: from kadam (/41.202.241.51)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Jan 2019 11:44:09 -0800
Date:   Thu, 10 Jan 2019 22:44:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vboxvideo: vbox_main: Remove unnecessary local
 variable
Message-ID: <20190110192942.GF1718@kadam>
References: <20190110061347.31326-1-realwakka@gmail.com>
 <20190110122358.GC1743@kadam>
 <20190110170023.4vcyws3ktsf2sz3g@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110170023.4vcyws3ktsf2sz3g@raspberrypi>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9132 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901100152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 05:00:24PM +0000, Sidong Yang wrote:
> I think you just point out that my code isn't obvious because the
> function returns negative error codes. I agree with you. But what if
> change my code like if(hgsmi_query_conf() != 0). 
> 

That's even worse!  :P

You should do comparisons with zero when you are talking about zero
meaning the number zero.  In this case, hgsmi_query_conf() returns "zezro
meaning success" not "zero meaning the number zero".  How many bytes?
Zero.  That is the number zero.

!= zero is a double negative, because NOT and ZERO are negatives.  If
double negatives simplified the code we would add four of them instead
of just the one:

	if ((((hgsmi_query_conf() != 0) != 0) != 0) != 0) {

See?  Adding != 0 doesn't make it simpler...

The other place where != 0 is appropriate besides talking about the
number is when you're using a strcmp() function because it works like
this:

	if (strcmp(a, b) < 0) {  <-- means a < b
	if (strcmp(a, b) == 0) { <-- means a == b
	if (strcmp(a, b) != 0) { <-- means a != b

regards,
dan carpenter

