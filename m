Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F26C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 601EE20872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:15:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 601EE20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754832AbeFTJPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:15:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42798 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751579AbeFTIdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:33:44 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5K6sfJA155843
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 02:59:56 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jqe9tyjq4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 02:59:56 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Wed, 20 Jun 2018 07:59:54 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Jun 2018 07:59:51 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5K6xoIV31588596
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Jun 2018 06:59:50 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56DF211C069;
        Wed, 20 Jun 2018 07:50:15 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B569E11C05C;
        Wed, 20 Jun 2018 07:50:14 +0100 (BST)
Received: from oc3784624756.ibm.com (unknown [9.152.212.222])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jun 2018 07:50:14 +0100 (BST)
Subject: Re: [PATCH 2/2] perf test shell: make perf inet_pton test more
 portable
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
References: <20180619184952.dac6a3a1e39d3b1d255e7119@arm.com>
From:   Thomas-Mich Richter <tmricht@linux.ibm.com>
Organization: IBM LTC
Date:   Wed, 20 Jun 2018 08:59:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619184952.dac6a3a1e39d3b1d255e7119@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18062006-0016-0000-0000-000001DDF974
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062006-0017-0000-0000-000032320AAA
Message-Id: <b054c9cf-fa7a-b1d9-5fee-0946910ace3b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-20_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806200080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/20/2018 01:49 AM, Kim Phillips wrote:
> Debian based systems such as Ubuntu have dash as their default shell.
> Even if the normal or root user's shell is bash, certain scripts still
> call /bin/sh, which points to dash, so we fix this perf test by
> rewriting it in a more portable way.
> 
> BEFORE:
> 
> $ sudo ./perf test -v 64
> 64: probe libc's inet_pton & backtrace it with ping       :
> --- start ---
> test child forked, pid 31942
> ./tests/shell/record+probe_libc_inet_pton.sh: 18: ./tests/shell/record+probe_libc_inet_pton.sh: expected[0]=ping[][0-9 \.:]+probe_libc:inet_pton: \([[:xdigit:]]+\): not found
> ./tests/shell/record+probe_libc_inet_pton.sh: 19: ./tests/shell/record+probe_libc_inet_pton.sh: expected[1]=.*inet_pton\+0x[[:xdigit:]]+[[:space:]]\(/lib/x86_64-linux-gnu/libc-2.27.so|inlined\)$: not found
> ./tests/shell/record+probe_libc_inet_pton.sh: 29: ./tests/shell/record+probe_libc_inet_pton.sh: expected[2]=getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\(/lib/x86_64-linux-gnu/libc-2.27.so\)$: not found
> ./tests/shell/record+probe_libc_inet_pton.sh: 30: ./tests/shell/record+probe_libc_inet_pton.sh: expected[3]=.*\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$: not found
> ping 31963 [004] 83577.670613: probe_libc:inet_pton: (7fe15f87f4b0)
> ./tests/shell/record+probe_libc_inet_pton.sh: 39: ./tests/shell/record+probe_libc_inet_pton.sh: Bad substitution
> ./tests/shell/record+probe_libc_inet_pton.sh: 41: ./tests/shell/record+probe_libc_inet_pton.sh: Bad substitution
> test child finished with -2
> ---- end ----
> probe libc's inet_pton & backtrace it with ping: Skip
> 
> AFTER:
> 
> 64: probe libc's inet_pton & backtrace it with ping       :
> --- start ---
> test child forked, pid 32277
> ping 32295 [001] 83679.690020: probe_libc:inet_pton: (7ff244f504b0)
> 7ff244f504b0 __GI___inet_pton+0x0 (/lib/x86_64-linux-gnu/libc-2.27.so)
> 7ff244f14ce4 getaddrinfo+0x124 (/lib/x86_64-linux-gnu/libc-2.27.so)
> 556ac036b57d _init+0xb75 (/bin/ping)
> test child finished with 0
> ---- end ----
> probe libc's inet_pton & backtrace it with ping: Ok
> 
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
> Cc: Michael Petlan <mpetlan@redhat.com>
> Cc: "Hendrik Brückner" <brueckner@linux.vnet.ibm.com>
> Cc: Sandipan Das <sandipan@linux.vnet.ibm.com>
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> ---
> Fixed using fake array technique described here:
> 
> https://www.linuxquestions.org/questions/programming-9/basic-bash-how-to-use-eval-to-evaluate-variable-names-made-of-arbitrary-strings-775622/
> 
> Note that bashisms can also be found with 'checkbashisms':
> 
> $ checkbashisms record+probe_libc_inet_pton.sh
> script record+probe_libc_inet_pton.sh does not appear to have a #! interpreter line;
> you may get strange results
> possible bashism in record+probe_libc_inet_pton.sh line 18 (bash arrays, H[0]):
> 	expected[0]="ping[][0-9 \.:]+probe_libc:inet_pton: \([[:xdigit:]]+\)"
> possible bashism in record+probe_libc_inet_pton.sh line 19 (bash arrays, H[0]):
> 	expected[1]=".*inet_pton\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
> possible bashism in record+probe_libc_inet_pton.sh line 23 (bash arrays, H[0]):
> 		expected[2]="gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
> possible bashism in record+probe_libc_inet_pton.sh line 24 (bash arrays, H[0]):
> 		expected[3]="(__GI_)?getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
> possible bashism in record+probe_libc_inet_pton.sh line 25 (bash arrays, H[0]):
> 		expected[4]="main\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$"
> possible bashism in record+probe_libc_inet_pton.sh line 29 (bash arrays, H[0]):
> 		expected[2]="getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$"
> possible bashism in record+probe_libc_inet_pton.sh line 30 (bash arrays, H[0]):
> 		expected[3]=".*\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$"
> possible bashism in record+probe_libc_inet_pton.sh line 39 (bash arrays, ${name[0|*|@]}):
> 		echo "$line" | egrep -q "${expected[$idx]}"
> possible bashism in record+probe_libc_inet_pton.sh line 41 (bash arrays, ${name[0|*|@]}):
> 			printf "FAIL: expected backtrace entry %d \"%s\" got \"%s\"\n" $idx "${expected[$idx]}" "$line"
> possible bashism in record+probe_libc_inet_pton.sh line 44 (let ...):
> 		let idx+=1
> possible bashism in record+probe_libc_inet_pton.sh line 45 (bash arrays, ${name[0|*|@]}):
> 		[ -z "${expected[$idx]}" ] && break
> 
>  .../shell/record+probe_libc_inet_pton.sh      | 23 ++++++++++---------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> index 263057039693..41124fa12913 100755
> --- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> +++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> @@ -15,19 +15,20 @@ nm -Dg $libc 2>/dev/null | fgrep -q inet_pton || exit 254
>  
>  trace_libc_inet_pton_backtrace() {
>  	idx=0
> -	expected[0]="ping[][0-9 \.:]+probe_libc:inet_pton: \([[:xdigit:]]+\)"
> -	expected[1]=".*inet_pton\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
> +	expected='expected'
> +	eval ${expected}0="'ping[][0-9 \.:]+probe_libc:inet_pton: \([[:xdigit:]]+\)'"
> +	eval ${expected}1="'.*inet_pton\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$'"
>  	case "$(uname -m)" in
>  	s390x)
>  		eventattr='call-graph=dwarf,max-stack=4'
> -		expected[2]="gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
> -		expected[3]="(__GI_)?getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
> -		expected[4]="main\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$"
> +		eval ${expected}2="'gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$'"
> +		eval ${expected}3="'(__GI_)?getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$'"
> +		eval ${expected}4="'main\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$'"
>  		;;
>  	*)
>  		eventattr='max-stack=3'
> -		expected[2]="getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$"
> -		expected[3]=".*\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$"
> +		eval ${expected}2="'getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$'"
> +		eval ${expected}3="'.*\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$'"
>  		;;
>  	esac
>  
> @@ -36,13 +37,13 @@ trace_libc_inet_pton_backtrace() {
>  	perf record -e probe_libc:inet_pton/$eventattr/ -o $file ping -6 -c 1 ::1 > /dev/null 2>&1
>  	perf script -i $file | while read line ; do
>  		echo $line
> -		echo "$line" | egrep -q "${expected[$idx]}"
> +		echo "$line" | egrep -q "$(echo $(eval echo \$$expected${idx}))"
>  		if [ $? -ne 0 ] ; then
> -			printf "FAIL: expected backtrace entry %d \"%s\" got \"%s\"\n" $idx "${expected[$idx]}" "$line"
> +			printf "FAIL: expected backtrace entry %d \"%s\" got \"%s\"\n" $idx "$(echo $(eval echo \$$expected${idx}))" "$line"
>  			exit 1
>  		fi
> -		let idx+=1
> -		[ -z "${expected[$idx]}" ] && break
> +		idx=$((idx+1))
> +		[ -z "$(echo $(eval echo \$$expected${idx}))" ] && break
>  	done
>  
>  	# If any statements are executed from this point onwards,
> 

I tried it on my s390 and it works nicely.

Tested-by: Thomas Richter <tmricht@linux.ibm.com>

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

