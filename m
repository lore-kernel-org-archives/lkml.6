Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1797295-1527158616-2-172667729543118695
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
    1527158615; b=GnQSqt7Nbt/0YQvlcvfeC7AiXMjvE3Ns8bMpzuGvS0onVi0xcp
    wAYr4LzZ7Dv7L79hMMKFdPofua31CvucgmVABvlfLlVRT62358PRnbo+s+usGtwt
    oQ45yGyMzadS/5BaPh9Sd44SujJcPRdGVPG944WHWcv9jNJYEl5cNwqt/nS2f1Wc
    Eqi31SpXfbbN+L92DX/ZWeAlldp9076tM//fRJurTpPQrNwE7HLoXXcA1QGgKQjU
    /LcMioX16FkUOz1srAhX2vM227X/PBtOxFGjIvrEtLZ1wT6HcsUPaZeQNAtkMllc
    pmPxOwXw1bySsHn1G2zHbU+ktB8CKWCscTeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527158615; bh=71ILKWYxp0MnjznnCNhqRSxMQRp5z4
    7NVVPL7ZznuS8=; b=bslCwxZIFfNVz8TXYsPR+s/Cuf66ApUS0EIENIQhccAcVk
    qoVmjPKFbHKRKk0eCaYGxMnfm3STSfzb0/mO9EqJMBPu1q/378kie9kW1ttT+em0
    IUtMcW8ZdKBRDa7OHy72p4d/njGqRWWiK5QKFdqKvTPePcvPL+04dQ8zcKb2EtNl
    6laTfHMn+gVJyg1z428Iw9hLMEu8RElXLnAsks8gWnxrCv4mH4sSjAsRg27d1G5L
    a00iDLJ8HD4gRzl7TPV5nDSCAVH8QELPeLqohQTY3CnAeqvRjNS2IPyRI9jDyqPG
    nc1+eVMrqiDPRWOE2zDBBYK5tV1G0b+8azDs5Nug==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=tEG9Rkrf x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=tEG9Rkrf x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfFEOJeyO+sjhZqUqLtMri5EBOEDYT1hl/+kNMC0TQ40uWvDboqTett8zpAFIlvfphIaXbZTzGLb+GdQ6S7AhK0IVgf37DC5+trAf1je7pefgOqiZTSB4
    YzQqi2VdsL0v17qyCQRHiZM7usSWguFnkiJfW3EFgxW3y5sHH/YNf75vYGNjMcGcKaslssJ/qW+It9I0p9otxUNARNUW7LFzYVNp9Nplx9iUkL6skt3OCDko
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=gvl4HP8tAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=gHKpONVr7PSgpswXA0sA:9 a=g0HygFdazKld5Uvo:21 a=DdutMEGR732iBeq7:21
    a=QEXdDO2ut3YA:10 a=tRkgsvjveJ3YVe9fnr1q:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032346AbeEXKnW (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:43:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030586AbeEXJ6Q (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:58:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sjoerd Simons <sjoerd.simons@collabora.co.uk>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 122/165] ASoC: rockchip: rk3288-hdmi-analog: Select needed codecs
Date: Thu, 24 May 2018 11:38:48 +0200
Message-Id: <20180524093626.942167592@linuxfoundation.org>
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

From: Ezequiel Garcia <ezequiel@collabora.co.uk>

[ Upstream commit b1d0db067fbe2598d62b248beea5d705a0ea7642 ]

The driver does not select all the codec drivers that needs.
Fix it by selecting the analog and HDMI codecs.

Cc: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.co.uk>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/rockchip/Kconfig |    3 +++
 1 file changed, 3 insertions(+)

--- a/sound/soc/rockchip/Kconfig
+++ b/sound/soc/rockchip/Kconfig
@@ -56,6 +56,9 @@ config SND_SOC_RK3288_HDMI_ANALOG
 	depends on SND_SOC_ROCKCHIP && I2C && GPIOLIB && CLKDEV_LOOKUP
 	select SND_SOC_ROCKCHIP_I2S
 	select SND_SOC_HDMI_CODEC
+	select SND_SOC_ES8328_I2C
+	select SND_SOC_ES8328_SPI if SPI_MASTER
+	select DRM_DW_HDMI_I2S_AUDIO if DRM_DW_HDMI
 	help
 	  Say Y or M here if you want to add support for SoC audio on Rockchip
 	  RK3288 boards using an analog output and the built-in HDMI audio.
