Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id gHgrEB4eHlvTNwAAmS7hNA
	; Mon, 11 Jun 2018 07:01:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 310B4607E7; Mon, 11 Jun 2018 07:01:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B3D6A601D2;
	Mon, 11 Jun 2018 07:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B3D6A601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754062AbeFKHBD (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 03:01:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50126 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753950AbeFKHBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 03:01:01 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5B6xRTD045562
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 03:01:00 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jhekbjfqc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 03:01:00 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Mon, 11 Jun 2018 08:00:58 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 11 Jun 2018 08:00:55 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5B70sxH28770536
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Jun 2018 07:00:54 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C08D2AE061;
        Mon, 11 Jun 2018 07:49:46 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A319AE057;
        Mon, 11 Jun 2018 07:49:46 +0100 (BST)
Received: from oc3784624756.ibm.com (unknown [9.152.212.222])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 11 Jun 2018 07:49:46 +0100 (BST)
Subject: Re: [PATCH] perf test: Test 6 dumps core on s390
To: Kim Phillips <kim.phillips@arm.com>, Jiri Olsa <jolsa@redhat.com>,
        acme@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
References: <20180608131728.75084-1-tmricht@linux.ibm.com>
 <20180608095318.2ba14669fdc5da2004285bcf@arm.com>
From: Thomas-Mich Richter <tmricht@linux.ibm.com>
Organization: IBM LTC
Date: Mon, 11 Jun 2018 09:00:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180608095318.2ba14669fdc5da2004285bcf@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18061107-0012-0000-0000-0000027DFD64
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061107-0013-0000-0000-000020AF0BF6
Message-Id: <0d25bc25-ed0b-81bb-c516-12fd25442427@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-11_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806110085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2018 04:53 PM, Kim Phillips wrote:
> On Fri, 8 Jun 2018 15:17:28 +0200
> Thomas Richter <tmricht@linux.ibm.com> wrote:
> 
>> Perf test case 6 "Parse event definition strings"
>> dumps core when executed on s390.
> 
> I reported it actually fails on any $ARCH system without
> Intel Processor Trace (PT) h/w:
> 
> https://www.spinics.net/lists/linux-perf-users/msg06020.html
> 
> There was a follow-up patch sent here:
> 
> https://www.spinics.net/lists/linux-perf-users/msg06029.html
> 
> which worked for me, but I don't know what has/has-not transpired
> since, other than it is still broken, as you found.
> 
> Kim


Looks like this is still broken. I also can not find this patch on
git clone -b perf/core git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux

We actually need 2 patches
- one to fix the core dump
- one to test for x86 platform


-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
