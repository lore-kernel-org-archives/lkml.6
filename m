Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1B1C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD2122466
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CD2122466
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933835AbeFUWCp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 18:02:45 -0400
Received: from mga05.intel.com ([192.55.52.43]:49420 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933559AbeFUWCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 18:02:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2018 15:02:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,253,1526367600"; 
   d="scan'208";a="59214081"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Jun 2018 15:02:43 -0700
Received: from orsmsx160.amr.corp.intel.com (10.22.226.43) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 21 Jun 2018 15:02:40 -0700
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.228]) by
 ORSMSX160.amr.corp.intel.com ([10.22.226.43]) with mapi id 14.03.0319.002;
 Thu, 21 Jun 2018 15:02:39 -0700
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "willy@infradead.org" <willy@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Accardi, Kristen C" <kristen.c.accardi@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [PATCH 1/3] vmalloc: Add __vmalloc_node_try_addr function
Thread-Topic: [PATCH 1/3] vmalloc: Add __vmalloc_node_try_addr function
Thread-Index: AQHUCONfAlQUZg38/kWgL4xqEcpAaaRqLyWAgAGLogA=
Date:   Thu, 21 Jun 2018 22:02:39 +0000
Message-ID: <1529618574.29548.207.camel@intel.com>
References: <1529532570-21765-1-git-send-email-rick.p.edgecombe@intel.com>
         <1529532570-21765-2-git-send-email-rick.p.edgecombe@intel.com>
         <20180620222653.GC11479@bombadil.infradead.org>
In-Reply-To: <20180620222653.GC11479@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.7.197.56]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBF7B1AD2130BB4D8BDEDBD442B31691@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTA2LTIwIGF0IDE1OjI2IC0wNzAwLCBNYXR0aGV3IFdpbGNveCB3cm90ZToN
Cj4gTm90IG5lZWRlZDoNCj4gDQo+IHZvaWQgd2Fybl9hbGxvYyhnZnBfdCBnZnBfbWFzaywgbm9k
ZW1hc2tfdCAqbm9kZW1hc2ssIGNvbnN0IGNoYXINCj4gKmZtdCwgLi4uKQ0KPiB7DQo+IC4uLg0K
PiDCoMKgwqDCoMKgwqDCoMKgaWYgKChnZnBfbWFzayAmIF9fR0ZQX05PV0FSTikgfHwgIV9fcmF0
ZWxpbWl0KCZub3BhZ2VfcnMpKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJl
dHVybjsNCj4gDQpZZXMsIHRoYW5rcyE=
