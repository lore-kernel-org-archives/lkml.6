Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518C6C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 14:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34D6206B5
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 14:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34D6206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbeIWUZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 16:25:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:31790 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbeIWUZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 16:25:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Sep 2018 07:27:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,294,1534834800"; 
   d="scan'208";a="82649259"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Sep 2018 07:24:12 -0700
Received: from fmsmsx119.amr.corp.intel.com (10.18.124.207) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Sun, 23 Sep 2018 07:24:12 -0700
Received: from fmsmsx115.amr.corp.intel.com ([169.254.4.182]) by
 FMSMSX119.amr.corp.intel.com ([169.254.14.38]) with mapi id 14.03.0319.002;
 Sun, 23 Sep 2018 07:24:12 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     =?utf-8?B?SMOla29uIEJ1Z2dl?= <Haakon.Bugge@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        "Latif, Faisal" <faisal.latif@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] RDMA/i40iw: Fix incorrect iterator type
Thread-Topic: [PATCH] RDMA/i40iw: Fix incorrect iterator type
Thread-Index: AQHUTo/TThlrd5jITUCGxcBsK3DbZaT99FeA
Date:   Sun, 23 Sep 2018 14:24:12 +0000
Message-ID: <9DD61F30A802C4429A01CA4200E302A7A2F99554@fmsmsx115.amr.corp.intel.com>
References: <20180917140707.1253738-1-Haakon.Bugge@oracle.com>
In-Reply-To: <20180917140707.1253738-1-Haakon.Bugge@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.200.108]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PlN1YmplY3Q6IFtQQVRDSF0gUkRNQS9pNDBpdzogRml4IGluY29ycmVjdCBpdGVyYXRvciB0eXBl
DQo+DQo+Q29tbWl0IGYyN2I0NzQ2ZjM3OCAoImk0MGl3OiBhZGQgY29ubmVjdGlvbiBtYW5hZ2Vt
ZW50IGNvZGUiKSB1c2VzIGFuDQo+aW5jb3JyZWN0IHJjdSBpdGVyYXRvciwgd2hpbHN0IGhvbGRp
bmcgdGhlIHJ0bmxfbG9jay4gU2luY2UgdGhlIGNyaXRpY2FsIHJlZ2lvbiBpbnZva2VzDQo+aTQw
aXdfbWFuYWdlX3FoYXNoKCksIHdoaWNoIGlzIGEgc2xlZXBpbmcgZnVuY3Rpb24sIHRoZSByY3Ug
bG9ja2luZyBhbmQNCj50cmF2ZXJzYWwgY2Fubm90IGJlIHVzZWQuDQo+DQo+U2lnbmVkLW9mZi1i
eTogSMOla29uIEJ1Z2dlIDxoYWFrb24uYnVnZ2VAb3JhY2xlLmNvbT4NCj4tLS0NCj4gZHJpdmVy
cy9pbmZpbmliYW5kL2h3L2k0MGl3L2k0MGl3X2NtLmMgfCAyICstDQo+IDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpUaGFua3MgZG9pbmcgdGhpcyBIYWtv
biENCg0KQWNrZWQtYnk6IFNoaXJheiBTYWxlZW0gPHNoaXJhei5zYWxlZW1AaW50ZWwuY29tPg0K
DQo=
