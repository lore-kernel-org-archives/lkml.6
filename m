Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC93DC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2D524048
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LgWaGBSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2D524048
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753987AbeGELrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:47:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37266 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753921AbeGELrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:47:24 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w65Bidki096612;
        Thu, 5 Jul 2018 11:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2017-10-26;
 bh=BIXOHERpaJEyyYNa3f6TWyx9F1E4nb9qNplrZ1hoZ3U=;
 b=LgWaGBSOd3OgU3lGW0kYgWNhwtQFKuLb3LShTnI9IcLXDoow9HlEk7d7b+VnvQjtfwjr
 jD6t42NUB8uBbsJICFj7OPUq6MI4cCP/Gh9ZEHs1Xz0/zumLqNvkDNkjBXvrZq82os4+
 ndAUmV0RJVUKdpgAo/RTsEGIOCVMktqgkLkAhRQavR7GTOMSYgsTxzNbJeJjkuG5tpZi
 B/pDKbqd8PTYB95xeyV8cUAtIUrFh4d6eVt9ArGI6nZ5MPjOfk15gIol5syM2qe1QdH8
 SbrFZ8YNDZABrAiOv56amXoFKWoo2NB8X/vohBuRoLhryGTL0NP+me7qj17hbxBrgEiY Zw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2k0dnjnhgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jul 2018 11:46:16 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w65BkFFa019163
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Jul 2018 11:46:15 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w65BkCtw024147;
        Thu, 5 Jul 2018 11:46:12 GMT
Received: from mwanda (/197.157.34.168)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Jul 2018 04:46:11 -0700
Date:   Thu, 5 Jul 2018 14:46:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tamir Suliman <tsuliman@linuxvaults.com>
Cc:     Justin Skists <justin.skists@juzza.co.uk>, w.d.hubbs@gmail.com,
        gregkh@linuxfoundation.org, speakup@linux-speakup.org,
        devel@driverdev.osuosl.org, dhowells@redhat.com,
        linux-kernel@vger.kernel.org, chris@the-brannons.com
Subject: Re: [PATCH 3/3] drivers/speakup: Fix style and coding warnings
Message-ID: <20180705114600.f27xfsro3yucorrt@mwanda>
References: <1530603080-1353-1-git-send-email-tsuliman@linuxvaults.com>
 <1527895743.93688.1530605455516@email.1and1.co.uk>
 <fb7d3816-255d-15e7-b9ef-533b1167f73c@linuxvaults.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb7d3816-255d-15e7-b9ef-533b1167f73c@linuxvaults.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8944 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=677
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807050138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, Jul 04, 2018 at 10:46:05PM +0300, Tamir Suliman wrote:
> 
> Interesting construct...  Yeah I'm little bit rusty on my C /programming  .
> I understand  proper coding style may be should end with else so I wasn't
> sure .. however this resolved the warnings. :)


The code you wrote was very wrong.

It doesn't compile.  You need to figure out what is wrong with your
testing so that it doesn't happen again.

regards,
dan carpenter

