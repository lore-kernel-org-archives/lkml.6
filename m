Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3460534-1522279386-2-17349375894745126412
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522279385; b=Rn/+Lcr+MwO1BzloRChHuTQaCW1xUTUhJ6zuxWD2nvmVorr
    ou58wo1HeI9co0xXx8U3AphntMpnz2dSR3TjLyhFpGOWA3/4F0beCGeTdmw0qJ9B
    XIbwzpuwRS1UH4mLRWLQUuyxlWE9mGjYc+GpxR5uLMpDrBO3wSmbv+Nvm3MRtieK
    8gwjIlKpUhNgt+71uiVmg/l7C1GQFViws3Im1Denva+UYh1djIadkPGzBhPLkgEK
    h/2BhD4ZoUEioHqVTqzUkQmfkuTb5JuUDbM6tZLliTVGceKDQ4rkAKXpE849z+o1
    fNOxEPcSnwPBzlW51Us6q5/ncWL4F5IAg3EwAfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522279385; bh=B
    xeFyKnOoNoisn/k5Rw2MegDXk+3+RZLdai3Zl0HOgo=; b=J5XX2DGtH65eaqZez
    cjX2KmMV8DYYPHEL66F6FmVH5lzp/qNRR+/2P8mmI2OUlrdH+slfPPbrgi+NDsKD
    5zZoLv368FQ6yKxMi4IWAgcQeEl8qz14RSsQiMZ9XHyVO8Sh/uwypuaHft0bUu7p
    f5Vg2iRGvLS+h1qQU6EPl31dc4jHklhVn/VDwjGH1CJqdU55ukfrVVGyNuiIkspV
    7EVB8to71G55KiAL11XAZeUdar3VBL/eIHW5WqYMV2txASEVHFYw+54qZHpxjg0B
    xImYSl9G9ae29TYTSVjUXTCOTFsnq58tIwu9y5peInZiwtuRUFJ+uSWVM02PWX2f
    Y5Ufw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=I7ZaKFPB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=I7ZaKFPB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDCYxup48bl9Fe0ZjBwXNGRN69XEcR1D0eY+b+W6G0m7/30MI7xgyzg2Ml2x+GuASgTMMsAU6MR8DmThIO9hBkOl/C4Z0DAcxjgugWt4FDgS1p/aTyxJ
    o8mptSyTw2puNXAlwET3LbFfFdRckIrgFDBE0Vk4c5k3fPphRiPnUBjRSNdE5khLuNfJo5kk+rcGQH6ifmMCkTKSNI52oOz80EHcvxsQ7jjGw6MMGBrXCMNJ
    l0CcVceA71ZDC3aC3AxOSA==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=T7kgPA9ckXYA:10 a=Mr1FtkBQSwEA:10
    a=ktgBQwt_910A:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=v2DPQv5-lfwA:10
    a=Lf-vpJhqX20A:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yPCof4ZbAAAA:8
    a=Odnh0R2cAAAA:8 a=yMhMjlubAAAA:8 a=6n1iNii3AAAA:8 a=DDOyTI_5AAAA:8
    a=VwQbUJbxAAAA:8 a=tljz5pN-hOLo6KDKgi8A:9 a=CjuIK1q_8ugA:10
    a=lNAA6UHySJB7qmBR1x20:22 a=qL8UFIJES1IU-uv6apQ6:22 a=_BcfOz0m4U4ohdxiHPKc:22
    a=AjGcO6oz07-iQ99wixmX:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Stephen Hemminger <sthemmin@microsoft.com>
To: Long Li <longli@microsoft.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Long Li <longli@linuxonhyperv.com>
Subject: RE: [Resend Patch 1/3] Vmbus: Add function to report available ring
 buffer to write in total ring size percentage
Thread-Topic: [Resend Patch 1/3] Vmbus: Add function to report available ring
 buffer to write in total ring size percentage
