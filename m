Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1536617-1521818767-2-11138811629040298848
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521818766; b=i4Ab0YT4/0CnZH8irT81mlL71ZFz0j5xLBAvM7ZcQXn+GTQ
    F9wwuuQH9/HNK/sRICSoD3cPhrZ1UmR5pIHgS1LOyVp9VfT6gEsDz47pu4uYQkc4
    JKDVoN9CwBmYpTyprEVMvxrhEIWcID/sjLjo/AM3t21HlY8C67NaHQJwhz5TCbFb
    LfG1fwJ7TyG41xiM/SSXQzoyKqQ0/OGMuBFmdsXewYLYO7MmJlhAUqdeYX4sSopX
    JN4ZsoDirsJv7JbAmgRb4aRWDE2sSTZtQXcmbfQB5EcH5Wi1OBha7ySO1QaIc1yT
    GnLVqyFZI5h4M8UmkyBHjEWzgsp2I/laLFuZYiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521818766; bh=M
    Wsoq+m/lO8HxVMFAZT8ntIA0JBPp7rEP/hHSFnFlQY=; b=VyKKw9px2y3TVd2kU
    5CQXeFFVIhCEhqVnCBy7EroiWRW0r+m6gX59CfoeAI98zCkfL3LioUF6k8p1r16+
    LIBwHjH9ll4dtA/TvqtnP6f2q+1FzQvcHhD3phUdwYF2EuH/ggGr64ertU3HzTUd
    i/7mUuk0WZGl86fBMMqq5qmsLAOPksCCB3vOFvWAjSV1LHjY74nQXO0mlE4Jqh0H
    P//fs1j85z3WNriVjcefJ8j3QKxBvAOjzd9mTIlEd3VeFfIcYveHlWw0cmjTGTpU
    9Bp4NwvU6xCu862hSeiYlZs7ftkcEF/1g1xy+vaf+CURsoRxqI6H812oXbVH/TxY
    C9osA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=d+adTO48 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=d+adTO48 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Long Li <longli@linuxonhyperv.com>, KY Srinivasan <kys@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, "James E . J . Bottomley"
 <JBottomley@odin.com>, "Martin K . Petersen" <martin.petersen@oracle.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] Vmbus: Add function to report available ring buffer
 to write in total ring size percentage
Thread-Topic: [PATCH 1/3] Vmbus: Add function to report available ring buffer
 to write in total ring size percentage
Thread-Index: AQHTwjxEj37h1bxbXUGtGf1VbQWfLaPd7YrA
Date: Fri, 23 Mar 2018 15:10:18 +0000
Message-ID: <BL0PR2101MB11086A8AD9581CDD7ED08AD8CAA80@BL0PR2101MB1108.namprd21.prod.outlook.com>
References: <20180323001538.31876-1-longli@linuxonhyperv.com>
In-Reply-To: <20180323001538.31876-1-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-23T15:10:16.7689402Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [69.130.166.81]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BL0PR2101MB1027;
 7:m8hIVGctpkqhWAZyueJcb9qxz7bV5p/pVLIxFWs+orVdsAydjakTXb8CPjGrK4fUdQ9pErv7GPFgPCwuE4H9B+H+XdVojluFM/K+ZHgIO1ybFGQPgD/KhwnI2D8Quylf2t0hGS6khckUcYb1f+N9P48PPqv8pFHK1oxeC/6OwEAd1QB8Dr2DHbIszDlkcsPopaS0bb3DWMNmkyq9yAZsUkGaCFWoye9l4vjMAjHnr2gJ44nMM1pMOD9x09N/y9N4;
 20:wcH5YGY0pWddq9Pq4ubmLZ2g5tqlym/eapibHDLce3uiGAPtt7xR4WbK7D0T32n7EgHbHKPS9Myu2MYqJo/T6/OyNCYmht/fQMBXcb9X8GGZ0x0zjwtHlbrlZne/it3y2NhOdFiNgBO9BekiUMsv44+VyQGOakon7V385/AYqDQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a3fb585d-aae1-4c47-a16e-08d590d03064
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:BL0PR2101MB1027;
x-ms-traffictypediagnostic: BL0PR2101MB1027:
x-microsoft-antispam-prvs: <BL0PR2101MB1027CC52CF7AED88B4E3AD70CAA80@BL0PR2101MB1027.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(146099531331640); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);
 SRVR:BL0PR2101MB1027; BCL:0; PCL:0; RULEID:; SRVR:BL0PR2101MB1027;
x-forefront-prvs: 0620CADDF3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(346002)(39380400002)(39860400002)(396003)(13464003)(199004)(189003)(5250100002)(3660700001)(7736002)(2501003)(86362001)(2201001)(2900100001)(6346003)(22452003)(316002)(102836004)(26005)(3280700002)(110136005)(66066001)(68736007)(14454004)(10290500003)(10090500001)(186003)(2906002)(3846002)(6116002)(6506007)(53546011)(1511001)(4326008)(229853002)(86612001)(5660300001)(97736004)(55016002)(76176011)(8936002)(25786009)(9686003)(6246003)(33656002)(53936002)(305945005)(105586002)(6436002)(106356001)(8990500004)(478600001)(8676002)(74316002)(446003)(107886003)(11346002)(7696005)(81166006)(81156014)(99286004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BL0PR2101MB1027;
 H:BL0PR2101MB1108.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com;
x-microsoft-antispam-message-info: ug+ry73PpGepegJAnWg8BUW+zshlH/ONd3YPlpwVztva3uoy0Tq4L6FymBmm9D/I99Llb45McItrh0KQ/QOPN3oXlfec2GY9gC3yR+7gJ/PR5oisLwMaDqgh7HGqxAgSooibCAq0scNSBdRygXfiybUc+fOidY1fHVxJwHBEkGIn20TupDmsfU1u7XAUoOpRjcJ5Jhh96Q1CUiZrv80tBjtcaFZUJLT2Xboz0GypWvohGdBviHAO2Y++5IwNP5IKyu+zZagXUcKvb4rbSg7fVBvKCX2SXGAXxvbjtM10tVTtImGmsrsh/VXEv/IuJmABrx+4lgigcTgaSSWovSilrQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3fb585d-aae1-4c47-a16e-08d590d03064
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2018 15:10:18.1030 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1027
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Message-----
> From: Long Li <longli@linuxonhyperv.com>
> Sent: Thursday, March 22, 2018 8:16 PM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> James E . J . Bottomley <JBottomley@odin.com>; Martin K . Petersen
> <martin.petersen@oracle.com>; devel@linuxdriverproject.org; linux-
> scsi@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Long Li <longli@microsoft.com>
> Subject: [PATCH 1/3] Vmbus: Add function to report available ring buffer to
> write in total ring size percentage
> 
> From: Long Li <longli@microsoft.com>
> 
> Netvsc has a similar function to calculate how much ring buffer in percentage
> is available to write. This function is useful for storvsc and other vmbus devices.
> 
> Define a similar function in vmbus to be used by storvsc.
> 
> Signed-off-by: Long Li <longli@microsoft.com>
> ---

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
