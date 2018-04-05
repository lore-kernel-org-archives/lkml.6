Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3270552-1522946596-2-3321362799647493200
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522946596; b=cIlZVQ/xc6gh2vUqEsud/qGnwKD1Q8+rG6kBQyDAgHTQnITNGK
    jtGmbRvb92VFPnkfXx5SxALmZ5KmGcPCDy2gGMuJ5vA/6orhk4WJUtVjFKrBtq6B
    35t/weZDAhs4kvrhoWdHHmmD9bc1V8yi+3FDRefQBJ8E8wi8uuUiJvnIUTcurcGf
    AdAexmjpZ78KStPE400mWKUsOwhA2hQ7QlgXaEdqjbHiCUXYx9B4zJ+Ve4BlIK7y
    6sJbWg5Di+DUTL8Ji/PPZHB8mE4JK189dwt23T3E+tcWb9ht47pyPl+HNNbZuqD+
    IeBxyHs5RNJk4x4eXA1sgnKJA/OIAc3KyJFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1522946596; bh=qhJ/ww7dN3
    XqkfPpp+7SGZ2CVKzufAWHnVw++rR3yCU=; b=n+pibWGoU3S4A515mzNW0ZNuf2
    gGOH544Jk5SARN2RESqMOU1iyD69p3o/KxbF9YuSrXRgKYybPhnQKZlK6A5u0h2x
    1mOCiGn4DIEmt97Hp38+JPQQ6feSh9SDD81HTy1VNMvtlHpdhHJ0SOALTaOXa+Yk
    hJixlsVqxrxQJC889yHwSqMDc62c2yDzrXRowyTc47fEON6Ppf2oj4jos9mPfsAm
    RyLhRo26YfLOGe2joYIyxNZUTRardtAkbTMIGjdJxkOhSE9bKqzo+qi7ONwFZPU+
    FvMTJx/jd1A7SqXb0NNWUO9S5YYRl7QRKUtauXtkIfUawOBdrlUvPjqaxYSA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Le3crI6y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Le3crI6y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB8/HNCGu3BOZ+tt8bpsX4wAOT63Yxa2RaXq6XNVRPbdLZg6e/30U1+HYcimiK1rMQTDZ/gV/pIhoLGD4pjgpk+HxOtkvd+SNvnHr8+llFFkTwIZuSId
    gZxrRY5BuohVfdB968jYH6yNn0wOLyuNMi4/3I2Y3a2RSIM43AmYYrtx8BliFPP86LVi3yq/INVQqvTICRL2+/XHop0sm2/n9k2hTCMyVLBuD7P2YgZs+Lhb
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=WCLRXoBrZ2UA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=hEBxi9MLR1DCsw2oq4cA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750726AbeDEQnP (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 12:43:15 -0400
Received: from mail-sn1nam01on0132.outbound.protection.outlook.com ([104.47.32.132]:10022
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750736AbeDEQnO (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 5 Apr 2018 12:43:14 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 5/6] clocksource/drivers/imx-tpm: Correct some registers
 operation flow
Thread-Topic: [PATCH 5/6] clocksource/drivers/imx-tpm: Correct some registers
 operation flow
Thread-Index: AQHTzP0vec7ZJo0PukKG8/jdhV6zZw==
Date: Thu, 5 Apr 2018 16:43:12 +0000
Message-ID: <DM5PR2101MB103225190F1A58D268C1F007FBBB0@DM5PR2101MB1032.namprd21.prod.outlook.com>
References: <1522760432-32048-5-git-send-email-daniel.lezcano@linaro.org>
In-Reply-To: <1522760432-32048-5-git-send-email-daniel.lezcano@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0999;7:hNyuJHza3K3NKCAjevg8VWLjlno61+vou0hNjRAqR+thPYWFzQJ2FNuX5+A2CJe+mhghbw6fspvSftzYq6QjkU2oWTN2h78bDZx7US9nt8ngwhdmZGXmXGpJCZ0GKAONO1roeWpkuFcmLBMUbgY8HbNMtp/s6ZvlnZfCYNgokRdk27V9w1OZ4YipzYfyuq4yLDiBYtG7sd82BR8aKqYLgb7w7BIJTE5D0xz0SZbUxrMHJqxK2kOH5BKz7fyEyaZf;20:6vM4td8wCJ4b7MTQPxjQ/9toxiyiUSdwPHRioDskPDP8i5NYcF6VUiVQUXlhuY68rKByTxQ9MHNkTDaH72MT+4gBPp4zMC6nBIefzuT/C3SN1xXEov3bW0XoL+eAU9Si1B7S88Z2rTIeMsZqbXykD+trguWFcJTzwRbu2Y1peNs=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 44abe358-72ca-488a-ffb8-08d59b14523c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0999;
x-ms-traffictypediagnostic: DM5PR2101MB0999:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0999984E740931C0A04852EBFBBB0@DM5PR2101MB0999.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0999;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0999;
x-forefront-prvs: 06339BAE63
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(39380400002)(346002)(376002)(199004)(189003)(9686003)(8990500004)(54906003)(10090500001)(6436002)(476003)(110136005)(86362001)(105586002)(74316002)(81166006)(1511001)(2501003)(11346002)(99286004)(72206003)(478600001)(25786009)(486006)(5660300001)(6116002)(4326008)(446003)(7736002)(316002)(8936002)(2900100001)(86612001)(97736004)(22452003)(66066001)(3846002)(305945005)(10290500003)(14454004)(8676002)(3280700002)(81156014)(33656002)(3660700001)(7696005)(8656006)(106356001)(26005)(229853002)(55016002)(6506007)(76176011)(6246003)(53936002)(68736007)(2906002)(5250100002)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0999;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: bEwO7EQAS7AkJ1HuFEXUZUTXIb6jcE1v7ndQE+3mLyijKtoJi04KiCE0rPG6HipdufFqHkK6v7RYeTMkcKkoeylygYG6E30cJxLlFcfMpT6YcwLi6UbGxcHxKuJPrd5VV4fVYVi8rbud60QcMcpmY+Kg7pXxh0EZDL3gxDtNAeUFXI/ankMKxXUqQwMuEO3RgxqHVxFCU2pT8YDsk61iQ6NgH1Z5NK5GvDWCy9rbBHgngAxZcCwz7uw7NWnOIRqB93AVcuUTxSdTnk7qqsiqLTVwpP6NrfEuhY/DAIxOQ/mQhRTXiz7amgfK/I7lvdnPOgQT4RfZSPkFV0ozJiIdhAxoN5LdKEU+99ucRKClxcRinsCissoJQM5Gpw9cTJ5vjU11dzBla3HYWqyFeK+9hhPhF8NW7xbpNkckGY4QS1w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44abe358-72ca-488a-ffb8-08d59b14523c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2018 16:43:12.2612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0999
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi.

[This is an automated email]

This commit has been processed by the -stable helper bot and determined
to be a high probability candidate for -stable trees. (score: 11.8806)

The bot has tested the following trees: v4.15.15, v4.14.32, v4.9.92, v4.4.1=
26,=20

v4.15.15: Build OK!
v4.14.32: Build OK!
v4.9.92: Failed to apply! Possible dependencies:
    506a7be93ff7 ("clocksource/drivers/imx-tpm: Correct some registers oper=
ation flow")

v4.4.126: Failed to apply! Possible dependencies:
    506a7be93ff7 ("clocksource/drivers/imx-tpm: Correct some registers oper=
ation flow")


Please let us know if you'd like to have this patch included in a stable tr=
ee.

--
Thanks.
Sasha=
