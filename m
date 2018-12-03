Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E05AC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 06:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25F020848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 06:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E25F020848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbeLCGVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 01:21:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59388 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725812AbeLCGVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 01:21:37 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB36J1B5021605
        for <linux-kernel@vger.kernel.org>; Mon, 3 Dec 2018 01:21:32 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2p4wpa38h1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 01:21:32 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 3 Dec 2018 06:21:30 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 3 Dec 2018 06:21:27 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wB36LQFO35193072
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Dec 2018 06:21:26 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9238411C04A;
        Mon,  3 Dec 2018 06:21:26 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 918A911C052;
        Mon,  3 Dec 2018 06:21:25 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.204.137])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  3 Dec 2018 06:21:25 +0000 (GMT)
Date:   Mon, 3 Dec 2018 08:21:23 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Roman Gushchin <guroan@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v4 7/7] cgroup: document cgroup v2 freezer interface
References: <20181130234745.6756-1-guro@fb.com>
 <20181130234745.6756-8-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130234745.6756-8-guro@fb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18120306-4275-0000-0000-000002EB1F80
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120306-4276-0000-0000-000037F82054
Message-Id: <20181203062123.GE6959@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-03_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812030062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 03:47:45PM -0800, Roman Gushchin wrote:
> Describe cgroup v2 freezer interface in the cgroup v2 admin guide.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-doc@vger.kernel.org
> Cc: kernel-team@fb.com

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  Documentation/admin-guide/cgroup-v2.rst | 27 +++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 07e06136a550..f8335e26b362 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -864,6 +864,8 @@ All cgroup core files are prefixed with "cgroup."
>  	  populated
>  		1 if the cgroup or its descendants contains any live
>  		processes; otherwise, 0.
> +	  frozen
> +		1 if the cgroup is frozen; otherwise, 0.
> 
>    cgroup.max.descendants
>  	A read-write single value files.  The default is "max".
> @@ -897,6 +899,31 @@ All cgroup core files are prefixed with "cgroup."
>  		A dying cgroup can consume system resources not exceeding
>  		limits, which were active at the moment of cgroup deletion.
> 
> +  cgroup.freeze
> +	A read-write single value file which exists on non-root cgroups.
> +	Allowed values are "0" and "1". The default is "0".
> +
> +	Writing "1" to the file causes freezing of the cgroup and all
> +	descendant cgroups. This means that all belonging processes will
> +	be stopped and will not run until the cgroup will be explicitly
> +	unfrozen. Freezing of the cgroup may take some time; when this action
> +	is completed, the "frozen" value in the cgroup.events control file
> +	will be updated to "1" and the corresponding notification will be
> +	issued.
> +
> +	A cgroup can be frozen either by its own settings, or by settings
> +	of any ancestor cgroups. If any of ancestor cgroups is frozen, the
> +	cgroup will remain frozen.
> +
> +	Processes in the frozen cgroup can be killed by a fatal signal.
> +	They also can enter and leave a frozen cgroup: either by an explicit
> +	move by a user, or if freezing of the cgroup races with fork().
> +	If a process is moved to a frozen cgroup, it stops. If a process is
> +	moved out of a frozen cgroup, it becomes running.
> +
> +	Frozen status of a cgroup doesn't affect any cgroup tree operations:
> +	it's possible to delete a frozen (and empty) cgroup, as well as
> +	create new sub-cgroups.
> 
>  Controllers
>  ===========
> -- 
> 2.17.2
> 

-- 
Sincerely yours,
Mike.

