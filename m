Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA53C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22EB22146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:01:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22EB22146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbeLAFLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:11:41 -0500
Received: from mga03.intel.com ([134.134.136.65]:15626 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbeLAFLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:11:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 10:01:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,299,1539673200"; 
   d="scan'208";a="279375944"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga005.jf.intel.com with ESMTP; 30 Nov 2018 10:01:34 -0800
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.128]) by
 ORSMSX102.amr.corp.intel.com ([169.254.3.81]) with mapi id 14.03.0415.000;
 Fri, 30 Nov 2018 10:01:34 -0800
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC:     linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Arend Van Spriel" <arend.vanspriel@broadcom.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Eric Snowberg" <eric.snowberg@oracle.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Joe Perches" <joe@perches.com>, Jon Hunter <jonathanh@nvidia.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Nathan Chancellor" <natechancellor@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>
Subject: RE: [GIT PULL 00/11] EFI updates
Thread-Topic: [GIT PULL 00/11] EFI updates
Thread-Index: AQHUiAbHOvhS3sTUD06cGnW0DdiISqVnEMMAgAGuNoD//95JAA==
Date:   Fri, 30 Nov 2018 18:01:33 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F485F184E@ORSMSX114.amr.corp.intel.com>
References: <20181129171230.18699-1-ard.biesheuvel@linaro.org>
 <FFF73D592F13FD46B8700F0A279B802F485F14B8@ORSMSX114.amr.corp.intel.com>
 <CAKv+Gu9wYBoLUsioOvsx+ggg6DanqWd3VKVP8nxZ+=zqOqzM3w@mail.gmail.com>
In-Reply-To: <CAKv+Gu9wYBoLUsioOvsx+ggg6DanqWd3VKVP8nxZ+=zqOqzM3w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMWM2YTcyNTItYzY1ZS00OTgwLTlhY2MtZmJmM2Q2NzliMzExIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTzUrVjJ3M2p6aUZGUEpOXC9RbENaVUYxNm92R0RqS3RyUGZTVHRka1FYQmhxaU51VVU5V0tiYnk2RHJrZ1JQNUEifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBUaHUsIDI5IE5vdiAyMDE4IGF0IDE5OjI3LCBQcmFraHlhLCBTYWkgUHJhbmVldGgNCj4g
PHNhaS5wcmFuZWV0aC5wcmFraHlhQGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBIaSBBcmQs
DQo+ID4NCj4gPiBXaGlsZSBidWlsZGluZyBmcm9tIG5leHQgYnJhbmNoIG9mIGVmaSB0cmVlLCBJ
IG5vdGljZWQgdGhlIGJlbG93IHdhcm5pbmcuIENvdWxkDQo+IHlvdSBwbGVhc2UgY2hlY2sgdGhl
IHNhbWUgb24geW91ciBzaWRlPw0KPiA+DQo+ID4gICBDQyAgICAgIGxpYi9saXN0X2RlYnVnLm8N
Cj4gPiBkcml2ZXJzL2Zpcm13YXJlL2VmaS9lZmkuYzogSW4gZnVuY3Rpb24gJ2VmaV9tZW1fcmVz
ZXJ2ZV9wZXJzaXN0ZW50JzoNCj4gPiBkcml2ZXJzL2Zpcm13YXJlL2VmaS9lZmkuYzoxMDAwOjY6
IHdhcm5pbmc6IHVudXNlZCB2YXJpYWJsZSAncnN2c2l6ZScgWy0NCj4gV3VudXNlZC12YXJpYWJs
ZV0NCj4gPiAgIGludCByc3ZzaXplID0gRUZJX01FTVJFU0VSVkVfU0laRSgxKTsNCj4gPiAgICAg
ICBefn5+fn5+DQo+ID4gICBDQyAgICAgIGxpYi9iaXRyZXYubw0KPiA+ICAgQ0MgICAgICBuZXQv
Y29yZS9zb2NrX3JldXNlcG9ydC5vDQo+ID4NCj4gDQo+IFRoYW5rcyBTYWkNCj4gDQo+IEluZ28g
c3BvdHRlZCBpdCBhcyB3ZWxsIGFuZCBmaXhlZCBpdCB1cCBiZWZvcmUgbWVyZ2luZy4NCg0KR3Jl
YXQhIDopDQoNClJlZ2FyZHMsDQpTYWkNCg==
