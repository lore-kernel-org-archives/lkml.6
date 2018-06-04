Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751978AbeFDJY7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 05:24:59 -0400
Received: from mail-cys01nam02on0045.outbound.protection.outlook.com ([104.47.37.45]:59776
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750886AbeFDJYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 05:24:55 -0400
From: Przemyslaw Gaj <pgaj@cadence.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
CC: Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v4 07/10] i3c: master: Add driver for Cadence IP
Thread-Topic: [PATCH v4 07/10] i3c: master: Add driver for Cadence IP
Thread-Index: AQHT+9X8HfEKG84YRkiSh33u/KQANqRP9aCA
Date: Mon, 4 Jun 2018 09:24:51 +0000
Message-ID: <9613475C-ECAE-4AD6-9C02-55C9214A6489@cadence.com>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
 <20180330074751.25987-8-boris.brezillon@bootlin.com>
In-Reply-To: <20180330074751.25987-8-boris.brezillon@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pgaj@cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR07MB4955;7:TBQwYOn3IF5jpEna77VMTwhkp0jYOvdEszRR1dybQbflUlrQoRBhvmuhWj/YLlVtLGpE8VyMhhXNamxZsVDjXp3at5zSExQubyLWgq+DrwkxJJd44hEhsYXDqRI7/evHdRvbO5lW1e6e2ffwType0blJWbh8bXHpARtMqBqKBEe3M25Rh3hEBZ2dO15/lDW/ZhAGOxNfFLKDAPco5X4jrRlZhVxgqYQ1RrUqSo+9Z2f2XmDiKHfEuWhNi9R6PAvM;20:DNHY9RDJ1i/8fN4OlscWfWSlENyxubGd70f7PNqkMYOoyx8wU3qeYyRTJME4gd38LI87HdgdJ2mEJLfUtdLtYWM5dI0T7Xc1Me0OPx02SufG0lWSCt3i5jO3onkthI0sMyg9Xuv2DgmXrzuSeW4SjY00GjPWIJV1onIvDh9cUgr4E7uut/mTaaZQtlQWBp19PYm3YwncVgfRf4Z8F8bm4JLNnYPxI77h4MkSu405VJ1YTkWyvxUltcTOlZiPzTap
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM6PR07MB4955;
x-ms-traffictypediagnostic: DM6PR07MB4955:
x-microsoft-antispam-prvs: <DM6PR07MB49552483D76C6B48B6792531C2670@DM6PR07MB4955.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DM6PR07MB4955;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB4955;
x-forefront-prvs: 069373DFB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39380400002)(39860400002)(366004)(396003)(36092001)(189003)(199004)(8936002)(6116002)(3846002)(106356001)(59450400001)(105586002)(6246003)(6506007)(53936002)(5660300001)(316002)(186003)(110136005)(33656002)(7416002)(26005)(305945005)(6512007)(102836004)(54906003)(14454004)(99286004)(2900100001)(6436002)(7736002)(4326008)(25786009)(229853002)(36756003)(76176011)(478600001)(68736007)(6486002)(476003)(11346002)(2501003)(82746002)(5250100002)(2616005)(446003)(8676002)(486006)(81156014)(66066001)(3660700001)(83716003)(97736004)(86362001)(2906002)(3280700002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4955;H:DM6PR07MB4812.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 2TDqxQaoArTq2hLsangeViIu1T1Xsqs1rDffHNoFoL3uVozQSiZcE+7csWTqltWUAQP5SHB0uyhP9tUJ5Xl2hRFLjC6X4nE/0Vx1yWiO7APFRg8vX8Fh2v6yKOHgrhgV2z7FUt5s4KSBQ7N4pzlpLnVXdqmLzHTTyXL4Pwd5iGmnVwpFe5YaydfjQQTzdZWneKWE50ublZWuSpPkHDPwmg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <18ED8795B9B6864F89C11CA99D8CF0B5@namprd07.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 8ec3b1bd-53c6-40a3-f05b-08d5c9fd0689
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec3b1bd-53c6-40a3-f05b-08d5c9fd0689
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 09:24:51.4686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4955
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w549P580032515

Hi Boris,

Few things regarding Cadence IP driver:

﻿On 6/4/18, 9:31 AM, "Boris Brezillon" <boris.brezillon@bootlin.com> wrote:

    +static void cdns_i3c_master_handle_ibi(struct cdns_i3c_master *master,
    +				       u32 ibir)
    +{
    +	struct cdns_i3c_i2c_dev_data *data;
    +	bool data_consumed = false;
    +	struct i3c_ibi_slot *slot;
    +	u32 id = IBIR_SLVID(ibir);
    +	struct i3c_device *dev;
    +	int len, i, j;
    +	u8 *buf;
    +
    +	/*
    +	 * FIXME: maybe we should report the FIFO OVF errors to the upper
    +	 * layer.
    +	 */
    +	if (id >= master->ibi.num_slots || (ibir & IBIR_ERROR))
    +		goto out;
    +
    +	dev = master->ibi.slots[id];
    +	spin_lock(&master->ibi.lock);
    +
    +	data = i3c_device_get_master_data(dev);
    +	slot = i3c_generic_ibi_get_free_slot(data->ibi_pool);
    +	if (!slot)
    +		goto out_unlock;
    +
    +	buf = slot->data;
    +
    +	len = IBIR_XFER_BYTES(ibir);
    +	for (i = 0; i < IBIR_XFER_BYTES(ibir); i += 4) {
    +		u32 tmp = readl(master->regs + IBI_DATA_FIFO);
    +
    +		for (j = 0; j < 4 && i + j < dev->ibi->max_payload_len; j++)
    +			buf[i + j] = tmp >> (j * 8);
    +
    +	}
    +	slot->len = min_t(unsigned int, IBIR_XFER_BYTES(ibir),
    +			  dev->ibi->max_payload_len);
    +	i3c_master_queue_ibi(dev, slot);
    +	data_consumed = true;
    +
    +out_unlock:
    +	spin_unlock(&master->ibi.lock);
    +
    +out:
    +	/* Consume data from the FIFO if it's not been done already. */
    +	if (!data_consumed) {
    +		for (i = 0; i < IBIR_XFER_BYTES(ibir); i += 4)
    +			readl(master->regs + IBI_DATA_FIFO);
    +	}
    +}
    
len variable is unneeded.

    +static int cdns_i3c_master_probe(struct platform_device *pdev)
    +{
    +	struct cdns_i3c_master *master;
    +	struct resource *res;
    +	int ret, irq;
    +	u32 val;
    +
    +	master = devm_kzalloc(&pdev->dev, sizeof(*master), GFP_KERNEL);
    +	if (!master)
    +		return -ENOMEM;
    +
    +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
    +	master->regs = devm_ioremap_resource(&pdev->dev, res);
    +	if (IS_ERR(master->regs))
    +		return PTR_ERR(master->regs);
    +
    +	master->pclk = devm_clk_get(&pdev->dev, "pclk");
    +	if (IS_ERR(master->pclk))
    +		return PTR_ERR(master->pclk);
    +
    +	master->sysclk = devm_clk_get(&pdev->dev, "sysclk");
    +	if (IS_ERR(master->pclk))
    +		return PTR_ERR(master->pclk);
    +
    +	irq = platform_get_irq(pdev, 0);
    +	if (irq < 0)
    +		return irq;
    +
    +	ret = clk_prepare_enable(master->pclk);
    +	if (ret)
    +		return ret;
    +
    +	ret = clk_prepare_enable(master->sysclk);
    +	if (ret)
    +		goto err_disable_pclk;
    +
    +	if (readl(master->regs + DEV_ID) != DEV_ID_I3C_MASTER) {
    +		ret = -EINVAL;
    +		goto err_disable_sysclk;
    +	}
    +
    +	spin_lock_init(&master->xferqueue.lock);
    +	INIT_LIST_HEAD(&master->xferqueue.list);
    +
    +	INIT_WORK(&master->hj_work, cdns_i3c_master_hj);
    +	writel(0xffffffff, master->regs + MST_IDR);
    +	writel(0xffffffff, master->regs + SLV_IDR);
    +	ret = devm_request_irq(&pdev->dev, irq, cdns_i3c_master_interrupt, 0,
    +			       dev_name(&pdev->dev), master);
    +	if (ret)
    +		goto err_disable_sysclk;
    +
    +	platform_set_drvdata(pdev, master);
    +
    +	val = readl(master->regs + CONF_STATUS0);
    +
    +	/* Device ID0 is reserved to describe this master. */
    +	master->maxdevs = CONF_STATUS0_DEVS_NUM(val);
    +	master->free_rr_slots = GENMASK(master->maxdevs, 1);
    +
    +	val = readl(master->regs + CONF_STATUS1);
    +	master->caps.cmdfifodepth = CONF_STATUS1_CMD_DEPTH(val);
    +	master->caps.rxfifodepth = CONF_STATUS1_RX_DEPTH(val);
    +	master->caps.txfifodepth = CONF_STATUS1_TX_DEPTH(val);
    +	master->caps.ibirfifodepth = 16;

IBI fifo depth is hardcoded. You can read this value from CONF_STATUS0 register.

    +	master->caps.cmdrfifodepth = 16;

CMDR fifo depth is hardcoded. You can read this value from CONF_STATUS0 register also.

    +
    +	spin_lock_init(&master->ibi.lock);
    +	master->ibi.num_slots = CONF_STATUS1_IBI_HW_RES(val);
    +	master->ibi.slots = devm_kzalloc(&pdev->dev,
    +					 sizeof(*master->ibi.slots) *
    +					 master->ibi.num_slots,
    +					 GFP_KERNEL);
    +	if (!master->ibi.slots)
    +		goto err_disable_sysclk;
    +
    +	writel(IBIR_THR(1), master->regs + CMD_IBI_THR_CTRL);
    +	writel(MST_INT_IBIR_THR, master->regs + MST_IER);
    +	writel(DEVS_CTRL_DEV_CLR_ALL, master->regs + DEVS_CTRL);
    +
    +	ret = i3c_master_register(&master->base, &pdev->dev,
    +				  &cdns_i3c_master_ops, false);
    +	if (ret)
    +		goto err_disable_sysclk;
    +
    +	return 0;
    +
    +err_disable_sysclk:
    +	clk_disable_unprepare(master->sysclk);
    +
    +err_disable_pclk:
    +	clk_disable_unprepare(master->pclk);
    +
    +	return ret;
    +}
    
Regards,
Przemyslaw Gaj
