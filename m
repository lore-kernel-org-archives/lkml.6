Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2751116-1520412690-2-8117738704134254101
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520412689; b=U5bQKygKcUHsQ/mw3bigm/H4DVjJcT7Nqd5B4+3ui7V6s+M
    LlgmWpcaaGdeKtYxnKuPjgtYp7Rzz5sd013U+g5OjgN85yl3v7YwVwGMyFclsflC
    r0LTNSGiIP9L1hLhB6i7aKxiQO/EdF3J7xlm9EyIAWFdLSlCkWlePPDqCGrKzxLX
    O+nMq/dVQYcA01QbKv/mYgpkjeT/FBA4y0veGCRS8eiqajnCUinABzC9ye1GpftK
    cy/8H6T7Bod3JDH06ucbpbp2AxHM8dpeT7mKxbzkB8pbKLQ/w9rsymfM39n8KaNT
    zt4xjXbfXhSJb6oru6d50Lrd+zxwvFurBKsll8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1520412689; bh=UO9naaAP2rAUm6VFD0wtRxEJ3it4mibVgZO/sMa3WC4=; b=B
    2MXcBnP4PMjJc0R8SwlJCxxhCKwjJEDCtpK2hdufFcLr6GR3UkwGuB7kG0X7kNpb
    BzXo+bbhU6+k71Di0U7Tn2jh1H9TvgyqNmJYCyDZI8BjtTT3LxSlibi8Wy0cAT4a
    4xaYY7WgBpjjSb2kWl5sA7TgAHTbrb1B1MYPvmQP5rdxzA/X6YXbHxEBQ7BafxwQ
    rfw8pqy9fQBK0YOhy2K5bgwyLs92yzDosxpzUymUJVMk3z8hQGbeqfYfbS5c6boR
    pTm61J/7KFDbegBlCppzi9AOKrAY96cjo7PUIXZNtiVxu422NF3bIrmaGLMSeSqi
    SwBmh7lJhyWwElfLaZ4WA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754210AbeCGIvE (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 03:51:04 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:13415 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751284AbeCGIuj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Mar 2018 03:50:39 -0500
From: <patrice.chotard@st.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <linux-serial@vger.kernel.org>
CC: <patrice.chotard@st.com>
Subject: [PATCH v3 0/3] Fix STi aliases property name
Date: Wed, 7 Mar 2018 09:49:54 +0100
Message-ID: <1520412597-30545-1-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-07_03:,,
 signatures=0
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Patrice Chotard <patrice.chotard@st.com>

Since dtc v1.4.6-9-gaadd0b65c987, when compiling dtb with W=1 option,
the following warnings are triggered :
    
arch/arm/boot/dts/stih418-b2199.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
arch/arm/boot/dts/stih407-b2120.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
arch/arm/boot/dts/stih410-b2260.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
arch/arm/boot/dts/stih410-b2120.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'

_ Patch 1, convert the aliases property name in lowercase in 
  all STi board dts files.

_ Patch 2, remove "console=serialN" from bootargs property

_ Patch 3, rework the tty driver st-asc accordingly, as aliases id is retrieved 
  using of_alias_get_id() with a defined string with is not lowercase only.

v3: Fix Rob Herring's remarks :
      _ remove "console=serialN,115200" from bootargs and use prefered stdout-path property
      _ update st-asc driver with "serial" alias prefix and keep "ttyAS" in second choice

v2: Fix Rob Herring's remarks :
      _ use serialN instead of ttyasN aliases to not break ABI
      _ remove useless stdout-path property
      _ update st-asc driver with "serial" alias prefix

Patrice Chotard (3):
  ARM: dts: STi: Fix aliases property name for STi boards
  ARM: dts: STi: Remove console=serialN from bootargs for STi boards
  tty: st-asc: Update tty alias

 arch/arm/boot/dts/stih407-b2120.dts | 4 ++--
 arch/arm/boot/dts/stih410-b2120.dts | 4 ++--
 arch/arm/boot/dts/stih410-b2260.dts | 4 ++--
 arch/arm/boot/dts/stih418-b2199.dts | 4 ++--
 drivers/tty/serial/st-asc.c         | 4 +++-
 5 files changed, 11 insertions(+), 9 deletions(-)

-- 
1.9.1

