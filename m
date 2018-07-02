Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E243C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 06:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADBCE254F8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 06:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADBCE254F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753336AbeGBGSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 02:18:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41862 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753247AbeGBGSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 02:18:31 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w626E8uV117198
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 02:18:31 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jybhunxbs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 02:18:30 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Mon, 2 Jul 2018 07:18:27 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 2 Jul 2018 07:18:23 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w626IMht41550056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Jul 2018 06:18:22 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3A424C046;
        Mon,  2 Jul 2018 07:18:05 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CB654C050;
        Mon,  2 Jul 2018 07:18:05 +0100 (BST)
Received: from oc3784624756.ibm.com (unknown [9.152.212.95])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  2 Jul 2018 07:18:05 +0100 (BST)
Subject: Re: [PATCH v2 1/4] perf test shell: Replace '|&' with '2>&1 |' to
 work with more shells
To:     Kim Phillips <kim.phillips@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        =?UTF-8?Q?Hendrik_Br=c3=bcckner?= <brueckner@linux.vnet.ibm.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>
References: <20180629124633.0a9f4bea54b8d2c28f265de2@arm.com>
From:   Thomas-Mich Richter <tmricht@linux.ibm.com>
Organization: IBM
Date:   Mon, 2 Jul 2018 08:18:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180629124633.0a9f4bea54b8d2c28f265de2@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18070206-0008-0000-0000-0000024E9DCA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070206-0009-0000-0000-000021B4A502
Message-Id: <4db9a273-1604-6f92-070c-b2779fbe4614@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-02_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807020073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/29/2018 07:46 PM, Kim Phillips wrote:
> Since we do not specify bash (and/or zsh) as a requirement, use the
> standard error redirection that is more widely supported.
> 
> BEFORE:
> 
>  $ sudo ./perf test -v 62
>  62: Check open filename arg using perf trace + vfs_getname:
>  --- start ---
>  test child forked, pid 27305
>  ./tests/shell/trace+probe_vfs_getname.sh: 20: ./tests/shell/trace+probe_vfs_getname.sh: Syntax error: "&" unexpected
>  test child finished with -2
>  ---- end ----
>  Check open filename arg using perf trace + vfs_getname: Skip
> 
> AFTER:
> 
>  $ sudo ./perf test -v 62
>  64: Check open filename arg using perf trace + vfs_getname               :
>  --- start ---
>  test child forked, pid 23008
>  Added new event:
>    probe:vfs_getname    (on getname_flags:72 with pathname=result->name:string)
> 
>  You can now use it in all perf tools, such as:
> 
>          perf record -e probe:vfs_getname -aR sleep 1
> 
>       0.361 ( 0.008 ms): touch/23032 openat(dfd: CWD, filename: /tmp/temporary_file.VEh0n, flags: CREAT|NOCTTY|NONBLOCK|WRONLY, mode: IRUGO|IWUGO) = 4
>  test child finished with 0
>  ---- end ----
>  Check open filename arg using perf trace + vfs_getname: Ok
> 
> Similar to commit 35435cd06081, with the same title.
> 
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
> Cc: Michael Petlan <mpetlan@redhat.com>
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> ---
> v2: indent terminal session logs with a space to avoid git-am parsing
> '--- start ---' as the end of the description text.
> 
>  tools/perf/tests/shell/trace+probe_vfs_getname.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
> index 55ad9793d544..4ce276efe6b4 100755
> --- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
> +++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
> @@ -17,7 +17,7 @@ skip_if_no_perf_probe || exit 2
>  file=$(mktemp /tmp/temporary_file.XXXXX)
> 
>  trace_open_vfs_getname() {
> -	evts=$(echo $(perf list syscalls:sys_enter_open* |& egrep 'open(at)? ' | sed -r 's/.*sys_enter_([a-z]+) +\[.*$/\1/') | sed 's/ /,/')
> +	evts=$(echo $(perf list syscalls:sys_enter_open* 2>&1 | egrep 'open(at)? ' | sed -r 's/.*sys_enter_([a-z]+) +\[.*$/\1/') | sed 's/ /,/')
>  	perf trace -e $evts touch $file 2>&1 | \
>  	egrep " +[0-9]+\.[0-9]+ +\( +[0-9]+\.[0-9]+ ms\): +touch\/[0-9]+ open(at)?\((dfd: +CWD, +)?filename: +${file}, +flags: CREAT\|NOCTTY\|NONBLOCK\|WRONLY, +mode: +IRUGO\|IWUGO\) += +[0-9]+$"
>  }
> 


Applied and tested for s390. You have my tested by.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

