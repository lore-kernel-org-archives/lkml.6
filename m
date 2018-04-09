Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523245157-2-5286589858420822062
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523245157; b=ikwGvs4XBoLCqpLkNz5qWyj/cfQL5v4alPFKCFVUDmbaFS2Liq
    n8fcQPAfKE+XjjBj84tjqQzxfNU/OgWr/X0FBiQNHJKCMTVkv3O3ztGo7iAWlrLv
    50q3ivpmQZ+xuN0HW8umZBrhwvhB60LBmOl1rFYK5rdIJJTw1DdOaPoLHB9+Bejg
    DVPxK01iwfOWmS4B3O72TOHwCZkhEDZ6KuvbX8M+m5kttvOB/0qq2POw/HVeyG5C
    9Up+WRpwzddjDf6v/hmHGg/SgE24Erb+UmvQisq6qgKg1rNKjcDAbKgkY0l44Mkb
    BVYSXDyKBmBE7eoFrOFtvEU+EOrFG3wkLjrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245157; bh=WeKQywLmaX
    bAQz9ti0iRuajMpaPxFWtvPWXklivmSzE=; b=VACXOjZ+YGeDThFpgRskYucKT8
    2VtV/a1tgfr0g3xGSZGGZe6HJXFc1wZA4M38+n2ZH3fmvelmb0tiMbsoQscR7YRA
    j09Ldp1wzE3QRhI4qYMEPZbDw8SuOl4MAGg5x0wUloOTF+e3Gwacg1XIjj7ftCI4
    VH0Z/bZWTWqHW5VdmTqWPqN2cimcrEve1pzHW5DxwRTL/1NzgH235tbeLje2pHzv
    7OW2O6g/2/JFSTL/lW7tJDfnRG0EkSP7vEJLFhD4pW+1e5muNy8mjssg7ooyOqpW
    ljm3I7SO23Lv6LzWbodw2SsDHT1Z+uZi1YgSYckeNHfrJXLxbnwKBrovW1qQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=C4EjZWHK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=C4EjZWHK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOdVomKVKZPoE+ZvzATKhblgZcMwt7h0e5YE425DYyjBd/9C0jMp9vQHJ2nI8focUBmtKoLx3yNsUAuUi6hPDVbP+5E4CF9EmlEMR9omMyEAWPoc0JBM
    RF93cJVLSmY4ghATGZXA7ji+GTmJjK9oqc2j5fPX9CKoXaA3BbsNemK2B5GoOONJa7pSSPWene+bSHLiI6lLJ8gwuXUmMwj/f6UK6Negy5HDrVmrbCm+ICNo
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=Z0MEXSAVmvUA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=1nDYEFkVsKwEciwpJlIA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753391AbeDIDiz (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:38:55 -0400
Received: from mail-by2nam01on0139.outbound.protection.outlook.com ([104.47.34.139]:39793
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754387AbeDIDgl (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 23:36:41 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] uapi: fix linux/kfd_ioctl.h userspace compilation errors
Thread-Topic: [PATCH] uapi: fix linux/kfd_ioctl.h userspace compilation errors
Thread-Index: AQHTz7P39IpjHnB+4EC+fZ4+cnNNBw==
Date: Mon, 9 Apr 2018 03:36:39 +0000
Message-ID: <DM5PR2101MB10329959D87B05E16A25EAE8FBBF0@DM5PR2101MB1032.namprd21.prod.outlook.com>
References: <20180405042655.GA13233@altlinux.org>
In-Reply-To: <20180405042655.GA13233@altlinux.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:256CD/Qwdf7fuuiXG5A+maZLmCoZ+f6BxmwPiVIPV6Q2xBmTm5n3RSCUHb4U2s2NJ9yafryZjmsofzubArTKukL9imROYKShnVoSVdNLjgE+ANQlirzOUF2CQUOGDJVx9xMfVUpd4kC6lDlpuz/MIzcZS+230IUUb0ihYM0yt0XtNis+mJpYTuu4q7XJxT2czoprf/ggW0scuO7BkAftMrgF+Jc9adO62UawYDE43e8M4S5EPurcNN6BOPCM+VF7;20:uewkbmO4/zT64/QhYe2cnKVbl/rV8CayfRiuH++0Yk8IOGuSAytR+Dxdqw6iu6QOzREGPDzYZn3TBRv1brNFppy1aviInupoXDH24j9ILExRpxEy7WoIXm9vGVtP3K3dA6mrCDzLawSorZTR/9dRlpaJyKRtfVSDMGb/XlVoixw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 06df88c8-1638-4613-6e91-08d59dcb1a96
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB109573F98595BA3962E8C71BFBBF0@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(346002)(376002)(39860400002)(396003)(199004)(189003)(476003)(10090500001)(105586002)(86362001)(102836004)(11346002)(446003)(6246003)(55016002)(9686003)(76176011)(97736004)(74316002)(6506007)(8676002)(99286004)(4326008)(81156014)(7696005)(81166006)(86612001)(26005)(486006)(2900100001)(106356001)(33656002)(72206003)(305945005)(478600001)(8936002)(25786009)(10290500003)(3660700001)(7736002)(66066001)(68736007)(8990500004)(110136005)(316002)(54906003)(3280700002)(2906002)(3846002)(6116002)(6436002)(53936002)(8666007)(229853002)(1511001)(5250100002)(14454004)(5660300001)(22452003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: dmJ4SgDBvaSLmTKZ8WMqN/O5r80cr1yeS8/O094jShoZVupU6tcmI8yQx2qyeuOr30Go/oeQeRYMg9GsKMFH/IfhKv5Lyvv4Wcf7uZBb0zGb4Ps0OVgJDPwQgA+jPpUs0gGt++NTQXv4Ov6qpLumraYPP9IveIh9vL9O5Yso0kOZB3PeKAVzjLvU4/fSl22H/iBBougo9/xhTAy3/aDxaTaNx3U4liEO2XU+9RMPLcmzhcyuDPHRO2NJowIsu6cRmbHTf4m3W+ZydiaNfwjJTGcJLjflvbd88oDjC+8xfFSvSE9qgo3z1D7Lv7IrUQsrh/Olo63HtvPYu30RtjwmQSWTSUcm1asK/med7x1nyHfBxN3dgKorE0EeyI/uXWl/4SBrSyYHVvbj0COO/V4ccFhRnmIDy68EAiXet7yY9Dw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06df88c8-1638-4613-6e91-08d59dcb1a96
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 03:36:39.1375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1095
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag,
fixing commit: 6a1c9510694f drm/amdkfd: Adding new IOCTL for scratch memory=
 v2.

The bot has also determined it's probably a bug fixing patch. (score: 20.44=
72)

The bot has tested the following trees: v4.16, v4.15.15, v4.14.32.


--
Thanks,
Sasha=
