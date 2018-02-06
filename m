Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-440661-1517901516-2-6386262160523381599
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  RCVD_IN_SORBS_WEB 1.5, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='RO'
X-Spam-charsets: from='iso-8859-2', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517901514; b=rSo2dfRm/ZapgJvaI0yUk2Q6Hfcs8dakjooU7+ibD2xU8qd
    41bWLScD0JpTK3op+mLQfe3SWvnmFggJ7rXDSR6xvzVVJ5/1taK/Ues/AoYgc7vk
    Rf8P1uCucWI/r2UDThNSn/FSkv+X/rwZGMrikhAValdZwGXOrd0Jh6PMoo20tiCV
    23s5gb4Eb95L09GuutqJSq/cRkFzUXqqlP1SNNb5dPytnyVPCwyUBPcWoSOYN1Mg
    PTeZb/rygRnbzUIN/G6SiYX1uf2nvQ2fyj+cW1mERbql5M6Y4OQsktMCyhWvPCIa
    fHVjoRjm0YD5IMcQBOS2P7qh32uiQOwKeQJrrzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:mime-version:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1517901514; bh=W
    iwt3Rpj0RvGDsjbJeWCRuJM1+F6aQThr86HM5fTgBY=; b=EH/UzEe/qeZyg2xA+
    5mQlA3Bzs9Lib0xy6IaJW7ljXgjf0Zruyf37XIMSozbhnwMrxBqPwLgR6LFqYLwf
    OudmvA8zk9gRkl4sVEu7k2/H+qoO8eEW6ye2PrC0Zbo39S+WanGLqLE+ZMrqqFKT
    JDu/j/7Vfwui2dKOsxdWvenfT3Jehsrbg+8kiDQb+hZQT46oZuS8PK/9rTMGmoQ5
    kBAMjCNteAgTkQ4d1GTebAcvQI/WLsvMsGueCPPK7QsuCs02qwh8xdktOGucyoDm
    Amo/Fq4qcslysmt02xI7E80d6mS0EWX4xguWwRiMQHN5AphLsZtHT/ewVCFOWanV
    9frNw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=PTgmfNo4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=PTgmfNo4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: =?iso-8859-2?Q?Horia_Geant=E3?= <horia.geanta@nxp.com>
To: Bogdan Purcareata <bogdan.purcareata@nxp.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Laurentiu Tudor
 <laurentiu.tudor@nxp.com>, Ruxandra Ioana Ciocoi Radulescu
 <ruxandra.radulescu@nxp.com>
