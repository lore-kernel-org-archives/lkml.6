Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752617AbeB1Mzt convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 07:55:49 -0500
Received: from enterprise01.smtp.diehl.com ([193.201.238.219]:35782 "EHLO
        enterprise01.smtp.diehl.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752428AbeB1Mzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 07:55:46 -0500
X-$ESA-Groupmapping: true
X-IronPort-AV: E=Sophos;i="5.47,405,1515452400";
   d="scan'208";a="45685401"
From: Denis OSTERLAND <denis.osterland@diehl.com>
To: "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@free-electrons.com"
        <alexandre.belloni@free-electrons.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mgr@pengutronix.de" <mgr@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Denis OSTERLAND <denis.osterland@diehl.com>
Subject: [PATCH v2 0/4] rtc: isl1208: fixes, documentation and isl1219 support
Thread-Topic: [PATCH v2 0/4] rtc: isl1208: fixes, documentation and isl1219
 support
Thread-Index: AQHTsJIOcHZA4fRjlk6Cw87EC+P7DQ==
Date: Wed, 28 Feb 2018 12:45:47 +0000
Message-ID: <1519821214-22379-1-git-send-email-Denis.Osterland@diehl.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.153.3.249]
MIME-Version: 1.0
X-GBS-PROC: byQFdw3ukCM+zy1/poiPc0CGI8Kj8nA1470zzstx6GxOZJaUnR4wS2jLMesKTORe
X-MIMETrack: Itemize by SMTP Server on DIGNS29/SRV/DIEHL-HUB(Release 9.0.1FP10 HF66|February
 09, 2018) at 28.02.2018 13:45:47,
        Serialize by ntm_grab.EXE on DIGNS29/SRV/DIEHL-HUB(Release 9.0.1FP10 HF66|February
 09, 2018) at 28.02.2018 13:45:47,
        Serialize complete at 28.02.2018 13:45:47,
        Itemize by ntm_grab.EXE on DIGNS29/SRV/DIEHL-HUB(Release 9.0.1FP10 HF66|February
 09, 2018) at 28.02.2018 13:45:47,
        Serialize by Router on DIGNS29/SRV/DIEHL-HUB(Release 9.0.1FP10 HF66|February
 09, 2018) at 28.02.2018 13:45:47
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes since v1:
Represent isl1219 tamper detection as RTC timestamp event,
instead of hwmon intrusion sensor.
Switch to rtc_register_device, to fix possible race conditions in probe.
Add documentation of the two possible interrupt sources for isl1219.
Support "evdet" named interrupt souce.

Michael Grzeschik (2):
  rtc: isl1208: enable interrupt after context preparation
  rtc: isl1208: add support for isl1219 with tamper detection

Denis Osterland (2):
  rtc: isl1208: switch to rtc_register_device
  rtc: isl1208: Add "evdet" interrupt source for isl1219.

 .../devicetree/bindings/rtc/isil,isl1219.txt       |  28 +++
 drivers/rtc/rtc-isl1208.c                          | 209 +++++++++++++++++----
 2 files changed, 203 insertions(+), 34 deletions(-)

Message-Id: 20180123121801.4214-1-m.grzeschik@pengutronix.de


Diehl AKO Stiftung & Co. KG, Pfannerstraße 75-83, 88239 Wangen im Allgäu
Bereichsvorstand: Dr.-Ing. Michael Siedentop (Sprecher), Josef Fellner (Mitglied)
Sitz der Gesellschaft: Wangen i.A. – Registergericht: Amtsgericht Ulm HRA 620609 – Persönlich haftende Gesellschafterin: Diehl Verwaltungs-Stiftung – Sitz: Nürnberg – Registergericht: Amtsgericht Nürnberg HRA 11756 –
Vorstand: Dr.-Ing. E.h. Thomas Diehl (†) (Vorsitzender), Herr Dipl.-Wirtsch.-Ing. Wolfgang Weggen (stellvertretender Vorsitzender), Dipl.-Kfm. Claus Günther, Dipl.-Kfm. Frank Gutzeit, Dr.-Ing. Heinrich Schunk, Dr.-Ing. Michael Siedentop , Dipl.-Kfm. Dr.-Ing. Martin Sommer, Dipl.-Ing. (FH) Rainer von Borstel, Vorsitzender des Aufsichtsrates: Dr. Klaus Maier
___________________________________________________________________________________________________
Der Inhalt der vorstehenden E-Mail ist nicht rechtlich bindend. Diese E-Mail enthaelt vertrauliche und/oder rechtlich geschuetzte Informationen.
Informieren Sie uns bitte, wenn Sie diese E-Mail faelschlicherweise erhalten haben. Bitte loeschen Sie in diesem Fall die Nachricht. Jede unerlaubte Form der Reproduktion, Bekanntgabe, Aenderung, Verteilung und/oder Publikation dieser E-Mail ist strengstens untersagt.
The contents of the above mentioned e-mail is not legally binding. This e-mail contains confidential and/or legally protected information. Please inform us if you have received this e-mail by mistake and delete it in such a case. Each unauthorized reproduction, disclosure, alteration, distribution and/or publication of this e-mail is strictly prohibited.
