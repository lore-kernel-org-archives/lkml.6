Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0F6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E842173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DQ/RdtPL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbfAJMYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:24:10 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:44280 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfAJMYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 07:24:10 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0ACK50l132335;
        Thu, 10 Jan 2019 12:24:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=LJKiU+cD4Pffn28Qn7ybb3uImGtSfwdIv5eUfEmjn1I=;
 b=DQ/RdtPLA0MKbc3RPZJzreTRwEw5fis8NxxKdFbuX47ayp9vZyK0GMmZ3p1wI8paBl7l
 8ImWLLxmB8zx8wizgoVthFHq+o2MT8sL5RcQlDtY5Tn/vYyR967YAOWFH+cX+rjJn7Xf
 YROhUwT1kMXuFT8Tg9iW2tol9iTup+UYxJjV+XImL4OKYQ5UVZU5tOWExlt7OzkWo4EZ
 qJR2rsA3Wr1CMjKjm99V+0GgJtLVUC2/ZyotDVzZTbZE/feRKtoPUKYxW8qF1h5WDNyA
 lTQxBaU47oINyJx5+lGJCpbCYbz3Hn69emX5jpVI1Y7hVz0riB7QHn4YJhn9EsVxqtZn ZA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2ptj3e72vy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jan 2019 12:24:04 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0ACO4ui005665
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jan 2019 12:24:04 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0ACO38u025071;
        Thu, 10 Jan 2019 12:24:03 GMT
Received: from kadam (/197.157.0.17)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Jan 2019 04:24:03 -0800
Date:   Thu, 10 Jan 2019 15:23:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vboxvideo: vbox_main: Remove unnecessary local
 variable
Message-ID: <20190110122358.GC1743@kadam>
References: <20190110061347.31326-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110061347.31326-1-realwakka@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9131 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901100101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 06:13:47AM +0000, Sidong Yang wrote:
> Removed unnecessary local variable in have_hgsmi_mode_hints.
> The result of hgsmi_query_conf should be directly compared without
> assigning to local variable.
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---

I sort of prefer the original...

The hgsmi_query_conf() function returns negative error codes if it
can't complete the query because of allocation failures.  To me that's
more obvious, when we write it in the original way.

In the new code it looks like it returns bool or something.  The
copy_to/from_user() are normally written like if (copy_to_user()) {
but those don't return negative error codes so it's a different
situation.

This isn't something in checkpatch or CodingStyle so there isn't a
standard.  It's just personal opinion vs personal opinion.  If you were
going to do a lot of vboxvideo development, then it would be your
opinion which matters the most because you are doing the work.  But
this is your first vboxvideo patch...

Let's just leave it as-is.

regards,
dan carpenter


