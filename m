Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F768C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 19:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30BB22360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 19:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D30BB22360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbeKOFff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 00:35:35 -0500
Received: from mga03.intel.com ([134.134.136.65]:23748 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbeKOFfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 00:35:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2018 11:31:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,233,1539673200"; 
   d="scan'208";a="89306528"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga007.jf.intel.com with ESMTP; 14 Nov 2018 11:31:03 -0800
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 14 Nov 2018 11:31:02 -0800
Received: from orsmsx105.amr.corp.intel.com ([169.254.2.237]) by
 ORSMSX157.amr.corp.intel.com ([169.254.9.136]) with mapi id 14.03.0415.000;
 Wed, 14 Nov 2018 11:31:02 -0800
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     "Moger, Babu" <Babu.Moger@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "qianyue.zj@alibaba-inc.com" <qianyue.zj@alibaba-inc.com>,
        "Shen, Xiaochen" <xiaochen.shen@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jannh@google.com" <jannh@google.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "rian@alum.mit.edu" <rian@alum.mit.edu>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Hunt, Douglas" <Douglas.Hunt@amd.com>
Subject: RE: [PATCH v7 11/13] arch/x86: Introduce QOS feature for AMD
Thread-Topic: [PATCH v7 11/13] arch/x86: Introduce QOS feature for AMD
Thread-Index: AQHUeG4uwPRu5I4I10iY3UihB8yywKVOQg0AgAHERQCAABuEgP//jN8Q
Date:   Wed, 14 Nov 2018 19:31:01 +0000
Message-ID: <3E5A0FA7E9CA944F9D5414FEC6C71220985A68FF@ORSMSX105.amr.corp.intel.com>
References: <20181109205153.14811-1-babu.moger@amd.com>
 <20181109205153.14811-12-babu.moger@amd.com>
 <3E5A0FA7E9CA944F9D5414FEC6C71220985A6664@ORSMSX105.amr.corp.intel.com>
 <DM5PR12MB2471AB9EFDE9E8D7C65C58A295C30@DM5PR12MB2471.namprd12.prod.outlook.com>
 <204f5ddb-21f3-5275-273b-02335a5a03c8@amd.com>
In-Reply-To: <204f5ddb-21f3-5275-273b-02335a5a03c8@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMmJlZWExY2MtYTY4Zi00Yjg0LWI2YTItZTgyZjczYWUzMGUxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSHJoM1Fid1wvUklRWk01bWZkbmFMVmxYMWRybnJqZ1RiV0wxcnR0eXNBSnl1eE1XeUw3K3pyUUN2emxFT3EwZlAifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBNb2dlciwgQmFidSBbbWFpbHRvOkJhYnUuTW9nZXJAYW1kLmNvbV0NCj4gPj4gSSdt
IHdvbmRlcmluZzogZG9lcyB0aGF0IG1lYW4gdGhlIHRhc2tzIHJ1bm5pbmcgd2l0aCB0aGlzIGNs
b3NpZA0KPiA+PiBkaXJlY3RseSBhY2Nlc3MgbWVtb3J5IHdpdGhvdXQgY2FjaGU/IElzIHRoZXJl
IGFueSB1c2FnZSBmb3IgdGhpcw0KPiBzaXR1YXRpb24/DQo+IA0KPiBIZXJlIGlzIHRoZSBkZXRh
aWxlZCBhbnN3ZXIgdG8geW91ciBxdWVzdGlvbiBmcm9tIERvdWcoaW4gQ0MpLg0KPiANCj4gQSBj
bG9zaWQgd2l0aCBMM19NQVNLIG9mIGFsbCAwJ3Mgd2lsbCBub3QgdXNlIGFueSBvZiB0aGUgTDMg
Y2FjaGUsIGJ1dCB3aWxsIHN0aWxsDQo+IGJlIGFibGUgdG8gdXNlIEwyIGNhY2hlLiAgU28sIG5v
LCB0aGUgcHJvY2Vzc2VzIGluIHRoYXQgY2xvc2lkIHdpbGwgbm90DQo+ICJkaXJlY3RseSBhY2Nl
c3MgbWVtb3J5IiBpbiB0aGUgc2Vuc2UgdGhhdCB0aGV5IHdpbGwgdXNlIHRoZSBMMSBhbmQgTDIN
Cj4gY2FjaGVzIGFzIG5vcm1hbC4gIEJ1dCBpZiB0aGV5IG1pc3MgdGhlIEwyIHRoZW4sIHllcywg
dGhlIGFjY2VzcyB3aWxsIGdvDQo+IGRpcmVjdGx5IHRvIG1lbW9yeS4gIFRvIGJlIHByZWNpc2Us
IG5vbmUgb2YgdGhlIGxpbmVzIHdoaWNoIGFyZSBmZXRjaGVkIGJ5IGENCj4gcHJvY2VzcyBydW5u
aW5nIHdpdGggc3VjaCBhIGNvbmZpZ3VyYXRpb24gd2lsbCBiZSBpbnN0YWxsZWQgaW4gdGhlIEwz
IGNhY2hlLA0KPiBzbyBzdWJzZXF1ZW50IGFjY2Vzc2VzIHdoaWNoIG1pc3MgdGhlIEwyIGNhY2hl
IHdpbGwgbm90IGZpbmQgdGhlIHJlcXVlc3RlZA0KPiBkYXRhIGluIHRoZSBMMyBjYWNoZSBhbmQg
d2lsbCB0aGVuIGdvIG9uIHRvIGFjY2VzcyBtZW1vcnkuDQoNClNlZW1zIGFsbCB6ZXJvcyBDQk0g
cmVkdWNlcyB0aGUgY2FjaGVzIHRvIEwxIGFuZCBMMi4gVGhpcyBtaWdodCBiZSB1c2VmdWwgaW4g
ZmFzdCBhY2Nlc3MgdG8gc21hbGwgZGF0YSBmaXR0aW5nIGluIEwyLg0KDQpUaGFuayB5b3UgdmVy
eSBtdWNoIGZvciB5b3VyIGV4cGxhbmF0aW9uIQ0KDQotRmVuZ2h1YQ0K
