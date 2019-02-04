Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1228EC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91B32082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731413AbfBDNtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 08:49:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60488 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729207AbfBDNtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 08:49:55 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x14DkBgp052113
        for <linux-kernel@vger.kernel.org>; Mon, 4 Feb 2019 08:49:53 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qemvewbxx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 08:49:46 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 4 Feb 2019 13:49:42 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 4 Feb 2019 13:49:39 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x14Dnc2D1769970
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Feb 2019 13:49:38 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6561042045;
        Mon,  4 Feb 2019 13:49:38 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 467B24203F;
        Mon,  4 Feb 2019 13:49:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.107.242])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  4 Feb 2019 13:49:37 +0000 (GMT)
Subject: Re: [PATCH 3/3] selftests/ima: kexec_file_load syscall test
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        David Howells <dhowells@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Shuah Khan <shuah@kernel.org>
Date:   Mon, 04 Feb 2019 08:49:26 -0500
In-Reply-To: <20190203220258.GC4022@x230>
References: <1548960936-7800-1-git-send-email-zohar@linux.ibm.com>
         <1548960936-7800-4-git-send-email-zohar@linux.ibm.com>
         <20190203220258.GC4022@x230>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19020413-0028-0000-0000-00000343EB05
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020413-0029-0000-0000-00002401F022
Message-Id: <1549288166.4146.80.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-04_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902040110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-02-03 at 23:02 +0100, Petr Vorel wrote:
> Hi Mimi,
> 
> > The kernel can be configured to verify PE signed kernel images, IMA
> > kernel image signatures, both types of signatures, or none.  This test
> > verifies only properly signed kernel images are loaded into memory,
> > based on the kernel configuration and runtime policies.
> 
> > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thank you for the specific and generic suggestions to simplify/clean
up the tests!  The suggestions, below, and the "print" helpers will
really make a difference.

Mimi

