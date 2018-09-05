Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8DAC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C90120857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:50:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C90120857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbeIENTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:19:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53814 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726401AbeIENTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:19:46 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w858hfdE137712
        for <linux-kernel@vger.kernel.org>; Wed, 5 Sep 2018 04:50:34 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2maa0mwafr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 04:50:34 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Wed, 5 Sep 2018 09:50:33 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 5 Sep 2018 09:50:31 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w858oUkW43647068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Sep 2018 08:50:30 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D3D9A405D;
        Wed,  5 Sep 2018 11:50:23 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83336A4057;
        Wed,  5 Sep 2018 11:50:22 +0100 (BST)
Received: from linux.vnet.ibm.com (unknown [9.40.192.68])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed,  5 Sep 2018 11:50:22 +0100 (BST)
Date:   Wed, 5 Sep 2018 01:50:29 -0700
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 3/4] sched/topology: remove smt_gain
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1535548752-4434-1-git-send-email-vincent.guittot@linaro.org>
 <1535548752-4434-4-git-send-email-vincent.guittot@linaro.org>
 <20180904082424.GA2090@linux.vnet.ibm.com>
 <20180904093626.GA23936@linaro.org>
 <20180904103742.GC61288@linux.vnet.ibm.com>
 <CAKfTPtBVLWgtRJpP0nTOVpkwJse6BwrGa28o4qat0T3kOvEAfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAKfTPtBVLWgtRJpP0nTOVpkwJse6BwrGa28o4qat0T3kOvEAfw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18090508-0008-0000-0000-0000026C8535
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090508-0009-0000-0000-000021D4A0A5
Message-Id: <20180905085029.GA57420@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-05_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=745 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809050094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vincent Guittot <vincent.guittot@linaro.org> [2018-09-05 09:36:42]:

> >
> > I dont know of any systems that have come with single threaded and
> > multithreaded. However some user can still offline few threads in a core
> > while leaving other cores untouched. I dont really know why somebody
> > would want to do it.  For example, some customer was toying with SMT 3
> > mode in a SMT 8 power8 box.
> 
> In this case, it means that we have the same core capacity whatever
> the number of CPUs
> and a core with SMT 3 will be set with the same compute capacity as
> the core with SMT 8.
> Does it still make sense ?
> 

To me it make sense atleast from  a power 8 perspective, because SMT 1 >
SMT 2 > SMT 4 > SMT8. So if one core is configured for SMT 2 and other
core is configured for SMT4; all threads being busy, the  individual
threads running on SMT2 core will complete more work than SMT 4 core
threads.

-- 
Thanks and Regards
Srikar Dronamraju

