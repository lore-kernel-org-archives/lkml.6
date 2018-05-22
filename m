Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751287AbeEVHGy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 03:06:54 -0400
Received: from mail-ve1eur01on0079.outbound.protection.outlook.com ([104.47.1.79]:18496
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750709AbeEVHGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 03:06:52 -0400
From: Robin Gong <yibin.gong@nxp.com>
To: "vkoul@kernel.org" <vkoul@kernel.org>
CC: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "vinod.koul@intel.com" <vinod.koul@intel.com>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v1] dma: imx-sdma: add virt-dma support
Thread-Topic: [PATCH v1] dma: imx-sdma: add virt-dma support
Thread-Index: AQHTwbZRQFd8gKZYyk6iiiOUnMCFSKQ7pH0ggAAL2QCAAIkrgA==
Date: Tue, 22 May 2018 07:06:48 +0000
Message-ID: <1527001591.3990.1.camel@nxp.com>
References: <1521735499-29138-1-git-send-email-yibin.gong@nxp.com>
         <DB6PR04MB32230F836E366C6D0AA7A44489940@DB6PR04MB3223.eurprd04.prod.outlook.com>
         <20180522065534.GD18351@vkoul-mobl>
In-Reply-To: <20180522065534.GD18351@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR04MB3015;7:hqyxonaDawy+EntEUb7AGSXVkHqH314AE5O/kE2tOnD+1F5X64UnDH2l/ZRLpaKXOqdil1dm7H1A0bKZrQHVmYK4lT1fK2ReH257auBLbbeO66Z9XJTSyUQk00CSH20tY2tUIYqIqlQoAzib8xf3wD9xdIWwZ5gaZtChDNp+fxKmF8J5lcCqKIAtqtdYljG3tICIQ8anOIYCN4p158zjvBqpg1x+MTcKgRRLvJ0G3lHkED9ENhoNzx6oEgkammXP
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3015;
x-ms-traffictypediagnostic: DB6PR04MB3015:
x-microsoft-antispam-prvs: <DB6PR04MB3015FA8732A8039267BB543489940@DB6PR04MB3015.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3015;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3015;
x-forefront-prvs: 0680FADD48
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(346002)(366004)(396003)(376002)(377424004)(189003)(199004)(2900100001)(3846002)(81166006)(6506007)(53546011)(5640700003)(6436002)(8676002)(6486002)(6116002)(50226002)(316002)(6916009)(86362001)(6512007)(229853002)(6246003)(36756003)(1730700003)(478600001)(4326008)(68736007)(81156014)(106356001)(26005)(558084003)(102836004)(186003)(105586002)(2351001)(25786009)(53936002)(14454004)(305945005)(2906002)(3280700002)(97736004)(5660300001)(66066001)(76176011)(2616005)(5250100002)(54906003)(99286004)(103116003)(3660700001)(476003)(2501003)(7736002)(8936002)(11346002)(486006)(446003)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3015;H:DB6PR04MB3223.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: SvshLIZ71YGK4hd+GYuAQ8IIiJYwVOrHxLZds5G7nYibfdPdKYphQ3cQQc7p0rN9fTUKCn7O8zdiFme7VlbAgh0o3pnqvyI7ZUTHy5Xc5PYDPq0fzh1M1eQhjDE5kVPI98gwmOXgo/BR/C8b1Qc/XQGaNrm618L0kLxt/gaWLddDsnajK2pBDlv6LTHJmTy5
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D57D8C08B0AD140BA5F18B906CAB67D@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 6c683895-2d6c-4bd4-3738-08d5bfb2965f
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c683895-2d6c-4bd4-3738-08d5bfb2965f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2018 07:06:48.9918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3015
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4M76xrG012599

Ok, I'll resend it after rebase and test.

On 二, 2018-05-22 at 12:25 +0530, Vinod wrote:
> On 22-05-18, 06:16, Robin Gong wrote:
> > 
> > Ping.
> Looks like I missed this one, can you please rebase and resend.
> While at it, modify the subject to dmaengine, as thats the subsystem
> name
> 
