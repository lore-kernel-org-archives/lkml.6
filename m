Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752427AbeEQQrH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 12:47:07 -0400
Received: from mail-by2nam01on0136.outbound.protection.outlook.com ([104.47.34.136]:17888
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752393AbeEQQrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 12:47:01 -0400
From: Hoan Tran <hoan.tran@amperecomputing.com>
To: Lee Jones <lee.jones@linaro.org>
CC: Phil Edworthy <phil.edworthy@renesas.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hoan Tran <hotran@apm.com>, Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] gpio: dwapb: Add support for 1 interrupt per port A
 GPIO
Thread-Topic: [PATCH v6] gpio: dwapb: Add support for 1 interrupt per port A
 GPIO
Thread-Index: AQHT6QKEeroxHiUlzUOz48IDYcRHwqQydbSAgAEH1wCAADhsAA==
Date: Thu, 17 May 2018 16:46:56 +0000
Message-ID: <AA01D623-B3ED-446C-B7C4-37856A185A4B@amperecomputing.com>
References: <1526027497-32556-1-git-send-email-phil.edworthy@renesas.com>
 <F70CFA9C-2059-432E-BFD3-3FA6CB618795@amperecomputing.com>
 <20180517062500.GJ5130@dell>
In-Reply-To: <20180517062500.GJ5130@dell>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hoan.tran@amperecomputing.com;
x-originating-ip: [4.28.13.142]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR0102MB3549;7:VnAUQ4OaBFGq4/eNec/ni56EDqmPjKyok671PfdVNik1LcYfOLL2Jfc7a+zESKpW6oW4ISWCnoSCpsVBO59hlOmHY18iNNhqsB3sO5KC34Tm4sVpUlF20B16IQRr+aFmOcAl4azeG5NsGQrp+qvu+wT/zJao95evGPPCviO95CwT/YLVYo5eIdwhS4lkCu72eQvT2fMw3lwrtlUIKNcJlrX254eexE6+QKINh9fJKn2dDyGIj7qWdRcvlcSHSadU
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN6PR0102MB3549;
x-ms-traffictypediagnostic: SN6PR0102MB3549:
x-microsoft-antispam-prvs: <SN6PR0102MB35496C12CA7DBF0595C94FE0E4910@SN6PR0102MB3549.prod.exchangelabs.com>
x-exchange-antispam-report-test: UriScan:(148322886591682)(81227570615382);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:SN6PR0102MB3549;BCL:0;PCL:0;RULEID:;SRVR:SN6PR0102MB3549;
x-forefront-prvs: 067553F396
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39840400004)(366004)(376002)(396003)(346002)(199004)(189003)(305945005)(105586002)(106356001)(229853002)(97736004)(86362001)(316002)(25786009)(33656002)(4326008)(26005)(45080400002)(99286004)(102836004)(36756003)(7736002)(76176011)(53546011)(186003)(82746002)(6506007)(2906002)(83716003)(5250100002)(3660700001)(68736007)(81166006)(81156014)(8676002)(3846002)(476003)(53936002)(14454004)(6486002)(5660300001)(6512007)(8936002)(66066001)(6916009)(2616005)(6436002)(7416002)(6246003)(478600001)(2900100001)(11346002)(6116002)(446003)(486006)(44832011)(3280700002)(39060400002)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR0102MB3549;H:SN6PR0102MB3550.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: SgtvB64ZgkVIXdg5upNdu1q08ZhdCINMsu+CbaXecPiy+3vJ5fYhkeOdXMDfJBFZ006c0S0cvGPFdnkOsMqXjNp8WUIOxwpYAgK+BXV4jaTV78bjDUZRTQ5IR0pWE4CkFFnntqNhY0XgwP29IuoAb0RigAsApW9mvHjVTIoVY55xpNQBj1XB4PmWSXi2gvyo
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DA4FC1A17BBE84EA2C437747D7171E6@prod.exchangelabs.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: f966b795-b015-4db0-4774-08d5bc15cd73
X-OriginatorOrg: amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f966b795-b015-4db0-4774-08d5bc15cd73
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2018 16:46:56.8762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR0102MB3549
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4HGlC3Q024419

Hi Lee,

