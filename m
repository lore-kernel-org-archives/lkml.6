Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2486798-1527616949-2-17117936540803469022
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527616948; b=UfAZukC/fuAN/HFmh0PDcvPqIuSKzdKFBXErW6w+t4uVksRz1v
    utzVQNlq9IQuCsUYOS2kUPmygNZVE3XOZMGr4yYU8q/63JvgbijA5gO7vEWzuZBy
    S8mklDPrHsdp7SdWTOj5oWnhLKS//eGuI15wg9eWFbz8djIFsxtppoO/XX9hPw4T
    wOnM90Yqz75XaT6htPw8hIN/n5cugPb+P33xLhC7JsAdUfC2aRIkCC493OIl2fBO
    rhwIAWZBv7iqRLb72aXU6q9SAxRY8GqiNg7TeV7d9UFBo8YowIeRyU/NtqrcqX5F
    Q1aNoD4jBjcs0u6NDN6FBUVKmIm8Ua+io/NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1527616948; bh=1vEJnH9Z7wgyIECeiWEtJI2aeU6neZ
    Y05jObOQz6D+0=; b=IWfhk4+yXeZPmanXm1ei5zpC+dhSR11HqivVKD2ZSpKMp4
    KkpNUXCjCqjIJvpAtFK7xZidrrRrd+j/GEmjfG/Iy8bxzoKTH+VftvUIRJAGDuoG
    izfDPIQUDFiHk0o+jU4sSpSH7u+bixz5LNIsIT53V7WvPL9O/A0Xs9Emq093H3Rz
    +lh3iXmEeP/EIywg2Uh1SnFcEfBgTKSgdxa7KPtw2hAsgrMyIRgkRXXvkm12sUue
    qIJzwXbeBTnq1U6lmXVwbC9tLDQHGjzQn7IY11Nqk9tfRaBg3Ezg13wNeEqMpyIn
    4Y9PeygiXMO6cJJI/Bz41OD5O1h0WES694W/piUg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
    header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.vnet.ibm.com header.result=pass
    header_org.domain=ibm.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
      header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.vnet.ibm.com header.result=pass
      header_org.domain=ibm.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJaHLf272ucTnoRegYJ0mPtE41HzKSDHzZkqBLWdjNzFLo2tJDUXIpXyDkgB/bSGM9qUXCpGa4giZ1mUiAxOjHWedobMQYjcIAjIByKhD7ofZt7NLutd
    MP3GJsJFLQHpY6n6h4RqISTb2QQjh/PUneAjggQ7mEWRpt4lNtavJF7VyoY7lTC/z+x5e5uCriN/rGT14OhHyNJCy3Fg3EYQCX07nlzeruWqtZ1BVChhkzkw
    YbVwfWgayKfR466CMCw9DA==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=pfepmeDxbJN8zshhl1AA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965740AbeE2SCV (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 14:02:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41834 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965705AbeE2SCT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 29 May 2018 14:02:19 -0400
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v4 0/8] kexec/firmware: support system wide policy requiring signatures
Date: Tue, 29 May 2018 14:01:52 -0400
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
x-cbid: 18052918-0044-0000-0000-00000558109A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052918-0045-0000-0000-0000289A2019
Message-Id: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-29_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=5 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805290195
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Instead of adding the security_kernel_read_file LSM hook - or defining a
wrapper for security_kernel_read_file LSM hook and adding it, or
renaming the existing hook to security_kernel_read_data() and adding it
- in places where the kernel isn't reading a file, this version of the
patch set defines a new LSM hook named security_kernel_load_data().

The new LSM hook does not replace the existing security_kernel_read_file
LSM hook, which is still needed, but defines a new LSM hook allowing
LSMs and IMA-appraisal the opportunity to fail loading userspace
provided file/data.

The only difference between the two LSM hooks is the LSM hook name and a
file descriptor.  Whether this is cause enough for requiring a new LSM
hook, is left to the security community.

---

IMA-appraisal is mostly being used in the embedded or single purpose
closed system environments.  In these environments, both the Kconfig
options and the userspace tools can be modified appropriately to limit
syscalls.  For stock kernels, userspace applications need to continue to
work with older kernels as well as with newer kernels.

In this environment, the customer needs the ability to define a system
wide IMA policy, such as requiring all kexec'ed images, firmware, kernel
modules to be signed, without being dependent on either the Kconfig
options or the userspace tools.[1]

This patch set allows the customer to define a policy which requires
the kexec'ed kernel images, firmware, and/or kernel modules to be
signed.

In addition, this patch set includes the ability to configure a build
time IMA policy, which is automatically loaded at run time without
needing to specify it on the boot command line and persists after
loading a custom kernel policy.

[1] kexec-tools suupports the new syscall based on a flag (-s).

Changelog v4:
- Define a new LSM hook named security_kernel_load_data().
- Define kernel_load_data_id enumeration.
- Replace the existing LSM hook in init_module syscall.

Changelog v3:
Based on James' feedback:
- Renamed security_kernel_read_file() to security_kernel_read_data().
- Defined new kernel_load_data_id enumeration.
- Cleaned up ima_read_data(), replacing if's with switch.

Changelog v2:
- combined "kexec: limit kexec_load syscall" and "firmware: kernel
signature verification" patch sets.
- add support for build time policy.
- defined generic security_kernel_read_blob() wrapper for
  security_kernel_read_file(). Suggested by Luis.

Mimi Zohar (8):
  security: define new LSM hook named security_kernel_load_data
  kexec: add call to LSM hook in original kexec_load syscall
  ima: based on policy require signed kexec kernel images
  firmware: add call to LSM hook before firmware sysfs fallback
  ima: based on policy require signed firmware (sysfs fallback)
  ima: add build time policy
  ima: based on policy prevent loading firmware (pre-allocated buffer)
  module: replace the existing LSM hook in init_module

 drivers/base/firmware_loader/fallback.c |  7 +++
 include/linux/ima.h                     |  7 +++
 include/linux/lsm_hooks.h               |  6 +++
 include/linux/security.h                | 33 ++++++++++++++
 kernel/kexec.c                          |  8 ++++
 kernel/module.c                         |  2 +-
 security/integrity/ima/Kconfig          | 58 ++++++++++++++++++++++++
 security/integrity/ima/ima.h            |  1 +
 security/integrity/ima/ima_main.c       | 79 ++++++++++++++++++++++++---------
 security/integrity/ima/ima_policy.c     | 48 ++++++++++++++++++--
 security/security.c                     | 10 +++++
 security/selinux/hooks.c                | 26 ++++++++---
 12 files changed, 255 insertions(+), 30 deletions(-)
-- 
2.7.5