Subject: Re: [PATCH v6 1/2] staging: fsl-mc: Move core bus out of staging
Thread-Topic: [PATCH v6 1/2] staging: fsl-mc: Move core bus out of staging
Thread-Index: AQHTnorGG/7Mw+/qPE63R2Gm218s7Q==
Date: Tue, 6 Feb 2018 07:18:18 +0000
Message-ID: <VI1PR0402MB33427D7D04239420F3FE7D5A98FD0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
References: <20180205140743.29974-1-bogdan.purcareata@nxp.com>
 <20180205140743.29974-2-bogdan.purcareata@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0402MB2799;
 6:CSEvN/zzTD/uGMRWhRdhobzj++xsExSTL7vUBizQDExnaSXZf7JgYvVoTs7GXlFVLwz54jLyK8coHeeZWSB8a0FCwXZiAT7nDTlf+KhCsTbgCxUa5nb1fEe9sG52kuMrcXns6W09Lw2Dzy1Rd/Eq/gxIPydZ9XoCSkJnWuEPttEdT2v5RMv/6Cmvsry4j9x5LL/CnL6ZkcuZ04/9xCds8dPfhP0mitww+RfWtXcl4cTciCswEtiWOiudvQJpbzQu+6HfyHp66ef8gV4M+Tc06sqjtOmi+1H9fk1FEhjLnIOBFi/0FINq0Uv1oIFaCsIDDZ88zBXU1P0HZ+i4qcQLXHTlt03M/ibhEsI0FMFj87ANUzOzDtCQhamxdj+2D9ET;
 5:VAlzN8WINxaaaGn+q6/AifyuWkGeZ6P2g36wTQhB9SC/AnG+I10ioBjnlVpXeziTAWGZjHilz1JtzShBVLgn4S/a8VKP8wtGbmHJg2+rRepXAhgXSrq+EDhDyJv8ZbHW7wBFlnlW1WXAfYd3dL15rTF2+RzAjxPGm/ONRDe1ES4=;
 24:mmHdD0EXZni5/6vcZcWOUyggCHC/uLiIkYlWtkZ18Beig6clkeZe+nElVweg3Cdv6cnxrTG6hWW+Y9hTUQkwc3Pdkq555Ea4EBSdpRK2rzw=;
 7:xmhne2r4K/R9O6ILczkci2Gi256vPBRrutBcM4nfqmbeI0dzh+5WDrNfg69I8x5XYP2aLbsahKi99b9DAASmHvnuH3j2AYH3WTDA4RRvdYk83KrIcOtPFBOONjUeFLdaS7qLm8OHaYr/RtJ0bpdyFYDU6ZtYLjw1xyNjHtez/FwnxzfEcsBr92x2AZRyHLr4QFCeKToA2xLGvDcye/iGsBRIFCvoRew/uJit0iUUVB+aHE6NJglL5klYisRafKb8
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI; SCL:-1; SFV:NSPM;
 SFS:(10009020)(376002)(346002)(396003)(39380400002)(39860400002)(366004)(199004)(189003)(7736002)(9686003)(8936002)(86362001)(2900100001)(74316002)(2906002)(97736004)(6116002)(53936002)(5660300001)(68736007)(66066001)(305945005)(25786009)(6636002)(229853002)(14454004)(478600001)(53546011)(76176011)(6506007)(26005)(4326008)(3280700002)(7416002)(3660700001)(105586002)(6246003)(99286004)(5250100002)(3846002)(316002)(2501003)(110136005)(54906003)(8676002)(7696005)(39060400002)(102836004)(6436002)(106356001)(81166006)(81156014)(33656002)(55016002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB2799;
 H:VI1PR0402MB3342.eurprd04.prod.outlook.com; FPR:; SPF:None; PTR:InfoNoRecords;
 A:1; MX:1; LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: befc27f1-3aca-4a6d-a9e4-08d56d31cbee
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);
 SRVR:VI1PR0402MB2799;
x-ms-traffictypediagnostic: VI1PR0402MB2799:
x-microsoft-antispam-prvs: <VI1PR0402MB2799D49757550D9E1690BC7298FD0@VI1PR0402MB2799.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);
 SRVR:VI1PR0402MB2799; BCL:0; PCL:0; RULEID:; SRVR:VI1PR0402MB2799;
x-forefront-prvs: 0575F81B58
x-microsoft-antispam-message-info: RupWa+20BUyjN2woO5Z7hk4395poTLRdOnQSX6GNdVbM2capcEGfqdylXsNJ2oBRgjCdz7XDRJbkYIPDYnyPxQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: befc27f1-3aca-4a6d-a9e4-08d56d31cbee
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2018 07:18:18.3940 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2799
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 "robh@kernel.org" <robh@kernel.org>, "stuyoder@gmail.com" <stuyoder@gmail.com>,
 "arnd@arndb.de" <arnd@arndb.de>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
 Roy Pledge <roy.pledge@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Razvan Stefanescu <razvan.stefanescu@nxp.com>,
 Nipun Gupta <nipun.gupta@nxp.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "jason@lakedaemon.net" <jason@lakedaemon.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2/5/2018 4:08 PM, Bogdan Purcareata wrote:
> Move the source files out of staging into their final locations:
>   -mc.h include file in drivers/staging/fsl-mc/include go to include/linux/fsl
>   -source files in drivers/staging/fsl-mc/bus go to drivers/bus/fsl-mc
>   -overview.rst, providing an overview of DPAA2, goes to
>    Documentation/networking/dpaa2/overview.rst
[...]
>  rename {drivers/staging/fsl-mc => Documentation/networking/dpaa2}/overview.rst (100%)

Is this the proper location for documentation?
The doc focuses on networking, however there's also information about fsl mc
bus, dpio.

In the future, we might want to add doc for other dpaa2 objects sitting on the
fsl mc bus:
-dpseci ("Data Path SEC Interface" - abstraction for the crypto engine)
-dpdcei ("Data Path Decompression and Compression Engine Interface")

Would these fit under networking doc folder too?

Thanks,
Horia
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
