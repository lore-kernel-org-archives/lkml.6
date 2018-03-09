Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751279AbeCIFIq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 00:08:46 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:60358 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbeCIFIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 00:08:43 -0500
X-IronPort-AV: E=Sophos;i="5.47,443,1515427200";
   d="scan'208";a="176282712"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "sbates@raithlin.com" <sbates@raithlin.com>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@mellanox.com" <jgg@mellanox.com>, "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "maxg@mellanox.com" <maxg@mellanox.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 08/10] nvme-pci: Add support for P2P memory in requests
Thread-Topic: [PATCH v2 08/10] nvme-pci: Add support for P2P memory in
 requests
Thread-Index: AQHTsO2vHottGvceZEGvyZV9CHYkK6O7OSyAgABRTQCAC90FgA==
Date: Fri, 9 Mar 2018 05:08:36 +0000
Message-ID: <1520572115.11647.3.camel@wdc.com>
References: <20180228234006.21093-1-logang@deltatee.com>
         <20180228234006.21093-9-logang@deltatee.com>
         <c6639530-48ba-4655-c772-7d88a030e37e@grimberg.me>
         <1CE68E79-E5FD-4EE2-BD88-B3EE57E43ACE@raithlin.com>
In-Reply-To: <1CE68E79-E5FD-4EE2-BD88-B3EE57E43ACE@raithlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [76.103.131.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0975;7:Ei5hGdreS+W/C5PDqvS6FklrOR80BtgF0CRrFnQPZx2ENHu06JTkHRwtl+cHoHkUNfEva4ZmV3oMsGGgvQHNJN1Gt0S7LUPRs+vwmvIFUS8gbXOlPeR+R5PYmzFQ4Ore7KuxFOPCrJS847lKjBpSF58Jy1zMlf1Bl2VHsJHFgPpz28v1PX69dKCOdvq2pikjHuzSmolryFktLV+2BUZCxWQlaUZi8fdbnrxyjN4HGIylo3K/XApQ69W50qljHYGj;20:aXaji2I8uxHu5lSA2RN2vZcKadpifObv+uLkC/1QxiOdao7wmk9Qiyvzg2v9Fxlh+58s31ANOvYTGA4F4zr4o2XW15YstJhqDWzihKz/cgjj4841tu/ZTR7qTr3WeHwbHE5yMBgJdAa+UBA39ayxt3TfEnGT4XVtI6qqdf9KGPc=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 26207f53-a75a-4c69-6545-08d5857bd0a9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0975;
x-ms-traffictypediagnostic: MWHPR04MB0975:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0975C8503C6A5B71AF6618BC98DE0@MWHPR04MB0975.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR04MB0975;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0975;
x-forefront-prvs: 0606BBEB39
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(376002)(346002)(366004)(199004)(189003)(11905935001)(377424004)(54906003)(8936002)(229853002)(3280700002)(2950100002)(6506007)(7416002)(2501003)(4326008)(99286004)(5660300001)(6306002)(5890100001)(5250100002)(36756003)(7736002)(305945005)(97736004)(6512007)(66066001)(2201001)(110136005)(6436002)(2906002)(25786009)(316002)(3660700001)(186003)(14454004)(103116003)(478600001)(2900100001)(106356001)(68736007)(966005)(6116002)(3846002)(76176011)(6246003)(102836004)(93886005)(53936002)(26005)(81156014)(81166006)(6486002)(72206003)(8676002)(86362001)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0975;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: jXyHEjds0y5EDfno0swrh5X0YG5NV7MtcA+88BsA9GC7i0Sr9MxxxKRC6SrgHnIqJtOwAFxJK0Mm2+VJQft8bN421AuHJ53Ceuilh9ZDdpQ1AQByrhL1zs1w7MlPXR2TAXJQ+uz217B/N7uCZtB187rU4ySVtXsdYloGlai1v7/odUjtJT3fbE3+GvmF4gtbF17vn/o44MEjcHyI8iMgRYbwHKesmHlMwO2yPfKNyG/WQMbKi+F2elFgS8pLo9W46Boy1EqpQAXC4+Syl8eae2TOsK93QR6P6KCov2ztJV1+ZWDyDO5QJdPWelk5oYkLt45nsDLk9EEwBa//ZbffLg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C229E9B9532B144A863F407D859C647F@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26207f53-a75a-4c69-6545-08d5857bd0a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2018 05:08:37.0089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0975
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w295981G018041

On Thu, 2018-03-01 at 15:58 +0000, Stephen  Bates wrote:
> > Any plans adding the capability to nvme-rdma? Should be
> > straight-forward... In theory, the use-case would be rdma backend
> > fabric behind. Shouldn't be hard to test either...
> 
> Nice idea Sagi. Yes we have been starting to look at that. Though again we
> would probably want to impose the "attached to the same PCIe switch" rule
> which might be less common to satisfy in initiator systems. 
> 
> Down the road I would also like to discuss the best way to use this P2P
> framework to facilitate copies between NVMe namespaces (on both PCIe and
> fabric attached namespaces) without having to expose the CMB up to user
> space. Wasn't something like that done in the SCSI world at some point
> Martin?

Are you perhaps referring to the following patch series: "Copy Offload"
(https://www.spinics.net/lists/linux-scsi/msg74680.html /
https://lwn.net/Articles/592094/)? I will contact Martin off-list and in
case he wouldn't have the time myself to revive that patch series then I
will free up some time to work on this.

Bart.
