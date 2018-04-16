Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753073AbeDPQrl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 12:47:41 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:46019 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753025AbeDPQrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 12:47:37 -0400
X-IronPort-AV: E=Sophos;i="5.48,459,1517846400";
   d="scan'208";a="172718930"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "rajatja@google.com" <rajatja@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "mingo@redhad.com" <mingo@redhad.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>
Subject: Re: [RESEND PATCH v1 1/2] trace: events: scsi: Add tag in SCSI trace
 events
Thread-Topic: [RESEND PATCH v1 1/2] trace: events: scsi: Add tag in SCSI trace
 events
Thread-Index: AdPVj5Jy/9Ew2ExTSbalJ+RQV0SXDQAB/Q4AAAKLxwAAADn3gA==
Date: Mon, 16 Apr 2018 16:47:34 +0000
Message-ID: <47879f7ce437dd50ee594a1b19b2b93e78968fb8.camel@wdc.com>
References: <4650cbf668fd4853ad98dba834141e08@SIWEX5A.sing.micron.com>
         <20180416112810.57a3f74b@gandalf.local.home>
         <CACK8Z6F02C2nskv7uO20fj=Ns3OsEwJ1FjaDYaE62+jfF5QZag@mail.gmail.com>
In-Reply-To: <CACK8Z6F02C2nskv7uO20fj=Ns3OsEwJ1FjaDYaE62+jfF5QZag@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0945;7:kXdCL5V6SVghgy0n8QfO2qkUZ0N0hcgbUKKjLslHdt8O4R/GuWav/PZdfB9zuSA4pQQ831HlZtW7Jqai9Tbk0nf97Zf+jDgyccd16d6GoyNz45iFvbaCO98y7nqZGlsb78AhXCGLl9zEwvNGBuR30Sm+EErsVMWAbrnOIwSKOmiaRLlEJW2vv+Fca3ZCZNpHi+Ncrc6uw6OiK4/XzM5CF8gKVj5MixqGSH1DZ1eB8ap07lJxp15qPrAtGzAJ/OWH;20:5c5k3sYyKSOTiF3EB/OJ68SGod4e/729K6uA3Dyr9okgY6HHC2fxCpQBYmZtTPb8aNxYoKQsdiXdo8yyssaFv6y7SxdvnMdZPNyknJcAXxzlfCioF42NJ+Psve23qxKBFRMsCy73afwIq+Sfg1I81T5kftp47tm4S+VuvFWTSW0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0945;
x-ms-traffictypediagnostic: MWHPR04MB0945:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0945761484343523BF93E54D98B00@MWHPR04MB0945.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231232)(944501327)(52105095)(3002001)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:MWHPR04MB0945;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0945;
x-forefront-prvs: 0644578634
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(39860400002)(346002)(396003)(366004)(199004)(189003)(377424004)(99286004)(8936002)(3660700001)(102836004)(3846002)(3280700002)(186003)(14454004)(229853002)(476003)(2900100001)(5250100002)(59450400001)(4326008)(6506007)(446003)(6116002)(2501003)(81156014)(81166006)(11346002)(2906002)(72206003)(26005)(53546011)(8676002)(68736007)(25786009)(76176011)(86362001)(478600001)(2616005)(66066001)(6486002)(110136005)(97736004)(6436002)(6512007)(36756003)(6246003)(53936002)(486006)(105586002)(54906003)(316002)(305945005)(7736002)(7416002)(5660300001)(106356001)(118296001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0945;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Hf9nwyA8Q5SrBC+aMZveOD75rcrafj9kK5m2KCwetiY+32fQbSuMJ6cpUdsNUbAgMEemh+P4M9JQ1xTnRnMHndMOXzst8LD3YdYBWEG2NE5HNq8M5HcgEY7wkKc1jG+fsuieyQQB0MfcIsQ60CQyENmLRrF76vSCzh1Q+GHR+lr9J9FywPkSjoITHL+dXVoZ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <213BBD2B2E092D449013B7AB6CDA416E@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 0298f458-00f3-48f6-5d26-08d5a3b9c130
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0298f458-00f3-48f6-5d26-08d5a3b9c130
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2018 16:47:34.6601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0945
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3GGlkpN017041

On Mon, 2018-04-16 at 09:41 -0700, Rajat Jain wrote:
> On Mon, Apr 16, 2018 at 8:28 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Mon, 16 Apr 2018 14:31:49 +0000
> > "Bean Huo (beanhuo)" <beanhuo@micron.com> wrote:
> > 
> > > Print the request tag along with other information
> > > while tracing a command.
> > > 
> > > Signed-off-by: Bean Huo <beanhuo@micron.com>
> 
> Acked-by: Rajat Jain <rajatja@google.com>

This patch is not acceptable because it adds support for tag tracing to the
legacy block layer only. Any patch that adds a new feature to the legacy block
layer must also add it to blk-mq.

Bart.
