Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3293482-1527035143-2-3791241865242887981
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527035142; b=Gx2Gnaj6SISB3B4nNIx8cynDLNN2bT7Nw+wbUENS6sXLbyfLeO
    T68k6Vis6uGmLPj9DVvTzh/2bGt8+Y8LYl3whwZfEaZyQ5F5DrdV9T9NYGiGbC1L
    LpOZ+lRlvviBLnptA9F4v8Dc7QD5BzNFjZc3aS2UHWFvBVl3AGhQRjQ2oEjMX7mr
    dvS/enb0KIuV8ETmd4Ab6Mc/hSBAj95Uc/xfmF3agI/+NiufYmj70+nxi7MvLCGc
    I853avYcD3Swsc0J2rrPVQC7NpZ1UVQayOTHw/Acr51Tf0XM6IGzoUikkONoUssq
    HvnIY7ImJ9C7o3E8Umafd79fYWwMb0aiDzDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1527035142; bh=Zr8tob9WjQpv4ub+DZVhoMWd7osjYO
    emJsgnYoVhIvY=; b=ndvtrI6JYx96lEcObreMxK9B0G8kcBJ7ko0/QV84Grt2BF
    ln99CbWnzDBzo0phdmyUMZrpu+YpyeZYuscgoEG78W5vbH1RJ25XbyBNeZHchEmD
    k6Tka1cax3FiijH90VenhREs8FwqcvFic+K4AmfXOe0Qu0UAEN7PpeWRqwqzLPVq
    3Hv+mds3DcKP6gaEdfAFW4dhIyW0NYW0dk0wubAn7u7Z7NI3IwJY5hf+LJOhN1S+
    uaUJSyUV//X+nl2wsn8VxKYKFmfw0/S1c0pMBh+R/ErYyFy/DgVmmDyR4mJH3B/P
    pV2WzUYPi7ADpTu2i7LlrCfZ+TroVCzn5U5gaeRQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.ibm.com header.result=pass
    header_org.domain=ibm.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.ibm.com header.result=pass
      header_org.domain=ibm.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPt23C9XkcPhn2M4ZUgmR4MMQM4gt0KA9YsvfkzNbGM0kdZqbCTfgdJYeUMhe2sz/MwRA80YuMcXdMs4eD21zpI57M/6njTiTkSYl9Pqf5an4QCZCAsy
    1DINzzjAnvgQvNy153UAF/j5FX16RNJiEvqCLw9JyzDRqtdNhe33CziLDmo9DA9AaLLX2DzlJ0kGrgghkM98dz5nopRGbGgiywmjBzgAU5B7ysR9+/VHYruB
    TfNS9CSkiPWTV2YQGG0HLA==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=Di9E_7cMCeAdn5_19KcA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753511AbeEWAZk (ORCPT <rfc822;linux@kroah.com>);
        Tue, 22 May 2018 20:25:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53942 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753484AbeEWAZj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 22 May 2018 20:25:39 -0400
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH v7 00/14] Appended signatures support for IMA appraisal
Date: Tue, 22 May 2018 21:12:39 -0300
X-Mailer: git-send-email 2.16.2
X-TM-AS-GCONF: 00
x-cbid: 18052300-0020-0000-0000-00000DFD5274
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009068; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01036241; UDB=6.00530093; IPR=6.00815369;
 MB=3.00021248; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-23 00:25:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052300-0021-0000-0000-00006182BD8F
Message-Id: <20180523001253.15247-1-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-22_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805230002
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

The main difference in this version is the addition of the last patch, which
ensures that there will always be a measurement entry containing the appended
modsig if one was used to appraise the file. The patch description and comments
in the code should explain in which circumstances the patch proved necessary.

Apart from that, there was some small cleaning up of the code, and merging and
splitting of patches. The changelog below has the details.

These patches apply on top of today's linux-integrity/next-integrity.

Original cover letter:

On the OpenPOWER platform, secure boot and trusted boot are being
implemented using IMA for taking measurements and verifying signatures.
Since the kernel image on Power servers is an ELF binary, kernels are
signed using the scripts/sign-file tool and thus use the same signature
format as signed kernel modules.

