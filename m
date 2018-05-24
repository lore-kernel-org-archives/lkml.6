Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1797295-1527158621-2-1317902959040247900
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527158621; b=NXsVgYh2ht9LYvuwWHCXsjA8l735NTb/V8dHHNRwIW5L+Gg2dY
    gcJZPxQKIOzGjo2lLpdoG7830+2/LvPuORWvBZk1a9z3JmRXCbK4Tq8cRJIcyssx
    dJOr2qAPweDMJFEJXrvopsnDkykivNJPVuNAeCujk82mnJ2ZUWd/GoUyP7ZIPDra
    yiCtLZR0Te+mslyohc5AtesSgqdPZDBNkOTsEaJfjh4jfTk39Fknou8TeTGmlSU8
    GhOcCPDTpOWEKaMy5m1xhpkXTJ7ldiWepo8tvhbStZxAkrTDfFDBc9ADMM26JNnQ
    PBi7wqXRsQFzIgc66djEFFOc2p5/3h1jD7VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527158621; bh=EGk5H1tj3Ux6W++MqmNOPHc8wdB1BJ
    4Qv/sUrjlNb+g=; b=YPth8zKHKb3YhzMd/uPhnnyj4KWBfsNhM6fBZKzTzYbzch
    UwcSsP92/BThJlQZ62TlnEnHXbw78ieLtEbZBnxYSf8XXCsr0dgiv0tZ2RpzgWxb
    vttVL6vS5nMy0lOGcNsjudw3XJV6uY/pmymNRzGiRoUfN07iV8zvC/YNCwFapJ5r
    O0n4yd9HTMypccgyqwWZPvfMlWYu4OEIxGI6vPF7jiM6qDNJ9XDfbSADLRD+VHFZ
    bVyhfKxb8dBGrTKoun+5cYuoJRMpHNy6gHSCWlt1WcJhyv3/O6bCV8crIi/qHbS4
    ScGvHVwTtg2XhjXVVwpobBkk2K4m9igt6xxK0jBA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=Pjbr7J4M x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=Pjbr7J4M x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHyeCjS+Vl2LNmnFM7tU1N8jjVMhZNpEEB+X5DL90SRUYiW0VJHTSk0t/na2bb2C/xSpeb5g1R8unC8gjdIZ6KBBjfIwHmrL5Rvms7mhTc2zbMfKbJ7A
    uk6Pympf9rCS3PtAeVc4B/7Wt/g44iKMial3VjHE4ZyhQ7CB/i8Cnd2rVkyN8dYYgsA3mTfJ8HS4yYSRoas5sdsziA6735QNYbrAtKV938CPLsT4VNciJhdi
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=sozttTNsAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=4uShfstDTGyhYL1vEfkA:9 a=QEXdDO2ut3YA:10 a=aeg5Gbbo78KNqacMgKqU:22
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030653AbeEXKnh (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:43:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:38012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030582AbeEXJ6N (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:58:13 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jyri Sarha <jsarha@ti.com>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 121/165] ASoC: hdmi-codec: Fix module unloading caused kernel crash
Date: Thu, 24 May 2018 11:38:47 +0200
Message-Id: <20180524093626.899960701@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

[ Upstream commit 5e558f8afaec8957932b1dbe5aeff800f9fc6957 ]

The hcp->chmap_info must not be freed up in the hdmi_codec_remove()
function as it leads to kernel crash due ALSA core's
pcm_chmap_ctl_private_free() is trying to free it up again when the card
destroyed via snd_card_free.

Commit cd6111b26280a ("ASoC: hdmi-codec: add channel mapping control")
should not have added the kfree(hcp->chmap_info); to the hdmi_codec_remove
function.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reviewed-by: Jyri Sarha <jsarha@ti.com>
Tested-by: Jyri Sarha <jsarha@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/hdmi-codec.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -801,12 +801,7 @@ static int hdmi_codec_probe(struct platf
 
 static int hdmi_codec_remove(struct platform_device *pdev)
 {
-	struct device *dev = &pdev->dev;
-	struct hdmi_codec_priv *hcp;
-
-	hcp = dev_get_drvdata(dev);
-	kfree(hcp->chmap_info);
-	snd_soc_unregister_codec(dev);
+	snd_soc_unregister_codec(&pdev->dev);
 
 	return 0;
 }
