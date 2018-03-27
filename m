Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751997AbeC0A11 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 20:27:27 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:12232 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751249AbeC0A1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 20:27:25 -0400
X-IronPort-AV: E=Sophos;i="5.48,366,1517846400";
   d="scan'208";a="177612491"
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
Thread-Index: AQHTtrrbWqiUB+mvVUytqfvwjCe7TaPjV0YA
Date: Tue, 27 Mar 2018 00:27:22 +0000
Message-ID: <1522110440.3102.55.camel@wdc.com>
References: <1520499006-19857-1-git-send-email-wen.yang99@zte.com.cn>
In-Reply-To: <1520499006-19857-1-git-send-email-wen.yang99@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0913;7:L3pvRDUYHN1o/Ygs6uVnhjeHoi1+41eWWbMB5bUe/vQkZXLDlrtZkTM4dah0wbKVMEg31BbWUej26D4CdUprc+3AjvnuVzsu2CeNBNwOiTFw5o4xGz7e9IG4rjURrF/kjV0G+Sa4zg8dLxDP+OATL6UxqKbOgckFomecmTM4oUO/sGoo7A/P5IpaEU1wsDnSUvezVlc1a3jDEg94z6fZtzRB9hlsZuOL6DY7HPuSpA/Xm+O34fIuxr6wfRc+Q8Uj;20:b0EYVF8n+KA+vOxgYn1XNeov0mu8wzQAC8VOjpnvI3A33SuKFg2FtP8QCzwyP35K2Ai4jGdMjym0px2lF49ii4CYv/tQhvyK1hGoGGOCmL4mQhUE3Ix6yfsac3wTe7obDKvpNC2mupYR1eSgsk0HpexjYzWtjTH6CB9dh1GjnLY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6e316f5c-b2cf-4c71-21be-08d59379820f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0913;
x-ms-traffictypediagnostic: MWHPR04MB0913:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0913982EB095545D7389F7CE98AC0@MWHPR04MB0913.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR04MB0913;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0913;
x-forefront-prvs: 0624A2429E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39860400002)(39380400002)(376002)(189003)(377424004)(199004)(8676002)(86362001)(446003)(110136005)(2201001)(81156014)(81166006)(2900100001)(102836004)(316002)(76176011)(66066001)(2501003)(36756003)(99286004)(59450400001)(26005)(186003)(3660700001)(8936002)(3280700002)(476003)(5250100002)(105586002)(2616005)(229853002)(11346002)(2906002)(6512007)(72206003)(4326008)(6436002)(6246003)(305945005)(6506007)(14454004)(6486002)(6116002)(53936002)(3846002)(25786009)(97736004)(54906003)(5660300001)(478600001)(103116003)(7736002)(68736007)(106356001)(486005)(486005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0913;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: c/XCzo4YW3dt2QoNceCeDamwHk3uY2OF13zrUy1Bgk2tvtpATXi6c2ZJCFaPy2VOP6/0t93ZcSLxGiYaCrJ0705PXvp35kydb2QD0rES3HghcBkVBJHZF1aK+U7w5zl3Vf89hIyeX+rf7czuvW0Vp+u71HeLSUi+Kx+WtKXrfP6T9eXVkse/5ychOwWkBjOzY9t02lYvk0FIZQ2Zfux1ePfFoA0owHYMPmRMHkCRTYfAayrIHuqmgDDi1GmIJxyhGC0BzwA/Cifn+qN6IdAfafEO649N7JWN+G/SNgxYIJSp5/Yacd2wq6DH2Lr4vprwdQQ5qwttFQWlMmZFosHZqQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F3E1DC260C12F449EBF5EC741E4661A@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e316f5c-b2cf-4c71-21be-08d59379820f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2018 00:27:22.3586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0913
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2R0RX9R003702

On Thu, 2018-03-08 at 16:50 +0800, Wen Yang wrote:
> This patch replacing the sdev_printk with async printk_deferred can
> avoid task blocking because of the slow serial and unstable disks in
> such senario.

Although I'm not enthusiast about this approach, I haven't been able to come
up with a better solution and the patch itself looks fine to me.

Bart.
