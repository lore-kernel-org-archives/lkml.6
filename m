Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936471AbeCBQWe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:22:34 -0500
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:52478 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935226AbeCBQWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:22:30 -0500
From: "Kani, Toshi" <toshi.kani@hpe.com>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "maxg@mellanox.com" <maxg@mellanox.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "oliveroh@au1.ibm.com" <oliveroh@au1.ibm.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI Memory
Thread-Topic: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI
 Memory
Thread-Index: AQHTsO2SauImX1OM+UWgCf/w5DnppaO6wDuAgAAAYICAAQJ2gIAAFIKAgAABk4CAAAOhgIAAFJIAgAAG2oCAAADQAIABNwIA
Date: Fri, 2 Mar 2018 16:22:24 +0000
Message-ID: <1520010446.2693.19.camel@hpe.com>
References: <20180228234006.21093-1-logang@deltatee.com>
         <1519876489.4592.3.camel@kernel.crashing.org>
         <1519876569.4592.4.camel@au1.ibm.com>
         <CAPcyv4h7mcFphv3j_vW-CGxXa2pjQgLqpBOLzHuTzAFzygai-Q@mail.gmail.com>
         <1519936477.4592.23.camel@au1.ibm.com>
         <1519936815.4592.25.camel@au1.ibm.com> <20180301205315.GJ19007@ziepe.ca>
         <1519942012.4592.31.camel@au1.ibm.com>
         <CA+55aFy-oAiFJ3WDx4giR1enj65y-YJnZZhY6geFw0ygFyKXfQ@mail.gmail.com>
         <1519943658.4592.34.camel@kernel.crashing.org>
In-Reply-To: <1519943658.4592.34.camel@kernel.crashing.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.219.147.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0321;6:fmLT87FwEaQRLVIJCwUJhOXPC9WgYAWVaSA6+NcJ8QBj7blB2HGhIzpuqRZ/08sJH+rteTthGO/6PANTUKDoVPW/9PxUsgBlPiWlR+QvTJKN6+P2RVtHb5fbnAZUejW4cXiw8QfL70zJG/t6mEcfHMdCf2Pi8e1h8/BkpGCN20YcLthsfFxshCC/HxxExfjnmteatRLm2UtGGsQJ4aVYp16iusiCOIqv/UL0OMeyWZq48OhGZuecaKnmRHMR4M2cQ6p+9SqffENN4HhyLuG9gMdHX3qVDKKv9evrPcrsV3sWIDyIBCnOURqH88ceLrsY1dT2n4VaolWMXI5Tpzv+NWWhiksR87BFVG6FR20yz9qS63UA80jgbmqFqjnVWITK;5:TKBAmMkUuU8QOOjEYFvx9qAUBoWjSOhCSpTgVnGgfBUmRKHPPM9Q35WKh9QgTZHe4C422xX1cl9pqSiNIkqS2CCuyUvOEXmVn4Dtq7OFLCYjhLXxZJ0zviYkQeKn9AE/w2ylcFk85l5drglXIXbaiEB7X/vtxRVmgxlf5R+1HLk=;24:RjHSNA9Q3fIsvzG457YmuPF/APZEpDX63Ctz+g3MU96ha7F/CE1DScEFQzK9qJcMIs6AQp3ZMnv3R8A2oQ4v6RSE7apsnLHCgnZQGa9PzyQ=;7:IBQERLjDc9DqGflai94z3mmyekSXRl508hp/HwKHCtqPvuynwYVI/DpcFlfaxh1r7jHnYl0Ua2v0e/9bT7lUUDruABBHeo8CC7UUZ5lJdzORBroTPP9Ll4Up2ubWb/JMz7ZL+trsTFBWle5f+A6pdA7cXadza4ze1agxUELSt2mEtlpnfhaoAzQYAOUBaOmMzPhBQOpBV0XdXKKcYNk1yxkVFpi30x8Z3qGdAatY968qaXOauObmV1xug54TYPvx
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7d0127cb-c29b-4277-172b-08d58059c86f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:AT5PR8401MB0321;
x-ms-traffictypediagnostic: AT5PR8401MB0321:
x-microsoft-antispam-prvs: <AT5PR8401MB0321E97743957130FB562B7A82C50@AT5PR8401MB0321.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(104084551191319)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231220)(944501241)(52105095)(10201501046)(6055026)(6041288)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:AT5PR8401MB0321;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0321;
x-forefront-prvs: 05991796DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(39860400002)(39380400002)(376002)(189003)(199004)(377424004)(36756003)(3280700002)(81166006)(14454004)(81156014)(5660300001)(86362001)(103116003)(8936002)(229853002)(4326008)(97736004)(6116002)(25786009)(478600001)(66066001)(3846002)(105586002)(2906002)(7736002)(8676002)(305945005)(53936002)(6486002)(26005)(186003)(6506007)(5250100002)(2950100002)(110136005)(3660700001)(6512007)(54906003)(106356001)(6436002)(76176011)(316002)(102836004)(6246003)(93886005)(68736007)(2501003)(99286004)(53546011)(7416002)(2900100001);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0321;H:AT5PR8401MB1297.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: L3qO7sRC+r6w34tDfjN+S4Tk29TKWz0ffUWJSWqMjmPaQ+6QDENH3rF+yDcIUYerwrzg1TgtptS3PKUGX9yofvSeI90IpV0yMpHWo7tiULmNtNDdkZWpzaLhgTDvjuiGS4sykOkhXW3lT3UmRiggF4QZskDb4bboYnv9ea4f+c0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A740CC14662A0948A822E31824F31125@NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0127cb-c29b-4277-172b-08d58059c86f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2018 16:22:24.5024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0321
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w22GMdjb000616

