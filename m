Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77726C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7BC20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7BC20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=diehl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388389AbeGXMrR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:47:17 -0400
Received: from enterprise03.smtp.diehl.com ([193.201.238.214]:31107 "EHLO
        enterprise03.smtp.diehl.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388256AbeGXMrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:47:16 -0400
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Jul 2018 08:47:11 EDT
X-$ESA-Groupmapping: true
X-IronPort-AV: E=Sophos;i="5.51,397,1526335200"; 
   d="scan'208";a="1739767"
From:   Denis OSTERLAND <denis.osterland@diehl.com>
To:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        Denis OSTERLAND <denis.osterland@diehl.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH v5 0/5] rtc: isl1208: fixes, documentation and isl1219 support
Thread-Topic: [PATCH v5 0/5] rtc: isl1208: fixes, documentation and isl1219
 support
Thread-Index: AQHUI0HY3oZ43+1oq0ulwj9woBrmAA==
Date:   Tue, 24 Jul 2018 11:31:21 +0000
Message-ID: <20180724095437.6016-1-Denis.Osterland@diehl.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
MIME-Version: 1.0
X-TrailerSkip: 1
X-GBS-PROC: byQFdw3ukCM+zy1/poiPc3S+cPOwesVRp3YOtqJ1nLG8aTLXZ+KEA0OUxYeiE/X7
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes since v4:
 - fix 'souces' typo and change interrupt documentation
 - change "isil,ev-evienb" type to int and do not touch bit if not present
 - pass ISL1219_REG_EV_EVEN directly instead of assigning it to rc
 - fix module build by adding EXPORT_SYMBOL to rtc_add_group(s)
 - use kcalloc
 - return error if device is already registered
 - include helper functions into rtc_add_groups

Michael Grzeschik (1):
    rtc: isl1208: add support for isl1219 with tamper detection

Denis Osterland (4):
    rtc: sysfs: facilitate attribute add to rtc device
    rtc: isl1208: Add "evdet" interrupt source for isl1219.
    rtc: isl1208: set ev-evienb bit from device tree
    rtc: isl1219: add device tree docu

 .../devicetree/bindings/rtc/isil,isl1219.txt       |  29 ++++
 drivers/rtc/rtc-core.h                             |  13 ++
 drivers/rtc/rtc-isl1208.c                          | 192 ++++++++++++++++++---
 drivers/rtc/rtc-sysfs.c                            |  43 +++++
 4 files changed, 254 insertions(+), 23 deletions(-)

Message-Id: 20180710090710.9066-1-Denis.Osterland@diehl.com





Diehl Connectivity Solutions GmbH
Geschäftsführung: Horst Leonberger
Sitz der Gesellschaft: Nürnberg - Registergericht: Amtsgericht
Nürnberg: HRB 32315
___________________________________________________________________________________________________

Der Inhalt der vorstehenden E-Mail ist nicht rechtlich bindend. Diese E-Mail enthaelt vertrauliche und/oder rechtlich geschuetzte Informationen.
Informieren Sie uns bitte, wenn Sie diese E-Mail faelschlicherweise erhalten haben. Bitte loeschen Sie in diesem Fall die Nachricht.
Jede unerlaubte Form der Reproduktion, Bekanntgabe, Aenderung, Verteilung und/oder Publikation dieser E-Mail ist strengstens untersagt.
The contents of the above mentioned e-mail is not legally binding. This e-mail contains confidential and/or legally protected information. Please inform us if you have received this e-mail by
mistake and delete it in such a case. Each unauthorized reproduction, disclosure, alteration, distribution and/or publication of this e-mail is strictly prohibited. 
