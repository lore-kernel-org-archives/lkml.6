Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2707851-1524408555-2-7982826846021062726
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524408554; b=NNYREtmhT1d11em+Yw/bwyG1rtyxVINl9slNPf5ZFv8+WvAr9Y
    ZHlgS1xawSLADzpCyff3Fxcs+SJFOv+JUti4+CsOnlPuHESZdqbHdyfGiE3yK6V1
    X7Og1/sPqG8U6G4RuWsU1EyAcDpG49ePAZwtVhe+YRSwVqrjeGASyeX6oO/cuJ7n
    bmyJRJtIexwatr9jRgcXk/FK1W90B0tkLxhNknqoS9yAiAKguWEMcp2Q4LnbzJiN
    /wMaSW3caTz4x39IRhstQ8HDFAEG7VE7Wt7PnRH0OdnFdSLqP/GrSRbV3WPoKOD4
    vvCPD06mVPhWZ8FTgxsEQqwzFdqSoLWgTJLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524408554; bh=F21zh+C/L90jsD7LgUwwiPP/Z62a+H
    rZEW9kLFEL268=; b=Ru/RJOXsfxF69ifsjYx50xOKROY8S+hgLiS1AlmaoLJAW+
    rs5BmDsL5AxzjaYfz62J6Lsh5OvAfDSo7HKdHkGJ+XE4sCuMtUEDL1P0JDkU9ibn
    IyqQqoM2Wc9hpQVagMA1/B/BcD8iV2WyFUd5EMM1j9o0e3nt/V3s78C0q2Ls4HSC
    zDFGY2c67ZEYcFWu940z8bcyIOHkcmEWg+gTDfO8lQpciPYD8+87bYBAmEIbX9Nw
    gtpMFyNikHj5ATa1G8xDrTEYQyHVT6RuC4NAIQQYz6bhMuUW8DsbkRiPVd1h7sjM
    /PVfXYrDPjNIoK8Q2Piin4OmL1IEbvhvkpfaTDEA==
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
X-CM-Envelope: MS4wfKrrKkDzKu9VOoeu1crP3XsooYuJYXKMpj/RLgW4UPfXQPdC7aMkgEARDTTEewDs0bZWLH1vRcUbt/Eja9IclV92rYXHdiPf/UjnLT2Ng7QyyokN1Twe
    ru+C+EqtbF3BHP5RdZggmAsx6MAdOEdnQ6gg0wZYcBm6pQiJImjo9w3e+T95yE68mUw6QwnEt7ysyYG5czyzFNCqIj5ISAEC4nzcYJzyRndXl47Qe8AmCH0R
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=iox4zFpeAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=PyAcsGnoYPOmBCnezHkA:9
    a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932176AbeDVOPt (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:15:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56988 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757007AbeDVOPr (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:15:47 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bassem Boubaker <bassem.boubaker@actia.fr>,
        Oliver Neukum <oneukum@suse.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 16/97] cdc_ether: flag the Cinterion AHS8 modem by gemalto as WWAN
Date: Sun, 22 Apr 2018 15:52:54 +0200
Message-Id: <20180422135305.522935434@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
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

From: Bassem Boubaker <bassem.boubaker@actia.fr>


[ Upstream commit 53765341ee821c0a0f1dec41adc89c9096ad694c ]

The Cinterion AHS8 is a 3G device with one embedded WWAN interface
using cdc_ether as a driver.

The modem is controlled via AT commands through the exposed TTYs.

AT+CGDCONT write command can be used to activate or deactivate a WWAN
connection for a PDP context defined with the same command. UE
supports one WWAN adapter.

Signed-off-by: Bassem Boubaker <bassem.boubaker@actia.fr>
Acked-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/cdc_ether.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -705,6 +705,12 @@ static const struct usb_device_id	produc
 				      USB_CDC_PROTO_NONE),
 	.driver_info = (unsigned long)&wwan_info,
 }, {
+	/* Cinterion AHS3 modem by GEMALTO */
+	USB_DEVICE_AND_INTERFACE_INFO(0x1e2d, 0x0055, USB_CLASS_COMM,
+				      USB_CDC_SUBCLASS_ETHERNET,
+				      USB_CDC_PROTO_NONE),
+	.driver_info = (unsigned long)&wwan_info,
+}, {
 	/* Telit modules */
 	USB_VENDOR_AND_INTERFACE_INFO(0x1bc7, USB_CLASS_COMM,
 			USB_CDC_SUBCLASS_ETHERNET, USB_CDC_PROTO_NONE),
