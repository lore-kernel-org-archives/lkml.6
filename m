Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-196919-1522174088-2-16455324450567424991
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, URIBL_BLACK 1.7,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522174088; b=KQq/ZumRp2kqjXY8GXphligyOfzyM5wpSRrHbu4hoHviu+/
    /AdMUFyXnDqOJ12DdqlAo/p79dchOLyRBi5guukFeb+GnYmW8CuRZ2dN0KDRckZu
    qpWheYBiYSfKdYPQGVF/qET3PPAKkHnYiWnAkMD1PAKV5degzMCxQhs/SWxKvILj
    ELW/sCg/qxLhRgzBnkO5Gz2hIkLIVfmG8zbxqExnT/D46pft4wUE4t3sIjaJqs0N
    Wt8W+/yTrAs/l6GqJb+xvi70ZIQOeDM7flN4vxILnMBL3tCQcd9atkxkHi6NpFP0
    uud6aeMzpcmnOsaClelO9rjj3CNymGhelCRnxLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522174088; bh=vxZTEl/0IbHtpYr+vTNxZF3pVJ
    6fx6Plao5XZLuvm8M=; b=KsrArolbtMu5U9rF7G64RmR0+7ZzsSkZTiDftyAXWi
    zkI/QsO/btybomVu037W/c2VJGBJ3wK728gea94T0jP9JRkhGnzDfxThacp+tteE
    0ouJUigDVZM308yihiv84xDkbCTgA+TcfKxiC2+qjRyg3ooagxmfllZm5Orgxxvk
    VOEOwr/t8krcOfUKQQG18qImoEFeU250/5QLOwUBWrguDecHZkWc1ZxkZYa4fqdD
    nrPiRkoasoKakJLZLWRk+2EAtYw2xlFHjpNQXjpy+MKdxFibsDXwx/qbQihGVmso
    TPb3Ud/XWj/0q2PKul+bXK4eSFo0eAoV8KSpbniPej9w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP+tfA67or7JCi7lTxHNoN/pIq+KxerGb7xgrZPoaeSqUxsFEYtoGCs8+n4kLXylc6NAA0vpng6kvmw0Wn5h2RK7N/shwjHj4QIVfjyzixCkkR4H3E+m
    PYXFEwEI9AR2I5oPaEOu7KOisRLJiivgHGseNGzJFhoxECChXzXN6ahBjN4ctCRczQ+PzP3wedH/rir33Dq04aee4Txi9KzrY50LhXE2mXngTeWZ1zKyJFGn
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=yQdBAQUQAAAA:8 a=VwQbUJbxAAAA:8 a=Op-mwl0xAAAA:8 a=LpQP-O61AAAA:8
    a=ag1SF4gXAAAA:8 a=PiMjbuRkwvBlGGGJ92oA:9 a=QEXdDO2ut3YA:10
    a=SzazLyfi1tnkUD6oumHU:22 a=AjGcO6oz07-iQ99wixmX:22 a=_kNtSFdpYmJUICABlfa3:22
    a=pioyyrs4ZptJ924tMmac:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751110AbeC0SH4 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 14:07:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41360 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751192AbeC0Q3a (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:29:30 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Larry Finger <Larry.Finger@lwfinger.net>,
        James Cameron <quozl@laptop.org>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.4 27/43] rtlwifi: rtl8723be: Fix loss of signal
Date: Tue, 27 Mar 2018 18:27:31 +0200
Message-Id: <20180327162717.940562599@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162716.407986916@linuxfoundation.org>
References: <20180327162716.407986916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Larry Finger <Larry.Finger@lwfinger.net>

commit 78dc897b7ee67205423dbbc6b56be49fb18d15b5 upstream.

In commit c713fb071edc ("rtlwifi: rtl8821ae: Fix connection lost problem
correctly") a problem in rtl8821ae that caused loss of signal was fixed.
That same problem has now been reported for rtl8723be. Accordingly,
the ASPM L1 latency has been increased from 0 to 7 to fix the instability.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Stable <stable@vger.kernel.org>
Tested-by: James Cameron <quozl@laptop.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c
@@ -1123,7 +1123,8 @@ static void _rtl8723be_enable_aspm_back_
 
 	/* Configuration Space offset 0x70f BIT7 is used to control L0S */
 	tmp8 = _rtl8723be_dbi_read(rtlpriv, 0x70f);
-	_rtl8723be_dbi_write(rtlpriv, 0x70f, tmp8 | BIT(7));
+	_rtl8723be_dbi_write(rtlpriv, 0x70f, tmp8 | BIT(7) |
+			     ASPM_L1_LATENCY << 3);
 
 	/* Configuration Space offset 0x719 Bit3 is for L1
 	 * BIT4 is for clock request
