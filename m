Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384A0C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1FD2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gV7AZQPn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB1FD2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbeJaEVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 00:21:08 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42990 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbeJaEVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 00:21:08 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9UJNl8G021571;
        Tue, 30 Oct 2018 19:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=vzzwzr0AxUnmRHtuPf7bFwmZFmSgmiOqnXc+w9midns=;
 b=gV7AZQPne5hK/Mb84s5D7wCUIwn6meL57t/v92Vg30VGXkDy7y1lzU+G60Ik1ZYKHNhd
 FzU2Mfb0rzGEHs1Zx3hbkuucPMyndkekwMO6U4dvBFmx6EN7/dOJUUvG7Vt78MQM1jGk
 ExmQZ+1lhPyFz6EKDbHDi6HCg30BETTctewJNzz82Eq8bS6LEVzluKUEXc9Jm7r9wjxM
 Y2MmUIg2YB9wHhYwK9ivA/04MvucYJT3hBB9BLEgEFELDUNJck90WXkpT19sK5nhbrIS
 WiE4W7rLdM9rP5P1edatD578DRCeqbl4wKkZ1EEKyPX25201gvffAeRNY0v8BIQ0RFuQ nw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2nducm394w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Oct 2018 19:25:58 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9UJPqaW030130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Oct 2018 19:25:52 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9UJPpeG019841;
        Tue, 30 Oct 2018 19:25:51 GMT
Received: from mwanda (/129.205.6.86)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Oct 2018 12:25:50 -0700
Date:   Tue, 30 Oct 2018 22:25:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Colin King <colin.king@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/core: clean up inconsisent indentation
Message-ID: <20181030192531.2ormldhqj2qizy33@mwanda>
References: <20181029233211.21475-1-colin.king@canonical.com>
 <20181030144444.GB23310@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030144444.GB23310@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9062 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=620
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810300163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 11:44:44AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Oct 29, 2018 at 11:32:11PM +0000, Colin King escreveu:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > Replace a bunch of spaces with tab, cleans up indentation
> 
> I think we can live with the spaces as the 'git blame' information is
> more valuable, i.e. who was that touched that line last?
> 

You can use "git blame -w" to ignore white space changes.  I add it
whenever I run blame.

regards,
dan carpenter

