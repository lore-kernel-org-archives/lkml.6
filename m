Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F54DC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2200D23C51
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E0lcCLd7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2200D23C51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753907AbeGEL5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:57:09 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:47058 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753698AbeGEL5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:57:08 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w65BrwjT130219;
        Thu, 5 Jul 2018 11:56:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=ZOJb1bz59cH1Ma8yhSxIH79FO36kisqb2f0MyQkFJwg=;
 b=E0lcCLd7StqECb8PKgKIsnQWrlIhGhAyv6B0FqAju9Z1Y7QZkhxB732dI4NfApM7j5Ji
 Zib4ocKSmJXjE+wyRhQ4RO+m2WO8/QlwxlUjRjGOA8bQmWiEQJrVlLmfy0Bm38EfCmaR
 fO7aKnXTT2GYakh5rVGKEQ/Po1tTfD1/9TCkLDnNB/i6/+96LajMsxhBThH920k5EhLA
 +Nqjue5YfgshU7Hmqf3tRybwHjeKTZa4/XIYuXMB0Mu9L7js6YQuxcgXR22MsuvwSjoZ
 lXovnIHl1X3rkY9uFNfu2p2WKSz6xgy6NofDpcI79/6vH26wLGd5ih2xIEkTBCurdbMy 6g== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2k0dnjdj4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jul 2018 11:56:02 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w65Bu1gC005834
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Jul 2018 11:56:01 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w65Bu0ef000414;
        Thu, 5 Jul 2018 11:56:00 GMT
Received: from mwanda (/197.157.34.168)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Jul 2018 04:56:00 -0700
Date:   Thu, 5 Jul 2018 14:55:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Justin Skists <justin.skists@juzza.co.uk>
Cc:     w.d.hubbs@gmail.com, gregkh@linuxfoundation.org,
        speakup@linux-speakup.org,
        Tamir Suliman <tsuliman@linuxvaults.com>,
        devel@driverdev.osuosl.org, dhowells@redhat.com,
        linux-kernel@vger.kernel.org, chris@the-brannons.com
Subject: Re: [PATCH 3/3] drivers/speakup: Fix style and coding warnings
Message-ID: <20180705115549.wifgpi5qe6dfkcoj@mwanda>
References: <1530603080-1353-1-git-send-email-tsuliman@linuxvaults.com>
 <1527895743.93688.1530605455516@email.1and1.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527895743.93688.1530605455516@email.1and1.co.uk>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8944 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=625
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807050140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 09:10:55AM +0100, Justin Skists wrote:
> > @@ -787,7 +787,7 @@ static ssize_t message_store_helper(const char *buf, size_t count,
> >  			continue;
> >  		}
> >  
> > -		index = simple_strtoul(cp, &temp, 10);
> > +		index = simple_ktrtoul(cp, &temp, 10);
> 
> Did you compile this?

Try to avoid rhetorical questions.  Just say "This doesn't compile.  Be
more careful."

regards,
dan carpenter
