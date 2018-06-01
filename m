Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3675997-1527878104-2-10032700961212842891
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527878103; b=RMTXO7invvrj+yzeAQj4BdPTIzqNBXijxFEi24l3Jk8qyTQihD
    zSSivBBle1Yl9HxWI4rp9kwoo7wmRPnscrrY1UBVyI/jpOq9QchE8e5dzEFSAtSK
    zEuidWhHy/j5CJNas3u6fqsEM5pH3btM6Ks3G0zhKBJ5ba5+aFR9snV18uFCI+vv
    CWBl2A29UP8ZYdtAUQK5bJCVOKQ7ph16HZ22qggNwlaxbQKL0ASFvrUhZUfwABAL
    1LOYiB+2IGRV7aVh++L0SuhQNSVACAVkx+P4yO5pBttQem+N0+HH+xLQE0L3Zj10
    kRrFFV7Hwuhqv2hNVQWBxzs6ed3oy/Jdth6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1527878103; bh=L8gCKlnWU1kxr2FGqlWOgnzM9JDJa/vBtXlY6KrSjF8=; b=
    jYwmFtBzSbQsbGXYXWpvWpuKOi5WxJ6hJvR3FGK/116Pm8FGzgmvWm+92xR7SnCK
    ahWP1cLDDUtisOXgZ1M2v7RYqvc3u+zfJem5OimYhYnAiQNWkhCQKCKjns5VAQeB
    yWzxR4Pt6jeuVJQdG8yWnIu21VcamTSIFLnnV+bSA27PUs7ZZZ7aD77BFjwocWz9
    39ifdXsw9L2WyaI1CrSGYsV/xFAmqFF2diPApI/LetNkzIJOzuZGOXtaVkpdLGu4
    LinrkwoyR0wFS78T9eTMDbannCML0selsDnMaW7HJZRSe+SNMjpP95my/HaSamic
    UyGOXV5VdwlSznkE6lBn9g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=cray.com header.i=@cray.com header.b=xKhhnxTq
    header.a=rsa-sha256 header.s=cray1024 x-bits=1024;
    dkim=pass (1024-bit rsa key sha256) header.d=crayinc.onmicrosoft.com
    header.i=@crayinc.onmicrosoft.com header.b=uXFLOf8Y
    header.a=rsa-sha256 header.s=selector1-cray-com x-bits=1024;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=cray.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=cray.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=cray.com header.i=@cray.com header.b=xKhhnxTq
      header.a=rsa-sha256 header.s=cray1024 x-bits=1024;
    dkim=pass (1024-bit rsa key sha256) header.d=crayinc.onmicrosoft.com
      header.i=@crayinc.onmicrosoft.com header.b=uXFLOf8Y
      header.a=rsa-sha256 header.s=selector1-cray-com x-bits=1024;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=cray.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=cray.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCpnHJZJcxYFQZJATCL3Z7D68T/5Vx758OZlvfdjZyfN0NKUNnw0IRIUKVhhoahdkUgRSwVpz0hcJTKfmOlzRzFjvyKGCc1j2r8TwDjTNbG5GHbGs5ep
    RpCRfmwz1rMCVQu4zWq0PBzB6CafBDg4Vr7ZnrGCWWQOiaUuNzT2pTPIrxWr05kUzmcqu53uyl3K8PgmWSIZI92n3gvVwp/ygMkjrmNa2t5jCbU58BDfRv/h
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=zrw9J8CsoM0A:10 a=l6nqK_Vz5-EA:10
    a=s3cSYYZoVzsA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=7mUfYlMuFuIA:10
    a=uLCC7SJ24JkA:10 a=RPJ6JBhKAAAA:8 a=JfrnYn6hAAAA:8 a=sK_hXKufAAAA:8
    a=agPvhSWLAAAA:8 a=gIQWn0-tklEFjY0qfs8A:9 a=CjuIK1q_8ugA:10
    a=fa_un-3J20JGBB2Tu-mn:22 a=1CNFftbPRP8L7MoqJWF3:22 a=yWjlxG-dkHreuWcaj4iL:22
    a=OFV2l2Cw3rRTRwl-yjV4:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753399AbeFASfB (ORCPT <rfc822;linux@kroah.com>);
        Fri, 1 Jun 2018 14:35:01 -0400
