Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031726AbeEZLPl (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 07:15:41 -0400
Received: from mail-ve1eur01on0040.outbound.protection.outlook.com ([104.47.1.40]:32480
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031606AbeEZLPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 07:15:39 -0400
From: Vadim Pasternak <vadimp@mellanox.com>
To: Darren Hart <dvhart@infradead.org>
CC: "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org"
        <platform-driver-x86@vger.kernel.org>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        Michael Shych <michaelsh@mellanox.com>,
        "ivecera@redhat.com" <ivecera@redhat.com>
Subject: RE: [PATCH v2 6/7] platform/mellanox: Introduce support for Mellanox
 register access driver
Thread-Topic: [PATCH v2 6/7] platform/mellanox: Introduce support for Mellanox
 register access driver
Thread-Index: AQHT5b9ckAeo7F7J+0CGY3sOu4IJ7aQ/s94AgAJFOaA=
Date: Sat, 26 May 2018 11:15:35 +0000
Message-ID: <HE1PR0502MB37530FE2CB64E415507244B1A2680@HE1PR0502MB3753.eurprd05.prod.outlook.com>
References: <1525675735-125547-1-git-send-email-vadimp@mellanox.com>
 <1525675735-125547-4-git-send-email-vadimp@mellanox.com>
 <20180525003112.GC10172@fury>
In-Reply-To: <20180525003112.GC10172@fury>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vadimp@mellanox.com;
x-originating-ip: [46.120.54.214]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0502MB2986;7:vQedTj8kG6gqeHJuTSya8J1JI5ej0Pp6nqDb9Q0XMXQ+g8oZSv00lNs5rROg3l0G1VeINlTuqTgOFUB86tWqVESzZ2M7ghurQGZX7nra6hHiq5N8ghMvcBPFEK2qbmQ6vXdfMF8jchEfdlt7OGMslPO0sT/uT3z2WrrIRxVCm9MYv7IldaN3PTnjIPc5U4Tdv/S/xMiY3ufrN5jJNi4ids5Ppzx8gUqudulXFGh6JD+n5bzCapg5K9XrZiXebC8G
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0502MB2986;
x-ms-traffictypediagnostic: HE1PR0502MB2986:
x-microsoft-antispam-prvs: <HE1PR0502MB29868D6996C13C82866950E4A2680@HE1PR0502MB2986.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959)(9452136761055)(85827821059158)(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0502MB2986;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0502MB2986;
x-forefront-prvs: 0684F80A5C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(39380400002)(376002)(366004)(396003)(13464003)(199004)(189003)(57704003)(2906002)(74316002)(6916009)(99286004)(105586002)(5250100002)(68736007)(106356001)(446003)(53936002)(6246003)(6506007)(186003)(53546011)(86362001)(102836004)(9686003)(478600001)(25786009)(26005)(55016002)(59450400001)(39060400002)(76176011)(486006)(7696005)(476003)(11346002)(14454004)(4326008)(97736004)(305945005)(7736002)(66066001)(3846002)(6116002)(81166006)(81156014)(3280700002)(3660700001)(229853002)(54906003)(33656002)(6436002)(316002)(2900100001)(8676002)(5660300001)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0502MB2986;H:HE1PR0502MB3753.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: r/0cWiBeIjxqzBM7NUZPSwjakvLeh0rkTBbIByJcvF48BHdOqfsIUtOxZTUWLABrWsw7Vi1PHK5yBR+SRROUnDkc5fdoCVFvmHl0VEPYdiYWlXMFVbbXYt366JK2SFLlFOCfFoXB3hs4BbenrvH+O5LpK02rq/TUKW86Bfh0Ex22bl3rAeebmTHG+7vuGEOE
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 0b573a33-2e99-496e-c98c-08d5c2fa00ca
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b573a33-2e99-496e-c98c-08d5c2fa00ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2018 11:15:35.2601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0502MB2986
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4QBFmEL006743



> -----Original Message-----
> From: Darren Hart [mailto:dvhart@infradead.org]
> Sent: Friday, May 25, 2018 3:31 AM
> To: Vadim Pasternak <vadimp@mellanox.com>
> Cc: andy.shevchenko@gmail.com; gregkh@linuxfoundation.org; linux-
> kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org; jiri@resnulli.us;
> Michael Shych <michaelsh@mellanox.com>; ivecera@redhat.com
> Subject: Re: [PATCH v2 6/7] platform/mellanox: Introduce support for Mellanox
> register access driver
> 
> On Mon, May 07, 2018 at 06:48:54AM +0000, Vadim Pasternak wrote:
> > Introduce new Mellanox platform driver to allow access to Mellanox
> > programmable device register space trough sysfs interface.
> > The driver purpose is to provide sysfs interface for user space for
> > the registers essential for system control and monitoring.
> > The sets of registers for sysfs access are supposed to be defined per
> > system type bases and include the registers related to system resets
> > operation, system reset causes monitoring and some kinds of mux selection.
> >
> > Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
> > ---
> 
> One question on the attr init which I'm not familiar with... Andy, Greg - can you
> offer your opinion below...
> 
> > +static int mlxreg_io_attr_init(struct mlxreg_io_priv_data *priv) {
> > +	int i;
> > +
> > +	priv->group.attrs = devm_kzalloc(&priv->pdev->dev,
> > +					 priv->pdata->counter *
> > +					 sizeof(struct attribute *),
> > +					 GFP_KERNEL);
> > +	if (!priv->group.attrs)
> > +		return -ENOMEM;
> > +
> > +	for (i = 0; i < priv->pdata->counter; i++) {
> > +		priv->mlxreg_io_attr[i] =
> > +				&priv->mlxreg_io_dev_attr[i].dev_attr.attr;
> > +
> > +		/* Set attribute name as a label. */
> > +		priv->mlxreg_io_attr[i]->name =
> > +				devm_kasprintf(&priv->pdev->dev,
> GFP_KERNEL,
> > +					       priv->pdata->data[i].label);
> > +
> > +		if (!priv->mlxreg_io_attr[i]->name) {
> > +			dev_err(&priv->pdev->dev, "Memory allocation failed
> for sysfs attribute %d.\n",
> > +				i + 1);
> > +			return -ENOMEM;
> > +		}
> > +
> > +		priv->mlxreg_io_dev_attr[i].dev_attr.attr.mode =
> > +						priv->pdata->data[i].mode;
> > +		switch (priv->pdata->data[i].mode) {
> 
> This seemed a bit odd to me. Do we need to do this conditional assignment
> within the kernel, or can these just be assigned, and the mode will guard against
> the user being able to call store on a read only attr?
> 
> > +		case 0200:
> > +			priv->mlxreg_io_dev_attr[i].dev_attr.store =
> > +							mlxreg_io_attr_store;
> > +			break;
> > +
> > +		case 0444:
> > +			priv->mlxreg_io_dev_attr[i].dev_attr.show =
> > +							mlxreg_io_attr_show;
> > +			break;
> > +
> > +		case 0644:
> > +			priv->mlxreg_io_dev_attr[i].dev_attr.show =
> > +							mlxreg_io_attr_show;
> > +			priv->mlxreg_io_dev_attr[i].dev_attr.store =
> > +							mlxreg_io_attr_store;
> > +			break;
> 
> If this is necessary, we can simplify this by checking for the read mask and the
> write mask and setting each once - rather than duplicating this for r, w, and rw.
> As it is a 0400 would not assign the show function, even though it is readable by
> somebody.

Maybe I really can add something like
static struct device_attribute mlxreg_io_devattr_rw = {
	.show	= mlxreg_io_attr_show,
	.store	= mlxreg_io_attr_store,
};

And replace this whole switch statement just with:
		memcpy(&priv->mlxreg_io_dev_attr[i].dev_attr,
		       &mlxreg_io_devattr_rw, sizeof(struct device_attribute));
> 
> --
> Darren Hart
> VMware Open Source Technology Center