On Fri, 2018-03-02 at 09:34 +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2018-03-01 at 14:31 -0800, Linus Torvalds wrote:
> > On Thu, Mar 1, 2018 at 2:06 PM, Benjamin Herrenschmidt <benh@au1.ibm.com> wrote:
> > > 
> > > Could be that x86 has the smarts to do the right thing, still trying to
> > > untangle the code :-)
> > 
> > Afaik, x86 will not cache PCI unless the system is misconfigured, and
> > even then it's more likely to just raise a machine check exception
> > than cache things.
> > 
> > The last-level cache is going to do fills and spills directly to the
> > memory controller, not to the PCIe side of things.
> > 
> > (I guess you *can* do things differently, and I wouldn't be surprised
> > if some people inside Intel did try to do things differently with
> > trying nvram over PCIe, but in general I think the above is true)
> > 
> > You won't find it in the kernel code either. It's in hardware with
> > firmware configuration of what addresses are mapped to the memory
> > controllers (and _how_ they are mapped) and which are not.
> 
> Ah thanks ! Thanks explains. We can fix that on ppc64 in our linear
> mapping code by checking the address vs. memblocks to chose the right
> page table attributes.

FWIW, this thing is called MTRRs on x86, which are initialized by BIOS.
These registers effectively overwrite page table setups.  Intel SDM
defines the effect as follows.  'PAT Entry Value' is the page table
setup.

MTRR Memory Type  PAT Entry Value  Effective Memory Type
--------------------------------------------------------
UC                UC               UC
UC                WC               WC
UC                WT               UC
UC                WB               UC
UC                WP               UC 

On my system, BIOS sets MTRRs to cover the entire MMIO ranges with UC.
Other BIOSes may simply set the MTRR default type to UC, i.e. uncovered
ranges become UC.

# cat /proc/mtrr
 :
reg01: base=0xc0000000000 (12582912MB), size=2097152MB, count=1:
uncachable
 :

# cat /proc/iomem | grep 'PCI Bus'
 :
c0000000000-c3fffffffff : PCI Bus 0000:00
c4000000000-c7fffffffff : PCI Bus 0000:11
c8000000000-cbfffffffff : PCI Bus 0000:36
cc000000000-cffffffffff : PCI Bus 0000:5b
d0000000000-d3fffffffff : PCI Bus 0000:80
d4000000000-d7fffffffff : PCI Bus 0000:85
d8000000000-dbfffffffff : PCI Bus 0000:ae
dc000000000-dffffffffff : PCI Bus 0000:d7

-Toshi
