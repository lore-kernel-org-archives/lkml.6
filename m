Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933355AbeDXOFb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 10:05:31 -0400
Received: from mail-sn1nam01on0087.outbound.protection.outlook.com ([104.47.32.87]:19383
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752630AbeDXOF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 10:05:28 -0400
From: Alan Douglas <adouglas@cadence.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "niklas.cassel@axis.com" <niklas.cassel@axis.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC 01/10] PCI: dwc: Add MSI-X callbacks handler
Thread-Topic: [RFC 01/10] PCI: dwc: Add MSI-X callbacks handler
Thread-Index: AQHT0O90eZoB3w6tM0iIqeAcoJMN2aQDKP0AgAsCRACAAWjSAIAAKX2AgABFsJA=
Date: Tue, 24 Apr 2018 14:05:26 +0000
Message-ID: <SN6PR07MB4512BED3D44003EF72EE06FDD8880@SN6PR07MB4512.namprd07.prod.outlook.com>
References: <cover.1523379766.git.gustavo.pimentel@synopsys.com>
 <77b7b2687e9618d3f7d1f11c3fc6ecec9a9442ef.1523379766.git.gustavo.pimentel@synopsys.com>
 <0b7023d9-29c6-0993-07d3-b046d25b67ff@ti.com>
 <e2fe7d5f-9f57-0e67-d321-541ff4706792@synopsys.com>
 <0e8b8ce9-db12-1e11-3eb5-62f3fa686d59@ti.com>
 <16d237b2-0052-447e-13cb-bc2f15848be4@synopsys.com>
In-Reply-To: <16d237b2-0052-447e-13cb-bc2f15848be4@synopsys.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYWRvdWdsYXNcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy04OWZkZGNlNS00N2M4LTExZTgtODZlNS1mNDk2MzQ4NmY0ZWNcYW1lLXRlc3RcODlmZGRjZTYtNDdjOC0xMWU4LTg2ZTUtZjQ5NjM0ODZmNGVjYm9keS50eHQiIHN6PSI1ODc0IiB0PSIxMzE2OTA1MjMyNzkzNjAyNzQiIGg9IkZXeEp6bHNXdlQ4RHRveE5LdnU0aE5pZ2JDUT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=adouglas@cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR07MB4429;7:Y1W7pF1RuefiXu9HiLdUxiZ7eAqyUnNKOGN6aZT+yN9972KgprMzDqWEUdSEFQARAhVSwJVN48vtDu0nDW7U3A/Ny+9Nk4xRXUd/0aCLdOgiPeHw+2l4joVocESu7HOaOjyJ2bTyLEwH9N7d3TcoN28/eH/x6Cngsb7Npv4DLG+tGBE6//tGOvkrXB1VHdwpWEU498+2sAu22k+59sPXBa5OBWP4krBD/QcojzLX+0ichexXqBj1XzvydOtm5und;20:+vby60BjybOd6xf8nFCxudQwsbw4+dCkXQ+j7hpmfWS16kgBLTqyOEdGsLFlSyB/rqIWyTCwFP40QBuwlm/Vg58911bxSj9RAzkkldexSDXw8stL0WeQBWrY0AncK3+pXarTHbGZ3z9ma53cxRpp8pZdUM9ZL4jgIofrai4YN4kwshU+3acxM/K2jLeqFqoY7VUzvQ8DF6IK8uwrw0E7Kt11wxVAiTu+o2sNNtR2YS5Qb3sM5ewu80nKa0PgPt4i
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4429;
x-ms-traffictypediagnostic: SN6PR07MB4429:
x-microsoft-antispam-prvs: <SN6PR07MB4429789906BB4476289BA06DD8880@SN6PR07MB4429.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231232)(944501410)(52105095)(10201501046)(93006095)(93001095)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:SN6PR07MB4429;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4429;
x-forefront-prvs: 0652EA5565
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(366004)(39380400002)(36092001)(199004)(189003)(316002)(7696005)(76176011)(33656002)(9686003)(55016002)(53936002)(97736004)(99286004)(102836004)(54906003)(105586002)(3280700002)(66066001)(110136005)(8676002)(53546011)(6506007)(59450400001)(106356001)(3660700001)(5660300001)(478600001)(68736007)(3846002)(2906002)(93886005)(81156014)(305945005)(39060400002)(74316002)(4326008)(7416002)(7736002)(229853002)(186003)(11346002)(81166006)(8936002)(25786009)(2900100001)(6436002)(476003)(5250100002)(2201001)(486006)(26005)(14454004)(6116002)(2501003)(446003)(86362001)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4429;H:SN6PR07MB4512.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 5l5KaxKvdRAxasurf+zNM4Vdp+CerInWwqT0dIqapieiPBp1TLkO/B5zQtGndlfDrG1Zna6ydwMZ4usvR8prRabyKRtzWsO0ltcaQhftL/2M6Zze16Za31ODcibodwXztF6xeRK4r8LIaSY+kKI/M/u17vi9qVytT1lmT5mNdOIkHGpVsOKArAciyIa5dsiz/feks8os5zqCeFWwjAVCQA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: ff246cb6-1623-4398-23f9-08d5a9ec6dde
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff246cb6-1623-4398-23f9-08d5a9ec6dde
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2018 14:05:26.1881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4429
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3OE5crt007882

