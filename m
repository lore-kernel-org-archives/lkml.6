Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7072DC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3429820645
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3429820645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbeICMev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 08:34:51 -0400
Received: from mga18.intel.com ([134.134.136.126]:63136 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbeICMev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 08:34:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2018 01:15:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,324,1531810800"; 
   d="scan'208";a="80453822"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by orsmga003.jf.intel.com with ESMTP; 03 Sep 2018 01:15:49 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.8]) by
 ORSMSX103.amr.corp.intel.com ([169.254.5.166]) with mapi id 14.03.0319.002;
 Mon, 3 Sep 2018 01:15:49 -0700
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
Thread-Index: AQHUQqIDDn4zPZk0nkeZ+lc+49cBHKTdRygAgACyz4CAAKD2gP//m8Qw
Date:   Mon, 3 Sep 2018 08:15:48 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F485B9196@ORSMSX114.amr.corp.intel.com>
References: <1535881594-25469-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1535881594-25469-3-git-send-email-sai.praneeth.prakhya@intel.com>
 <20180902105602.GA19431@zn.tnic>
 <FFF73D592F13FD46B8700F0A279B802F485B9142@ORSMSX114.amr.corp.intel.com>
 <20180903071207.GA10249@zn.tnic>
In-Reply-To: <20180903071207.GA10249@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNDIxOWMyZjItODExMS00ODdlLTgyYzQtNjM1OTM1MjVmOTlkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTm5rb3prbm5PZ1h1ekZBTXZLTkRrVzEzTG12UDF6S1wvTlFaR2VSbFJ1VFdSY0FYdUdaUmIxRkk2dyt3QStRUzIifQ==
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

PiBPbiBNb24sIFNlcCAwMywgMjAxOCBhdCAwNTowMzo1NkFNICswMDAwLCBQcmFraHlhLCBTYWkg
UHJhbmVldGggd3JvdGU6DQo+ID4gSG1tLi4gdGhvdWdodCB0aGF0IF9fZWZpX2luaXQgbWlnaHQg
YmUgY29uZnVzaW5nIHdpdGggdGhlIG5vcm1hbA0KPiA+IF9faW5pdCBhdHRyaWJ1dGUNCj4gDQo+
IEhvdyB3b3VsZCB0aGF0IGJlIGNvbmZ1c2luZz8gSXQgaGFzICJfX2VmaSIgcHJlcGVuZGVkPyEN
Cj4gDQo+IEFsbCBJJ20gc2F5aW5nIGlzLCBpZiB5b3UncmUgZ29pbmcgdG8gZGVmaW5lIHlvdXIg
b3duIGZ1bmN0aW9uIGF0dHJpYnV0ZXMsIGRvIHRoZW0NCj4gZ2VuZXJpYyBhbmQgc2hvcnQuICJf
Zml4dXAiIGlzIHRvbyBzcGVjaWZpYyBJTU8uIEl0IGFsc28gZW5sYXJnZXMgZnVuY3Rpb24NCj4g
ZGVmaW5pdGlvbnMgdW5uZWNlc3NhcmlseS4NCj4gDQoNClllcy4uIGFncmVlZCB0aGF0IHRoZSBm
dW5jdGlvbiBkZWZpbml0aW9ucyBkaWQgZW5sYXJnZS4NCg0KPiBXaXRoICJfX2VmaV9pbml0IiB5
b3UgYWxyZWFkeSBkZW5vdGUgdGhhdCBpdCBpcyBhIHNwZWNpYWwgYXR0cmlidXRlIHdoaWNoIGhh
cw0KPiByZWxldmFuY2UgaW4gdGhlIEVGSSBjb2RlIG9ubHkuIFdoYXQgeW91IGRvIGFib3V0IGl0
IC0gdGhlDQo+ICpmaXh1cCogLSBpcyB0aGUgdGhpbmcgeW91IGRvIHdpdGggdGhlIGF0dHJpYnV0
ZS4gQnV0IHlvdSBkb24ndCBoYXZlIHRvIGhhdmUgdGhlDQo+ICJ3aGF0IHlvdSBkbyIgaW4gdGhl
IGF0dHJpYnV0ZSBuYW1lIHRvby4NCg0KT2suLiBtYWtlcyBzZW5zZS4gV2lsbCByb2xsIGEgVjMg
d2l0aCBfX2VmaV9pbml0Lg0KDQpSZWdhcmRzLA0KU2FpDQo=
