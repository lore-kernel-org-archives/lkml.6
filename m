Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34AAC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E45216F9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E45216F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbeHNUyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:54:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38976 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729920AbeHNUyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:54:25 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7EI4Gjf014627
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 14:06:07 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kv3cshqan-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 14:06:06 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <davidj@linux.ibm.com>;
        Tue, 14 Aug 2018 12:06:06 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 Aug 2018 12:06:04 -0600
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7EI63w412517752
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Aug 2018 11:06:03 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 054DDC6061;
        Tue, 14 Aug 2018 12:06:03 -0600 (MDT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 931E2C605D;
        Tue, 14 Aug 2018 12:06:02 -0600 (MDT)
Received: from dev.watson.ibm.com (unknown [9.31.111.83])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 14 Aug 2018 12:06:02 -0600 (MDT)
From:   David Jacobson <davidj@linux.ibm.com>
To:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     David Jacobson <david@davidej.com>, Petr Vorel <pvorel@suze.cz>,
        David Jacobson <davidj@linux.ibm.com>
Subject: [PATCH 6/7] evmtest: test the preservation of extended attributes
Date:   Tue, 14 Aug 2018 14:05:50 -0400
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180814180551.28311-1-davidj@linux.ibm.com>
References: <20180814180551.28311-1-davidj@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18081418-0012-0000-0000-0000169E4EAE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009544; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01073490; UDB=6.00553126; IPR=6.00853448;
 MB=3.00022715; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-14 18:06:05
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081418-0013-0000-0000-0000540A5168
Message-Id: <20180814180551.28311-6-davidj@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-14_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808140185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IMA supports file signatures by storing information in a security.ima
extended file attribute. This test ensures that the attribute is
preserved when a file is copied.  This test requires root because only
root can write "security." xattrs to files.

Signed-off-by: David Jacobson <davidj@linux.ibm.com>
---
 evmtest/functions/r_xattr_preserve.sh | 74 +++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100755 evmtest/functions/r_xattr_preserve.sh

diff --git a/evmtest/functions/r_xattr_preserve.sh b/evmtest/functions/r_xattr_preserve.sh
new file mode 100755
index 0000000..e7f0e2a
--- /dev/null
+++ b/evmtest/functions/r_xattr_preserve.sh
@@ -0,0 +1,74 @@
+#!/bin/bash
+# Author: David Jacobson <davidj@linux.ibm.com>
+TEST="r_xattr_preserve"
+ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )/.."
+source $ROOT/files/common.sh
+
+VERBOSE=0
+# This test ensures that extended file attributes are preserved when a file is
+# moved with the correct flag
+
+usage (){
+	echo ""
+	echo "xattr_preserve [-hv]"
+	echo ""
+	echo "This test must be run as root"
+	echo ""
+	echo "	This test ensures that extended file attributes (specifically"
+	echo "	security.ima labels) are preserved when copying"
+	echo "Options"
+	echo "  -h,--help       Display this help message"
+	echo "  -v,--verbose    Verbose logging"
+}
+
+TEMP=`getopt -o 'hv' -l 'help,verbose' -n 'r_xattr_preserve' -- "$@"`
+eval set -- "$TEMP"
+
+while true ; do
+	case "$1" in
+	-h|--help) usage; exit; shift;;
+	-v|--verbose) VERBOSE=1; shift;;
+	--) shift; break;;
+	*) echo "[*] Unrecognized option $1"; exit 1;;
+	esac
+done
+
+EVMTEST_require_root
+
+begin
+
+LOCATION_1=`mktemp`
+LOCATION_2=`mktemp -u` # Doesn't create the file
+v_out "Labeling file..."
+
+evmctl ima_hash $LOCATION_1
+initial_ima_label=`getfattr -m ^security.ima -e hex \
+	--dump $LOCATION_1 2> /dev/null`
+
+initial_hash=`echo $initial_ima_label | awk -F '=' '{print $2}'`
+
+if [[ $initial_ima_label = *"security.ima"* ]]; then
+	v_out "Found hash on initial file... "
+else
+	fail "Hash not found on initial file"
+fi
+
+initial_hash=`echo $initial_ima_label | awk -F '=' '{print $2}'`
+
+v_out "Copying file..."
+cp --preserve=xattr $LOCATION_1 $LOCATION_2
+v_out "Checking if extended attribute has been preserved..."
+
+
+second_ima_label=`getfattr -m ^security.ima -e hex \
+	--dump $LOCATION_2 2> /dev/null`
+second_hash=`echo $second_ima_label | awk -F '=' '{print $2}'`
+if [[ "$initial_hash" != "$second_hash" ]]; then
+	fail "security.ima xattr was not preserved!"
+else
+	v_out "Extended attribute was preserved during copy"
+fi
+v_out "Cleaning up..."
+rm $LOCATION_1 $LOCATION_2
+
+passed
-- 
2.17.1