This patch series adds support in IMA for verifying those signatures.
It adds flexibility to OpenPOWER secure boot, because it allows it to boot
kernels with the signature appended to them as well as kernels where the
signature is stored in the IMA extended attribute.

Changes since v6:

- Patch "PKCS#7: Introduce pkcs7_get_message_sig() and verify_pkcs7_message_sig()"
  - Retitled to "PKCS#7: Refactor verify_pkcs7_signature() and
    add pkcs7_get_message_sig()"
  - Reworded description to clarify why the refactoring is needed.
    The code is unchanged. (Suggested by Mimi Zohar)
  - Added Mimi Zohar's Reviewed-by.

- Patch "PKCS#7: Introduce pkcs7_get_digest()"
  - Added Mimi Zohar's Reviewed-by.

- Patch "integrity: Introduce integrity_keyring_from_id"
  - Added Mimi Zohar's Signed-off-by.

- Patch "integrity: Introduce asymmetric_sig_has_known_key()"
  - Added Mimi Zohar's Signed-off-by.

- Patch "integrity: Select CONFIG_KEYS instead of depending on it"
  - Added Mimi Zohar's Signed-off-by.

- Patch "ima: Introduce is_ima_sig()"
  - Renamed function to is_signed() (suggested by Mimi Zohar).

- Patch "ima: Add functions to read and verify a modsig signature"
  - Changed stubs for the !CONFIG_IMA_APPRAISE_MODSIG to return -EOPNOTSUPP
    instead of -ENOTSUPP, since the latter isn't defined in uapi headers.
  - Moved functions to the patches which use them and dropped this patch
    (suggested by Mimi Zohar).

- Patch "ima: Implement support for module-style appended signatures"
  - Prevent reading and writing of IMA_MODSIG xattr in ima_read_xattr()
    and ima_inode_setxattr().
  - Simplify code in process_measurement() which decides whether to try
    reading a modsig (suggested by Mimi Zohar).
  - Moved some functions from patch "ima: Add functions to read and verify
    a modsig signature" into this patch.

- Patch "ima: Add new "d-sig" template field"
  - New patch containing code from patch "ima: Write modsig to the measurement list"
    (Suggested by Mimi Zohar).

- Patch "ima: Write modsig to the measurement list"
  - Moved some functions from patch "ima: Add functions to read and verify
    a modsig signature" into this patch.
  - Moved code related to d-sig support to new patch.

- Patch "ima: Write modsig to the measurement list"
  - New patch.

Changes since v5:
- Patch "ima: Remove some superfluous parentheses"
  - Dropped.

- Patch "evm, ima: Remove superfluous parentheses"
  - Dropped.

- Patch "evm, ima: Remove more superfluous parentheses"
  - Dropped.

- Patch "ima: Don't pass xattr value to EVM xattr verification."
  - Dropped.

- Patch "ima: Store measurement after appraisal"
  - Dropped.

- Patch "MODSIGN: Export module signature definitions"
  - Reduced changes to the code that was moved into validate_module_sig()
    to the minimum necessary (suggested by Mimi Zohar).
  - Added SPDX license identifier.

- Patch "PKCS#7: Introduce pkcs7_get_message_sig() and verify_pkcs7_message_sig()"
  - In the hypothetical case that there's more than one sinfo, changed
    pkcs7_get_message_sig() to return NULL instead of the first sinfo's sig.
  - Dropped Mimi's Reviewed-by because of the code change above.

- Patch "PKCS#7: Introduce pkcs7_get_digest()"
  - New patch.

- Patch "integrity: Introduce integrity_keyring_from_id"
  - Add stub in case CONFIG_INTEGRITY_SIGNATURE isn't set.

- Patch "integrity: Introduce asymmetric_sig_has_known_key()"
  - New patch.

- Patch "ima: Introduce is_ima_sig"
  - New patch, with code from "ima: Improvements in ima_appraise_measurement"

- Patch "ima: Add modsig appraise_type option for module-style appended signatures"
  - Changed appraise_type to accept "imasig|modsig" instead of
    "modsig|imasig" to reflect the fact that now IMA only looks for
    the modsig after failing to find a suitable imasig stored in the xattr.
  - Added SPDX license identifier.

