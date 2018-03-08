Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756028AbeCHP4v (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 10:56:51 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:33220 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754678AbeCHP4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 10:56:48 -0500
X-IronPort-AV: E=Sophos;i="5.47,441,1515427200";
   d="scan'208";a="169697400"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "James.Bottomley@HansenPartnership.com"
        <James.Bottomley@HansenPartnership.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tursulin@ursulin.net" <tursulin@ursulin.net>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "tvrtko.ursulin@intel.com" <tvrtko.ursulin@intel.com>,
        "hare@suse.com" <hare@suse.com>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "nab@linux-iscsi.org" <nab@linux-iscsi.org>
Subject: Re: [PATCH 6/6] lib/scatterlist: Drop order argument from
 sgl_free_n_order
Thread-Topic: [PATCH 6/6] lib/scatterlist: Drop order argument from
 sgl_free_n_order
Thread-Index: AQHTthJ6KXzzpEGpZE+JXaJ5GDOoGKPFGIaAgADiHoCAAIVDgA==
Date: Thu, 8 Mar 2018 15:56:32 +0000
Message-ID: <1520524591.2809.0.camel@wdc.com>
References: <20180307124712.14963-1-tvrtko.ursulin@linux.intel.com>
         <20180307124712.14963-7-tvrtko.ursulin@linux.intel.com>
         <1520447415.5558.12.camel@HansenPartnership.com>
         <faa56419-bdce-c539-5eee-5e180c62b0a5@ursulin.net>
In-Reply-To: <faa56419-bdce-c539-5eee-5e180c62b0a5@ursulin.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0625;7:N8uE+ml/qoPVAstDU4xZ1GM9RKrb0k1t4tR0EdDQZ6cd8sXtUGqtrNOo4iK+ooSRAGwXEY8Gl+y2w3pTYmKrynDTl8Xp1pebkOwDXfk6TzvN1LTpL1Ntx9o2/+g9h5s1MRTRCFIEECxYHQttrf+0B4ysFSEvajsaho3dDhWat+3PDZe5DYmHST3fQQx4HU+/hv4RR8HUIfD9zw1hEosaDUmM1CKRUQS+7OjPtVd/L2OOZUyujR31JNlsaji7f3v4;20:068H/j9XkGQyB+XyuXmST9ET0BUTU/MDo2QpNHVy3NwpvXeDuP1xhfaJ34W1BDBdYbYVvt5rAwnq6pirNc14P5Ur0aBFZhrnv4L5CxXCyiPG/5ikPVIjZieFJPTXN85I73tSg+wqeuUHxRcjkiV2xbYvnFSjPOkzqH6kfZoXKSc=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 39e34b99-547c-4d8d-2b69-08d5850d29b3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0625;
x-ms-traffictypediagnostic: MWHPR04MB0625:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0625DC70CF9CDEFB4B951D3698DF0@MWHPR04MB0625.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR04MB0625;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0625;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(366004)(39380400002)(376002)(377424004)(199004)(189003)(99286004)(5660300001)(6436002)(54906003)(8676002)(110136005)(186003)(81156014)(81166006)(6512007)(53936002)(25786009)(105586002)(2900100001)(93886005)(2906002)(97736004)(66066001)(4326008)(305945005)(7416002)(72206003)(3280700002)(26005)(36756003)(59450400001)(6246003)(2201001)(86362001)(6506007)(3660700001)(478600001)(316002)(102836004)(229853002)(7736002)(2501003)(8936002)(103116003)(76176011)(106356001)(2950100002)(3846002)(14454004)(6486002)(68736007)(5250100002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0625;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 65l4UxKk+6k/lfFJGyXDon+Eji8UompfFQJSMnqJqnVk05aDSWKrlytsqQ7bi3AoaBTaEFZT58ueswdYy5c1i4JvU94cqZxNZ+hLD9jE+xrGXVjI0+ByJeqgHTH7bGGxbypLQdtOIVlXr3EWi/0QLQ2LFexk7BJOQm9BCskKie1na5k4aJH5semmeFvrB5NsfMW53JNjWk6kWKWXdJLe2yGemoGlZH3P/s5/nazROkfgdI9tKnYUjEnlt0JLICVq0BbKFZcFQDsrVYTKR7XxEwD4dUNQwjKKdn2yENMAVjSFFbEa/qUpK6xg/gLj3O3EDfwojkyu6XPHFBTDJ5kfvA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2117B97994C65E469736CCAA099D193C@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e34b99-547c-4d8d-2b69-08d5850d29b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 15:56:32.2688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0625
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w28Fv2dD009131

On Thu, 2018-03-08 at 07:59 +0000, Tvrtko Ursulin wrote:
> However there is a different bug in my patch relating to the last entry 
> which can have shorter length from the rest. So get_order on the last 
> entry is incorrect - I have to store the deduced order and carry it over.

Will that work if there is only one entry in the list and if it is a short
entry?

Bart.
