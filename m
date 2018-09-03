Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85950C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 05:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2883820856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 05:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2883820856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbeICJYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 05:24:18 -0400
Received: from mga18.intel.com ([134.134.136.126]:45807 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbeICJYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 05:24:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2018 22:05:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,323,1531810800"; 
   d="scan'208";a="85530151"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga004.fm.intel.com with ESMTP; 02 Sep 2018 22:03:57 -0700
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Sun, 2 Sep 2018 22:03:57 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.8]) by
 ORSMSX157.amr.corp.intel.com ([169.254.9.29]) with mapi id 14.03.0319.002;
 Sun, 2 Sep 2018 22:03:56 -0700
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        Lee Chun-Yi <jlee@suse.com>, Al Stone <astone@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: RE: [PATCH V2 2/6] x86/efi: Remove __init attribute from memory
 mapping functions
Thread-Topic: [PATCH V2 2/6] x86/efi: Remove __init attribute from memory
 mapping functions
Thread-Index: AQHUQqIDDn4zPZk0nkeZ+lc+49cBHKTdRygAgACyz4A=
Date:   Mon, 3 Sep 2018 05:03:56 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F485B9142@ORSMSX114.amr.corp.intel.com>
References: <1535881594-25469-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1535881594-25469-3-git-send-email-sai.praneeth.prakhya@intel.com>
 <20180902105602.GA19431@zn.tnic>
In-Reply-To: <20180902105602.GA19431@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZWZmMzE0MjUtNDFlNy00MmM4LWEwN2MtMTAxZTQ0Njk3ZGFjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoid1wvVnRcL2UyT0pFUkcyVnJTSGdYeFwvV3JzT3NYVWxrdDlqT3h5QlIrYU1QcFQrSllDXC9DYUpqWWpkcmpVdUpFVVcifQ==
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

PiBPbiBTdW4sIFNlcCAwMiwgMjAxOCBhdCAwMjo0NjozMEFNIC0wNzAwLCBTYWkgUHJhbmVldGgg
UHJha2h5YSB3cm90ZToNCj4gPiBJbiBvcmRlciB0byBub3Qga2VlcCB0aGVzZSBmdW5jdGlvbnMg
bmVlZGxlc3NseSB3aGVuDQo+ID4gIkNPTkZJR19FRklfV0FSTl9PTl9JTExFR0FMX0FDQ0VTUyIg
aXMgbm90IHNlbGVjdGVkLCBhZGQgYSBuZXcNCj4gPiBfX2VmaV9pbml0X2ZpeHVwIGF0dHJpYnV0
ZSB3aG9zZSB2YWx1ZSBjaGFuZ2VzIGJhc2VkIG9uIHdoZXRoZXIgdGhlDQo+IA0KPiBXaHkgbm90
IGp1c3QgX19lZmlfaW5pdHssZGF0YX0gPw0KDQpIbW0uLiB0aG91Z2h0IHRoYXQgX19lZmlfaW5p
dCBtaWdodCBiZSBjb25mdXNpbmcgd2l0aCB0aGUgbm9ybWFsIF9faW5pdCBhdHRyaWJ1dGUNCmFu
ZCBoZW5jZSBhZGRlZCAiZml4dXAiLCBzbyB0aGF0IGl0J3MgZXhwbGljaXQgdGhhdCB3ZSBhcmUg
dHJ5aW5nIHRvIGZpeHVwIHRoZSBub3JtYWwgDQpfX2luaXQgYXR0cmlidXRlLiBfX2VmaV9pbml0
X2RhdGEgZG9lc24ndCBzZWVtIGFwcHJvcHJpYXRlIGJlY2F1c2Ugd2UgYXJlIGZpeGluZyANCmJv
dGggZnVuY3Rpb25zIGFuZCBkYXRhLg0KDQpSZWdhcmRzLA0KU2FpDQo=
