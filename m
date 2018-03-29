Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbeC2X4K (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 19:56:10 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:55149 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbeC2X4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 19:56:08 -0400
X-IronPort-AV: E=Sophos;i="5.48,378,1517846400";
   d="scan'208";a="74714556"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "wen.yang99@zte.com.cn" <wen.yang99@zte.com.cn>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jiang.biao2@zte.com.cn" <jiang.biao2@zte.com.cn>,
        "zhong.weidong@zte.com.cn" <zhong.weidong@zte.com.cn>,
        "sergey.senozhatsky.work@gmail.com"
        <sergey.senozhatsky.work@gmail.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "tan.hu@zte.com.cn" <tan.hu@zte.com.cn>,
        "tj@kernel.org" <tj@kernel.org>
Subject: Re: [PATCH] scsi: Introduce sdev_printk_ratelimited to throttle
 frequent printk
Thread-Topic: [PATCH] scsi: Introduce sdev_printk_ratelimited to throttle
 frequent printk
Thread-Index: AQHTxnEPZdRFdMp6hEqf3YMIRwShvKPn5g0A
Date: Thu, 29 Mar 2018 23:56:05 +0000
Message-ID: <ab95f87c23832aed080d0c1b6f329471a26d549b.camel@wdc.com>
References: <1522226584-137056-1-git-send-email-wen.yang99@zte.com.cn>
In-Reply-To: <1522226584-137056-1-git-send-email-wen.yang99@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0766;7:NkpDvaSEMLpRATYZSa5m6hgmznCT+FGSr9f/9/BSpH2OAiPYZ1ZXHUxo9mOVjlbs4iLWFujKuZgIHvwT7EndQZRY7fVrIwaccMEOs3Av/Cw9cxYatxeCBt26qVAyMIgv4AbOrqERQe4a5uQxl5+kh0Cbxk0stFshswasZ6blg6dg/u2KOBPleU4BQXdS1nD58k1fBX/pEpBYnp5YCklnEIhloT9yZPuoUHt+6/yxHaXdc/6S3d4KyHae6S2fGyls;20:o9SNsNMm+4tJRTbT80VqZZNW2A1TF41GTnYcHHme8dGKmdmhiq/BL2TQRLaWSqEUw3fzStReStMBTcFKqYLaYCHrkyUaOZwkqKUMos3TR7G6HJUa3EyyrMNR7+pDZW3ui9WhxblgQpTGBWH4X+clozw1gsi/d28WZ9hK2l5YjNY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 34a39496-e520-4484-0f94-08d595d0a2b4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0766;
x-ms-traffictypediagnostic: MWHPR04MB0766:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB076623A642C35C3A3078F21F98A20@MWHPR04MB0766.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR04MB0766;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0766;
x-forefront-prvs: 0626C21B10
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(39380400002)(396003)(366004)(376002)(189003)(199004)(377424004)(118296001)(39060400002)(2501003)(97736004)(2906002)(5250100002)(53936002)(68736007)(106356001)(3280700002)(7736002)(305945005)(81166006)(5660300001)(36756003)(186003)(6116002)(3846002)(76176011)(2201001)(8676002)(3660700001)(7416002)(81156014)(66066001)(6436002)(4326008)(54906003)(486005)(102836004)(316002)(110136005)(105586002)(6506007)(478600001)(486005)(72206003)(6246003)(2900100001)(6512007)(6486002)(446003)(99286004)(59450400001)(25786009)(476003)(2616005)(14454004)(86362001)(11346002)(229853002)(26005)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0766;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: kF/rDuiOzPlgIWUom+Fl2B6D65wEwhLpn6eyYor3bEYin+DkftuVASolclaU1zrGYaxC7K+xwqdqVLbd38gpkZ4XLaMghEeKkcRXt8oYdDvio5PZQf0WV52DY7xQa/XcQ0/Lu9ZSJGsNnbQ4+kOXZcSlyomtTjV7iTP+TmtODT0525yMTxxLMihkUodVplsV8FeJmAe3vpw21aPKP+WwJzflDFTpWK2ZsGtuWg9A/7zZVWBZOY8cBY9M8SnlhDRLRZbHPoHrsNJcEluLbH+tyc5B0PAdvMBfeJPQxWgJen7laKFteLgwZ06ZJgFo03jxL62d7OHMSy9LqqLx/QUH5hF5ieiFhk0nlqQcL1AFde9yQDeZNvbANjACDfUZsgxweb/LG8P1itdyeYJknn+O+Jk/0DACHpG8E5kGd5A9lhI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A661D461B7C25747A4EF9EEE37B927AC@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a39496-e520-4484-0f94-08d595d0a2b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2018 23:56:05.7301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0766
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2TNuGvP002623

On Wed, 2018-03-28 at 16:43 +0800, Wen Yang wrote:
> There would be so many same lines printed by frequent prink if one 
> disk went wrong, like,
> [  546.185242] sd 0:1:0:0: rejecting I/O to offline device
> [  546.185258] sd 0:1:0:0: rejecting I/O to offline device
> [  546.185280] sd 0:1:0:0: rejecting I/O to offline device
> [  546.185307] sd 0:1:0:0: rejecting I/O to offline device
> [  546.185334] sd 0:1:0:0: rejecting I/O to offline device
> [  546.185364] sd 0:1:0:0: rejecting I/O to offline device
> [  546.185390] sd 0:1:0:0: rejecting I/O to offline device
> [  546.185410] sd 0:1:0:0: rejecting I/O to offline device
> For slow serial console, the frequent prink may block the printk, and 
> if spin_lock was acquired before the printk like in scsi_request_fn,
> that could trigger the watchdog.
> 
> Relative disscussion can be found here,
  ^^^^^^^^
  Related?

Anyway:

Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
