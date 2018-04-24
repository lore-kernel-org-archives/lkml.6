Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756161AbeDXG77 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 02:59:59 -0400
Received: from mail-cys01nam02on0043.outbound.protection.outlook.com ([104.47.37.43]:41952
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755907AbeDXG7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 02:59:55 -0400
From: Alan Douglas <adouglas@cadence.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "niklas.cassel@axis.com" <niklas.cassel@axis.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC 06/10] misc: pci_endpoint_test: Add MSI-X support
Thread-Topic: [RFC 06/10] misc: pci_endpoint_test: Add MSI-X support
Thread-Index: AQHT0O91oylEOOENyECmUNt3OwL/tKQPj2pA
Date: Tue, 24 Apr 2018 06:59:51 +0000
Message-ID: <SN6PR07MB45121288F5ACECF3AB3A6D0AD8880@SN6PR07MB4512.namprd07.prod.outlook.com>
References: <cover.1523379766.git.gustavo.pimentel@synopsys.com>
 <8b88f8c2b766f36c71659deb0fce635154b2b39f.1523379766.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <8b88f8c2b766f36c71659deb0fce635154b2b39f.1523379766.git.gustavo.pimentel@synopsys.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYWRvdWdsYXNcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy0xNTU5ODYyZS00NzhkLTExZTgtODZlNS1mNDk2MzQ4NmY0ZWNcYW1lLXRlc3RcMTU1OTg2MmYtNDc4ZC0xMWU4LTg2ZTUtZjQ5NjM0ODZmNGVjYm9keS50eHQiIHN6PSI1ODE0IiB0PSIxMzE2OTAyNjc5MTkzNDAwMDciIGg9ImFyb2JMQkx1N3lNaGlwZ2R4TENkN0VBVmo0az0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=adouglas@cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR07MB4704;7:/ZIVYlx8zidhEsjmdCD9euwO7y5+D4GlBxGz8Y2P5GUjY+4ANDMFj6jwIZf3Q6pqiAuqlxLPVoEx97QtaCm1856OGd4dJ9GqA+2bIiqd3sr8zNLqyEmx46lXFym+7UPl1pYIxdhbyT2xeczhSWvHN+23XfSMUsQ/hwxbm1MtjkW0sCymvL4qZS8+1NFosnnbvTGZXfluXdMoUMj0vIWrQbhJQcFbST8zl9aezOvoM2sdemysCBx90ToSWoOgiC0X;20:0SsFb4Ol9Tw8dYi6nbGYEyk2To7oY+0P6XG9dYQBoP32WtsZUSGmc+H1A1yCv3IqzMdYa2zUUa85y+IGi9mC+iqxrHFRFgzcO9+wEYeqim2j2l4u0BrHgQ0WFgPXs3sLIXEhp78f6SRii88yclp6I4AQy520kC45bxOObdyX4p8+zXzwbFeG4kDXr6Aod2aen31L6EzY2n903jLDazKPKLy+Z8ussR0xIclF9OrWMLSiRStrqEyx+f+fh0xd48ry
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4704;
x-ms-traffictypediagnostic: SN6PR07MB4704:
x-microsoft-antispam-prvs: <SN6PR07MB470452584C56E25047663FBFD8880@SN6PR07MB4704.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231232)(944501410)(52105095)(10201501046)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:SN6PR07MB4704;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4704;
x-forefront-prvs: 0652EA5565
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(346002)(39380400002)(396003)(36092001)(305945005)(66066001)(3280700002)(4326008)(7696005)(81166006)(7736002)(99286004)(7416002)(476003)(6116002)(575784001)(2201001)(11346002)(5250100002)(86362001)(5660300001)(2906002)(53546011)(26005)(446003)(59450400001)(3660700001)(74316002)(102836004)(76176011)(229853002)(9686003)(110136005)(54906003)(2900100001)(6506007)(55016002)(6246003)(39060400002)(8936002)(33656002)(14454004)(6436002)(316002)(3846002)(25786009)(2501003)(478600001)(53936002)(186003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4704;H:SN6PR07MB4512.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
x-microsoft-antispam-message-info: jxeszwUm6PdQRzbgW6sKuNNJEZgol5MXPxLTQUV636/BdEoHYzrqEgHeEMCnQHBWZbaQlh8pRMy/8StpubzVG9kyJk6tvwmPZiarvB1cqXr4TeyzloxWbiaapmi+8fmQxCihpEldrFsQXVeEfbAkPPVUb0TQBwK3EEH1EaVWz8HEDRTg9WtFf2rbKKAaPE6shgsQMjcc4OkkecRYL0uXwQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 14a8f9c2-8146-41b5-066c-08d5a9b0fa42
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a8f9c2-8146-41b5-066c-08d5a9b0fa42
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2018 06:59:51.9824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4704
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3O704Sj012679

Hi Gustavo,

On 10 April 2018 18:15 Gustavo Pimentel wrote:
> 
> Adds the MSI-X support and updates driver documentation accordingly.
> 
> Changes the driver parameter in order to allow the interruption type
> selection.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  Documentation/misc-devices/pci-endpoint-test.txt |   3 +
>  drivers/misc/pci_endpoint_test.c                 | 102 +++++++++++++++++------
>  2 files changed, 79 insertions(+), 26 deletions(-)
> 
> diff --git a/Documentation/misc-devices/pci-endpoint-test.txt
> b/Documentation/misc-devices/pci-endpoint-test.txt
> index 4ebc359..fdfa0f6 100644
> --- a/Documentation/misc-devices/pci-endpoint-test.txt
> +++ b/Documentation/misc-devices/pci-endpoint-test.txt
> @@ -10,6 +10,7 @@ The PCI driver for the test device performs the
> following tests
>  	*) verifying addresses programmed in BAR
>  	*) raise legacy IRQ
>  	*) raise MSI IRQ
> +	*) raise MSI-X IRQ
>  	*) read data
>  	*) write data
>  	*) copy data
> @@ -25,6 +26,8 @@ ioctl
>   PCITEST_LEGACY_IRQ: Tests legacy IRQ
>   PCITEST_MSI: Tests message signalled interrupts. The MSI number
>  	      to be tested should be passed as argument.
> + PCITEST_MSIX: Tests message signalled interrupts. The MSI-X number
> +	      to be tested should be passed as argument.
>   PCITEST_WRITE: Perform write tests. The size of the buffer should be passed
>  		as argument.
>   PCITEST_READ: Perform read tests. The size of the buffer should be passed
> diff --git a/drivers/misc/pci_endpoint_test.c
> b/drivers/misc/pci_endpoint_test.c
> index 37db0fc..a7d9354 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -42,11 +42,16 @@
>  #define PCI_ENDPOINT_TEST_COMMAND	0x4
>  #define COMMAND_RAISE_LEGACY_IRQ	BIT(0)
>  #define COMMAND_RAISE_MSI_IRQ		BIT(1)
> -#define MSI_NUMBER_SHIFT		2
> -/* 6 bits for MSI number */
> -#define COMMAND_READ                    BIT(8)
> -#define COMMAND_WRITE                   BIT(9)
> -#define COMMAND_COPY                    BIT(10)
> +#define COMMAND_RAISE_MSIX_IRQ		BIT(2)
> +#define IRQ_TYPE_SHIFT			3
> +#define IRQ_TYPE_LEGACY			0
> +#define IRQ_TYPE_MSI			1
> +#define IRQ_TYPE_MSIX			2
> +#define MSI_NUMBER_SHIFT		5
> +/* 12 bits for MSI number */
> +#define COMMAND_READ                    BIT(17)
> +#define COMMAND_WRITE                   BIT(18)
> +#define COMMAND_COPY                    BIT(19)
> 
>  #define PCI_ENDPOINT_TEST_STATUS	0x8
>  #define STATUS_READ_SUCCESS             BIT(0)
> @@ -73,9 +78,9 @@ static DEFINE_IDA(pci_endpoint_test_ida);
>  #define to_endpoint_test(priv) container_of((priv), struct pci_endpoint_test,
> \
>  					    miscdev)
> 
> -static bool no_msi;
> -module_param(no_msi, bool, 0444);
> -MODULE_PARM_DESC(no_msi, "Disable MSI interrupt in
> pci_endpoint_test");
> +static int irq_type = IRQ_TYPE_MSIX;
> +module_param(irq_type, int, 0444);
> +MODULE_PARM_DESC(irq_type, "IRQ mode selection in pci_endpoint_test
> (0
> +- Legacy, 1 - MSI, 2 - MSI-X)");
> 
>  enum pci_barno {
>  	BAR_0,
> @@ -103,7 +108,7 @@ struct pci_endpoint_test {  struct
> pci_endpoint_test_data {
>  	enum pci_barno test_reg_bar;
>  	size_t alignment;
> -	bool no_msi;
> +	int irq_type;
>  };
> 
>  static inline u32 pci_endpoint_test_readl(struct pci_endpoint_test *test,
> @@ -177,10 +182,10 @@ static bool pci_endpoint_test_bar(struct
> pci_endpoint_test *test,
> 
>  static bool pci_endpoint_test_legacy_irq(struct pci_endpoint_test *test)  {
> -	u32 val;
> +	u32 val = COMMAND_RAISE_LEGACY_IRQ;
> 
> -	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
> -				 COMMAND_RAISE_LEGACY_IRQ);
> +	val |= (IRQ_TYPE_LEGACY << IRQ_TYPE_SHIFT);
> +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND, val);
>  	val = wait_for_completion_timeout(&test->irq_raised,
>  					  msecs_to_jiffies(1000));
>  	if (!val)
> @@ -192,12 +197,12 @@ static bool pci_endpoint_test_legacy_irq(struct
> pci_endpoint_test *test)  static bool pci_endpoint_test_msi_irq(struct
> pci_endpoint_test *test,
>  				      u8 msi_num)
>  {
> -	u32 val;
> +	u32 val = COMMAND_RAISE_MSI_IRQ;
>  	struct pci_dev *pdev = test->pdev;
> 
> -	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
> -				 msi_num << MSI_NUMBER_SHIFT |
> -				 COMMAND_RAISE_MSI_IRQ);
> +	val |= (msi_num << MSI_NUMBER_SHIFT);
> +	val |= (IRQ_TYPE_MSI << IRQ_TYPE_SHIFT);
> +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND, val);
>  	val = wait_for_completion_timeout(&test->irq_raised,
>  					  msecs_to_jiffies(1000));
>  	if (!val)
> @@ -209,6 +214,26 @@ static bool pci_endpoint_test_msi_irq(struct
> pci_endpoint_test *test,
>  	return false;
>  }
> 
> +static bool pci_endpoint_test_msix_irq(struct pci_endpoint_test *test,
> +				       u16 msix_num)
> +{
> +	u32 val = COMMAND_RAISE_MSIX_IRQ;
> +	struct pci_dev *pdev = test->pdev;
> +
> +	val |= (msix_num << MSI_NUMBER_SHIFT);
> +	val |= (IRQ_TYPE_MSIX << IRQ_TYPE_SHIFT);
> +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND, val);
> +	val = wait_for_completion_timeout(&test->irq_raised,
> +					  msecs_to_jiffies(1000));
> +	if (!val)
> +		return false;
> +
> +	if (test->last_irq - pdev->irq == msix_num - 1)
> +		return true;
I think we should use pci_irq_vector() to convert from device vector to Linux IRQ.
It can be done in pci_endpoint_test_irqhandler()
(With MSI, pdev->irq will be updated during MSI init, but it is not for MSI-X.)

pci_irq_vector()  should also be used for devm_request_irq() and devm_free_irq()
so some changes required in probe and remove.

Regards,
Alan
