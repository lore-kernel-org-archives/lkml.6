Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752425AbeC0Obk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 10:31:40 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:29863 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752331AbeC0Obh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 10:31:37 -0400
X-IronPort-AV: E=Sophos;i="5.48,367,1517846400";
   d="scan'208";a="74627255"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "wen.yang99@zte.com.cn" <wen.yang99@zte.com.cn>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jiang.biao2@zte.com.cn" <jiang.biao2@zte.com.cn>,
        "zhong.weidong@zte.com.cn" <zhong.weidong@zte.com.cn>
Subject: Re: [PATCH] scsi: Replace sdev_printk with printk_deferred to avoid
Thread-Topic: [PATCH] scsi: Replace sdev_printk with printk_deferred to avoid
Thread-Index: AQHTtrrbWqiUB+mvVUytqfvwjCe7TaPkQyOA
Date: Tue, 27 Mar 2018 14:31:32 +0000
Message-ID: <199ab05df000f2e8b5497a7aaecd0951321aadae.camel@wdc.com>
References: <1520499006-19857-1-git-send-email-wen.yang99@zte.com.cn>
In-Reply-To: <1520499006-19857-1-git-send-email-wen.yang99@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [76.103.131.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0206;7:6HTPVFwrEWWXuEV1qdZs2yBa1QEp2AAhex4m10YQpUkDZP1EyB+keHd5eV6xtum9alwkAiGEFpF/UrEjfjONAkbyP0VZbDYtX7HSmTU/RNCu1BfsisF9V3SxJN3zuIHg2/lWqPPicdJY4UepmVSzTJOpRlzv3QAxnMk7P1jZf4z9U49RSVqMC2EewDzKnXQvM0XHTQL4M/oftwHjCqJ3C35WV5g+g49kLwFYrZnT42TdDTDtLXj7MmCq32xCiNjG;20:V5W1noclhkT7HIlnguuYKBgq897Ei1+TH4BD4VgqWto8oBog9l/s80GEJYg/WRIIq/YcBoE6nXp/O5pT0q3z6aZXbQXWA/uMKgt7SDY5tGRVbIbblVLKDKBe8JVFgsDe4H6GpgzrTDhWFEPmerSW4jeoRPfhqoxdDLIkG/TD4aA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3cc53c74-d9d8-4038-b921-08d593ef7072
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0206;
x-ms-traffictypediagnostic: MWHPR04MB0206:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB020685EB7791F1149A4FA27A98AC0@MWHPR04MB0206.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR04MB0206;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0206;
x-forefront-prvs: 0624A2429E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(39380400002)(396003)(346002)(366004)(377424004)(189003)(199004)(54906003)(53936002)(106356001)(478600001)(110136005)(2201001)(66066001)(2906002)(25786009)(86362001)(966005)(5660300001)(476003)(2616005)(68736007)(6512007)(7736002)(72206003)(97736004)(305945005)(36756003)(316002)(4326008)(2501003)(11346002)(6306002)(2900100001)(446003)(76176011)(6436002)(118296001)(6116002)(6246003)(99286004)(5890100001)(186003)(14454004)(5250100002)(3280700002)(26005)(3660700001)(229853002)(6506007)(8936002)(3846002)(59450400001)(81156014)(486005)(486005)(8676002)(6486002)(81166006)(105586002)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0206;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: XmsIH7TKQsCEVznBFS+oJpUkTx1XPbd2dlTk1uU3mfxByJYGT/ZYz1tnBS/q0qYMTWdbTqcx1JOH5fYG4bxqO0amIKGUOrA8SOa8iTDJTBWMMYkgAYJLVlCYdpRY2cZqD0+9o4dGDzXtVywRYpZDCN6WUIRMvhN8Vdrz6pJYaSCrtY+7rUyRg3NMoXPb2rnrYF/rNTW2HTfiCNV/CHRbflKDfTPWPBNtjqPNtSW6jPTna/u+nh511CifxBnrE+lysyNHsJajzRPNTsh3efmkQ2qHRvK/N7AQeB+8J3QM94lJHKVlRxcQkEm6GvaHUue6vwzkBUieMHdXVTaexhMDjQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CC879AB51C6884C92D501F10D127F6B@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc53c74-d9d8-4038-b921-08d593ef7072
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2018 14:31:33.4889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0206
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2REVj3L014628

On Thu, 2018-03-08 at 16:50 +0800, Wen Yang wrote:
> When scsi disks went wrong frequently, and with serial console 
> attached, tasks may be blocked in the following flow for more than 10s: [ ... ]

>From https://bugzilla.kernel.org/show_bug.cgi?id=199003: "Hm,
printk_deferred is a bit dangerous; it moves console_unlock() to
IRQ. [ ... ] So I'd say that those two approaches

		printk_deferred + touch_nmi_watchdog

combined can do quite some harm. One thing for sure - they don't really fix
any problems."

Does that mean that this patch should be dropped?

Thanks,

Bart.