Thread-Index: AQHTxi618UT9UDkCA0ercTSDcW3/YaPmNC3DgAALo4CAAAreQA==
Date: Wed, 28 Mar 2018 23:22:53 +0000
Message-ID: <DM5PR2101MB0917BA3BDBA187201A15F3D8CCA30@DM5PR2101MB0917.namprd21.prod.outlook.com>
References: <20180328004840.22787-1-longli@linuxonhyperv.com>
 <yq1y3ibhndg.fsf@oracle.com>
 <MWHPR2101MB072958DDC25845615C3B1ADCCEA30@MWHPR2101MB0729.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR2101MB072958DDC25845615C3B1ADCCEA30@MWHPR2101MB0729.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=sthemmin@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-28T23:22:52.0905319Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [204.195.71.95]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR2101MB1061;
 7:BBIaSN4xp57KW7yuJLvanerWF0sCYTw9cziyTEeV/y3ueHX/co0fDgI2PAPuVZHKgmMagnPvtXTpVDl9FlIid9th1sGlbfRuu4qxrVMEP5HqJ2kdC66+uwXs/2iNdQbdaQmWvmih0q8XtBMQMUdYBQSPIoxxQg/rRTXS05glkLUHKMAVti07UArl3TVDmfIQJe3fVfArifmVaAlY9zhxDX4hJrR3JWmm/nDjjkzMZoCnPEIFxZp7ZaMyU+ubqh8w;
 20:N78QiTZgqjm1499wf/jHPIMRJByOO+kKlXSj0LEFBtUTR0E2bXQke7i3uJ48uKG+iZIQahIwg4M6tjdSqcCavMF7OBQ7DFAaYAatLpvUwDbvPw+NBtWgJhgxZcHU+M4cLJZ5BYagAdV5RwvO5iBT0tCKSKVzHNJ20KvDsLvMjK4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 21513816-9bc5-456d-eb41-08d59502d4fe
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7193020);
 SRVR:DM5PR2101MB1061;
x-ms-traffictypediagnostic: DM5PR2101MB1061:
x-microsoft-antispam-prvs: <DM5PR2101MB1061D48A95856830BB5BC242CCA30@DM5PR2101MB1061.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(146099531331640); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);
 SRVR:DM5PR2101MB1061; BCL:0; PCL:0; RULEID:; SRVR:DM5PR2101MB1061;
x-forefront-prvs: 06259BA5A2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(39380400002)(396003)(376002)(39860400002)(13464003)(199004)(189003)(6436002)(476003)(305945005)(486005)(486005)(54906003)(110136005)(22452003)(53936002)(446003)(229853002)(8990500004)(4326008)(7736002)(478600001)(26005)(55016002)(5660300001)(74316002)(14454004)(86612001)(10090500001)(11346002)(6346003)(25786009)(81156014)(81166006)(99286004)(76176011)(86362001)(3280700002)(8676002)(2900100001)(105586002)(102836004)(6246003)(68736007)(6506007)(9686003)(106356001)(316002)(3846002)(6116002)(1511001)(5250100002)(53546011)(7696005)(97736004)(33656002)(2906002)(3660700001)(10290500003)(66066001)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR2101MB1061;
 H:DM5PR2101MB0917.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sthemmin@microsoft.com;
x-microsoft-antispam-message-info: 3RnzbYH7l3DIGM/e4BlkKyAtuTB2vOXDdzjmbgiBi4zQzty2T2YrD4QhaloImASeyf57+pXm4ogF/BoRmXneZGg2QDzBQgj4NnxSd43ytfW5nTdfjtKzzTOwSqM67/JGrdXu7cbFOkcPCos9ycfWFZC3HaoQ1gfxUoUX56x2Y10zAK+HpK0ivOrOuvkwlE73rWJHdMb7gg7HBpUOR66Y3Prd6u2XN1fsflBjDmbnMMycSjX3dsJLHd7ezV0HMDWosNJFKfBL2A4C6gZQ//GyMV6ZXVsMRW3MHI5/rJQQa242EMsKfE77bBGEmALiHUqnyk2tKHQCvHdgHpm+nwvH6A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21513816-9bc5-456d-eb41-08d59502d4fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2018 23:22:53.7001 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1061
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
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "James E . J . Bottomley" <JBottomley@odin.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Maybe best through greg's char-misc tree since it has generic hv code and sometime updates both network and scsi.

Alternatively,  put common code through one tree, and hold off the network device change till next release.

-----Original Message-----
From: Long Li 
Sent: Wednesday, March 28, 2018 3:43 PM
To: Martin K. Petersen <martin.petersen@oracle.com>; Long Li <longli@linuxonhyperv.com>
Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>; James E . J . Bottomley <JBottomley@odin.com>; devel@linuxdriverproject.org; linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org; netdev@vger.kernel.org
Subject: RE: [Resend Patch 1/3] Vmbus: Add function to report available ring buffer to write in total ring size percentage

> Subject: Re: [Resend Patch 1/3] Vmbus: Add function to report available ring
> buffer to write in total ring size percentage
> 
> 
> Long,
> 
> > Netvsc has a function to calculate how much ring buffer in percentage
> > is available to write. This function is also useful for storvsc and
> > other vmbus devices.
> 
> What is the submission strategy for this series? Do you expect it to go
> through net or scsi? If the latter, I'll need an ack from davem.

Martin,

I hope this patch set goes through SCSI, because it's purpose is to improve storvsc.

If this strategy is not possible, I can resubmit the 1st two patches to net, and the 3rd patch to scsi after the 1st two are merged.

Long

> 
> --
> Martin K. Petersen	Oracle Linux Engineering
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