- Patch "ima: Add functions to read and verify a modsig signature"
  - Changed ima_read_modsig() to abort loading the modsig if it uses a key
    which isn't known to IMA.
  - Changed ima_get_modsig_hash() to use pkcs7_get_digest().

- Patch "ima: Implement support for module-style appended signatures"
  - Added ima_xattr_sig_known_key() auxiliary function.
  - Call ima_read_modsig() directly from process_measurement() instead of
    from ima_appraise_measurement(), and only if there's no xattr signature
    or if the xattr signature uses a key which isn't known to IMA.
  - hash_algo in process_measurement() is always obtained from the xattr
    signature, never from the modsig.
  - Changes to ima_appraise_measurement() are a lot simpler now, and don't
    involve going back to the main switch statement a second time.
  - Pass xattr_value to evm_verifyxattr() unless xattr_value is a modsig.

- Patch "ima: Write modsig to the measurement list"
  - Since now we determine whether we'll use an xattr sig or a modsig
    at the time they are read, there's no need to store a measurement
    again in the modsig case. Thus, this patch doesn't need to change
    ima_store_measurement() nor process_measurement() anymore.
  - Define new "d-sig" template field which holds the digest that is
    expected to match the one contained in the modsig.
  - Moved addition of ima_modsig_serialize_data() to patch "ima: Add
    functions to read and verify a modsig signature".
  - Increase MAX_TEMPLATE_NAME_LEN to 24.

Thiago Jung Bauermann (14):
  MODSIGN: Export module signature definitions
  PKCS#7: Refactor verify_pkcs7_signature() and add
    pkcs7_get_message_sig()
  PKCS#7: Introduce pkcs7_get_digest()
  integrity: Introduce struct evm_xattr
  integrity: Introduce integrity_keyring_from_id()
  integrity: Introduce asymmetric_sig_has_known_key()
  integrity: Select CONFIG_KEYS instead of depending on it
  ima: Introduce is_signed()
  ima: Export func_tokens
  ima: Add modsig appraise_type option for module-style appended
    signatures
  ima: Implement support for module-style appended signatures
  ima: Add new "d-sig" template field
  ima: Write modsig to the measurement list
  ima: Store the measurement again when appraising a modsig

 Documentation/ABI/testing/ima_policy      |   6 +-
 Documentation/security/IMA-templates.rst  |   5 +
 certs/system_keyring.c                    |  61 ++++++---
 crypto/asymmetric_keys/pkcs7_parser.c     |  16 +++
 crypto/asymmetric_keys/pkcs7_verify.c     |  25 ++++
 include/crypto/pkcs7.h                    |   5 +
 include/linux/module.h                    |   3 -
 include/linux/module_signature.h          |  44 +++++++
 include/linux/verification.h              |  10 ++
 init/Kconfig                              |   6 +-
 kernel/Makefile                           |   2 +-
 kernel/module.c                           |   1 +
 kernel/module_signing.c                   |  77 +++++------
 security/integrity/Kconfig                |   2 +-
 security/integrity/digsig.c               |  28 +++-
 security/integrity/digsig_asymmetric.c    |  44 +++++--
 security/integrity/evm/evm_crypto.c       |   4 +-
 security/integrity/evm/evm_main.c         |  10 +-
 security/integrity/ima/Kconfig            |  13 ++
 security/integrity/ima/Makefile           |   1 +
 security/integrity/ima/ima.h              |  67 ++++++++++
 security/integrity/ima/ima_api.c          |   8 +-
 security/integrity/ima/ima_appraise.c     |  78 +++++++++--
 security/integrity/ima/ima_main.c         |  33 ++++-
 security/integrity/ima/ima_modsig.c       | 212 ++++++++++++++++++++++++++++++
 security/integrity/ima/ima_policy.c       |  81 ++++++++++--
 security/integrity/ima/ima_template.c     |  31 ++++-
 security/integrity/ima/ima_template_lib.c |  49 ++++++-
 security/integrity/ima/ima_template_lib.h |   2 +
 security/integrity/integrity.h            |  30 ++++-
 30 files changed, 825 insertions(+), 129 deletions(-)
 create mode 100644 include/linux/module_signature.h
 create mode 100644 security/integrity/ima/ima_modsig.c