Received: from esa2.cray.iphmx.com ([68.232.143.164]:36363 "EHLO
        esa2.cray.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752485AbeFASfA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jun 2018 14:35:00 -0400
X-IronPort-AV: E=Sophos;i="5.49,467,1520899200";
   d="scan'208";a="19856552"
X-Cray-OBMMKR: 1433258124 19856552
From: Doug Oucharek <doucharek@cray.com>
To: Andreas Dilger <adilger@dilger.ca>
CC: Christoph Hellwig <hch@infradead.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Drokin <oleg.drokin@intel.com>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        fsdevel <linux-fsdevel@vger.kernel.org>,
        lustre-devel <lustre-devel@lists.lustre.org>
Subject: Re: [lustre-devel] [PATCH] staging: lustre: delete the filesystem
 from the tree.
Thread-Topic: [lustre-devel] [PATCH] staging: lustre: delete the filesystem
 from the tree.
Thread-Index: AQHT+Yiv7eImo1VupUGq8tXFCLjNwqRLR/6AgABvXoCAAAFgAA==
Date: Fri, 1 Jun 2018 18:25:24 +0000
Message-ID: <29ACF5A8-7608-46BB-8191-E3FEB77D0F24@cray.com>
References: <20180601091133.GA27521@kroah.com>
 <20180601114151.GA25225@infradead.org>
 <E5BF8501-35EB-4DDF-ADBE-6016CF31A502@dilger.ca>
In-Reply-To: <E5BF8501-35EB-4DDF-ADBE-6016CF31A502@dilger.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [136.162.66.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR11MB1527;7:c7TRMQu//INnm1XvLUBfxpjNjUcY0Y5g+tx/yL6bRL5kVKa9weTTN4eeONExbpUqVS520jnPIPsvwdiBSB90dL1c+B5zCzz19MJXC36PuUFVpgKZzwinXy71nlbOMEcp3Zm7ZyJEUjgw+rsrN6V2GGnSocOaLwmcUmyyyEpdcB/3s0n9HKjcqssfrHDG50zAoZdtbrKBsMvuY5+rHmhU+JLHX62UZztzL5f49nqLoJ+WH+3wJJyCIsCRw6019HDR
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR11MB1527;
x-ms-traffictypediagnostic: CY4PR11MB1527:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=doucharek@cray.com;
x-microsoft-antispam-prvs: <CY4PR11MB1527FBED65C92E4DF8DE1F39D4620@CY4PR11MB1527.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:CY4PR11MB1527;BCL:0;PCL:0;RULEID:;SRVR:CY4PR11MB1527;
x-forefront-prvs: 0690E5FF22
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(396003)(346002)(366004)(39380400002)(376002)(189003)(199004)(446003)(86362001)(486006)(6246003)(66066001)(6306002)(6512007)(2906002)(11346002)(105586002)(7736002)(6436002)(14454004)(53936002)(59450400001)(54906003)(83716003)(6486002)(25786009)(2616005)(966005)(478600001)(476003)(229853002)(36756003)(4326008)(316002)(8676002)(81166006)(6916009)(3846002)(81156014)(186003)(8936002)(26005)(33656002)(3660700001)(5660300001)(2900100001)(102836004)(53546011)(6506007)(99286004)(305945005)(3280700002)(68736007)(82746002)(106356001)(97736004)(6116002)(5250100002)(76176011)(13693001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR11MB1527;H:CY4PR11MB2022.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: QNbIKhmtIhsg2da6NAKIAuEsyPGS45NxiEDP65REd76pX56Ghl85wwpJokQhuFB0QUSQ2Rks7up/J7fS/Z2mUXvDuj46iqn0YOiaSqSHNFIEJcFFnIBxXczrEN6ymYdG9f0aoqXO2frqPtWwWtIwZnSLDgDucrApCea9iwd6Y5vhRDCUtqCB2BVU58Rpvo/6
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <93BD660D583FFA4E862C95BF636E5772@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 72cb586c-7e7e-4abc-f0e5-08d5c7ed0a8f
X-MS-Exchange-CrossTenant-Network-Message-Id: 72cb586c-7e7e-4abc-f0e5-08d5c7ed0a8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2018 18:25:24.0394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e7b8488a-c0cd-4614-aae1-996bfabec247
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1527
X-OriginatorOrg: cray.com
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Would it makes sense to land LNet and LNDs on their own first?  Get the net=
working house in order first before layering on the file system?

Doug

> On Jun 1, 2018, at 11:20 AM, Andreas Dilger <adilger@dilger.ca> wrote:
>=20
> On Jun 1, 2018, at 7:41 AM, Christoph Hellwig <hch@infradead.org> wrote:
>>=20
>> Thanks,
>>=20
>> all that churn without much visible progress to a mergeable codebase
>> was really ennoying.
>>=20
>> I'd recommend if people want to merge lustre they start with a managable
>> subset first, e.g. the fs client code with simple IP-only networking.
>=20
> Adding or removing the IB networking makes basically no difference to the
> code size.  This would also make the client much less useful, since a lar=
ge
> number of sites use Lustre with IB networks.
>=20
> Cheers, Andreas
>=20
>=20
>=20
>=20
>=20
> _______________________________________________
> lustre-devel mailing list
> lustre-devel@lists.lustre.org
> http://lists.lustre.org/listinfo.cgi/lustre-devel-lustre.org