> 
> ...
> > +++ b/tools/testing/selftests/ima/test_kexec_file_load.sh
> > @@ -0,0 +1,250 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0+
> # SPDX-License-Identifier: GPL-2.0-or-later
> > +#
> > +# Loading a kernel image via the kexec_file_load syscall can verify either
> > +# the IMA signature stored in the security.ima xattr or the PE signature,
> > +# both signatures depending on the IMA policy, or none.
> > +#
> > +# To determine whether the kernel image is signed, this test depends
> > +# on pesign and getfattr.  This test also requires the kernel to be
> > +# built with CONFIG_IKCONFIG enabled and either CONFIG_IKCONFIG_PROC
> > +# enabled or access to the extract-ikconfig script.
> > +
> > +VERBOSE=1
> Maybe allow to disable verbose without source change?
> VERBOSE="${VERBOSE:-1}"
> 
> > +EXTRACT_IKCONFIG=$(ls /lib/modules/`uname -r`/source/scripts/extract-ikconfig)
> > +IKCONFIG=/tmp/config-`uname -r`
> > +PROC_CONFIG="/proc/config.gz"
> > +KERNEL_IMAGE="/boot/vmlinuz-`uname -r`"
> > +PESIGN=/usr/bin/pesign
> > +GETFATTR=/usr/bin/getfattr
> > +
> > +TEST="$0"
> > +. ./common_lib.sh
> > +
> > +# Kselftest framework requirement - SKIP code is 4.
> > +ksft_skip=4
> > +
> > +kconfig_enabled()
> > +{
> > +	RC=0
> > +	egrep -q $1 $IKCONFIG
> > +	if [ $? -eq 0 ]; then
> > +		RC=1
> > +	fi
> > +	return $RC
> > +}
> This would be enough (grep with -e returns only 0 or 1):
> kconfig_enabled()
> {
> 	grep -E -q $1 $IKCONFIG
> }
> > +
> > +# policy rule format: action func=<keyword> [appraise_type=<type>]
> > +check_ima_policy()
> > +{
> > +	IMA_POLICY=/sys/kernel/security/ima/policy
> > +
> > +	RC=0
> > +	if [ $# -eq 3 ]; then
> > +		grep -e $2 $IMA_POLICY | grep -e "^$1.*$3" 2>&1 >/dev/null
> > +	else
> > +		grep -e $2 $IMA_POLICY | grep -e "^$1" 2>&1 >/dev/null
> > +	fi
> > +	if [ $? -eq 0 ]; then
> > +		RC=1
> > +	fi
> > +	return $RC
> > +}
> This would be enough and more descriptive:
> check_ima_policy()
> {
> 	local action="$1"
> 	local keyword="$2"
> 	local type="$3"
> 
> 	[ -n "$type" ] && type="appraise_type=$type"
> 	grep -q "^$action.*func=$keyword.*$type" /sys/kernel/security/ima/policy
> }
> 
> > +
> > +check_kconfig_options()
> > +{
> > +	# Attempt to get the kernel config first via proc, and then by
> > +	# extracting it from the kernel image using scripts/extract-ikconfig.
> > +	if [ ! -f $PROC_CONFIG ]; then
> > +		modprobe configs 2>/dev/null
> > +	fi
> > +	if [ -f $PROC_CONFIG ]; then
> > +		cat $PROC_CONFIG > $IKCONFIG
> > +	fi
> > +
> > +	if [ ! -f $IKCONFIG ]; then
> > +		if [ ! -f $EXTRACT_IKCONFIG ]; then
> > +			echo "$TEST: requires access to extract-ikconfig" >&2
> > +			exit $ksft_skip
> > +		fi
> > +
> > +		$EXTRACT_IKCONFIG $KERNEL_IMAGE > $IKCONFIG
> > +		kconfig_enabled "CONFIG_IKCONFIG=y"
> > +		if [ $? -eq 0 ]; then
> > +			echo "$TEST: requires the kernel to be built with CONFIG_IKCONFIG" >&2
> > +			exit $ksft_skip
> > +		fi
> > +	fi
> > +
> > +	kconfig_enabled "CONFIG_KEXEC_BZIMAGE_VERIFY_SIG=y"
> > +	pe_sig_required=$?
> > +	if [ $VERBOSE -ne 0 ] && [ $pe_sig_required -eq 1 ]; then
> > +		echo "$TEST: [INFO] PE signed kernel image required"
> > +	fi
> Checks for $VERBOSE here and in other kconfig_enabled usages bellow are a bit
> redundant. And you check for assigned variable now and then later on,
> you use these variables as global (and reset $ima_sig_required in
> check_runtime().
> 
> How about using functions instead:
> log_info()
> {
> 	echo "$TEST: [INFO] $1"
> }
> (Reducing some duplicity, IMHO helper functions in shell library used in all
> selftest tests would be useful)
> 
> kconfig_enabled()
> {
> 	local config="$1"
> 	local msg="$2"
> 	local ret
> 
> 	grep -E -q $config $IKCONFIG
> 	ret=$?
> 	[ $VERBOSE -ne 0 ] && [ $ret -eq 1 ] && log_info "$msg"
> 	return $ret
> }
> 
> ima_sig_enabled()
> {
> 	kconfig_enabled "CONFIG_KEXEC_BZIMAGE_VERIFY_SIG=y" \
> 		"PE signed kernel image required"
> }
> 
> ima_sig_enabled()
> {
> 	kconfig_enabled "CONFIG_IMA_APPRAISE_REQUIRE_KEXEC_SIGS=y" \
> 		"IMA kernel image signature required"
> }
> Warning is printed each time, but that's deliberate.
> If it's not wanted, it can be moved into setup.
> 
> ...
> > +check_kconfig_options
> > +check_for_apps
> > +check_runtime
> > +check_for_sigs
> > +kexec_file_load_test
> 
> > +rc=$?
> > +exit $rc
> These two are redundant.
> 
> Kind regards,
> Petr
> 

