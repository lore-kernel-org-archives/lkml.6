Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BE6C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D7821A58
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3D7821A58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933631AbeGDHhE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 03:37:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32986 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932188AbeGDHhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 03:37:02 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w647XkPR066215
        for <linux-kernel@vger.kernel.org>; Wed, 4 Jul 2018 03:37:02 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k0s68j5b6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 03:37:01 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <brueckner@linux.ibm.com>;
        Wed, 4 Jul 2018 08:36:59 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Jul 2018 08:36:54 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w647as8h31522996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Jul 2018 07:36:54 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F22752054;
        Wed,  4 Jul 2018 10:37:19 +0100 (BST)
Received: from lynx.boeblingen.de.ibm.com (unknown [9.152.212.204])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 1C21E52052;
        Wed,  4 Jul 2018 10:37:19 +0100 (BST)
Received: from brueckh by lynx.boeblingen.de.ibm.com with local (Exim 4.90_1)
        (envelope-from <brueckner@linux.ibm.com>)
        id 1facLN-0002wE-Jg; Wed, 04 Jul 2018 09:36:53 +0200
Date:   Wed, 4 Jul 2018 09:36:53 +0200
From:   Hendrik Brueckner <brueckner@linux.ibm.com>
To:     Kim Phillips <kim.phillips@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] perf arm64: Generate system call table from
 asm/unistd.h
References: <20180703123228.eca1b003e51d5ced01317575@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703123228.eca1b003e51d5ced01317575@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18070407-0012-0000-0000-0000028691ED
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070407-0013-0000-0000-000020B8128E
Message-Id: <20180704073653.GA4680@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-04_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807040090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kim,

On Tue, Jul 03, 2018 at 12:32:28PM -0500, Kim Phillips wrote:
> This should speed up accessing new system calls introduced with the
> kernel rather than waiting for libaudit updates to include them.
> 
> Using the existing other arch scripts resulted in this error:
> 
> tools/perf/arch/arm64/entry/syscalls//mksyscalltbl: 25: printf: __NR3264_ftruncate: expected numeric value
> 
> because, unlike other arches, asm-generic's unistd.h does things like:
> 
>  #define __NR_ftruncate __NR3264_ftruncate
> 
> Turning the scripts printf's %d into a %s resulted in this in the
> generated syscalls.c file:
> 
>     static const char *syscalltbl_arm64[] = {
>             [__NR3264_ftruncate] = "ftruncate",
> 
> So we use the host C compiler to fold the macros, and print them out
> from within a temporary C program, in order to get the correct output:
> 
>     static const char *syscalltbl_arm64[] = {
>             [46] = "ftruncate",
> 
> Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> ---
>  tools/perf/arch/arm64/Makefile                | 21 ++++++++
>  .../arch/arm64/entry/syscalls/mksyscalltbl    | 54 +++++++++++++++++++
>  2 files changed, 75 insertions(+)
>  create mode 100755 tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
> 
> diff --git a/tools/perf/arch/arm64/Makefile b/tools/perf/arch/arm64/Makefile
> index 91de4860faad..85fdf4949db3 100644
> --- a/tools/perf/arch/arm64/Makefile
> +++ b/tools/perf/arch/arm64/Makefile
> @@ -4,3 +4,24 @@ PERF_HAVE_DWARF_REGS := 1
>  endif
>  PERF_HAVE_JITDUMP := 1
>  PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
> +
> +#
> +# Syscall table generation for perf
> +#
> +
> +out    := $(OUTPUT)arch/arm64/include/generated/asm
> +header := $(out)/syscalls.c
> +sysdef := $(srctree)/tools/arch/arm64/include/uapi/asm/unistd.h
> +sysprf := $(srctree)/tools/perf/arch/arm64/entry/syscalls/
> +systbl := $(sysprf)/mksyscalltbl
> +
> +# Create output directory if not already present
> +_dummy := $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
> +
> +$(header): $(sysdef) $(systbl)
> +	$(Q)$(SHELL) '$(systbl)' '$(CC)' '$(HOSTCC)' $(sysdef) > $@
> +
> +clean::
> +	$(call QUIET_CLEAN, arm64) $(RM) $(header)
> +
> +archheaders: $(header)
> diff --git a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
> new file mode 100755
> index 000000000000..1148302b7194
> --- /dev/null
> +++ b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
> @@ -0,0 +1,54 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Generate system call table for perf. Derived from
> +# powerpc script.
> +#
> +# Copyright IBM Corp. 2017
> +# Author(s):  Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
> +# Changed by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> +# Changed by: Kim Phillips <kim.phillips@arm.com>
> +
> +gcc=$1
> +hostcc=$2
> +input=$3
> +
> +if ! test -r $input; then
> +	echo "Could not read input file" >&2
> +	exit 1
> +fi
> +
> +create_table_from_c()
> +{
> +	local last_sc

For the sake of completion, also add the "sc" and "nr" local variables.

> +
> +	create_table_base=`mktemp -u /tmp/create-table-XXX`

- The -u is considered to be unsafe. But from below, I think you require
  this for the .c/.x file.  Alternatively, you could create the file
  (and prefer using more X for the template) and append to it.  Or pipe
  the C code to the $hostcc command, e.g.,
	$hostcc -o $create_table_base -x c -
  which would require a single temp file that would be overwritten by gcc.

> +	echo "#include <stdio.h>" > ${create_table_base}.c
> +	echo "#include \"$input\"" >> ${create_table_base}.c
> +
> +	echo "int main(int argc, char *argv[])" >> ${create_table_base}.c
> +	echo "{" >> ${create_table_base}.c

As alternative to these echos, use

cat >> ${create_table_base}.c <<-EoHEADER
	#include <stdio.h>
	#include "$input"
	int main(int argc, char *argv[])
	{
EoHeader

which is at least for larger portions a bit more readable.

> +	while read sc nr; do
> +		echo "	printf(\"\\\t[%d] = \\\"$sc\\\",\\\n\", __NR_$sc);" >> ${create_table_base}.c
> +		last_sc=$sc
> +	done
> +	echo "	printf(\"#define SYSCALLTBL_ARM64_MAX_ID %d\\\n\", __NR_$last_sc);" >> ${create_table_base}.c
> +	echo "}" >> ${create_table_base}.c
> +
> +	$hostcc -o ${create_table_base}.x ${create_table_base}.c
> +	${create_table_base}.x
> +}
> +
> +create_table()
> +{
> +	echo "static const char *syscalltbl_arm64[] = {"
> +	create_table_from_c
> +	echo '};'
> +
> +	$RM -f ${create_table_base}.[cx]

The $RM is obtained from the (make) environment.  I would prefer using rm here
to be able to run as standalone.

> +}
> +
> +$gcc -E -dM -x c  $input	       \
> +	|sed -ne 's/^#define __NR_//p' \
> +	|sort -t' ' -k2 -nu	       \
> +	|create_table
> -- 
> 2.17.1
> 
Kind regards,
  Hendrik

-- 
Hendrik Brueckner
brueckner@linux.ibm.com           | IBM Deutschland Research & Development GmbH
Linux on z Systems Development    | Schoenaicher Str. 220, 71032 Boeblingen


IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Martina Koederitz
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294

