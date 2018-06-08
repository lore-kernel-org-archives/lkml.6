Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id fcxOFEztGlseDQAAmS7hNA
	; Fri, 08 Jun 2018 20:55:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2E61F607DC; Fri,  8 Jun 2018 20:55:53 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="aON96YC3"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8F446601B4;
	Fri,  8 Jun 2018 20:55:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8F446601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753051AbeFHUzu (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 16:55:50 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:58146 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752910AbeFHUzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 16:55:49 -0400
Received: from pps.filterd (m0122333.ppops.net [127.0.0.1])
        by mx0a-00190b01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w58KlflU029388;
        Fri, 8 Jun 2018 21:55:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=36ynMn/ar2uXtK+DL42esEmk6UobHIMVITpqwWLDAcw=;
 b=aON96YC3Z4NtqtvMfDfWb9+Fmbnb2/5flS1Vt/K9+yM1Ud2Dc3kCCnNMjU8hqNWlu9FQ
 BmoByt+H98SLWBgr0M7jE7gfLMQT/v7YQtV0E5m8t9+tr4MCzFwrXNYEy8YGDG9wotyd
 g4rkXC+vKYT4dy+64PB5Z97SB6ec5dDpeuUTrZeLC83JFezbw/R2gHiRn20CK56bBnSD
 CyD7KnoPAO7jveeNLr0DXCcVQWaYOSQLZGpG8rywoGEimjmYvbPBy9mvqbHAFoC1AkCP
 lRuGN92sPyV/U5OtEGhWQBhZ5gH+YnIEFYqL3GZgkp2bjgzPp0Ki4/aYm7O69TVGz2ns vg==
Received: from prod-mail-ppoint4 (a96-6-114-87.deploy.static.akamaitechnologies.com [96.6.114.87] (may be forged))
        by mx0a-00190b01.pphosted.com with ESMTP id 2jeyggpjak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Jun 2018 21:55:34 +0100
Received: from pps.filterd (prod-mail-ppoint4.akamai.com [127.0.0.1])
        by prod-mail-ppoint4.akamai.com (8.16.0.21/8.16.0.21) with SMTP id w58KkRnA003194;
        Fri, 8 Jun 2018 16:55:30 -0400
Received: from prod-mail-relay14.akamai.com ([172.27.17.39])
        by prod-mail-ppoint4.akamai.com with ESMTP id 2jbpjwcjbq-1;
        Fri, 08 Jun 2018 16:55:30 -0400
Received: from [172.28.13.175] (bos-lpjec.kendall.corp.akamai.com [172.28.13.175])
        by prod-mail-relay14.akamai.com (Postfix) with ESMTP id D611880FAE;
        Fri,  8 Jun 2018 20:55:29 +0000 (GMT)
Subject: Re: [PATCH] mm/madvise: allow MADV_DONTNEED to free memory that is
 MLOCK_ONFAULT
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <1528484212-7199-1-git-send-email-jbaron@akamai.com>
 <20180608125717.c34d3e7125c62fc91ac427c8@linux-foundation.org>
From: Jason Baron <jbaron@akamai.com>
Message-ID: <ce5c6352-3f35-f02b-5e1b-b22649b15e12@akamai.com>
Date: Fri, 8 Jun 2018 16:55:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180608125717.c34d3e7125c62fc91ac427c8@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-08_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806080225
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-08_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1805220000
 definitions=main-1806080225
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2018 03:57 PM, Andrew Morton wrote:
> On Fri,  8 Jun 2018 14:56:52 -0400 Jason Baron <jbaron@akamai.com> wrote:
> 
>> In order to free memory that is marked MLOCK_ONFAULT, the memory region
>> needs to be first unlocked, before calling MADV_DONTNEED. And if the region
>> is to be reused as MLOCK_ONFAULT, we require another call to mlock2() with
>> the MLOCK_ONFAULT flag.
>>
>> Let's simplify freeing memory that is set MLOCK_ONFAULT, by allowing
>> MADV_DONTNEED to work directly for memory that is set MLOCK_ONFAULT. The
>> locked memory limits, tracked by mm->locked_vm do not need to be adjusted
>> in this case, since they were charged to the entire region when
>> MLOCK_ONFAULT was initially set.
> 
> Seems useful.
> 
> Is a manpage update planned?
> 

Yes, I will add a manpage update. I sort of wanted to see first if
people thought this patch was a reasonable thing to do.

> Various updates to tools/testing/selftests/vm/* seem appropriate.
> 

Indeed, I started updating tootls/testing/selftests/vm/mlock2-tests.c
with this new interface, but then I realized that that test is failing
before I made any changes. So I will go back and sort that out, and add
additional testing for this new interface.

>> Further, I don't think allowing MADV_FREE for MLOCK_ONFAULT regions makes
>> sense, since the point of MLOCK_ONFAULT is for userspace to know when pages
>> are locked in memory and thus to know when page faults will occur.
> 
> This sounds non-backward-compatible?
> 

I was making the point of why I think allowing 'MADV_DONTNEED' for
MLOCK_ONFAULT regions makes sense, while allowing 'MADV_FREE' for
MLOCK_ONFAULT regions really does not.

Thanks,

-Jason
