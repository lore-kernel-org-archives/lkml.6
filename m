Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3808880-1520444176-2-6901793587390372978
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
    t=1520444176; b=DhwfUWNpZzmkI3L+huWw0ppQC3y70A0zO/B1BHYLcde0/v8
    lRLmqpVfwCTRjsDeF8AMaIXLsHmtN5avchcJAf7CdgUw/NbNrXPyIdD+SBq/HaC8
    XwlHWryRQJC7AxX1j+OQHvU2Pld6RXPwxwJjyOxxm9GWROZUf91wRpqlyNrGPx3X
    xWgWerxCyBqHFlZf7IUNyMd4ILuXKkm7DgWlg2VRowNDMcqxO8oGggfAkSxZLWKb
    Trif/a8nfPmZb49V3RHFLin/XfwXLYIFgEPj2SX4x2cFm5nwlSNDkDRHaKjVESb5
    lptjbs4XWuIKcU5+pHbNoudeIGyWc+bj9dcVl5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1520444176; bh=Wsw+Y4oGMnIlePtnrQZHRXp1mDf1jxwy2UpInEaY+Nc=; b=e
    LZiA/VfS1rmpYUwiXmUfQqQvzN2L1JZX+QVchK52aTFfNEiV8uvDQRwa12vuDsTb
    9eEkrGZmnXpyd3kJxgZ/LPL/D7izY2MjDhZFW/iaxRb2sT3P/tOdBXpqyBywLXPj
    W3xcUqnDdwfY1WAd4e/OFqi9dkxlMjDh7Mah6KUOFWffCKsF0887GLWBHopz6WBX
    O08tCl+yxCOFh1GGOLnHOIH9eZuy0H7zb3kLK2DnwyAFxKPuHIniBgAcY8rAdW0Q
    KFXQ/mwNDTDTtNoKFBjhChUZrxEXdit0ZG3B4Tolq6GcLMfTqChvbDeRYj36hkOn
    sCgXa9YTpTI/TVSxEPiwg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
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
        id S933647AbeCGRgO (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 12:36:14 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:35991 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933806AbeCGRgN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Mar 2018 12:36:13 -0500
From: <patrice.chotard@st.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <linux-serial@vger.kernel.org>
CC: <patrice.chotard@st.com>
Subject: [PATCH v4 0/3] Fix STi aliases property name
Date: Wed, 7 Mar 2018 18:35:31 +0100
Message-ID: <1520444134-30144-1-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-07_08:,,
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

v4: Fix Rob Herring's remarks :
      _ reorder patches, first st-asc driver update and the DTS patches
        in order to not break boot.
      _ squash chunks of previous patch 1 into previous patch 2

v3: Fix Rob Herring's remarks :
      _ remove "console=serialN,115200" from bootargs and use prefered stdout-path property
      _ update st-asc driver with "serial" alias prefix and keep "ttyAS" in second choice

v2: Fix Rob Herring's remarks :
      _ use serialN instead of ttyasN aliases to not break ABI
      _ remove useless stdout-path property
      _ update st-asc driver with "serial" alias prefix

Patrice Chotard (3):
  tty: st-asc: Update tty alias
  ARM: dts: STi: Fix aliases property name for STi boards
  ARM: dts: STi: Remove "console=ttyASN" from bootargs for STi boards

 arch/arm/boot/dts/stih407-b2120.dts | 4 ++--
 arch/arm/boot/dts/stih410-b2120.dts | 4 ++--
 arch/arm/boot/dts/stih410-b2260.dts | 4 ++--
 arch/arm/boot/dts/stih418-b2199.dts | 4 ++--
 drivers/tty/serial/st-asc.c         | 4 +++-
 5 files changed, 11 insertions(+), 9 deletions(-)

-- 
1.9.1

