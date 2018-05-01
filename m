Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755455AbeEANsj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 09:48:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40170 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754340AbeEANsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 09:48:37 -0400
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Jones <pjones@redhat.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH 0/6] firmware: kernel signature verification 
Date: Tue,  1 May 2018 09:48:17 -0400
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
x-cbid: 18050113-0040-0000-0000-00000453CC11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050113-0041-0000-0000-000020F7E72E
Message-Id: <1525182503-13849-1-git-send-email-zohar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-01_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805010138
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow LSMs and IMA to differentiate between different methods of
firmware loading (eg. direct loading, sysfs fallback) and to
differentiate/coordinate between signature verification methods (eg.
regdb, IMA-appraisal).

In addition, the last two patches address the pre-allocated buffer.  The
first of these patches doesn't differentiate between reading the
firmware first into kernel memory and verifying the kernel signature,
versus reading the firmware directly into a pre-allocated buffer.

The last patch, which is posted as an RFC, questions whether the device
can access the pre-allocated buffer before the kernel signature has been
verified.

Mimi Zohar (6):
  firmware: permit LSMs and IMA to fail firmware sysfs fallback loading
  ima: prevent sysfs fallback firmware loading
  firmware: differentiate between signed regulatory.db and other
    firmware
  ima: coordinate with signed regulatory.db
  ima: verify kernel firmware signatures when using a preallocated
    buffer
  ima: prevent loading firmware into a pre-allocated buffer

 drivers/base/firmware_loader/fallback.c |  7 +++++++
 drivers/base/firmware_loader/main.c     |  5 +++++
 include/linux/fs.h                      |  2 ++
 security/integrity/ima/ima_main.c       | 29 +++++++++++++++++++++++++++--
 4 files changed, 41 insertions(+), 2 deletions(-)

-- 
2.7.5
