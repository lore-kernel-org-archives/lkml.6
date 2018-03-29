Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752314AbeC2QOm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 12:14:42 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:34966 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751859AbeC2QOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 12:14:40 -0400
X-IronPort-AV: E=Sophos;i="5.48,376,1517846400";
   d="scan'208";a="74830156"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "logang@deltatee.com" <logang@deltatee.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "james.smart@broadcom.com" <james.smart@broadcom.com>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 3/4] nvmet-fc: Don't use the count returned by the
 dma_map_sg call
Thread-Topic: [PATCH 3/4] nvmet-fc: Don't use the count returned by the
 dma_map_sg call
Thread-Index: AQHTx3g9T5YWYwnprEekrzr0ahYPmKPnYx8A
Date: Thu, 29 Mar 2018 16:14:37 +0000
Message-ID: <a60ddb463159bcc287998ecfafdc2753973a4828.camel@wdc.com>
References: <20180329160721.4691-1-logang@deltatee.com>
         <20180329160721.4691-4-logang@deltatee.com>
In-Reply-To: <20180329160721.4691-4-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB1231;7:aMZtAmE/Xt3Mh/2ZObAt2nqOhblzZavANfW4740iRHRA+/yVzpAGtbrF3wKOYjJmPaoYbw/he5aTSnSgXUD+2JkR0iKSXV5s6qzsQo/HU7qXnaMQiPlCH2Srjw0whtutH2eeZCZPb+UXYa+3kbEKFXDH7SVK1qMD0mNY9vqaseBQqjc2lVbUBu5lWipgcWmyy/ALp4CPc/nqMp40YoMk4YLKke8cC+q/+1YO/W5Zts3kARARCdDFIa8Nogb6rEcv;20:phURjlpktvSmLGSqdfS9ibN8wzKiheQK5yPrqPJ7S9IVBSSnPR6SXDCJLyyuUJtZ1a870ELnBy8ECLK+Jk/wOfwqnftvpVUll8ssk7RBA1q7seSukExpfVdWyRFa6P69pV4koE6Sfz29vBYoonH/sKvCZ2pCyEd+0Mgm5uKx4wE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 31ed8680-141a-402b-e0e3-08d595902ba3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB1231;
x-ms-traffictypediagnostic: MWHPR04MB1231:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB1231A3620C0B96C3D67D0BCD98A20@MWHPR04MB1231.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:MWHPR04MB1231;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB1231;
x-forefront-prvs: 0626C21B10
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(346002)(39380400002)(366004)(377424004)(189003)(199004)(305945005)(102836004)(26005)(25786009)(6506007)(2616005)(3280700002)(4326008)(5250100002)(54906003)(11346002)(3660700001)(99286004)(2906002)(478600001)(229853002)(6512007)(486005)(3846002)(316002)(476003)(6246003)(6116002)(2501003)(486005)(14454004)(446003)(110136005)(2201001)(86362001)(72206003)(76176011)(66066001)(97736004)(2900100001)(8676002)(81156014)(7736002)(186003)(6436002)(106356001)(118296001)(81166006)(36756003)(68736007)(105586002)(6486002)(53936002)(8936002)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB1231;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: lh+jJB2aeeBF5965e1ESqM2foHFdQ/HhTrxv/x7fxxi5OrlY5pQvbfrfXFqAyoSV3UHt0XrQcmUtwRVGSkvDUmLZurVpdbQn8MjhmEOfzu8743XfQp+uhCWO12pNc8XtFmmpVX1E8JOfkg4ie44UUmdJnrW17Rqiu5V99ZwZ3eDArtBUzBkJKHTcX322+5ZdA0ciiFPKIYL4ArHyZ+Tw6FaftSYG+z+1sL5JLnIzR+X1JHyP8pBNuDkE0iJYHuzOyL0oVegBG6THZCWIus7IkjrJozWbFIsoZi793iveWGstnLJp0d6eoznCFrkr59aaky+AsG0duijXh+76QeVLrQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F586833F33F5064F8FE68DD513564705@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ed8680-141a-402b-e0e3-08d595902ba3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2018 16:14:38.1220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1231
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2TGExSX024597

On Thu, 2018-03-29 at 10:07 -0600, Logan Gunthorpe wrote:
> +	ret = fc_dma_map_sg(fod->tgtport->dev, sg, nent,
> +			    ((fod->io_dir == NVMET_FCP_WRITE) ?
> +				    DMA_FROM_DEVICE : DMA_TO_DEVICE));
> +			    /* note: write from initiator perspective */

If you have to repost this patch please remove the four superfluous parentheses.

Thanks,

Bart.
