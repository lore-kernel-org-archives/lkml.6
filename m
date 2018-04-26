Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2355419-1524738182-2-18145826924364141978
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='IN'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524738182; b=lfhMvmIGU+4pMsY+7EN1jM6dejMY/FOZF/fop/4hS071THS38R
    /X3/NR17Ui1hKbmA+cTKc02qIPh+qC46LzjOL6ajJosCV0iNbpgZ9BfRJ7Zy26/P
    HYhN57DYxpKRJ+dsVHXcnkWemroX79M4Hcs7TvP1wDiR2SHpcp6ulVBb4oRlUXMs
    C+/v8ev/pghRg3tRXRRJSjr7sxCoAqm1tWQyTM8sBVQPn6Vpet/23SyM3KsB0dum
    io38UGqdo7aA6WMajRs4FEU4vWYloIsfQdy+qqTIDhonmxmImVC2R+T0WpfiE8Ys
    zPm1auAVbVCwsI1z4ghibMmICmt6T3bT0Kjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524738182; bh=UgAou
    HWCCIP76/KwfDQajqOI0ZqKLs+ytKuPZ95GXRk=; b=pO7x1xaHREla3FroUBgsQ
    EfuEmfeG8krNEMtiVvmXEYVdibZWdE1I5sz133SKxiEcdTYnjpvA+9hwK+H+jdOC
    pzJ7GdOSr7t5KsPcvCJumX8Jb2hpN/Dj03W0KiihCzrchqrZXhetOkfk4hSg/iGi
    yK/UoDqZessMxW/iA/uiE+ulhraI0KIvUG6wRXd0d6QONMY8Huj0q7pyZ8bN1TGx
    4vKWA16bfQIXr3iJzkMYbMvU727oq5avWWWDLyQZrVeenkPAaQxpx86HgXbRqS9t
    1VM1iHbE4JhSOrPFAeOCnC+2GR0vgc7kE+kcdTV1iTxddlGov68WEoehZTSbOM59
    Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=eMwJA+6v x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=eMwJA+6v x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBg0yj3WDQ+eh9d92iAQ3oNIEQoY829Ta2zDd0r+F8h+3N2k/hkDhlmiLm0Ahj4wz7EJ9JZa7pS2ZdNgmIi4qGYYhkXa+ffh1I7I5TWTXHmFyIhhc8gB
    +KjzF0E43OSsgCYU/JwEnuXbhLkQbxbR9TZ44aYoUmSPptPLcnl66dmNmzTkusY7OVbhCN9zFTc6ttyb9rCaB9o0U0lJAyq+gdJcsmg5NHVeXRS3poDOXrCX
    4E5tKHVL4uL1hqbtdCIdkg==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=nd-XxV4gJusA:10 a=QN8zSLG36AAA:10
    a=JgFq0pVtA0oA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=dw2S5ISiLjYA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8
    a=8AirrxEcAAAA:8 a=lTbjQzD5AAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
    a=yPCof4ZbAAAA:8 a=DDOyTI_5AAAA:8 a=XkOQvLz4XF57Yw-RuUsA:9 a=CjuIK1q_8ugA:10
    a=ST-jHhOKWsTCqRlWije3:22 a=w8YF5asEQ23juLwKoPR8:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: "Y.b. Lu" <yangbo.lu@nxp.com>
To: Richard Cochran <richardcochran@gmail.com>
Subject: RE: [PATCH] staging: fsl-dpaa2/eth: Add support for hardware
 timestamping
Thread-Topic: [PATCH] staging: fsl-dpaa2/eth: Add support for hardware
 timestamping
Thread-Index: AQHT3HZv/Y/PznkfA0CVZRkLjjVOL6QSVOYAgACBylA=
Date: Thu, 26 Apr 2018 10:22:49 +0000
Message-ID: <DB6PR0401MB2536A4E804E84D417AD1398CF88E0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
References: <20180425091749.46841-1-yangbo.lu@nxp.com>
 <20180426023308.aezdge7xlbqoe5at@localhost>
