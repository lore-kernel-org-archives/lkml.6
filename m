Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481B2C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F4862087A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Le17VEhE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F4862087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389843AbeKQADg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 19:03:36 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48530 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbeKQADg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 19:03:36 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAGDmb3G042281;
        Fri, 16 Nov 2018 13:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=ekcpQhPY+IZsmGw9U7W3VSOe29bQkFw6fyKf+LGLBWE=;
 b=Le17VEhE8gju+nUkjKkNC7et2frtnW96OsGWRPmK0bOoYlbUrkYe+InphxlZBd9fbTdw
 bctR4wkF4iwiyZnO3fuKvMLPRvTxwODxQw7sLPkxYeaXHDyi7FMcOkSA/L073mUrNcaF
 lC1EU1Eof92AFraH7Wbng4it0qY7EEufQSSNCiPjnp0F2ZBq/2kAVyoeG6sNtBPYNOb+
 xoNtYxjZskipsZujd2Cr/aigFIy3R++HD119GyYuPKjt1qQl5umuGG7sU8kPORMkYuyJ
 K9psIAYmpNBp4BmWXtkuA8CmTlNPYOgdFpb73IMRXJg+fwE/VapeyZULesbC9+4vIHtP hA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2nr7csfb0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Nov 2018 13:50:55 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAGDorAg012642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Nov 2018 13:50:54 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAGDorpp028839;
        Fri, 16 Nov 2018 13:50:53 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 16 Nov 2018 05:50:52 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 1/5] mm: print more information about mapping in
 __dump_page
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20181116083020.20260-2-mhocko@kernel.org>
Date:   Fri, 16 Nov 2018 06:50:52 -0700
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <OSalvador@suse.com>,
        Baoquan He <bhe@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Content-Transfer-Encoding: 7bit
Message-Id: <F51AB111-E394-4F67-A5DD-2E7D854086DC@oracle.com>
References: <20181116083020.20260-1-mhocko@kernel.org>
 <20181116083020.20260-2-mhocko@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9078 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=695
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811160123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 16, 2018, at 1:30 AM, Michal Hocko <mhocko@kernel.org> wrote:
> 
> From: Michal Hocko <mhocko@suse.com>
> 
> __dump_page prints the mapping pointer but that is quite unhelpful
> for many reports because the pointer itself only helps to distinguish
> anon/ksm mappings from other ones (because of lowest bits
> set). Sometimes it would be much more helpful to know what kind of
> mapping that is actually and if we know this is a file mapping then also
> try to resolve the dentry name.

I really, really like this - the more information available in the dump
output, the easier it is to know where to start looking for the problem.

Reviewed-by: William Kucharski <william.kucharski@oracle.com>
