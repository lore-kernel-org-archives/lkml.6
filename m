Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752708AbeCLKp6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 06:45:58 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:41818 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751802AbeCLKp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 06:45:56 -0400
X-IronPort-AV: E=Sophos;i="5.47,460,1515427200";
   d="scan'208";a="73966735"
From: Avri Altman <Avri.Altman@wdc.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Harish Jenny K N <harish_kandiga@mentor.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Vladimir_Zapolskiy@mentor.com" <Vladimir_Zapolskiy@mentor.com>
Subject: RE: [PATCH v9] mmc: Export host capabilities to debugfs.
Thread-Topic: [PATCH v9] mmc: Export host capabilities to debugfs.
Thread-Index: AQHTubsGYD25STNRbUa+dM7TicfsWKPMYHQAgAAKQEA=
Date: Mon, 12 Mar 2018 10:45:53 +0000
Message-ID: <DM5PR04MB10854C79897A80023EF37F76FCD30@DM5PR04MB1085.namprd04.prod.outlook.com>
References: <1520829090-3567-1-git-send-email-harish_kandiga@mentor.com>
 <1520849262.10722.582.camel@linux.intel.com>
In-Reply-To: <1520849262.10722.582.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com;
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR04MB0426;20:8EZw+BvzO4KgXYTLxBqThPfj+bO4wQFhlLzfpFXIWcOd39rC+FGR/AmJ4p1DlpSMaAyn/BIs9bVY0r1F/ngF6fLePN95zPxmCdMrKoQOwtsqix7Qq6DzYPDWs5pVywmsBdFlk+DbfOVKAWJ5dezpDayzVZvIn8EAF4IyjsLnF3I=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 661aadb9-b853-4653-3738-08d588066df8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR04MB0426;
x-ms-traffictypediagnostic: DM5PR04MB0426:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM5PR04MB0426DAFD35DD9144FD5A7578FCD30@DM5PR04MB0426.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(6055026)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR04MB0426;BCL:0;PCL:0;RULEID:;SRVR:DM5PR04MB0426;
x-forefront-prvs: 06098A2863
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(366004)(39380400002)(39860400002)(13464003)(189003)(199004)(377424004)(4326008)(186003)(53936002)(68736007)(6506007)(53546011)(316002)(9686003)(97736004)(229853002)(6246003)(2950100002)(25786009)(72206003)(966005)(102836004)(14454004)(26005)(478600001)(6306002)(33656002)(55016002)(105586002)(2900100001)(106356001)(6436002)(99286004)(7736002)(305945005)(66066001)(3846002)(5250100002)(74316002)(7696005)(2501003)(3660700001)(8936002)(81166006)(5660300001)(6116002)(81156014)(76176011)(2906002)(3280700002)(2201001)(8676002)(86362001)(54906003)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR04MB0426;H:DM5PR04MB1085.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: AKn0zK3L149qKLbqmq8WwRMdnez7EzUdMic/sY8owKT2yKcFjGGp4U+/ylivZUXpSs9nyedcMa3z6hq9FErvFLVgzuBD8gc6t/aBrHgAaitzkEf706f8YBB4N6pghm5JLc2ygxV9Z++2dnnN4vFH/FBZP8RG1ltwWlHvrs7kHYr8CDvRPXRlWvgERUXrUGCOKe0f/uvuMelfXN0vWXMOYplPMe7qbeMyH+qocXFxP999EgrhiyuTBcgpAgIqZdmGfJ9lOXRpPgCIs+6XRroNfS/7dKoYdYLLRPvwPyi85BlG7eigR7dp6nEZH5jee8znEerXIRbZwoB6D3PZHgZPYw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 661aadb9-b853-4653-3738-08d588066df8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2018 10:45:53.8333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0426
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2CAk3nZ013889



> -----Original Message-----
> From: Andy Shevchenko [mailto:andriy.shevchenko@linux.intel.com]
> Sent: Monday, March 12, 2018 12:08 PM
> To: Harish Jenny K N <harish_kandiga@mentor.com>; ulf.hansson@linaro.org;
> linus.walleij@linaro.org; adrian.hunter@intel.com; shawn.lin@rock-
> chips.com; Avri Altman <Avri.Altman@wdc.com>
> Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org;
> Vladimir_Zapolskiy@mentor.com
> Subject: Re: [PATCH v9] mmc: Export host capabilities to debugfs.
> 
> On Mon, 2018-03-12 at 10:01 +0530, Harish Jenny K N wrote:
> > This patch exports the host capabilities to debugfs
> >
> > This idea of sharing host capabilities over debugfs came up from Abbas
> > Raza <Abbas_Raza@mentor.com> Earlier discussions:
> > https://lkml.org/lkml/2018/3/5/357
> > https://www.spinics.net/lists/linux-mmc/msg48219.html
> >
> 
> Address below minors and, FWIW, take mine
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> > +	for_each_set_bit(bit, (const unsigned long *)&caps,
> > BITS_PER_LONG)
> 
> > +	for_each_set_bit(bit, (const unsigned long *)&caps2,
> > BITS_PER_LONG)
> 
> Explicit casting is not needed anymore in both cases.
Also maybe use sizeof(mmc_host_capabilities) instead of BITS_PER_LONG?


> 
> --
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Intel Finland Oy
