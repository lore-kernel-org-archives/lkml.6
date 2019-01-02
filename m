Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBBAC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46696218CD
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="4NOq2Arc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbfABKve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 05:51:34 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:39272 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbfABKvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 05:51:33 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x02AnFVO184150;
        Wed, 2 Jan 2019 10:51:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=6gK1j0fpCdSgZ65qgqoabwyuMVbdaZeWfgfOQFsAWzw=;
 b=4NOq2Arcxex9Y7qihHnIczdNGWU7cAXjFsG9IOEu4xzDJJgehc53LE9nmPIJVM42Bgxo
 KlGPtWKW9uTdvfOnBfYXBR1hsEXdwBtCPAICj/v600DOq0aWO/zAST6SQ0fb/cjRHcI3
 bGijRkLrYMcNz3yv7Bbgzz24G68fz13YeO/OFfAxFwkxweUSIlPe+kRqRDR54mFC7Kdh
 y3vnOrGnP32mKwqMKyauIskqeI9EM6Qdvceb/BwzJiYZ6gnYPYeeY0IZzFvP34nZKAOK
 tmTiquop6t6fMHhtsl/9ljiK/nmoH8oGWAzhnXrUhZ0Om54va1b715YS7DLHjF5V8XQT ZA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2pnxee1nvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Jan 2019 10:51:24 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x02ApJW6016922
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Jan 2019 10:51:19 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x02ApIJm028405;
        Wed, 2 Jan 2019 10:51:18 GMT
Received: from kadam (/197.157.0.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Jan 2019 02:51:17 -0800
Date:   Wed, 2 Jan 2019 13:50:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     devel@driverdev.osuosl.org, Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kjlu@umn.edu,
        linux-kernel@vger.kernel.org, Aymen Qader <qader.aymen@gmail.com>
Subject: Re: [PATCH] staging: rts5208: Add a check for ms_read_extra_data
Message-ID: <20190102105058.GH3781@kadam>
References: <20181227193554.25448-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181227193554.25448-1-pakki001@umn.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9123 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=881
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901020099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2018 at 01:35:53PM -0600, Aditya Pakki wrote:
> In ms_copy_page, the function ms_read_extra_data may fail for many
> reasons. The fix adds a check similar to other invocation to return
> error upstream.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

Yup.  It doesn't make sense to use stale "extra" data. 

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

