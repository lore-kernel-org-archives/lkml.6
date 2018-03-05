Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1903134-1520262153-2-3313366479979808341
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
    t=1520262153; b=wJex6JKaDAF4Eq3X72oNmngkGlYtp0KPJaamK0eJ8Ftqgba
    t+9+BKpfedy1WxXPS3GkMByExT1zjXDjBkYzAy3l2izMgtu0UYcTJVWYjU3YAwhw
    vgvr+wBrN1lm+zsqkhBf7s+5zpKcfkOMyAESEEWhigTMfoaUtXM1jpV+dSWpK6Cx
    0hMq+nXv6sMIzZTTjvtayEo1Qh4ZQvVdQEIDuq10T3kK75tGY1xSbzvzExD4HuNt
    0ExjFw8ilqWrezOS2QJ0UWzSjMWneXYM9oh3HPLpbIF35UAZr+aVrVsX4RIc3C/z
    pnjMagerdH0crWwEoNX+c69bbr/GuhHFee1Tm5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1520262153; bh=fTvCnRUBge5cT8vGdfxtTUGJL5RjMpAiKhyZ4vUf/Qs=; b=P
    5SwTjOPCLPOvbbOsPUJ07j2S5YmH/TlR9Lk5ZkrUzV5zTDTvl7f7aGtcFfGcanBg
    6WBqRVEddYODANgMG/eHt0ljF8swfjHGaP3zLkLITXJQSBe2Glm1CByNT0fRpoI1
    QbRWXRgKW7aLORhT6Ywzf8oTd9xhiKx6ugYOXC5dSQA9lJmu8yQo8LWAFPW+CXAy
    c5HpZDKB25ydfXjXhD5v1GWU4AtrFtHogEyTHvIYKv7Wy9ALeqQenmVr3Lgf2A9Z
    E339CGhkDdDGD9t3vJclj4bLotJwqZtGmS+NVYQzmSq/ybrn+4hU8nkd+FWT8yFL
    Wwnd+9CAt65Oy5/BAcDtA==
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
        id S1752162AbeCEPBi (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 10:01:38 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:44267 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751893AbeCEPBh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 5 Mar 2018 10:01:37 -0500
From: <patrice.chotard@st.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <linux-serial@vger.kernel.org>
CC: <patrice.chotard@st.com>
Subject: [PATCH 0/2] Fix STi aliases property name
Date: Mon, 5 Mar 2018 16:00:23 +0100
Message-ID: <1520262025-21088-1-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG4NODE1.st.com (10.75.127.10) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-05_06:,,
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

_ Patch 2, rework the tty driver st-asc accordingly, as aliases id is retrieved 
  using of_alias_get_id() with a defined string with is not lowercase only.


Patrice Chotard (2):
  ARM: dts: STi: Fix aliases property name for STi boards
  tty: st-asc: Convert tty alias in lowercase

 arch/arm/boot/dts/stih407-b2120.dts | 4 ++--
 arch/arm/boot/dts/stih410-b2120.dts | 4 ++--
 arch/arm/boot/dts/stih410-b2260.dts | 4 ++--
 arch/arm/boot/dts/stih418-b2199.dts | 4 ++--
 drivers/tty/serial/st-asc.c         | 2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

-- 
1.9.1