In-Reply-To: <20180426023308.aezdge7xlbqoe5at@localhost>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yangbo.lu@nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB6PR0401MB2246;
 7:cXeEt6Wf2HNDnm9MH8gp2l9iFpSZ9rjPJH1ndoEPaHeMWLN7NjgXYS40nBiczERcEMuVOk89dKagTGpJ6kE+Ih6x8VKJheTbYZRsWx9qqPsYBMJj3AoN2Lm63yEfmwsiv28H24XPK23TGSJuN827fidyBF2BEs2t0LuU/DzUE1tFBdbtNyD0HlK8ll/3bkXM2dskCKlJFLGWqjGI92VdrrhfC8E3JTn6q3UgLEKy8DVh6Elu0DnCVdzP8NCIEbAr
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);
 SRVR:DB6PR0401MB2246;
x-ms-traffictypediagnostic: DB6PR0401MB2246:
x-microsoft-antispam-prvs: <DB6PR0401MB2246352AB9B09ADE8A8CF8A7F88E0@DB6PR0401MB2246.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158)(146099531331640); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(6072148)(201708071742011);
 SRVR:DB6PR0401MB2246; BCL:0; PCL:0; RULEID:; SRVR:DB6PR0401MB2246;
x-forefront-prvs: 0654257CF5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(366004)(346002)(376002)(39380400002)(13464003)(189003)(199004)(8936002)(4326008)(6116002)(7696005)(76176011)(3660700001)(478600001)(66066001)(53936002)(97736004)(11346002)(99286004)(33656002)(8676002)(229853002)(14454004)(6246003)(1411001)(486006)(186003)(86362001)(305945005)(5250100002)(5660300001)(476003)(7736002)(25786009)(106356001)(74316002)(2906002)(105586002)(6436002)(6506007)(6916009)(68736007)(316002)(81156014)(53546011)(39060400002)(9686003)(3846002)(3280700002)(55016002)(81166006)(2900100001)(446003)(54906003)(102836004)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB6PR0401MB2246;
 H:DB6PR0401MB2536.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1;
x-microsoft-antispam-message-info: 8PebCAK1fN1iCVl/xeWQOZ7JJrNILhAwb5mMXCkKv0d1zXnTHL7uNmgmDrUk3qJcNvZXCRWeBvDw4dyn4oI0vHLxb9AmM+24lsTnmDtO2MhwGZiMBWgaEJADxuMjUtFzbYjpbghDkupJ8j3YkjkJNN7lAdtY66qIKTG9BTGoDU+9PWcb4xtsR6cQvnJjnFQK
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d8bcbaf1-4eb7-4c68-10fe-08d5ab5fa958
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8bcbaf1-4eb7-4c68-10fe-08d5ab5fa958
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2018 10:22:49.3532 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2246
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Richard,


> -----Original Message-----
> From: Richard Cochran [mailto:richardcochran@gmail.com]
> Sent: Thursday, April 26, 2018 10:33 AM
> To: Y.b. Lu <yangbo.lu@nxp.com>
> Cc: devel@driverdev.osuosl.org; linux-kernel@vger.kernel.org; Greg
> Kroah-Hartman <gregkh@linuxfoundation.org>; dan.carpenter@oracle.com;
> Ruxandra Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
> Subject: Re: [PATCH] staging: fsl-dpaa2/eth: Add support for hardware
> timestamping
> 
> On Wed, Apr 25, 2018 at 05:17:49PM +0800, Yangbo Lu wrote:
> 
> > +/* PTP nominal frequency 1GHz */
> > +#define DPAA2_PTP_NOMINAL_FREQ_PERIOD_NS 1
> 
> Nit: Frequency is the inverse of the period.  It can be one or the other, not
> both.
> 
> Why not call it simply DPAA2_PTP_CLK_PERIOD_NS?

[Y.b. Lu] Thanks. Let me use DPAA2_PTP_CLK_PERIOD_NS in next version.

> 
> You haven't implemented the ethtool_get_ts_info() method, but you need to
> do so.  Show us how the user can related these MAC time stamps to the PHC
> device in your other patch series.

[Y.b. Lu] I will add patch for ethtool_get_ts_info in next version. Thanks!
But I'm not sure whether ethtool should show hw timestamping always ignoring phc enabled or not.
Actually the hw timestamping is supported always since ptp clock had been initialized in MC firmware.
Let me just send out the patch for reviewing.

> 
> Thanks,
> Richard
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
