Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A24C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A86320880
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="hWlPCDR1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A86320880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbeIZCFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:05:10 -0400
Received: from mail-eopbgr700053.outbound.protection.outlook.com ([40.107.70.53]:63057
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726596AbeIZCFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:05:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fn7azcaLqAbLxn8+Q5nxsF0l3X3WpHm0qKmWuYN8svo=;
 b=hWlPCDR1zBGj0iitY5WbUVTGgq+A6OOaNH6SmrlQRkgYIOryl1BM3LW5gj59iVeWbJXQfqteMqdB0GIT8Gw4igUq8ia85tzeoPCvy6PiL/QJq/4gPqH0Jin1rOA7ctx2EYzRmM15iTcv0DciTxyf5ryWFOwAs/Q/rKtRRuf1a8w=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4822.namprd05.prod.outlook.com (52.135.235.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.17; Tue, 25 Sep 2018 19:55:57 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::1cc9:412c:6f6b:e0ae]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::1cc9:412c:6f6b:e0ae%5]) with mapi id 15.20.1185.014; Tue, 25 Sep 2018
 19:55:56 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Xavier Deguillard <xdeguillard@vmware.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v2 00/20] vmw_balloon: compaction, shrinker, 64-bit, etc.
Thread-Topic: [PATCH v2 00/20] vmw_balloon: compaction, shrinker, 64-bit, etc.
Thread-Index: AQHUUQfQIMMIWFZCCEKofaxAOk4MR6UBVYEAgAAb+YA=
Date:   Tue, 25 Sep 2018 19:55:56 +0000
Message-ID: <4E03488E-E9EC-4676-A008-C89BC61CD05A@vmware.com>
References: <20180920173026.141333-1-namit@vmware.com>
 <20180925181548.GB25458@kroah.com>
In-Reply-To: <20180925181548.GB25458@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4822;20:RjxrZfXN+p8Dz6if2vahRTWaxMMphBTFDJzsaqad6XORik4PLysfRlmPBt5nHsdRVLutzWr/8fx0FWDkPqYrHhPF7tIRcunrhhKYDC5KYsRQLff6AZHuW0a5llkQCfaVBzccHQmpqlovPbzj08WXMNnrfZZP9C3ZXbTaCysHv8U=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9cb52292-71a9-4980-68f6-08d62320e8b3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4822;
x-ms-traffictypediagnostic: BYAPR05MB4822:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
bcl:    0
x-microsoft-antispam-prvs: <BYAPR05MB4822D09F24DA5C40DC1024D7D0160@BYAPR05MB4822.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(3002001)(149066)(150042)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:BYAPR05MB4822;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4822;
x-forefront-prvs: 08062C429B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(396003)(136003)(376002)(189003)(199004)(25786009)(4326008)(6512007)(36756003)(5250100002)(81166006)(229853002)(6486002)(7736002)(26005)(186003)(6506007)(476003)(81156014)(6246003)(5660300001)(97736004)(305945005)(82746002)(105586002)(54906003)(8676002)(106356001)(6116002)(486006)(316002)(6436002)(102836004)(6916009)(2906002)(76176011)(14454004)(33656002)(99286004)(256004)(14444005)(68736007)(3846002)(478600001)(8936002)(446003)(86362001)(11346002)(2900100001)(71200400001)(2616005)(71190400001)(53936002)(66066001)(83716004)(34290500001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4822;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: p7rN4ZeOCGp5qC79jwzu0psYw3l54Tgjt4QxdDZ5Mw/8Msh50WAZ+Cb1Y1N5rTZ4ZUVHxTTfSTwXUJCyUxW7lLsits/sDb68U8vlwyPIf6GGBj4KJcgVQg1AfkK3CqLTYjvlsIqvYVUf3d0VruCQduuZUyEfmP/iwGAHP7OdGvLyGLAJWUSVzexQ5TEWoT0WwBGJUSuRuXOMeFIBxsb4SIRA2oGahl9G6JopkJRAkeYee8J3MRsi89QI2UyWmZFHPZgKfn5GUuzEz+UlGE7rNYSB3WRJG0sAxM1lXa5GwYxMzjwTsQi8uD6g6Et06JBkoxJEMTcGsk6zbrcmJwyC3gL7Vcw6V04cCNTyUk46hRY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <38E03D8D6F3DB242B54FC7FA56F287BA@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb52292-71a9-4980-68f6-08d62320e8b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2018 19:55:56.7850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 11:15 AM, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Thu, Sep 20, 2018 at 10:30:06AM -0700, Nadav Amit wrote:
>> This patch-set adds the following enhancements to the VMware balloon
>> driver:
>>=20
>> 1. Balloon compaction support.
>> 2. Report the number of inflated/deflated ballooned pages through vmstat=
.
>> 3. Memory shrinker to avoid balloon over-inflation (and OOM).
>> 4. Support VMs with memory limit that is greater than 16TB.
>> 5. Faster and more aggressive inflation.
>>=20
>> To support compaction we wish to use the existing infrastructure.
>> However, we need to make slight adaptions for it. We add a new list
>> interface to balloon-compaction, which is more generic and efficient,
>> since it does not require as many IRQ save/restore operations. We leave
>> the old interface that is used by the virtio balloon.
>>=20
>> Big parts of this patch-set are cleanup and documentation. Patches 1-13
>> simplify the balloon code, document its behavior and allow the balloon
>> code to run concurrently. The support for concurrency is required for
>> compaction and the shrinker interface.
>>=20
>> For documentation we use the kernel-doc format. We are aware that the
>> balloon interface is not public, but following the kernel-doc format may
>> be useful one day.
>=20
> I applied the first 16 patches.  Please fix up 17 and resend.

Thanks. I will update it and resend later today.

Regards,
Nadav
