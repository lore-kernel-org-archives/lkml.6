Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71CDC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E1C218CD
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbfADR31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:29:27 -0500
Received: from mga05.intel.com ([192.55.52.43]:51557 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbfADR31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 12:29:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jan 2019 09:29:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,439,1539673200"; 
   d="scan'208";a="132983635"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga004.fm.intel.com with ESMTP; 04 Jan 2019 09:29:26 -0800
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 4 Jan 2019 09:29:26 -0800
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.158]) by
 ORSMSX116.amr.corp.intel.com ([169.254.7.100]) with mapi id 14.03.0415.000;
 Fri, 4 Jan 2019 09:29:26 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     =?utf-8?B?5buW5aiB6ZuE?= <liaoweixiong@allwinnertech.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC v4 0/3] pstore/rom: new support logger for block devices
Thread-Topic: [RFC v4 0/3] pstore/rom: new support logger for block devices
Thread-Index: AQHUozhqO1w/2T4wnE2emvMOu7brUqWdyBJAgAFu2ICAACgTwA==
Date:   Fri, 4 Jan 2019 17:29:25 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7D4BB657@ORSMSX110.amr.corp.intel.com>
References: <1546501533-1855-1-git-send-email-liaoweixiong@allwinnertech.com>
 <3908561D78D1C84285E8C5FCA982C28F7D4B623C@ORSMSX110.amr.corp.intel.com>
 <e94cfa87-9f25-101e-708c-c116b90e8e45@allwinnertech.com>
In-Reply-To: <e94cfa87-9f25-101e-708c-c116b90e8e45@allwinnertech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMGExZTY5ODctNTBlNC00NzkxLTlmNzQtMDg3ZDE5ZjBjNjE5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoic0NNa1RTdmh0bFk4WkUyS2FXMGpZWUxhaFwvdU9xY1lMdEIxVGg3WkFkSGpnTTdxbURSb2pLQzROTmtjSzNwWU0ifQ==
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

Pj4gSXQgbG9va3MgdG8gYmUgYSByZWFsbHkgZ29vZCBpZGVhLg0KPiBTaG91bGQgaSBhZGQgIkFj
a2VkLWJ5IiBpbiBuZXh0IHZlcnNpb24gb2YgcGF0Y2g/DQoNCkkndmUgb25seSBsb29rZWQgYXQg
dGhlIGNvbmNlcHQsIG5vdCBhdCB0aGUgY29kZSB5ZXQuIFNvIHRvbyBlYXJseSB0byBjb21taXQg
dG8gYW4gIkFja2VkLWJ5Ig0KDQo+IEkgaGF2ZSBsaXR0bGUgZXhwZXJpZW5jZSBpbiBzZW5kaW5n
IHBhdGNoIHRvIHVwc3RyZWFtIGxpbnV4Lg0KDQpZb3UgYXJlIGRvaW5nIGZpbmUgc28gZmFyLg0K
DQotVG9ueQ0KIA0K
