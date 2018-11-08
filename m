Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7356EECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3180D2081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f7DRy3gQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3180D2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbeKIEzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 23:55:55 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46410 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbeKIEzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 23:55:55 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA8JE0lm067532;
        Thu, 8 Nov 2018 19:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=FDjiVo5UWwpIKNWN8FkL/M9sKk0X+TB9jfE/jV+H5Hc=;
 b=f7DRy3gQ+355gAswnzW3UU/8Ki63Cqb2FAgj5k9oFWic1a4gKwjIbElQug1v0BX5+OfF
 RdIzvxdd4e7EWrWMiYoCiMixTg4DncUSijEGFm7S9Lxf94B4S/cIlopq1hhXCyAdC9JY
 +5rBZgvnMsIlzIrfgIljNRJ3u2TPrGw/Q/OvtOy7ZACJl/MtjT2/+V51NbbjDn5GLgBQ
 ZHRZkhkdXkTBOLtRU7fLNxQ8YLCahN/00qJJNqjIV130Rn2bimlqPXwerUNZhrcUhnX8
 8EZrzCKVDdWmf6F9vAPKgUF11nzOXT3Go+Rnl7zOIt7X/htzMjcaNQCDP0OyA1hbKJbT 6w== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2nh4ar39ee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Nov 2018 19:18:30 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA8JIP4o030271
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Nov 2018 19:18:25 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wA8JINId028584;
        Thu, 8 Nov 2018 19:18:23 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 08 Nov 2018 11:15:45 -0800
Date:   Thu, 8 Nov 2018 11:15:53 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>, linux-mm@kvack.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        aarcange@redhat.com, aaron.lu@intel.com, akpm@linux-foundation.org,
        alex.williamson@redhat.com, bsd@redhat.com,
        darrick.wong@oracle.com, dave.hansen@linux.intel.com,
        jgg@mellanox.com, jwadams@google.com, jiangshanlai@gmail.com,
        mhocko@kernel.org, mike.kravetz@oracle.com,
        Pavel.Tatashin@microsoft.com, prasad.singamsetty@oracle.com,
        rdunlap@infradead.org, steven.sistare@oracle.com,
        tim.c.chen@intel.com, tj@kernel.org, vbabka@suse.cz,
        peterz@infradead.org, dhaval.giani@oracle.com
Subject: Re: [RFC PATCH v4 01/13] ktask: add documentation
Message-ID: <20181108191553.nu7yn2akmcql2vje@ca-dmjordan1.us.oracle.com>
References: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
 <20181105165558.11698-2-daniel.m.jordan@oracle.com>
 <20181108102638.3415ae0b@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108102638.3415ae0b@lwn.net>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9071 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=932
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811080162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 10:26:38AM -0700, Jonathan Corbet wrote:
> On Mon,  5 Nov 2018 11:55:46 -0500
> Daniel Jordan <daniel.m.jordan@oracle.com> wrote:
> 
> > Motivates and explains the ktask API for kernel clients.
> 
> A couple of quick thoughts:
> 
> - Agree with Peter on the use of "task"; something like "job" would be far
>   less likely to create confusion.  Maybe you could even call it a "batch
>   job" to give us old-timers warm fuzzies...:)

smp_job?  Or smp_batch, for that retro flavor?  :)

> 
> - You have kerneldoc comments for the API functions, but you don't pull
>   those into the documentation itself.  Adding some kernel-doc directives
>   could help to fill things out nicely with little effort.

I thought this part of ktask.rst handled that, or am I not doing it right?

    Interface
    =========
    
    .. kernel-doc:: include/linux/ktask.h

Thanks for the comments,
Daniel
