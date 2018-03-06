Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4005293-1520323697-2-14821112875194638510
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520323696; b=Bp5D8yd9nam9H683tUy9AB1k5MJYrAqmEB6DBP/BMBMNKwo
    UaDlPPD8m66fHCVSs/gI2sbcl9IqaWVRQ/k8Upgxj2ut42kMT5sVZuqec2XeXJ7q
    pFtFPkqQQ+9i+uXd4X3nfz1YgIY/RG9NVPQzIFKj8+chdaH5rc9cO3VI9r62kNaD
    k3W30/pkXSge9SJ4+7oSfQrgFrH2r2KqhShAshZO1W0WlgzAjQ9fV5am8sGIk37Z
    PLIqbKBPoTjBtl0PLvC5cJWnA6ZnJBwI8/AihyWdKDWYzDLPpPZRebsS5IsdVmLw
    WPzv6j+fSbNFGuZT9pEHpTlEeJ/+McBOY9TDs7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1520323696; bh=rz33RKCmHaWGSiJew6x70n7x1kcghrimDsMlG66aeQs=; b=X
    W7u3cIoMiqDX0q6FEzLIsgGmfZIUm44YaRRXlxBYtOPtG4FCL7EulzmgU0ELduzO
    xT7sEnD0Pq5WDokkfY7oJqXfAdIBO4vseuTLlv5oQv2PL2gBnNWGH1mU6TF8Wwed
    XoyiGcL8yhKEBHg5/FVFsMbX4mBgwYRZHvGJ1Br8xvCw18v6ZGhsV+BV+E5xYOrh
    69x8ZBejXxhbe7yKa45dF7yIp3wz2seYkBkmAL3+GJPGhjaaoEvi7mgkUMsNMGUz
    w2PF0Bid0gc20i+hY1zgfYtl+hHq2ZqkMQH4jR+I8yuwz9sZBMDD0dF8riTIfHJM
    s2BgkBFU452QcpOH0bEdw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
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
        id S1750825AbeCFIIN (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 03:08:13 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:58679 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750769AbeCFIIM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Mar 2018 03:08:12 -0500
From: <patrice.chotard@st.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <linux-serial@vger.kernel.org>
CC: <patrice.chotard@st.com>
Subject: [PATCH v2 0/3] Fix STi aliases property name
Date: Tue, 6 Mar 2018 09:07:27 +0100
Message-ID: <1520323650-11030-1-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-06_04:,,
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

_ Patch 2, remove useless stdout-path property

_ Patch 3, rework the tty driver st-asc accordingly, as aliases id is retrieved 
  using of_alias_get_id() with a defined string with is not lowercase only.

v2: Fix Rob Herring's remarks :
  	  _ use serialN instead of ttyasN aliases to not break ABI
	  _ remove useless stdout-path property
	  _ update st-asc driver with "serial" alias prefix

Patrice Chotard (2):
  ARM: dts: STi: Fix aliases property name for STi boards
  ARM: dts: STi: Remove useless stdout-path for STi boards
  tty: st-asc: Update tty alias

 arch/arm/boot/dts/stih407-b2120.dts | 5 ++---
 arch/arm/boot/dts/stih410-b2120.dts | 5 ++---
 arch/arm/boot/dts/stih410-b2260.dts | 5 ++---
 arch/arm/boot/dts/stih418-b2199.dts | 5 ++---
 drivers/tty/serial/st-asc.c         | 2 +-
 5 files changed, 9 insertions(+), 13 deletions(-)

-- 
1.9.1

