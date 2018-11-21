Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6278FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB0D206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:48:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB0D206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390692AbeKVKZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 05:25:06 -0500
Received: from mga11.intel.com ([192.55.52.93]:53943 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388031AbeKVKZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 05:25:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2018 15:48:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,262,1539673200"; 
   d="scan'208";a="281962702"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by fmsmga005.fm.intel.com with ESMTP; 21 Nov 2018 15:48:29 -0800
Received: from orsmsx161.amr.corp.intel.com (10.22.240.84) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 21 Nov 2018 15:48:29 -0800
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.106]) by
 ORSMSX161.amr.corp.intel.com ([169.254.4.42]) with mapi id 14.03.0415.000;
 Wed, 21 Nov 2018 15:48:29 -0800
From:   "Pathan, Arshiya Hayatkhan" <arshiya.hayatkhan.pathan@intel.com>
To:     "Moger, Babu" <Babu.Moger@amd.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H Peter Anvin" <hpa@zytor.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        James Morse <james.morse@arm.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 3/8] selftests/resctrl: Read memory bandwidth from
 perf IMC counter and from resctrl file system
Thread-Topic: [PATCH v3 3/8] selftests/resctrl: Read memory bandwidth from
 perf IMC counter and from resctrl file system
Thread-Index: AQHUcV25tY+W07SzO0+zDf8yZQoMk6VNPPyAgA3G0LA=
Date:   Wed, 21 Nov 2018 23:48:29 +0000
Message-ID: <A452FAC4F7CA284ABAC2C8FAB7160B2F3239A4@ORSMSX115.amr.corp.intel.com>
References: <1541019754-192204-1-git-send-email-fenghua.yu@intel.com>
 <1541019754-192204-4-git-send-email-fenghua.yu@intel.com>
 <a1ffa4f0-96ae-ca0e-fc75-38765d336522@amd.com>
In-Reply-To: <a1ffa4f0-96ae-ca0e-fc75-38765d336522@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTI2YWM2NmQtN2U5My00YTZmLWE1YjMtZGY1NWJiNzI3ZjM5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicHphK2NcL0RTMHFjMlB2WktRMUZoVnVRWmVnc2d1and4Z0JObFpJdzV3Wlp5NFNoNlJ1RGxnRzBOOWkrYmJKa0sifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICtzdGF0aWMgaW50IGluaXRpYWxpemVfbWVtX2J3X2ltYyh2b2lkKQ0KPiA+ICt7DQo+ID4g
KwlpbnQgaW1jLCBqOw0KPiA+ICsNCj4gPiArCWltY3MgPSBudW1fb2ZfaW1jcygpOw0KPiA+ICsJ
aWYgKGltY3MgPCAwKQ0KPiANCj4gSSB0aGluayB0aGlzIGNvbmRpdGlvbiBzaG91bGQgYmUgIjw9
Ii4gUGxzIGNoZWNrLg0KDQpUaGFuayB5b3UgZm9yIHBvaW50aW5nIGl0IG91dC4gSXQgbWFrZXMg
c2Vuc2UgdG8gY2hhbmdlIGl0IHRvICI8PSIuIFdpbGwgZml4IGl0IGluIG5leHQgdmVyc2lvbi4N
Cg0KPiA+ICsJCXJldHVybiBpbWNzOw0KPiA+ICsNCj4gPiArCS8qIEluaXRpYWxpemUgcGVyZl9l
dmVudF9hdHRyIHN0cnVjdHVyZXMgZm9yIGFsbCBpTUMncyAqLw0KPiA+ICsJZm9yIChpbWMgPSAw
OyBpbWMgPCBpbWNzOyBpbWMrKykgew0KPiA+ICsJCWZvciAoaiA9IDA7IGogPCAyOyBqKyspDQo+
ID4gKwkJCW1lbWJ3X2luaXRpYWxpemVfcGVyZl9ldmVudF9hdHRyKGltYywgaik7DQo+ID4gKwl9
DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCg0KVGhhbmtzIGFuZCBSZWdhcmRzLA0K
QXJzaGl5YQ0K
