Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3402981-1522276977-2-13534555214467347512
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522276976; b=LLABcCAT+NSlS7HSuCsLzyM3rKmFq47eieIaQNNXp8RnW1G
    X4aDnwOswN9W2fEtO9yqYwmGMKmAprGW/tW0resTIaLOWbjo/0A4T7ECvytKTWJ9
    iW9a5J69Un2OPDkZYkxT6mP/wZ586cbGYkdfHnrWFA97GKp3qjHCgxdo/H7S1S9z
    Y8GVRH+yRSEXPd/3G4vFD4HD98XLTlB+8DSVsaTmYx1VqeU24Ni6arnkUVFTzF6D
    b+Sxzi/nvwuPp7K/fduYsV+iIvM1emVBf9lwH2pil3WP2TSRq5n4p9mo+kIpXK24
    EyFAnDJ/72c3mYiOYDZirF2gnXtIqltnB8CKVhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522276976; bh=X
    wcYdWC+umdugf6uLJfrYmy37bef2VdsCQ8WV+JGuig=; b=XbmZ9dtVgGo/4dIZU
    X24209UyVwqwvkd43TGUZuxedP9/WNGvGF7G6sWfnKwNDsWk3xOEVfsM1xvLHenr
    uKr0LPGGDlyW+Odh0mYafUoIHv0BGfhMJm6qBB2Hn0q7Hqh5teEZa/lUl1aoF11Q
    8Q9+BvVbYtG5ltTUSbv/ChxmHC/Bstm6LeYP9Q33Ry2sVmcFB5xVL969i5To7sj1
    I3v8azBOmda1rzd0Zi4vXb56MBBh8Hw5fRDSoY0Ts1QrqQ/3sLZ2gP8AL5mKsFR2
    JNBgxk8BweOPOS6F0WMR0uRE6jXwNQrIwI0c2ZmBGMq9VCeG0PGPE5WQEqY5v/hj
    Ijibw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=c7lEzlAq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=c7lEzlAq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMHDbvdv5yJHYBjWEfHISjsLtWU3iIhLfVHr3qnWBl2PuVrb7ygs3R1ygabh4qdb51FnxDSVnhYAntXYaZYxdyC0SzLX7a7S7RkbB7uyd/ctZqdUlgFh
    sfPhiZNuoTx7hAbwJSMGjNFg+zq6DepYBXyshHKZjl8cvGtLppoe+E+9mTT7YJEL9+KqYVjoJ+FWa87rMoLYMSgTxdB7X6oVXruo0bgDz50KinI8Ch7RL6e/
    j1m7aGEmrMWnzJ7YOrGA5w==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=R4fxTKrshSIA:10 a=ktgBQwt_910A:10
    a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=v2DPQv5-lfwA:10 a=Lf-vpJhqX20A:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=9wgM_2a8NCVDSPvlk1cA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Long Li <longli@microsoft.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>, Long Li
 <longli@linuxonhyperv.com>
Subject: RE: [Resend Patch 1/3] Vmbus: Add function to report available ring
 buffer to write in total ring size percentage
Thread-Topic: [Resend Patch 1/3] Vmbus: Add function to report available ring
 buffer to write in total ring size percentage
Thread-Index: AQHTxi61HVmVjtlmGEedCNp7Dar+hqPmNDBBgAAJfjA=
Date: Wed, 28 Mar 2018 22:42:45 +0000
Message-ID: <MWHPR2101MB072958DDC25845615C3B1ADCCEA30@MWHPR2101MB0729.namprd21.prod.outlook.com>
References: <20180328004840.22787-1-longli@linuxonhyperv.com>
 <yq1y3ibhndg.fsf@oracle.com>
In-Reply-To: <yq1y3ibhndg.fsf@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8::2e0]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR2101MB0811;
 7:t4h9HpBYCzlli6ww1a0q2pCBYB77vH6lbrr2Ea4SaK0ZJX3CVynmOpYkkNg3IHNHB16Exv7XpYQHepqEdVvoC/kkYvNnIG5ArMSN/VApP0NWrvZT4xA55yDC+smmtdlJd6XlX83DQN7D32XHUEiEw921QolsohNivxgbp3Yyg3RjEN2rOadIihb+/NtZl4/y3kfdSTlavlYAcA5GVAlMQqMdLgBLWqJibmSpKpq8+kuHtGrTB3aPtoVcMgqZT+do;
 20:bqkn5QRCwYS30GywU3cj1zEv5FtizucB8fdyJPrlVy8Mjb5TxvvaIoNp32dIhnt3+a3z6HuaTUAT/v69JGZ9/1oLOfuBtfe9KNM75cpMbKVq+rT8rjlsd2x2BlmVYgOcOF5s8EQMcHhTARDcxSIREykqxiJWytQWSKDuz3MUClo=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2285a291-50c1-455b-6ca6-08d594fd39a8
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:MWHPR2101MB0811;
x-ms-traffictypediagnostic: MWHPR2101MB0811:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com;
x-microsoft-antispam-prvs: <MWHPR2101MB0811DD477C4FC41AA06C1B6CCEA30@MWHPR2101MB0811.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(6072148)(201708071742011);
 SRVR:MWHPR2101MB0811; BCL:0; PCL:0; RULEID:; SRVR:MWHPR2101MB0811;
x-forefront-prvs: 06259BA5A2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39860400002)(396003)(376002)(39380400002)(346002)(199004)(189003)(6246003)(6116002)(186003)(2900100001)(6436002)(53936002)(54906003)(76176011)(102836004)(3280700002)(99286004)(6506007)(8936002)(86362001)(110136005)(46003)(10090500001)(10290500003)(81166006)(476003)(8676002)(74316002)(25786009)(105586002)(86612001)(229853002)(33656002)(478600001)(55016002)(14454004)(7696005)(68736007)(7736002)(22452003)(11346002)(8990500004)(316002)(3660700001)(5250100002)(5660300001)(2906002)(97736004)(4326008)(9686003)(486005)(446003)(106356001)(81156014)(305945005)(486005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR2101MB0811;
 H:MWHPR2101MB0729.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1;
x-microsoft-antispam-message-info: M5dOQQtPBC6F+QlW1sPNApAfucbAWAU3DXjPTKli/yIziPnlndlzngF4WtztlONByNCIeOWlCwLoaaiE4PXI7tC1f0E/y80KyKr1+VeQjWUFjtVAeZKFEHs2PFUx3kJjl9CXLNm8Pmx/dWNCRMQCofYPOHfzU32ANyvl4zWOAwhZPBUYYKJUNIrFV0+ijsj7tfHx+JUigzW2ER6SgiCxq4sDB65eYWPOZ40I/2oHy5VwSfWs0YMDg07Yd++8Y2ygF+vKfzJmpurn0XlKUg3vLgB4SpIfIKjEFSmKumufNVDVUFErBkM084ynieK1q4LjJ8LujfUQPxvx0ykDcPl1ww==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2285a291-50c1-455b-6ca6-08d594fd39a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2018 22:42:45.6398 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0811
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
Cc: Stephen Hemminger <sthemmin@microsoft.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
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
