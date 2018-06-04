Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752283AbeFDJLc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 05:11:32 -0400
Received: from mail-sn1nam01on0089.outbound.protection.outlook.com ([104.47.32.89]:58496
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750866AbeFDJL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 05:11:28 -0400
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
Subject: Re: [PATCH v4 01/10] i3c: Add core I3C infrastructure
Thread-Topic: [PATCH v4 01/10] i3c: Add core I3C infrastructure
Thread-Index: AQHT+9YfX6KvIA2jCkquNeLryIvG+6RP8d0A
Date: Mon, 4 Jun 2018 09:11:25 +0000
Message-ID: <EFF070CA-9C6C-4E9C-9CEF-45AAD02745BB@cadence.com>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
 <20180330074751.25987-2-boris.brezillon@bootlin.com>
In-Reply-To: <20180330074751.25987-2-boris.brezillon@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pgaj@cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR07MB4331;7:N5dX6Wm8zzhrxPSPt0WSC0cFxz8Xv4DT2X5cr2AYtCIo3XqARYvWfIOh2o7WZgIgA6dOhQz0mcWM0Rjg1+bEJU2UkTOWuPh7oV5dVnOUWcMWk5PUvQ39MzuM5XRRYKaNVR2NnjPo2y7siEpnjZfAa4j37fFQuDM0U2t/D5k7DvVQiDchF8mDfWBErLByFzP39ebBzWVmytvjd7aQ4ZoB8+0C0orM7ETSqrnNOgNiIQwugd8RbLfQnLSxh166M3LW;20:gPJcBD7vENkR4MkIjvdJsK1Oc9H93nu1Kia9fBMZFCTY36JKxuQRpoEwul38M3cMle9IulV3lwbnrlV+dAR5t9mE+CaHY+RFO2bA4olk8yx8WzvrVsmwq3EeRE5t0jAGmimvrp70t5dyLnKaa4dBPbNfjpAMo+Yc5c3ClFlE5i2X9fkmtyh4ccpaqNIsjfPqERdzUd1vl9+kvaBYVQJPraaMgkL0p8xnPwV2Z0+K7MgTyuNJBV4eCpAEW4fFmEPc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM6PR07MB4331;
x-ms-traffictypediagnostic: DM6PR07MB4331:
x-microsoft-antispam-prvs: <DM6PR07MB43311BBAD9DC98165075E4A9C2670@DM6PR07MB4331.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM6PR07MB4331;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB4331;
x-forefront-prvs: 069373DFB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(39860400002)(366004)(346002)(376002)(36092001)(189003)(199004)(6436002)(2501003)(82746002)(106356001)(2900100001)(486006)(83716003)(11346002)(446003)(2616005)(6116002)(6512007)(476003)(229853002)(86362001)(97736004)(53936002)(6486002)(105586002)(478600001)(66066001)(5250100002)(54906003)(8936002)(36756003)(26005)(33656002)(4326008)(7416002)(316002)(110136005)(3280700002)(68736007)(76176011)(102836004)(3846002)(6246003)(59450400001)(25786009)(6506007)(2906002)(7736002)(81166006)(305945005)(99286004)(5660300001)(3660700001)(81156014)(186003)(14454004)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4331;H:DM6PR07MB4812.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: pKACji52dwaN0tgE3azob0vcFq8e4KXJUVuBRMKRDszqogwC6ezHjIU/IxdC7qQojxz15jOeAjw8UzPuUU6t82EFePqOr3y2PdXjnlXle7LecCIR2aUS8Mp/AO9IeitcwIEcJdXnNBm9sY+O7yup8X4nvn6fCb14h+yagIcDEqG+vldt8QyQxPT+gWmlFaG6wryV5F/VXrje1H+CGSiMyQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7577811D7F90ED4B9CA00C0F091F817C@namprd07.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: cd68812a-f9d2-4ffc-2555-08d5c9fb2649
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd68812a-f9d2-4ffc-2555-08d5c9fb2649
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 09:11:25.7220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4331
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w549Bccd032397

Hi Boris

It looks great, just one comment to DEFSLVS command:

﻿On 6/4/18, 9:32 AM, "Boris Brezillon" <boris.brezillon@bootlin.com> wrote:

    +int i3c_master_defslvs_locked(struct i3c_master_controller *master)
    +{
    +	struct i3c_ccc_cmd_dest dest = {
    +		.addr = I3C_BROADCAST_ADDR,
    +	};
    +	struct i3c_ccc_cmd cmd = {
    +		.id = I3C_CCC_DEFSLVS,
    +		.dests = &dest,
    +		.ndests = 1,
    +	};
    +	struct i3c_ccc_defslvs *defslvs;
    +	struct i3c_ccc_dev_desc *desc;
    +	struct i3c_device *i3cdev;
    +	struct i2c_device *i2cdev;
    +	struct i3c_bus *bus;
    +	bool send = false;
    +	int ndevs = 0, ret;
    +
    +	if (!master)
    +		return -EINVAL;
    +
    +	bus = i3c_master_get_bus(master);
    +	i3c_bus_for_each_i3cdev(bus, i3cdev) {
    +		ndevs++;
    +		if (I3C_BCR_DEVICE_ROLE(i3cdev->info.bcr) == I3C_BCR_I3C_MASTER)
    +			send = true;
    +	}
    +
    +	/* No other master on the bus, skip DEFSLVS. */
    +	if (!send)
    +		return 0;
    +
    +	i3c_bus_for_each_i2cdev(bus, i2cdev)
    +		ndevs++;
    +
    +	dest.payload.len = sizeof(*defslvs) +
    +			   ((ndevs - 1) * sizeof(struct i3c_ccc_dev_desc));
    +	defslvs = kzalloc(dest.payload.len, GFP_KERNEL);
    +	if (!defslvs)
    +		return -ENOMEM;
    +
    +	dest.payload.data = defslvs;
    +
    +	defslvs->count = ndevs;
    +	defslvs->master.bcr = master->this->info.bcr;
    +	defslvs->master.dcr = master->this->info.dcr;
    +	defslvs->master.dyn_addr = master->this->info.dyn_addr;
    +	defslvs->master.static_addr = I3C_BROADCAST_ADDR;
    +
    +	desc = defslvs->slaves;
    +	i3c_bus_for_each_i2cdev(bus, i2cdev) {
    +		desc->lvr = i2cdev->lvr;
    +		desc->static_addr = i2cdev->info.addr;
    +		desc++;
    +	}
    +
    +	i3c_bus_for_each_i3cdev(bus, i3cdev) {
    +		/* Skip the I3C dev representing this master. */
    +		if (i3cdev == master->this)
    +			continue;
    +
    +		desc->bcr = i3cdev->info.bcr;
    +		desc->dcr = i3cdev->info.dcr;
    +		desc->dyn_addr = i3cdev->info.dyn_addr;
    +		desc->static_addr = i3cdev->info.static_addr;
    +		desc++;
    +	}
    +
    +	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
    +	kfree(defslvs);
    +
    +	return ret;
    +}

You should shift all the addresses (dynamic and static) one bit left. 
Addresses are stored on bits [7:1], this is described in MIPI spec, 
section 5.1.9.3.7 Define List of Slaves (DEFSLVS)

Regards,
Przemyslaw Gaj