Hi Kishon,

On 24 April 2018 10:36 Gustavo Pimentel wrote:
> Hi Kishon,
> 
> On 24/04/2018 08:07, Kishon Vijay Abraham I wrote:
> > Hi,
> >
> > On Monday 23 April 2018 03:06 PM, Gustavo Pimentel wrote:
> >> Hi Kishon,
> >>
> >> On 16/04/2018 10:29, Kishon Vijay Abraham I wrote:
> >>> Hi Gustavo,
> >>>
> >>> On Tuesday 10 April 2018 10:44 PM, Gustavo Pimentel wrote:
> >>>> Changes the pcie_raise_irq function signature, namely the
> >>>> interrupt_num variable type from u8 to u16 to accommodate the MSI-X
> >>>> maximum interrupts of 2048.
> >>>>
> >>>> Implements a PCIe config space capability iterator function to
> >>>> search and save the MSI and MSI-X pointers. With this method the
> >>>> code becomes more generic and flexible.
> >>>>
> >>>> Implements MSI-X set/get functions for sysfs interface in order to
> >>>> change the EP entries number.
> >>>>
> >>>> Implements EP MSI-X interface for triggering interruptions.
> >>>>
> >>>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> >>>> ---
> >>>>  drivers/pci/dwc/pci-dra7xx.c           |   2 +-
> >>>>  drivers/pci/dwc/pcie-artpec6.c         |   2 +-
> >>>>  drivers/pci/dwc/pcie-designware-ep.c   | 145
> ++++++++++++++++++++++++++++++++-
> >>>>  drivers/pci/dwc/pcie-designware-plat.c |   6 +-
> >>>>  drivers/pci/dwc/pcie-designware.h      |  23 +++++-
> >>>>  5 files changed, 173 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/drivers/pci/dwc/pci-dra7xx.c
> >>>> b/drivers/pci/dwc/pci-dra7xx.c index ed8558d..5265725 100644
> >>>> --- a/drivers/pci/dwc/pci-dra7xx.c
> >>>> +++ b/drivers/pci/dwc/pci-dra7xx.c
> >>>> @@ -369,7 +369,7 @@ static void dra7xx_pcie_raise_msi_irq(struct
> >>>> dra7xx_pcie *dra7xx,  }
> >>>>
> >>>>  static int dra7xx_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> >>>> -				 enum pci_epc_irq_type type, u8
> interrupt_num)
> >>>> +				 enum pci_epc_irq_type type, u16
> interrupt_num)
> >>>>  {
> >>>>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> >>>>  	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci); diff --git
> >>>> a/drivers/pci/dwc/pcie-artpec6.c b/drivers/pci/dwc/pcie-artpec6.c
> >>>> index e66cede..96dc259 100644
> >>>> --- a/drivers/pci/dwc/pcie-artpec6.c
> >>>> +++ b/drivers/pci/dwc/pcie-artpec6.c
> >>>> @@ -428,7 +428,7 @@ static void artpec6_pcie_ep_init(struct
> >>>> dw_pcie_ep *ep)  }
> >>>>
> >>>>  static int artpec6_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> >>>> -				  enum pci_epc_irq_type type, u8
> interrupt_num)
> >>>> +				  enum pci_epc_irq_type type, u16
> interrupt_num)
> >>>>  {
> >>>>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> >>>>
> >>>> diff --git a/drivers/pci/dwc/pcie-designware-ep.c
> >>>> b/drivers/pci/dwc/pcie-designware-ep.c
> >>>> index 15b22a6..874d4c2 100644
> >>>> --- a/drivers/pci/dwc/pcie-designware-ep.c
> >>>> +++ b/drivers/pci/dwc/pcie-designware-ep.c
> >>>> @@ -40,6 +40,44 @@ void dw_pcie_ep_reset_bar(struct dw_pcie
> *pci, enum pci_barno bar)
> >>>>  	__dw_pcie_ep_reset_bar(pci, bar, 0);  }
> >>>>
> >>>> +void dw_pcie_ep_find_cap_addr(struct dw_pcie_ep *ep) {
> >>>
> >>> This should be implemented in a generic way similar to
> pci_find_capability().
> >>> It'll be useful when we try to implement other capabilities as well.
> >>
> >> Hum, what you suggest? Something implemented on the pci-epf-core?
> >
> > yeah, Initially thought it could be implemented as a helper function
> > in pci-epc-core so that both designware and cadence can use it.
> 
> That would be nice, however I couldn't find out how to access the config
> space, through the pci_epf or pci_epc structs.
> 
> So, I reworked the functions like this:
> 
> (on pcie-designware-ep.c)
> 
> u8 __dw_pcie_ep_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
>                               u8 cap)
> {
>         u8 cap_id, next_cap_ptr;
>         u16 reg;
> 
>         reg = dw_pcie_readw_dbi(pci, cap_ptr);
>         next_cap_ptr = (reg & 0xff00) >> 8;
>         cap_id = (reg & 0x00ff);
> 
>         if (!next_cap_ptr || cap_id > PCI_CAP_ID_MAX)
>                 return 0;
> 
>         if (cap_id == cap)
>                 return cap_ptr;
> 
>         return __dw_pcie_ep_find_next_cap(pci, next_cap_ptr, cap); }
> 
> u8 dw_pcie_ep_find_capability(struct dw_pcie *pci, u8 cap) {
>         u8 next_cap_ptr;
>         u16 reg;
> 
>         reg = dw_pcie_readw_dbi(pci, PCI_CAPABILITY_LIST);
>         next_cap_ptr = (reg & 0x00ff);
> 
>         if (!next_cap_ptr)
>                 return 0;
> 
>         return __dw_pcie_ep_find_next_cap(pci, next_cap_ptr, cap); }
> 
> int dw_pcie_ep_init(struct dw_pcie_ep *ep) { [...]
>         ep->msi_cap = dw_pcie_ep_find_capability(pci, PCI_CAP_ID_MSI);
>         ep->msix_cap = dw_pcie_ep_find_capability(pci, PCI_CAP_ID_MSIX); [...]
> }
> 
> >
> > But do we really have to find the address like this? since all
> > designware IP's will have a particular capability at a fixed address
> > offset, why not follow use existing mechanism in dw_pcie_ep_get_msi?
> 
> The capabilities are not fixed to a specific address offset by default they
> assume those values, but they can be easily change at design stage.
> 
> >
> > Or is it possible for a particular capability to have address offsets
> > for different vendors? How is it for cadence?
> 
> Yes, it's possible to have different address offset for different vendors.
> 
For cadence the offsets are fixed for each specific hw (if a capability is 
disabled it will just be removed from the linked list) but it would be 
better to allow for the possibility for them to vary between different hw.

> >
> > Thanks
> > Kishon
> >
> 
> Thanks,
> Gustavo
Regards,
Alan
