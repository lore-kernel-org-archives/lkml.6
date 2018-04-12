Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753469AbeDLWmJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 18:42:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58060 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752847AbeDLWmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 18:42:07 -0400
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: David Howells <dhowells@redhat.com>
Cc: Matthew Garrett <mjg59@google.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] kexec: limit kexec_load syscall
Date: Thu, 12 Apr 2018 18:41:48 -0400
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
x-cbid: 18041222-0044-0000-0000-00000546AADE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041222-0045-0000-0000-00002886E7E4
Message-Id: <1523572911-16363-1-git-send-email-zohar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-12_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804120213
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In environments that require the kexec kernel image to be signed, prevent
using the kexec_load syscall.  In order for LSMs and IMA to differentiate
between kexec_load and kexec_file_load syscalls, this patch set adds a
call to security_kernel_read_file() in kexec_load_check().

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

Mimi Zohar (3):
  ima: based on the "secure_boot" policy limit syscalls
  kexec: call LSM hook for kexec_load syscall
  ima: based on policy require signed kexec kernel images

 kernel/kexec.c                      | 11 +++++++++++
 security/integrity/ima/ima.h        |  1 +
 security/integrity/ima/ima_main.c   |  9 +++++++++
 security/integrity/ima/ima_policy.c | 27 ++++++++++++++++++++-------
 4 files changed, 41 insertions(+), 7 deletions(-)

-- 
2.7.5
