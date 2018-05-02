Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751809AbeEBRvl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 13:51:41 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:45352 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751087AbeEBRva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 13:51:30 -0400
X-IronPort-AV: E=Sophos;i="5.49,354,1520870400";
   d="scan'208";a="77098166"
From: Adam Manzanares <Adam.Manzanares@wdc.com>
To: Christoph Hellwig <hch@infradead.org>
CC: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "bcrl@kvack.org" <bcrl@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] fs: add RWF_IOPRIO
Thread-Topic: [PATCH 1/2] fs: add RWF_IOPRIO
Thread-Index: AQHT4KRlEd5NDzQNtkaeY+N6d8GL1KQctbOAgAAFYwA=
Date: Wed, 2 May 2018 17:51:25 +0000
Message-ID: <e97ca367-a5d2-5780-a339-0be1aac33f03@wdc.com>
References: <20180430165740.2842-1-adam.manzanares@wdc.com>
 <20180430165740.2842-2-adam.manzanares@wdc.com>
 <20180502173207.GA27997@infradead.org>
In-Reply-To: <20180502173207.GA27997@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Adam.Manzanares@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR04MB0203;7:avqQcn5Lthx5jcMbP8K2EUNGCSlXAM417XGggUdVtgjw8yS9d8gOVUGw7G0asdm2uTAjrr4XtEnNmsO4Gw16d9veacQVt9xXPoCjfGwtYfiH6Xhow+DyN3xfxDZ81AStqUh/ju3Ctj0dvV2RHP8zeVvIYpAF2/25N6JABfilBcMCafIFSKWHlMiw6zygUcrZZKuL8N1f0ZL55efaPUAbtVh8iLPy8AZd5727vCjP+A65zG9bR6G3vaEArkVaI5qU;20:FVfysp39/ZTJPyhHUB7m9cfZYWiTzQQihAeaQBdsLcZBd4hfLWiIuF20o5wiFJ3c7O8NwftOD+CS/ECnYEtyDM0oz0rFElRxVayPqgL8cgGTNsqumDOECj+1W+ikeFafpNEjbwvt4SeeEiBWCLb4LEMDo4yoG10VQexgYPWcijo=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR04MB0203;
x-ms-traffictypediagnostic: DM5PR04MB0203:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM5PR04MB02032A853BC2BB09A961AB6DF0800@DM5PR04MB0203.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR04MB0203;BCL:0;PCL:0;RULEID:;SRVR:DM5PR04MB0203;
x-forefront-prvs: 06607E485E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(346002)(376002)(39860400002)(199004)(189003)(476003)(36756003)(478600001)(5660300001)(486006)(8936002)(81156014)(31686004)(4326008)(14454004)(105586002)(81166006)(2616005)(6486002)(31696002)(86362001)(6116002)(3660700001)(446003)(3846002)(3280700002)(99286004)(72206003)(316002)(11346002)(6512007)(8676002)(25786009)(5250100002)(6246003)(102836004)(53546011)(305945005)(6506007)(66066001)(6436002)(2900100001)(6916009)(229853002)(54906003)(97736004)(106356001)(76176011)(2906002)(68736007)(7736002)(53936002)(186003)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR04MB0203;H:DM5PR04MB0282.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: oqQjo+9yMco8IthB910zov0dU1ZXh4DnPhiHRq8SS7XOtTweTEqwm2CLBe/U04hloMg4ua719+Z4gOnPPiQJ9/ue7rt1+i4eXeSE70czg3ypOBALl8HoMcQQSqeJSJ15Ds7uqw9+diMUoPG44X7LIBz9jpR7u0a9/1TqQ3fukFQxABJMXbd/zE73KU4ZgmMB
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C29FEC7474AEF48B1C81DB1C5F1E13D@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: e210014c-8a8d-46c9-b6d6-08d5b0555311
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e210014c-8a8d-46c9-b6d6-08d5b0555311
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2018 17:51:25.3921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0203
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w42Hpnxg016362



On 5/2/18 10:32 AM, Christoph Hellwig wrote:
> On Mon, Apr 30, 2018 at 09:57:39AM -0700, adam.manzanares@wdc.com wrote:
>> From: Adam Manzanares <adam.manzanares@wdc.com>
>>
>> This is the per-I/O equivalent of the ioprio_set system call.
>>
>> When the RWF_IOPRIO flag is set then the aio_reqprio field of the iocb
>> is interpreted as an I/O scheduling class and priority.
> 
> I think this belongs into the IOCB_FLAG_* flags namespace for aio_flags
> field as it isn't a field valid for plain read/write.
> 
> Also you probably want to merge both patches as they only really
> make sense together.
> 

I will make the changes and send out a v2.
