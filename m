Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1534962-1522892042-2-11243180463955139696
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522892042; b=VK4U6T8PFSHvTJZnTIqOU7e9Dl+2ss+3WL8yBCMJK4u4XgKj7L
    dnq4wpWzmbbafIuW8Gu/SLv4JRJmdrvd4/uxHvG628mXOj9KuL5NT/bojj0SAvHE
    1ZvbS74cQYnyZxs5Hq2eEKbE8P14zHUyJMmvDtcAjxH7Cs/+5YZhCC/5ajEYcVpe
    D9bQ2v77W5gW37K1Czu0ambfV4wsDkPhP+C/LFuEcT37KzB8CVrPUn9HIoVooanP
    FL0hllw5YXi3mbjpCCckOzl1bflFv5dkxslolUHMzCNej0bdMW/4FjNDuklUTmLO
    9xbTIOnLmGK3wS5iSd/g4v5VDFCCiqzIF/vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1522892042; bh=lXSUNj+LEN
    eP2QoDUEIDXBdgX+IeV2yYHa7M7yvFEEs=; b=qrbA14uune+U6ZtBuXvqz2NDji
    FMxHFHr1Yr9dhsXnP7Wn6n3kQcF09jqOis22T4YpGfPzgOq74SkCcwFnWmdyPRZb
    gSbIT1ngF8VXV4amDc5/YPbULsGrhQybRmQFz4XUyfWJiDABlS5rtSCjIMS3GYEZ
    Fnzs/o2/rSfyIdFWqBibUTLaSYY9VAhpVYGUabf7tYWAWACgGAh2fTA6q62dfFpz
    zTN2g7A7hq30SQ1dMC3y5c5e1wzZduS49+rdJuzplNA98Mu+/PU7hShHxN0VEOlZ
    blSXIFBlIdwbu0xqx9Tpr1mxUhQWj5gyxqxNW3kSsOiei56to0egUFJNTdyw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FaLR+Ps7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FaLR+Ps7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD/1/TBqKzBc7MQyOvhQRImjlgDIxHyti7aZoumnr+Xvj5jMmOuxwAOUKCavW1IQl2piJSNAMcxtnaEl6auzCmcQXiUZYu5CbKhzGAzMo2wKUWdmqmI0
    aXIjGmPekDTT9tTgu650ngI3UBqOknNgSfmE/EHW+DjcqSryihxZy3dkL1Nw3ZuZ6RSHIXxuUGgAALS433ZXQyygVMBdgPUwgAkS6aB6335mw2aP97lJfHlx
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=BchL_CboiwcA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=ewovsp29iuzfA35nUwEA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752751AbeDEBd5 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 21:33:57 -0400
Received: from mail-cys01nam02on0096.outbound.protection.outlook.com ([104.47.37.96]:30784
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752615AbeDEBdy (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 4 Apr 2018 21:33:54 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "alex.aring@gmail.com" <alex.aring@gmail.com>,
        "eric@anholt.net" <eric@anholt.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] soc: bcm: raspberrypi-power: Fix use of __packed
Thread-Topic: [PATCH] soc: bcm: raspberrypi-power: Fix use of __packed
Thread-Index: AQHTzH4nrMAPVyqQN0ibKMtxjSoHgw==
Date: Thu, 5 Apr 2018 01:33:53 +0000
Message-ID: <DM5PR2101MB1032E05672513A1F7945B2C1FBBB0@DM5PR2101MB1032.namprd21.prod.outlook.com>
References: <20180401164225.8920-1-f.fainelli@gmail.com>
In-Reply-To: <20180401164225.8920-1-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1064;7:vsqCzvmbN+MiA5SP6PuiqJexxYogyhmzks5Ll5fc/stWuby3ZjMTHivorBXOyCiAiVwgcPVb2xy0AztgFXhEDX1afY7N3u1923LDhLnfMxPogP+zkXTwmSdwGQk1EOSwb6dqMLUf/dLkRuZ7Ge+0c1wlDuNRWJpELbuRAunWaaPevt1YW++olNs/iIQmtPEq8rQrAWffwBoUEVtIfZiE7xYOtwTFehHdQJW8kRedTj5t1rSE51Sf58H3deaWsQaV;20:/5R5+7dI1uB/CHJM/Qzxw5i6+xDtoU7Xc7ezrtPSZF5EtD8ffFhl/DTYbKChybnDOlV37CuFTSKsxxl9gI+vQkfraeJxyVzv7JUgSHxwHg5YPVhJobT0OgHy0ToeUOiFpF4+2n3BTG6N4IIsHOXL4Ih7pstPQJfzU1qHDU6ijis=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 81d13fba-4243-49c7-6be4-08d59a954a86
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1064;
x-ms-traffictypediagnostic: DM5PR2101MB1064:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1064BE5A69AAEF94E255960EFBBB0@DM5PR2101MB1064.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1064;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1064;
x-forefront-prvs: 06339BAE63
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(39860400002)(346002)(396003)(199004)(189003)(39060400002)(316002)(106356001)(110136005)(22452003)(54906003)(6246003)(446003)(476003)(66066001)(305945005)(486006)(14454004)(74316002)(86362001)(5660300001)(7736002)(11346002)(3280700002)(81156014)(8936002)(81166006)(1511001)(2900100001)(68736007)(26005)(3660700001)(4326008)(6506007)(25786009)(102836004)(5250100002)(8676002)(72206003)(99286004)(9686003)(55016002)(10290500003)(2501003)(105586002)(3846002)(86612001)(33656002)(2906002)(478600001)(6116002)(76176011)(7696005)(6436002)(229853002)(8990500004)(10090500001)(53936002)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1064;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 61pSX3+FmK74bMxnfcLLnBtSDHUuM5XOkxY74PHBWBylsMBPBWcY/qlMVtdMTqz7VZfVRkKYHOkVV6NdD7mJXlj2FpLNfx29i1jxCZHNYZS2VLmZ+xp0mMyXjuwLEhx9hAyaTKT9a5YBo08FOn9xw+5lYWbPydbruTbVP90Pk+IWtH9CVK9BeCzTRnQYW5VN8PVQK9V51uZgsvviONzdrOl5L3yHD3Y7PDsvth1NUOviOZ7QPqxthXHTM6teSRo/ctxLmhqFzrs1wT0hBRV/QNwtzxvNN1fyQ68x4boeJmHnDE1PgPzYSjUS5aC4sz9H1CnPL4ROYZJLvsJ/FHXT4xyoWDkIDGNZ0yP3zRozySDF7ClFTPQlQFvJtisiGavmRdCOAqEvm8/uc1Z+neJ+MdoxIKt4jSzkTCTdkUHIh0c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d13fba-4243-49c7-6be4-08d59a954a86
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2018 01:33:53.2460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1064
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Florian Fainelli.

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag.
fixing commit: a09cd356586d ARM: bcm2835: add rpi power domain driver.

The bot has also determined it's probably a bug fixing patch. (score: 35.57=
65)

The bot has tested the following trees: v4.15.15, v4.14.32, v4.9.92,=20

v4.15.15: Build OK!
v4.14.32: Build OK!
v4.9.92: Build OK!

--
Thanks.
Sasha=
