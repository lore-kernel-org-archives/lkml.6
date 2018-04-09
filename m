Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752246AbeDIOOz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 10:14:55 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:65373 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751550AbeDIOOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 10:14:53 -0400
X-IronPort-AV: E=Sophos;i="5.48,427,1517846400";
   d="scan'208";a="172139929"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        "hare@suse.de" <hare@suse.de>,
        "himanshu.madhani@cavium.com" <himanshu.madhani@cavium.com>
Subject: Re: [PATCH] scsi: qla2xxx: Correct setting of
 SAM_STAT_CHECK_CONDITION
Thread-Topic: [PATCH] scsi: qla2xxx: Correct setting of
 SAM_STAT_CHECK_CONDITION
Thread-Index: AQHT0AAkKynACExFdEWkcT5yHMJSUaP4ejQA
Date: Mon, 9 Apr 2018 14:14:44 +0000
Message-ID: <bc811b8b6b80fc83b3ce6238806f55b268e89c17.camel@wdc.com>
References: <20180409123922.854-1-jthumshirn@suse.de>
In-Reply-To: <20180409123922.854-1-jthumshirn@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [63.163.107.7]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0689;7:1tbas0GlhBXZt1DEePLe6dQ326lOFiSC9AEZK2Z5Tdl6BCFq6hPhu72bRVc0pYYcX+d64gDcRznObhcwB+TikgsxxJjc8Gzvtj44T4VqGEBzMbdTEdL2lVFhox7f8A2PbD6HAPZZbHavgKQ/3UB5hPyvVIF4oFfHlITXo0pu88cFwDwcJNZgCm911sorSDEoB7JogDKHLOsz30P1/CN5fO5zVV68jqlCem6DMVUlbqhtVhnE8e37r2sLdAC8YP99;20:OBY3pzkudaXgIBMtP8SbTHf3UctOV/bD1b2FWEpLMOx4fKp0YFdunfdNN4J0F1eveKPQKDK/yCoeVukJURvJEkPTx7k6rdP2UIKdTPDHrEna4hDuoCxZGcZbap/NpjlcLooCZw+P9DGW91pRNsx+mQ5SQG4beH4iyXOEDNIKwpc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: b0a1038b-6ae6-4b6e-b699-08d59e243e7b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0689;
x-ms-traffictypediagnostic: MWHPR04MB0689:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0689F79DC4B1280CCC30304098BF0@MWHPR04MB0689.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20558992708506);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6055026)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR04MB0689;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0689;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(39860400002)(39380400002)(377424004)(189003)(199004)(11346002)(2616005)(97736004)(446003)(6246003)(476003)(53936002)(6116002)(110136005)(54906003)(3846002)(478600001)(305945005)(72206003)(316002)(7736002)(118296001)(25786009)(6436002)(6512007)(8936002)(81156014)(14454004)(81166006)(4326008)(6506007)(68736007)(102836004)(8676002)(558084003)(105586002)(106356001)(36756003)(229853002)(486006)(2900100001)(6486002)(2501003)(5250100002)(66066001)(5660300001)(2906002)(3280700002)(26005)(186003)(3660700001)(86362001)(99286004)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0689;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: t2eTdzveovXYni/ueLL3cI6r5lX34rDARrTeWz7szefA3YKSzLdQl11sFXvtGEQ/Tjd+ylvyPNNfjTO3EwZ1T06zfJFSgGxVeNDfH2NAoktQuhCXz7D7HPKXAynhi+mniJ1zRYw+FAcHJyi6etdEjPELwcak/OcaJ0rfZ1qCz5jOIyfxgbXwnCUPydSfmU9i3OWTzZq3Z7GNWyYB6tO5M9lSEOgmdO88sEJwCYP2j8PYg/Xfr6OEJIT8XTwQMv99q9PoiuCejccoHwxV/wUCQnNJP/osdRbkdmHAHx+/KRXtOaqT9EY6ggGAykChs1UyqkKKtIEliW+BxRFyoU521BDdv+25OiuI1qjLpEJZBwc8/R5y9ZxbLC4pCTU6y22WOo8vO2bYrLGssqhDcgW4t1tIUXX2wHLvcyGYAflZ3y0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A6248908028AD4EA32BE6B289904722@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a1038b-6ae6-4b6e-b699-08d59e243e7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 14:14:44.6005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0689
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w39EF08j009646

On Mon, 2018-04-09 at 14:39 +0200, Johannes Thumshirn wrote:
> Bart reports that in qla_isr.c's qla2x00_handle_dif_error we're
> wrongly shifting the SAM_STAT_CHECK_CONDITION by one instead of
> directly ORing it onto the SCSI command's result.

Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
