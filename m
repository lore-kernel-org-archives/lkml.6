Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753079AbeCNIe6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 04:34:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55596 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751131AbeCNIez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 04:34:55 -0400
Subject: Re: [PATCH] perf stat: Add support for s390 transaction counters
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
References: <20180312103807.45069-1-tmricht@linux.vnet.ibm.com>
 <87tvtk64ld.fsf@linux.intel.com>
From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Organization: IBM LTC
Date: Wed, 14 Mar 2018 09:34:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87tvtk64ld.fsf@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18031408-0012-0000-0000-000005BE4260
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031408-0013-0000-0000-0000193A4429
Message-Id: <f7240f60-2a1d-58f9-8d6f-05d27557620a@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-14_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803140101
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/13/2018 04:23 AM, Andi Kleen wrote:
> Thomas Richter <tmricht@linux.vnet.ibm.com> writes:
> 
>> Right now there is only hard coded support for x86.
> 
> That's not true. There is support for generic transaction events in perf.
> 
> As far as I can tell your events would map 1:1 to the generic tx-* events.
> 
> -Andi
> 

I might be wrong, but when I look at function add_default_attributes()
in file buildin-stat.c the string variables transaction_attrs
and transaction_limited_attrs are used when flag T is specified on command line:

/* Default events used for perf stat -T */
static const char *transaction_attrs = {
        "task-clock,"
        "{"
        "instructions,"
        "cycles,"
        "cpu/cycles-t/,"
        "cpu/tx-start/,"
        "cpu/el-start/,"
        "cpu/cycles-ct/"
        "}"
};

These PMU events show up on my x86 notebook but no on the s390.
That's why I came to this conclusion. I have not tried other architectures.
-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
