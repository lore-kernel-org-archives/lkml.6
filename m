Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752844AbeDQLoB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 07:44:01 -0400
Received: from mail-by2nam01on0047.outbound.protection.outlook.com ([104.47.34.47]:47349
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752332AbeDQLn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 07:43:59 -0400
From: Radhey Shyam Pandey <radheys@xilinx.com>
To: Vinod Koul <vinod.koul@intel.com>
CC: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "Appana Durga Kedareswara Rao" <appanad@xilinx.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC 2/6] dmaengine: xilinx_dma: Pass AXI4-Stream control words
 to netdev dma client
Thread-Topic: [RFC 2/6] dmaengine: xilinx_dma: Pass AXI4-Stream control words
 to netdev dma client
Thread-Index: AQHTym7m2V209m7Mdku6MMzd169mt6P7VJGAgAmMXFA=
Date: Tue, 17 Apr 2018 11:43:56 +0000
Message-ID: <BN6PR02MB32825FDF8601D8A310C2270BC7B70@BN6PR02MB3282.namprd02.prod.outlook.com>
References: <1522665546-10035-1-git-send-email-radheys@xilinx.com>
 <1522665546-10035-3-git-send-email-radheys@xilinx.com>
 <20180411090854.GY6014@localhost>
In-Reply-To: <20180411090854.GY6014@localhost>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR02MB2291;7:7tjXP6lVB61pZMaYzMoDTKWODvxlpdiswxEkcSlbfouVuFJ99FeMmtCt2MS9DAIlx4K3onqiqYoaaHBHqTcAg76+MqVDDqfXbr8QDnHQFi9xqoOmKyzEMlbQiX4ZnTTxVXi5RJ3pyiTP8TKLynpa3lF5TLVALn74ZfuqY80+zUEtNRcwE5S3eXDE9j4ung+MA/+s/sS/pXX6tXRDQjXSSFfXa/IGDPVPFH6q0vl61pnoIl6aIIARVl9PLSHhbBl2
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39380400002)(396003)(376002)(346002)(39860400002)(366004)(13464003)(189003)(199004)(81156014)(6246003)(81166006)(33656002)(14454004)(3660700001)(99286004)(478600001)(6436002)(54906003)(2900100001)(4326008)(106356001)(8676002)(316002)(3280700002)(55016002)(66066001)(68736007)(2906002)(9686003)(229853002)(25786009)(53936002)(97736004)(6916009)(105586002)(8936002)(74316002)(55236004)(5250100002)(86362001)(76176011)(102836004)(11346002)(6116002)(446003)(486006)(476003)(305945005)(3846002)(7736002)(6506007)(53546011)(26005)(5660300001)(186003)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2291;H:BN6PR02MB3282.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:BN6PR02MB2291;
x-ms-traffictypediagnostic: BN6PR02MB2291:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=radheys@xilinx.com;
x-microsoft-antispam-prvs: <BN6PR02MB2291ABC9D94E363082E02F36C7B70@BN6PR02MB2291.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335)(192813158149592)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231232)(944501359)(52105095)(3002001)(6055026)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR02MB2291;BCL:0;PCL:0;RULEID:;SRVR:BN6PR02MB2291;
x-forefront-prvs: 0645BEB7AA
x-microsoft-antispam-message-info: XgDGmy0kqIZzGP3uUq8ODX29Qssbvuc3MSbG7ATugnZ9PxC2qxRNy2VU/A2JYsIlOUZYog5aU2zds0jqmENcUa7l8rJa3oRTb1lHTF9Uqfq3x6RHe7O9wKR9efbzWGpCtImclqxAkpOY45DWmyOBwI9qDxTYFeeWBNMPByiQEKvMAMk4dQqG9LpFrjMwN2LM
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 450e67a5-d2e1-4092-5982-08d5a458809f
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 450e67a5-d2e1-4092-5982-08d5a458809f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 11:43:56.3859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2291
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3HBi58m008266

Hi Vinod,

> -----Original Message-----
> From: Vinod Koul [mailto:vinod.koul@intel.com]
> Sent: Wednesday, April 11, 2018 2:39 PM
> To: Radhey Shyam Pandey <radheys@xilinx.com>
> Cc: dan.j.williams@intel.com; michal.simek@xilinx.com; Appana Durga
> Kedareswara Rao <appanad@xilinx.com>; Radhey Shyam Pandey
> <radheys@xilinx.com>; lars@metafoo.de; dmaengine@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [RFC 2/6] dmaengine: xilinx_dma: Pass AXI4-Stream control
> words to netdev dma client
> 
> On Mon, Apr 02, 2018 at 04:09:02PM +0530, Radhey Shyam Pandey wrote:
> 
> > +
> > +		if (chan->xdev->has_axieth_connected) {
> > +			seg = list_first_entry(&desc->segments,
> > +					struct xilinx_axidma_tx_segment,
> node);
> > +			if (cb.callback_param) {
> > +				app_w = (u32 *) cb.callback_param;
> 
> why are you interpreting callback_param? This is plainly wrong.
> we do not know what is the interpretation of callback_param and it is
> internal to submitter.
In design, if AXI DMA is connected to AXI Ethernet IP there are certain
AXI4-Stream Status fields (RX) that we need to pass to ethernet driver
along with data buffer. An example includes: checksum fields, packet
length etc. To pass these control words there is a structure defined
between dmaengine and client. Before calling the client callback
stream control words are copied to dma client callback_param struct
(only if axieth is connected).

I understand it's not an ideal way and we shouldn't be interpreting
callback_param but couldn't find any better alternative of passing
custom information from dmaengine to client driver and still be 
aligned to the framework.

> 
> What exactly is the problem you are trying to solve?
As mentioned above we need to pass AXI4-stream words(custom
data) from dmaengine driver to dma client driver(ethernet) for
each DMA descriptor. Current solution populates callback_param
struct (only if axieth is connected). Please let me know if there is
an alternate solution. 

> 
> > +				hw = &seg->hw;
> > +				*app_w = hw->status &
> XILINX_DMA_MAX_TRANS_LEN;
> > +				memcpy(app_w, hw->app, sizeof(u32) *
> > +					XILINX_DMA_NUM_APP_WORDS);
> > +			}
> 
> --
> ~Vinod
