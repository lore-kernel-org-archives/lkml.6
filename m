Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FFCC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 21:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B9B223AE
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 21:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B9B223AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbeKNHfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 02:35:45 -0500
Received: from mga14.intel.com ([192.55.52.115]:34582 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbeKNHfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 02:35:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 13:35:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,229,1539673200"; 
   d="scan'208";a="89049931"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga007.jf.intel.com with ESMTP; 13 Nov 2018 13:35:41 -0800
Received: from orsmsx113.amr.corp.intel.com (10.22.240.9) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 13 Nov 2018 13:35:41 -0800
Received: from orsmsx105.amr.corp.intel.com ([169.254.2.237]) by
 ORSMSX113.amr.corp.intel.com ([169.254.9.125]) with mapi id 14.03.0415.000;
 Tue, 13 Nov 2018 13:35:41 -0800
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     Borislav Petkov <bp@alien8.de>, "Moger, Babu" <Babu.Moger@amd.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
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
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v7 01/13] arch/x86: Start renaming the rdt files to more
 generic names
Thread-Topic: [PATCH v7 01/13] arch/x86: Start renaming the rdt files to
 more generic names
Thread-Index: AQHUeG4jLHZyQ+Dwi0aJlEIkm8Brh6VM7DAAgAFUIeA=
Date:   Tue, 13 Nov 2018 21:35:40 +0000
Message-ID: <3E5A0FA7E9CA944F9D5414FEC6C71220985A6632@ORSMSX105.amr.corp.intel.com>
References: <20181109205153.14811-1-babu.moger@amd.com>
 <20181109205153.14811-2-babu.moger@amd.com> <20181112171638.GH8167@zn.tnic>
In-Reply-To: <20181112171638.GH8167@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzBkNTRmYzEtOTgzMy00MDY4LTliMmYtYjNmYjlkNzlkYWFhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiclwvR0h1bXdyYkVKcktPbDB4MnRrM1N2MU5mUmxQdk5GRGhsNEN1UWllclJmNFVIK1dqTTJhUGZzamdEcWhjY1EifQ==
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

PiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgW21haWx0bzpicEBhbGllbjguZGVdDQo+ICBTdWJqZWN0
OiBbUEFUQ0ggdjcgMDEvMTNdIGFyY2gveDg2OiBTdGFydCByZW5hbWluZyB0aGUgcmR0IGZpbGVz
IHRvIG1vcmUNCj4gZ2VuZXJpYyBuYW1lcw0KPiANCj4gSSBndWVzcyB0aGUgc3ViamVjdCBwcmVm
aXggZm9yIGFsbCB0aG9zZSBzaG91bGQgYmUgImFyY2gvcmVzY3RybDoiIG9yIHNvIG5vdy4NCg0K
SXMgIng4Ni9yZXNjdHJsIiBhIGJldHRlciBzdWJqZWN0IHByZWZpeD8NCg0KVGhhbmtzLg0KDQot
RmVuZ2h1YQ0K
