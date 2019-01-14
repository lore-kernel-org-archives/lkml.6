Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB74C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148622086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfANMNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 07:13:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58222 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726467AbfANMNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 07:13:36 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0EC0Rxi041069
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 07:13:35 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q0psks2h4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 07:13:35 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Mon, 14 Jan 2019 12:13:33 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 14 Jan 2019 12:13:32 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0ECDV047340364
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jan 2019 12:13:31 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38F82A405B;
        Mon, 14 Jan 2019 12:13:31 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF96FA405C;
        Mon, 14 Jan 2019 12:13:30 +0000 (GMT)
Received: from oc3784624756.ibm.com (unknown [9.152.212.171])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Jan 2019 12:13:30 +0000 (GMT)
Subject: Re: [Patch 1/4] perf report: Add function for verbose dump of raw
 data
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
References: <20190111115259.99438-1-tmricht@linux.ibm.com>
 <20190111140059.GV22483@kernel.org>
From:   Thomas-Mich Richter <tmricht@linux.ibm.com>
Organization: IBM
Date:   Mon, 14 Jan 2019 13:13:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190111140059.GV22483@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19011412-0020-0000-0000-000003063F9E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011412-0021-0000-0000-0000215750B6
Message-Id: <9938997a-c00b-8331-cbd9-e0c778d83b92@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901140099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2019 03:00 PM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jan 11, 2019 at 12:52:56PM +0100, Thomas Richter escreveu:
>> Add support to call an architecture dependend function to interpret
>> raw data verbatim when dumping the perf.data file with
>> option -D.
> 
> Please add "per-arch" to the summary, so that just by looking at my
> inbox main page I can see what this is about.
> 

Will do.

> Also how this will deal with processing a perf.data file generated on a
> S/390 machine in another arch? I.e.
> 
> on s/390:
> 
> perf record -a sleep 10
> 
> on a x86_64:
> 
> scp that file
> perf report -i perf.data.from.s390
> 
> ?
> 

This is then the raw data in byte format, as in 
   [root@f29 perf]# ./perf report -D \
                 -i ~/perf-s390-ctrset/perf.data.s390.ctrset
....
0x750 [0x6e8]: event: 9
.
. ... raw event: size 1768 bytes
.  0000:  09 00 00 00 01 00 e8 06 1d 00 00 00 00 00 00 00  ................
.  0010:  00 00 00 00 00 00 00 00 34 82 00 00 34 82 00 00  ........4...4...
.  0020:  04 a3 d3 1e c4 01 00 00 00 00 00 00 00 00 00 00  ................
.  0030:  a0 0f 00 00 00 00 00 00 00 00 06 ac fe ef 00 00  ................
.  0040:  00 06 00 00 00 00 00 00 01 6c c8 ad 00 00 00 00  .........l......
.  0050:  00 d2 cf a5 00 00 00 00 00 00 39 93 00 00 00 00  ..........9.....
.  0060:  00 04 0c df 00 00 00 00 00 00 2c 97 00 00 00 00  ..........,.....
.  0070:  00 08 82 01 fe ef 00 01 00 02 00 00 00 00 00 00  ................
.  06b0:  00 00 14 58 d5 80 20 9a 29 34 a5 53 d5 80 20 9a  ...X.. .)4.S.. .
.  06c0:  28 15 83 53 00 00 00 00 00 00 00 00 00 00 00 00  (..S............
.  06d0:  00 00 00 00 d5 80 19 5e 46 96 8a 74 39 06 00 00  .......^F..t9...
.  06e0:  00 00 00 00 00 00 00 00                          ........        

0 1941842404100 0x750 [0x6e8]: PERF_RECORD_SAMPLE(IP, 0x1): 33332/33332: 0 peri>
 ... thread: facultaet:33332
 ...... dso: <not found>



> report code should lookup a function for the architecture the perf.data
> was recorded on, using the perf.data file header, etc.
> 
>         const char *arch_name = perf_env__arch(session->header->env);
> 
> Then lookup a table to find the right function, ok? See arch__find() for
> an example used in the annotation code.
> 
> - Arnaldo
>  

I can make this platform independent and call a function to display
the event raw data collected on a s/390 and any other platform.
I will start with s390 and x86.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

