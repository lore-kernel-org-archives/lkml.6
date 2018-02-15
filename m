Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754990AbeBOHhw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 02:37:52 -0500
Received: from enterprise01.smtp.diehl.com ([193.201.238.219]:43826 "EHLO
        enterprise01.smtp.diehl.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754890AbeBOHhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 02:37:50 -0500
X-$ESA-Groupmapping: true
X-IronPort-AV: E=Sophos;i="5.46,516,1511823600";
   d="scan'208";a="44466274"
From: Denis OSTERLAND <denis.osterland@diehl.com>
To: "m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>,
        "alexandre.belloni@free-electrons.com"
        <alexandre.belloni@free-electrons.com>
CC: "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH 1/4] rtc: isl1208: Fix unintended clear of SR bits
Thread-Topic: [PATCH 1/4] rtc: isl1208: Fix unintended clear of SR bits
Thread-Index: AQHTlERE9JsWiewi7k2J3pQ1IoXcHKOkas0AgAC42QA=
Date: Thu, 15 Feb 2018 07:27:47 +0000
Message-ID: <1518679666.5448.4.camel@diehl.com>
References: <20180123121801.4214-1-m.grzeschik@pengutronix.de>
         <20180123121801.4214-2-m.grzeschik@pengutronix.de>
         <20180214202610.GD8219@piout.net>
In-Reply-To: <20180214202610.GD8219@piout.net>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.153.3.249]
MIME-Version: 1.0
X-GBS-PROC: 415AWy8o668fDtCxszluz7wnyj4jzWa3saPJM3AFVOpkfmgXreDSmqsB3RSrik8W
X-MIMETrack: Itemize by SMTP Server on DIGNS29/SRV/DIEHL-HUB(Release 9.0.1FP9 HF139|October
 06, 2017) at 15.02.2018 08:27:47,
        Serialize by ntm_grab.EXE on DIGNS29/SRV/DIEHL-HUB(Release 9.0.1FP9 HF139|October
 06, 2017) at 15.02.2018 08:27:47,
        Serialize complete at 15.02.2018 08:27:47,
        Itemize by ntm_grab.EXE on DIGNS29/SRV/DIEHL-HUB(Release 9.0.1FP9 HF139|October
 06, 2017) at 15.02.2018 08:27:47,
        Serialize by Router on DIGNS29/SRV/DIEHL-HUB(Release 9.0.1FP9 HF139|October
 06, 2017) at 15.02.2018 08:27:47
X-TNEFEvaluated: 1
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-ID: <8918867F65DE854DB8517F3F638CC2FA@diehl.internal>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1F7buld023993

Am Mittwoch, den 14.02.2018, 21:26 +0100 schrieb Alexandre Belloni:
> On 23/01/2018 at 13:17:58 +0100, Michael Grzeschik wrote:
> > 
> > From: Denis Osterland <Denis.Osterland@diehl.com>
> > 
> > After successful
> > sr = isl1208_i2c_set_regs(client, 0, regs, ISL1208_RTC_SECTION_LEN);
> > sr will be 0.
> > As a result
> > sr = i2c_smbus_write_byte_data(client, ISL1208_REG_SR,
> > 			sr & ~ISL1208_REG_SR_WRTC);
> > is equal to
> > sr = i2c_smbus_write_byte_data(client, ISL1208_REG_SR, 0);
> > which clears all flags in SR.
> > 
> > Add an additional read of SR, to have value of SR in sr again.
> > 
> > Signed-off-by: Denis Osterland <Denis.Osterland@diehl.com>
> > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> > ---
> >  drivers/rtc/rtc-isl1208.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> Applied, thanks.
> 
You are welcome.

One question, shall we avoid resent this patch in v2 of this series?
I ask because we are pretty far with the suggested changes.

Regards Denis.
Diehl AKO Stiftung & Co. KG, Pfannerstraße 75-83, 88239 Wangen im Allgäu
Bereichsvorstand: Dr.-Ing. Michael Siedentop (Sprecher), Josef Fellner (Mitglied)
Sitz der Gesellschaft: Wangen i.A. – Registergericht: Amtsgericht Ulm HRA 620609 – Persönlich haftende Gesellschafterin: Diehl Verwaltungs-Stiftung – Sitz: Nürnberg – Registergericht: Amtsgericht Nürnberg HRA 11756 –
Vorstand: Dr.-Ing. E.h. Thomas Diehl (†) (Vorsitzender), Herr Dipl.-Wirtsch.-Ing. Wolfgang Weggen (stellvertretender Vorsitzender), Dipl.-Kfm. Claus Günther, Dipl.-Kfm. Frank Gutzeit, Dr.-Ing. Heinrich Schunk, Dr.-Ing. Michael Siedentop , Dipl.-Kfm. Dr.-Ing. Martin Sommer, Dipl.-Ing. (FH) Rainer von Borstel, Vorsitzender des Aufsichtsrates: Dr. Klaus Maier
___________________________________________________________________________________________________
Der Inhalt der vorstehenden E-Mail ist nicht rechtlich bindend. Diese E-Mail enthaelt vertrauliche und/oder rechtlich geschuetzte Informationen.
Informieren Sie uns bitte, wenn Sie diese E-Mail faelschlicherweise erhalten haben. Bitte loeschen Sie in diesem Fall die Nachricht. Jede unerlaubte Form der Reproduktion, Bekanntgabe, Aenderung, Verteilung und/oder Publikation dieser E-Mail ist strengstens untersagt.
The contents of the above mentioned e-mail is not legally binding. This e-mail contains confidential and/or legally protected information. Please inform us if you have received this e-mail by mistake and delete it in such a case. Each unauthorized reproduction, disclosure, alteration, distribution and/or publication of this e-mail is strictly prohibited.
