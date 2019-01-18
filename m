Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC30AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A757F20823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfARIjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:39:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41696 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726309AbfARIjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:39:17 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0I8csV4109310
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 03:39:16 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q38a1y3s4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 03:39:16 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Fri, 18 Jan 2019 08:39:14 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 18 Jan 2019 08:39:11 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0I8dAr154067406
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Jan 2019 08:39:11 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B601CAE05F;
        Fri, 18 Jan 2019 08:39:10 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E710AE051;
        Fri, 18 Jan 2019 08:39:10 +0000 (GMT)
Received: from oc3784624756.ibm.com (unknown [9.152.212.171])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Jan 2019 08:39:10 +0000 (GMT)
Subject: Re: [PATCHv2 1/3] perf report: Display s390 diagnostic counter sets
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
References: <20190117093003.96287-1-tmricht@linux.ibm.com>
 <20190117093003.96287-2-tmricht@linux.ibm.com>
 <20190117140053.GJ11922@kernel.org>
From:   Thomas-Mich Richter <tmricht@linux.ibm.com>
Organization: IBM
Date:   Fri, 18 Jan 2019 09:39:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190117140053.GJ11922@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19011808-0012-0000-0000-000002E9AB2D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011808-0013-0000-0000-00002120CA6D
Message-Id: <9c856ac0-ef23-72b5-901d-a1f815508976@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-18_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901180066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/17/2019 03:00 PM, Arnaldo Carvalho de Melo wrote:
> erf report: Display arch specific diagnostic counter sets, starting with s390
>     
>     On s390 the event bc000 (also named CF_DIAG) extracts the CPU
>     Measurement Facility diagnostic counter sets and displays them as
>     counter number and counter value pairs sorted by counter set number.
>     
>     Output:
>      [root@s35lp76 perf]# ./perf report -D --stdio
>     
>      [00000000] Counterset:0 Counters:6
>        Counter:000 Value:0x000000000085ec36 Counter:001 Value:0x0000000000796c94
>        Counter:002 Value:0x0000000000005ada Counter:003 Value:0x0000000000092460
>        Counter:004 Value:0x0000000000006073 Counter:005 Value:0x00000000001a9a73
>      [0x000038] Counterset:1 Counters:2
>        Counter:000 Value:0x000000000007c59f Counter:001 Value:0x000000000002fad6
>      [0x000050] Counterset:2 Counters:16
>        Counter:000 Value:000000000000000000 Counter:001 Value:000000000000000000
>        Counter:002 Value:000000000000000000 Counter:003 Value:000000000000000000
>        Counter:004 Value:000000000000000000 Counter:005 Value:000000000000000000
>        Counter:006 Value:000000000000000000 Counter:007 Value:000000000000000000
>        Counter:008 Value:000000000000000000 Counter:009 Value:000000000000000000
>        Counter:010 Value:000000000000000000 Counter:011 Value:000000000000000000
>        Counter:012 Value:000000000000000000 Counter:013 Value:000000000000000000
>        Counter:014 Value:000000000000000000 Counter:015 Value:000000000000000000
>      [0x0000d8] Counterset:3 Counters:128
>        Counter:000 Value:0x000000000000020f Counter:001 Value:0x00000000000001d8
>        Counter:002 Value:0x000000000000d7fa Counter:003 Value:0x000000000000008b
>        ...
>     
>     The number in brackets is the offset into the raw data field of the
>     sample.
>     
>     New functions trace_event_sample_raw__init() and s390_sample_raw() are
>     introduced in the code path to enable interpretation on non s390
>     platforms. This event bc000 attached raw data is generated only on s390
>     platform. Correct display on other platforms requires correct endianness
>     handling.
>     
>     Committer notes:
>     
>     Added a init function that sets up a evlist function pointer to avoid
>     repeated tests on evlist->env and calls to perf_env__name() that
>     involves normalizing, etc, for each PERF_RECORD_SAMPLE.
>     
>     Removed needless __maybe_unused from the trace_event_raw()
>     prototype in session.h, move it to be an static function in evlist.
>     
>     Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>

I have applied your changed patch. Works great. Thanks a lot.

Tested-by: Thomas Richter <tmricht@linux.ibm.com>

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

