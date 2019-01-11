Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B5FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 04:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A312146F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 04:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3p+YzvoL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730745AbfAKEZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 23:25:46 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:45140 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728178AbfAKEZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 23:25:46 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0B4JSSD132505;
        Fri, 11 Jan 2019 04:25:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=IY8sLSOYgVx/ehspVdffeUJz5kK176BpWKLb7Gb8WK8=;
 b=3p+YzvoL0kYZ22VTCKAtzcOvPcCWa1AF8i6o/mKy3lCv9jJw8TRok8KZ3siyhfk6VO69
 rZX4InWXE4q/UvHY/+cqufalksSgkds64+vzPvNcbXHTtztupezvSNWc1vBpjUm+MFiH
 voZ/DNHbMq2dVsf4Gio22jF+Ay8e9FDvVehLWjn9eZlDaeleofJhBtgfUx9aSqgoFDyh
 BddQ+Piu2dzsswkn2uznkFzBkpZJ99thwsAyXWEHrAscUkftiQPZhs/Rs2GROUEHrYSs
 Ipni5h/slAQfai06eDDwNGEAkwrFmuAEQW512K3EdqLSSfosnJGA+iZV5nyBBtDLMoDQ fA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2ptm0ujt7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jan 2019 04:25:13 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0B4PCE8022556
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jan 2019 04:25:13 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0B4PBwc029642;
        Fri, 11 Jan 2019 04:25:12 GMT
Received: from [10.39.212.228] (/10.39.212.228)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Jan 2019 20:25:11 -0800
Subject: Re: [PATCH 3/3] bitops.h: set_mask_bits() to return old value
To:     Vineet Gupta <vineet.gupta1@synopsys.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-snps-arc@lists.infradead.org, linux-mm@kvack.org,
        peterz@infradead.org, Miklos Szeredi <mszeredi@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>
References: <1547166387-19785-1-git-send-email-vgupta@synopsys.com>
 <1547166387-19785-4-git-send-email-vgupta@synopsys.com>
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
Organization: Oracle Corporation
Message-ID: <693b30a9-96dc-a5e6-9708-c215b90146b0@oracle.com>
Date:   Thu, 10 Jan 2019 20:25:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1547166387-19785-4-git-send-email-vgupta@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9132 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901110035
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/10/19 4:26 PM, Vineet Gupta wrote:
> | > Also, set_mask_bits is used in fs quite a bit and we can possibly come up
> | > with a generic llsc based implementation (w/o the cmpxchg loop)
> |
> | May I also suggest changing the return value of set_mask_bits() to old.
> |
> | You can compute the new value given old, but you cannot compute the old
> | value given new, therefore old is the better return value. Also, no
> | current user seems to use the return value, so changing it is without
> | risk.
>
> Link: http://lkml.kernel.org/g/20150807110955.GH16853@twins.programming.kicks-ass.net
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
>

Reviewed-by: Anthony Yznaga <anthony.yznaga@oracle.com>