﻿On 5/16/18, 11:25 PM, "Lee Jones" <lee.jones@linaro.org> wrote:

    On Wed, 16 May 2018, Hoan Tran wrote:
    
    > Hi Phil,
    > 
    > On 5/11/18, 1:31 AM, "Phil Edworthy" <phil.edworthy@renesas.com> wrote:
    > 
    >     The DesignWare GPIO IP can be configured for either 1 interrupt or 1
    >     per GPIO in port A, but the driver currently only supports 1 interrupt.
    >     See the DesignWare DW_apb_gpio Databook description of the
    >     'GPIO_INTR_IO' parameter.
    >     
    >     This change allows the driver to work with up to 32 interrupts, it will
    >     get as many interrupts as specified in the DT 'interrupts' property.
    >     It doesn't do anything clever with the different interrupts, it just calls
    >     the same handler used for single interrupt hardware.
    >     
    >     Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
    >     Reviewed-by: Rob Herring <robh@kernel.org>
    >     Acked-by: Lee Jones <lee.jones@linaro.org>
    >     ---
    >     One point to mention is that I have made it possible for users to have
    >     unconnected interrupts by specifying holes in the list of interrupts. This is
    >     done by supporting the interrupts-extended DT prop.
    >     However, I have no use for this and had to hack some test case for this.
    >     Perhaps the driver should support 1 interrupt or all GPIOa as interrupts?
    >     
    >     v6:
    >      - Treat DT and ACPI the same as much as possible. Note that we can't use
    >        platform_get_irq() to get the DT interrupts as they are in the port
    >        sub-node and hence do not have an associated platform device.
    >     v5:
    >      - Rolled ACPI companion code provided by Hoan Tran into this patch.
    >     v4:
    >      - Use of_irq_get() instead of of_irq_parse_one()+irq_create_of_mapping()
    >     v3:
    >      - Rolled mfd: intel_quark_i2c_gpio fix into this patch to avoid bisect problems
    >     v2:
    >      - Replaced interrupt-mask DT prop with support for the interrupts-extended
    >        prop. This means replacing the call to irq_of_parse_and_map() with calls
    >        to of_irq_parse_one() and irq_create_of_mapping().
    >     ---
    >      .../devicetree/bindings/gpio/snps-dwapb-gpio.txt   |  9 +++-
    >      drivers/gpio/gpio-dwapb.c                          | 49 +++++++++++++++-------
    >      drivers/mfd/intel_quark_i2c_gpio.c                 |  3 +-
    >      include/linux/platform_data/gpio-dwapb.h           |  3 +-
    >      4 files changed, 45 insertions(+), 19 deletions(-)
    >     
    >     diff --git a/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt b/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
    >     index 4a75da7..3c1118b 100644
    >     --- a/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
    >     +++ b/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
    >     @@ -26,8 +26,13 @@ controller.
    >        the second encodes the triger flags encoded as described in
    >        Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
    >      - interrupt-parent : The parent interrupt controller.
    >     -- interrupts : The interrupt to the parent controller raised when GPIOs
    >     -  generate the interrupts.
    >     +- interrupts : The interrupts to the parent controller raised when GPIOs
    >     +  generate the interrupts. If the controller provides one combined interrupt
    >     +  for all GPIOs, specify a single interrupt. If the controller provides one
    >     +  interrupt for each GPIO, provide a list of interrupts that correspond to each
    >     +  of the GPIO pins. When specifying multiple interrupts, if any are unconnected,
    >     +  use the interrupts-extended property to specify the interrupts and set the
    >     +  interrupt controller handle for unused interrupts to 0.
    >      - snps,nr-gpios : The number of pins in the port, a single cell.
    >      - resets : Reset line for the controller.
    >      
    > Acked-by: Hoan Tran <hoan.tran@amperecomputing.com>
    
    Well that's new.  I've never seen a mailer reply like that before.
    
    Which mailer are you using?  Might be worth sorting that out.

Yes, it looks like my new email from outlook does not have the correct format. With my old one, it works correctly.

Thanks
Hoan
    
    -- 
    Lee Jones [李琼斯]
    Linaro Services Technical Lead
    Linaro.org │ Open source software for ARM SoCs
    Follow Linaro: Facebook | Twitter | Blog
    
