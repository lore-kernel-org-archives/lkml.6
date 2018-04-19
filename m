Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3506551-1524155182-2-11668458482605687844
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: from='iso-8859-1', plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524155182; b=TkCDe3bTuETw7+7r9O8y0lkTF7ocjDWqNV7/jX6LfQ9NKoZOqj
    yUfSzc0Dykep0NXdTG5+xYTFewt9ktkL2FbvQuh6fZtVodTYWqAljvb0vLZY5HIj
    JAISjC5b1qbay83kE9GL96qKeg5wOqh8z1I8HXP8gO5ZND3eQclDsZTYqHothDUn
    kw2mJ1pUfRmPVddnu77EQIw0mqmxdt6+hQ0Pa5W6ltbO2zfjG13ygw1jnf0OHUlM
    tH6SV0xEOR7sggjYk6dO7aO96SlygeyQ32MswwHH22lXEfx3gLGtEPV7xxyTStPk
    0ZUB2nkI1hMsMd0SA+HMvzTBdVrsmWoOAp0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1524155182; bh=Gz51HofGUJB
    WCoG/+jM52N3QWCbtUS1FQUK/Q3dNG58=; b=Eq4onWSKEVVpk3YdeHlJd/SYu7w
    GgyT7rkhZLcTD0Wm74VE7K7i0jZsxUcY2e7gv8R4qpMVsN08DfZpGpxGwPvnIqfv
    hDfDg8xtp22VrH5mbcMFPjuqUs7LW5UczSZ1mBizT55CCI5PWcE6dUG3l5XgktoP
    FjNl3/C4HUfoH42lgb0YOrUfmjFsMpJbDFesZDYnUvnDKrwiPAzSbSyGQq6MIpki
    fpuPyZDhDlBCzbzWdM6bi1vfwwKo7/Q1fJA/QY5WoiZ8CdwS5K7/VjMCIFHe4at4
    +5utBPxNrP0IjOCs+ArbuuT8GM87ZuzKFnTCGlvhKa3/XhaQVueaRM66hGQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=pengutronix.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=pengutronix.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPBQiXMnqacupP9L/v2sAKE88aZkkoOMAq5TcAE1EN+Ms+z+yKNeeJDfZ0dHmIPN1tmPKOrQO6V1jwMaw2Ye/LK/eXy2UiSNuktm68T6xQ75mTUTJ5DP
    Uuxp/LgNf2yJbNN9pkAe4b+RK5k1TCjrIQYYR/r4H7MHR2VA97O1w0p8nWKDu2bUsIN6df6fhL/dQoB3OcekJmu79TXIKm0Er5KvzfFaCenatzWhbSRjc67q
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=bGNZPXyTAAAA:8 a=VwQbUJbxAAAA:8 a=zR2Dm80PUBsfDZRCP3sA:9
    a=wPNLvfGTeEIA:10 a=x8gzFH9gYPwA:10 a=yL4RfsBhuEsimFDS2qtJ:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753953AbeDSQ0U (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 12:26:20 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54389 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753920AbeDSQ0T (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Apr 2018 12:26:19 -0400
Date: Thu, 19 Apr 2018 18:26:14 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Stefan Agner <stefan@agner.ch>
Cc: gregkh@linuxfoundation.org, lukas@wunner.de, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] serial: imx: warn user when using unsupported
 configuration
Message-ID: <20180419162614.erf33d4kwt2clnev@pengutronix.de>
References: <20180419153916.21898-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180419153916.21898-1-stefan@agner.ch>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello Stefan,

On Thu, Apr 19, 2018 at 05:39:16PM +0200, Stefan Agner wrote:
> When using half-duplex mode (which disables receiver during txing)
> the RTS signal cannot be driven low during transmission when using
> i.MX UART RTS/CTS control. This seems to be a limitation of the
> i.MX UART IP: The RTS (CTS_B) signal is controlled by the receiver.
> When the receiver is disabled, the signal stays in UART logic idle
> state which is high...
> 
> If SER_RS485_RTS_ON_SEND is used, RTS needs to be high active during
> transmission. Since this is the default state of the RTS (CTS_B)
> signal when the receiver is off, half-duplex mode in this
> configuration works fine.
> 
> However, a low-active RTS signal (flag SER_RS485_RTS_ON_SEND not set)
> cannot be generated when the receiver is turned off.
> 
> Print an error if the user selects this unsupported configuration
> (both SER_RS485_RTS_ON_SEND and SER_RS485_RX_DURING_TX unset) and
> configure the closest working configuration (set the
> SER_RS485_RX_DURING_TX flag).
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
