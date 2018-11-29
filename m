Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713A0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37BE420863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a0evLdla"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37BE420863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbeK3A5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 19:57:04 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:57498 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbeK3A5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 19:57:04 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wATDnTZn194140;
        Thu, 29 Nov 2018 13:51:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=lZIasuT6Y6xpvBsQWZEcTUxxsQfR5vQV9qb6Ra4P6Es=;
 b=a0evLdlazr4iLg2S5BaeRdPQm77yxEolv4LlyfscmKPMsmEc4IUW+76imUBGB+py7M3t
 tNflNQb3zJruWz0DAmTI6AlDuoGBRl1adQdvP+S0QazgnBxruo3lmccJzFVNeemWtNT8
 Tiu/j7CR3YGzlf18d6mZb7FHAFB5VRkQpQgubnf8QkzLh7bmdSuCF6VllcZ7XqUumfM8
 GUZ1azMxn1KHn+Fa3CcQx/n/kvu68bQVayaJw/i8LTI4kAPCLaMV+YPog7FLMAW4TgRO
 Y3vi7Kr4OcOqQASnx85U9sP/hnUWRFHJ/yYVmGZwC2eQreeoBOnApwgrcwYUZp4DDPxj Yg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2nxy9rg7ve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 13:51:34 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wATDpX85030498
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 13:51:33 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wATDpWnt031913;
        Thu, 29 Nov 2018 13:51:32 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Nov 2018 05:51:32 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] hugetlbfs: Call VM_BUG_ON_PAGE earlier in free_huge_page
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <1543491843-23438-1-git-send-email-nic_w@163.com>
Date:   Thu, 29 Nov 2018 06:51:28 -0700
Cc:     mike.kravetz@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, nic_w@163.com
Content-Transfer-Encoding: 7bit
Message-Id: <0B408D50-D101-4457-B779-5951DEE0435A@oracle.com>
References: <1543491843-23438-1-git-send-email-nic_w@163.com>
To:     Yongkai Wu <nic.wuyk@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9091 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811290117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: William Kucharski <william.kucharski@oracle.com>

> On Nov 29, 2018, at 4:44 AM, Yongkai Wu <nic.wuyk@gmail.com> wrote:
> 
> A stack trace was triggered by VM_BUG_ON_PAGE(page_mapcount(page),
> page) in free_huge_page().  Unfortunately, the page->mapping field
> was set to NULL before this test.  This made it more difficult to
> determine the root cause of the problem.
> 
> Move the VM_BUG_ON_PAGE tests earlier in the function so that if
> they do trigger more information is present in the page struct.
> 
> Signed-off-by: Yongkai Wu <nic_w@163.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
> mm/hugetlb.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 7f2a28a..14ef274 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1248,10 +1248,11 @@ void free_huge_page(struct page *page)
> 		(struct hugepage_subpool *)page_private(page);
> 	bool restore_reserve;
> 
> -	set_page_private(page, 0);
> -	page->mapping = NULL;
> 	VM_BUG_ON_PAGE(page_count(page), page);
> 	VM_BUG_ON_PAGE(page_mapcount(page), page);
> +
> +	set_page_private(page, 0);
> +	page->mapping = NULL;
> 	restore_reserve = PagePrivate(page);
> 	ClearPagePrivate(page);
> 
> -- 
> 1.8.3.1
> 

