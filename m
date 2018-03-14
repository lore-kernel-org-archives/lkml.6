Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-620268-1521000159-2-9992575960141409185
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521000158; b=EravHgT5aAiljzbJprMxUjeTDSEKtk+tSOcaSYRc24MqL2o
    D2wQ/+cS+yA67qqIygwss+p0pcsctlTGsrO7Adl87bpZG+1H/gcC3yjZCfRNQjle
    gXnYb+kDJJZ6e5pErDqk6m1cSD+BreR932jxyMFTDE1K7hs8mwJuFyL5u07X+iJW
    qLKHm05dRFBzGq9i7jHRA/XV/DSCrgE0miBcYvbc6ZnHVa5YSsUQV/BPssf/suK1
    d0E7mi9P9+WUfrZ3OGu4P9it+93gvDUZkyZ178s5KHUMhyuy4LXuKIYQLXohqWqo
    igqi2JVse3dh2+wD0KwEcLqD+/KOrmpIa9Ee8Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521000158; bh=/Z2xSemPiGYuBk5NIKjWEoNIzM83XJAQvSA2Oj
    /9gPs=; b=kLw4rUG6yUGaosu07xxXw9UzwYslmCzB+nAogUoP4K+26iCfHuBUMC
    J252N4VkiVgdhLVMlDHOrx2VrFCYca8EB2BziZfG6RhrUIJJpkt3eBtB9hzSRKIZ
    jZbchZTRk6/Tj9k8oqb8tdctUbLZOQXKOyLBHrwIoFBi7vPPLmAkIaq9pKgPQEuA
    D2+nky7LZO3C+hZpjhV18VZPknfghBh072jqnKrrEMVnmQhv7emgSxwP8inr+DA2
    kQokRyTkA9brd3lAzi8uzlF1pXTMaZqTpZfzo1MUmJ61sQFDRitDH7OnuQcd+laq
    aD2juViSU31J6sfEv5lgd5FYXqvCAPmg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=onevmw.onmicrosoft.com header.i=@onevmw.onmicrosoft.com header.b=lEOVzZdW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-vmware-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=vmware.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=vmware.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=onevmw.onmicrosoft.com header.i=@onevmw.onmicrosoft.com header.b=lEOVzZdW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-vmware-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=vmware.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=vmware.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750758AbeCNECf (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 00:02:35 -0400
Received: from mail-cys01nam02on0047.outbound.protection.outlook.com ([104.47.37.47]:25056
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750737AbeCNECe (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 14 Mar 2018 00:02:34 -0400
From: Nadav Amit <namit@vmware.com>
To: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oleksandr Natalenko <onatalen@redhat.com>
CC: Xavier Deguillard <xdeguillard@vmware.com>,
        pv-drivers <pv-drivers@vmware.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Gil Kupfer <gilkup@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] vmw_balloon: fixing double free when batching mode is
 off
Thread-Topic: [PATCH v2] vmw_balloon: fixing double free when batching mode is
 off
Thread-Index: AQHTujhdSIiXJAlj90GNO4oOVtEcZaPPHhoA
Date: Wed, 14 Mar 2018 04:02:31 +0000
Message-ID: <E63288C3-BE4F-4D41-A074-1CB86C74414E@vmware.com>
References: <20180312191917.21381-1-namit@vmware.com>
 <20180312192848.22104-1-namit@vmware.com>
In-Reply-To: <20180312192848.22104-1-namit@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN2PR05MB2733;7:S1BSxf3mjVbWacKyY1r4zIClUoLekmmQO3fFshiEdR9bIvzu/IZUq1/PvTH7Fn5kXv8aq/bc9XsWQ0f3DiGS+s46RRLiNOMKD4pI8DODGOBWT8/MiYjdzltRdutNJntsmKsZa0CVZkPTMCU1BfEgS93obEx6wjcsqthz+XnnxEw1Ol2WzodD0SQDe3GAMa18e1MPe1Jt6SeEAMaIKIruxQlUJSKVv3MMPXAu1+v3wMSTtXBI8CGcp/MK0gneqtbw;20:U4QrwFImPUXzfBM7DYAos7uFC0+1hXDGhm0Gl89Lm2rKb8vlO/EcJOiJeY2J07vClP7laR/9iY9nY0JBt+Uc3swfhbl4CDbLuCZe31fEWFWS/CYCat6kXJv8QAO7p4tVi7xvcwchxdqk4sgiDKLWe2eG/juz8O2YGe91AnpdbJo=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 1925ebd1-149d-4563-eb7a-08d589606940
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN2PR05MB2733;
x-ms-traffictypediagnostic: SN2PR05MB2733:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com;
x-microsoft-antispam-prvs: <SN2PR05MB2733CB949AA3497A765CAE82D0D10@SN2PR05MB2733.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(3002001)(93006095)(93001095)(10201501046)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:SN2PR05MB2733;BCL:0;PCL:0;RULEID:;SRVR:SN2PR05MB2733;
x-forefront-prvs: 0611A21987
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(39380400002)(366004)(39860400002)(346002)(396003)(189003)(199004)(7736002)(54906003)(110136005)(97736004)(53936002)(105586002)(5660300001)(33656002)(6246003)(2900100001)(83716003)(86362001)(3660700001)(2906002)(3280700002)(5250100002)(82746002)(68736007)(305945005)(99286004)(25786009)(316002)(39060400002)(6116002)(3846002)(106356001)(229853002)(66066001)(478600001)(4326008)(2950100002)(36756003)(6486002)(8936002)(6512007)(81156014)(81166006)(8676002)(102836004)(6436002)(14454004)(59450400001)(186003)(26005)(76176011)(6506007)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR05MB2733;H:SN2PR05MB2654.namprd05.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: K5ljAl05pej0ZhD1qSEgViyH6TcA1n/CyWiIbbgKVgiEYasMNMURsDnJxtVz/ZQxGamcU5k3CJ/jN7C/+fAP4jmo+6lUOZu81G4iKDtPFD1Lx9uYGij9usq84S7gjTqp68kJ1M+8b/ZTd4veFi3vAziqg2EuWqUZv25OBr8VC2rWBD6Icntu+ON4bG5cWVvs9FxDXcwATozFufJ7eGKk2TjYuQwGPbI3Kb7rXxYglnqE4HA+GLHH+GoqlRUi7y4io3JwIJ678itW/tyYGKPUk8Xh28JIEg8sxN02dKV9wwqE1TPVz132+/as+M867IBPjXwDfEW+1EJDoLkdgUifdA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <52B8D4737E2E27448218BF1CD24AD0E2@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1925ebd1-149d-4563-eb7a-08d589606940
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2018 04:02:31.6958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR05MB2733
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Nadav Amit <namit@vmware.com> wrote:

> From: Gil Kupfer <gilkup@gmail.com>
>=20
> The balloon.page field is used for two different purposes if batching is
> on or off. If batching is on, the field point to the page which is used
> to communicate with with the hypervisor. If it is off, balloon.page
> points to the page that is about to be (un)locked.
>=20
> Unfortunately, this dual-purpose of the field introduced a bug: when the
> balloon is popped (e.g., when the machine is reset or the balloon driver
> is explicitly removed), the balloon driver frees, unconditionally, the
> page that is held in balloon.page.  As a result, if batching is
> disabled, this leads to double freeing the last page that is sent to the
> hypervisor.

Oleksandr, if you can confirm that it fixes the bug you encountered, it
would be great.

Greg, Arnd, on your free time, please let me know if there is any issue
with the patch, and whether you can incorporate it, preferably in 4.16,
since it is a bug-fix that was encountered by Red-Hat customers.

Thanks,
Nadav
