Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4FCC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 05:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BEC12147C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 05:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfBHFoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 00:44:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42004 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725940AbfBHFoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 00:44:16 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x185ebgO110896
        for <linux-kernel@vger.kernel.org>; Fri, 8 Feb 2019 00:44:15 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qgyr78ub0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 00:44:15 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Fri, 8 Feb 2019 05:44:13 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Feb 2019 05:44:08 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x185i7Nm36044910
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Feb 2019 05:44:07 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A85AAE057;
        Fri,  8 Feb 2019 05:44:07 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17D2BAE04D;
        Fri,  8 Feb 2019 05:44:04 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri,  8 Feb 2019 05:44:03 +0000 (GMT)
Date:   Fri, 8 Feb 2019 11:14:03 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Michael Bringmann <mwb@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Lynch <nathanl@linux.vnet.ibm.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Russell Currey <ruscur@russell.cc>,
        Haren Myneni <haren@us.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Rob Herring <robh@kernel.org>, Juliet Kim <minkim@us.ibm.com>,
        Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Subject: Re: [PATCH v03] powerpc/numa: Perform full re-add of CPU for
 PRRN/VPHN topology update
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <305ed693-ea85-8a70-1d3c-ae405aebc0ad@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <305ed693-ea85-8a70-1d3c-ae405aebc0ad@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 19020805-0020-0000-0000-0000031444D0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020805-0021-0000-0000-0000216551A8
Message-Id: <20190208054403.GA24971@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-08_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902080041
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
>  int arch_update_cpu_topology(void)
>  {
> -	return numa_update_cpu_topology(true);
> +	int changed = topology_changed;
> +
> +	topology_changed = 0;
> +	return changed;
>  }
> 

Do we need Powerpc override for arch_update_cpu_topology() now?  That
topology_changed sometime back doesn't seem to have help. The scheduler
atleast now is neglecting whether the topology changed or not.

Also we can do away with the new topology_changed.

>  static void topology_work_fn(struct work_struct *work)
>  {
> -	rebuild_sched_domains();
> +	lock_device_hotplug();
> +	if (numa_update_cpu_topology(true))
> +		rebuild_sched_domains();
> +	unlock_device_hotplug();
>  }

Should this hunk be a separate patch by itself to say why
rebuild_sched_domains with a changelog that explains why it should be under
lock_device_hotplug? rebuild_sched_domains already takes cpuset_mutex. 
So I am not sure if we need to take device_hotplug_lock.

>  static DECLARE_WORK(topology_work, topology_work_fn);
> 
> -static void topology_schedule_update(void)
> +void topology_schedule_update(void)
>  {
> -	schedule_work(&topology_work);
> +	if (!topology_update_in_progress)
> +		schedule_work(&topology_work);
>  }
> 
>  static void topology_timer_fn(struct timer_list *unused)
>  {
> +	bool sdo = false;

Is sdo any abbrevation?

> +
> +	if (topology_scans < 1)
> +		bitmap_fill(cpumask_bits(&cpu_associativity_changes_mask),
> +			    nr_cpumask_bits);

Why do we need topology_scan? Just to make sure
cpu_associativity_changes_mask is populated only once?
cant we use a static bool inside the function for the same?


> +
>  	if (prrn_enabled && cpumask_weight(&cpu_associativity_changes_mask))
> -		topology_schedule_update();
> -	else if (vphn_enabled) {
> +		sdo =  true;
> +	if (vphn_enabled) {

Any reason to remove the else above?

>  		if (update_cpu_associativity_changes_mask() > 0)
> -			topology_schedule_update();
> +			sdo =  true;
>  		reset_topology_timer();
>  	}
> +	if (sdo)
> +		topology_schedule_update();
> +	topology_scans++;
>  }

Are the above two hunks necessary? Not getting how the current changes are
different from the previous.

-- 
Thanks and Regards
Srikar Dronamraju

