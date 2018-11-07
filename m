Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B1EC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0437720862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fbIL4G2K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0437720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeKHHlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 02:41:08 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35046 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbeKHHlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 02:41:07 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA7M483t060910;
        Wed, 7 Nov 2018 22:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=o7MXF7SJcrGL2SsNB+CG3fWVQmgawRKvWhfaxdjq4DI=;
 b=fbIL4G2Kh3SwPraFrPIzUwUo02qfEMRiT5fCOuE1OKiHChLHzolnsdwB0u/diX4FKQ4s
 INhAU7NOUtsuu1j2wj2Y9ytYTfStYWMh+BWSoBj0qWdzP12cA2vkTt/6wKbmsLMM1/ET
 9YI0aTDSzYfMG4CiUEU0TY+YEFRUm5144eHKNtkjle3UGrtHLCIYXYEagjZeURoJVXV9
 dSM14c620+7tqyMrRCNo/D9Y2aZy5+lAnvJzRDG+nD5wBZhVa/XrBZngxj91MG8w/NQ7
 JF2G4/D7OpTnnftAXl/Ka92GAsrbMJ+ToNkAiUVt8QS8RzzTPnjyN0WjbVcThwjA3U1u nQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2nh4aqx4yh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Nov 2018 22:08:41 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wA7M8eJL001241
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Nov 2018 22:08:40 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wA7M8eSP032015;
        Wed, 7 Nov 2018 22:08:40 GMT
Received: from [10.175.44.41] (/10.175.44.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Nov 2018 14:08:39 -0800
Subject: Re: [PATCH] cpuset: remove set but not used variable 'cs'
To:     Yi Wang <wang.yi59@zte.com.cn>, lizefan@huawei.com
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn
References: <1541575111-36000-1-git-send-email-wang.yi59@zte.com.cn>
From:   Tom Hromatka <tom.hromatka@oracle.com>
Organization: Oracle Corporation
Message-ID: <7ac28cbe-56ec-3564-15fd-94acb4687150@oracle.com>
Date:   Wed, 7 Nov 2018 15:08:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1541575111-36000-1-git-send-email-wang.yi59@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9070 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811070195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2018 12:18 AM, Yi Wang wrote:
> This fixes the following warning:
> kernel/cgroup/cpuset.c: In function ‘cpuset_cancel_attach’:
> kernel/cgroup/cpuset.c:1501:17: warning: variable ‘cs’ set but not used [-Wunused-but-set-variable]
>    struct cpuset *cs;
>                   ^
> 
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>


Reviewed-by: Tom Hromatka <tom.hromatka@oracle.com>


> ---
>   kernel/cgroup/cpuset.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 266f10c..784f948 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1498,10 +1498,8 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>   static void cpuset_cancel_attach(struct cgroup_taskset *tset)
>   {
>   	struct cgroup_subsys_state *css;
> -	struct cpuset *cs;
>   
>   	cgroup_taskset_first(tset, &css);
> -	cs = css_cs(css);
>   
>   	mutex_lock(&cpuset_mutex);
>   	css_cs(css)->attach_in_progress--;
> 

