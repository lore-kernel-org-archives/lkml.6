Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF35ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 22:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A782082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 22:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34A782082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbeJYHPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 03:15:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:45247 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbeJYHPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 03:15:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 15:45:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,422,1534834800"; 
   d="scan'208";a="268533959"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by orsmga005.jf.intel.com with ESMTP; 24 Oct 2018 15:45:56 -0700
Received: from orsmsx154.amr.corp.intel.com (10.22.226.12) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 24 Oct 2018 15:45:55 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.194]) by
 ORSMSX154.amr.corp.intel.com ([169.254.11.186]) with mapi id 14.03.0319.002;
 Wed, 24 Oct 2018 15:45:55 -0700
From:   "Li, Juston" <juston.li@intel.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "lyude@redhat.com" <lyude@redhat.com>
CC:     "Ciobanu, Nathan D" <nathan.d.ciobanu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Taylor, Clinton A" <clinton.a.taylor@intel.com>,
        "jared_dominguez@dell.com" <jared_dominguez@dell.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "mario.limonciello@dell.com" <mario.limonciello@dell.com>,
        "cpaul@redhat.com" <cpaul@redhat.com>
Subject: Re: [RESEND PATCH v2 1/2] drm/dp/mst: Reprobe EDID for MST ports on
 resume
Thread-Topic: [RESEND PATCH v2 1/2] drm/dp/mst: Reprobe EDID for MST ports
 on resume
Thread-Index: AQHUa0BrUxyBfkiNM0u3Ld3QRT9tzaUva20AgAAKDYA=
Date:   Wed, 24 Oct 2018 22:45:54 +0000
Message-ID: <ee20a313fb63792c05ab1b67babf1fa9431ebcf8.camel@intel.com>
References: <20181024021925.27026-1-juston.li@intel.com>
         <20181024021925.27026-2-juston.li@intel.com>
         <f9b43dde4868d3c079b652b48babde9b8bebc728.camel@redhat.com>
In-Reply-To: <f9b43dde4868d3c079b652b48babde9b8bebc728.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.7.198.167]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F5B411A629D1B4CAF760B358E960F39@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTEwLTI0IGF0IDE4OjA5IC0wNDAwLCBMeXVkZSBQYXVsIHdyb3RlOg0KPiBT
aW5jZSB0aGVyZSdzIGdvaW5nIHRvIGJlIHF1aXRlIGEgbnVtYmVyIG9mIGNoYW5nZXMgSSBuZWVk
IHRvIG1ha2UgdG8NCj4gdGhpcyBJJ20NCj4ganVzdCBnb2luZyB0byBtYWtlIHRoZSBjaGFuZ2Vz
IG15c2VsZiEgSSdsbCBtYWtlIHN1cmUgdG8gQ2MgeW91IHdpdGgNCj4gdGhlDQo+IHJlc3Bpbg0K
DQpTb3VuZHMgZ29vZCwgdGhhbmtzIGZvciBwaWNraW5nIGl0IHVwIQ0KDQpKdXN0b24NCg0K
