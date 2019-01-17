Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1663C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 03:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B054420657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 03:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbfAQDxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 22:53:50 -0500
Received: from mga06.intel.com ([134.134.136.31]:54922 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728268AbfAQDxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 22:53:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2019 19:53:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,488,1539673200"; 
   d="scan'208";a="267758404"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga004.jf.intel.com with ESMTP; 16 Jan 2019 19:53:49 -0800
Received: from fmsmsx102.amr.corp.intel.com (10.18.124.200) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 16 Jan 2019 19:53:48 -0800
Received: from bgsmsx155.gar.corp.intel.com (10.224.48.102) by
 FMSMSX102.amr.corp.intel.com (10.18.124.200) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 16 Jan 2019 19:53:48 -0800
Received: from bgsmsx104.gar.corp.intel.com ([169.254.5.227]) by
 BGSMSX155.gar.corp.intel.com ([169.254.12.54]) with mapi id 14.03.0415.000;
 Thu, 17 Jan 2019 09:23:45 +0530
From:   "Gopal, Saranya" <saranya.gopal@intel.com>
To:     Nikolay Yakimov <root@livid.pp.ru>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] USB: Fix configuration selection issues introduced in
 v4.20.0
Thread-Topic: [PATCH] USB: Fix configuration selection issues introduced in
 v4.20.0
Thread-Index: AQHUrO1tcNtp2QCCK0m5HD3lqJDdwKWxQnqwgACmkgCAAOyOkA==
Date:   Thu, 17 Jan 2019 03:53:45 +0000
Message-ID: <C672AA6DAAC36042A98BAD0B0B25BDA94CB2885A@BGSMSX104.gar.corp.intel.com>
References: <20190115161354.6806-1-root@livid.pp.ru>
 <C672AA6DAAC36042A98BAD0B0B25BDA94CB280EC@BGSMSX104.gar.corp.intel.com>
 <CA+A=rXGckxCsEPAG_DczMgLwS2+K3SXFUnHnXQrOOr+9WOWj9w@mail.gmail.com>
In-Reply-To: <CA+A=rXGckxCsEPAG_DczMgLwS2+K3SXFUnHnXQrOOr+9WOWj9w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZDZlNzdlMDctNGFiMi00YzBlLWI5OWYtY2ZkYTkxNzA2YWRjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoib2xIM2QrZ3hTd2dRcWh0TFBwZU5veVBRcWNvZEJZSG96NUdZTE5xMUowWEJXUFAwRytxaFJ4dFRMcVpHaHFONyJ9
x-originating-ip: [10.223.10.10]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBUaGUgcmVzdWx0IGlzIHRoaXM6DQo+IEJlZm9yZSBmMTM5MTJkM2YwMTRhLCBpZiBhbiBSTkRJ
UyBkZXZpY2UgaGFzIG5vbi12ZW5kb3Itc3BlY2lmaWMNCj4gY29uZmlndXJhdGlvbnMgYWZ0ZXIg
dGhlIGZpcnN0IG9uZSwgdGhhdCBvbmUgd291bGQgYmUgc2VsZWN0ZWQuDQo+IEFmdGVyIGZmMmE4
YzUzMmMxNCwgdGhlIGZpcnN0IGNvbmZpZ3VyYXRpb24gd291bGQgYWx3YXlzIGJlIHNlbGVjdGVk
DQo+IGZvciBSTkRJUyBkZXZpY2VzLiBCZXNpZGVzLCB0aGVyZSBhcmUgc2V2ZXJhbCByZWR1bmRh
bnQgY2hlY2tzIGluIHRoaXMNCj4gY2FzZSwgd2hpY2ggaXMsIGlmIG5vdGhpbmcgZWxzZSwgY29u
ZnVzaW5nLg0KPiANCj4gSG9wZWZ1bGx5IEkndmUgZXhwbGFpbmVkIG15IHBvaW50IGNsZWFybHkg
ZW5vdWdoLg0KDQpBZ3JlZWQuIFRoYW5rcyBmb3IgcG9pbnRpbmcgaXQgb3V0LiBJIHNvbWVob3cg
bWlzc2VkIHRoaXMgOigNCg0KVGhhbmtzLA0KU2FyYW55YQ0K
