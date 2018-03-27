Return-Path: <roy.pledge@nxp.com>
X-Google-Smtp-Source: AG47ELuLjPOezpHxQS4piWf2x8c2PNsjZY7F8FnVyA9DWtgsssQYQL/5GMOVJ2FTFluOzapLLKjE
ARC-Seal: i=1; a=rsa-sha256; t=1522156791; cv=none;
        d=google.com; s=arc-20160816;
        b=Y9lRQClh8y1rU+vlvIbxYk+n0PN/pE8t6StVVViKr97dtt961GIYDlcf9l5N0PW87x
         UUb3KYPp9afF9yLd3k8xywrbbRiHayRDb/NFDt7TsWJAoGooyqXHN6YquIoAtsdA005h
         pRqpV6XdozcY0mCDVjwvQQfKxoIPNd+APA1l0DQkPf8VK9wROWmbCgt6aNI2ZMMzh+Nn
         nXZ1fOdS9bTzgAbiKrmhNOBxcvBf9Zn+O9OZ6fx8NxWfVLe9LQdHZ8/pOIwPfodb6TBS
         seonx+ZtUaVNVSB1/x+ggjq4wlfEcLecIdklABHuIh2kK5fWVKGCcBD8QMrX3vRakYiP
         GHGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:references
         :message-id:date:thread-index:thread-topic:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=4W2EY/fXJIxw8EiJ/0BeC7TyDz+CpcWhfREbi+C3SOY=;
        b=Q0Wu6ltp/4c7iwVEjpicNrQeGBfHYs4PxJUD9UbJt7KiVXz+vzFGKDg4LBeU/J8ldy
         dF6m87qjF86sLYr+s36tq2wUZuNmPewMc+8dGn2fY/hbPepeje41Ejqf1LKA0nNCp87s
         fox4PIU6jFja2HHwdVh3zkWdMFTkCq5tp8gOgwuKq3GjlbTPjKkDTaCzk0GrGQF23MEn
         Rs77QN3nzz0xNLgPo/tWYt/7DzMjR/I4tNK0T2k4E8O3XQuDau2IEzAKhDNqJKxb6l9q
         4sqtwuQ7QWxltODnms2X8Ia1nCfmj6zCF2KxdN76pV+MOVAf4DEPkf73Cm98W6D3H5CT
         /1gw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=UhL/WGrv;
       spf=pass (google.com: domain of roy.pledge@nxp.com designates 40.107.3.43 as permitted sender) smtp.mailfrom=roy.pledge@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=UhL/WGrv;
       spf=pass (google.com: domain of roy.pledge@nxp.com designates 40.107.3.43 as permitted sender) smtp.mailfrom=roy.pledge@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Roy Pledge <roy.pledge@nxp.com>
To: Robin Murphy <robin.murphy@arm.com>, "devel@driverdev.osuosl.org"
	<devel@driverdev.osuosl.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
CC: Ruxandra Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, =?iso-8859-2?Q?Horia_Geant=E3?=
	<horia.geanta@nxp.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Leo Li <leoyang.li@nxp.com>,
	"stuyoder@gmail.com" <stuyoder@gmail.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [PATCH v3 2/4] drivers/staging/fsl-mc: Fix DPIO error path issues
Thread-Topic: [PATCH v3 2/4] drivers/staging/fsl-mc: Fix DPIO error path
 issues
Thread-Index: AQHTxTV7QTuW6ZX0tUiE2xLwpXsWdQ==
Date: Tue, 27 Mar 2018 13:19:48 +0000
Message-ID: <DB6PR04MB2999389243117938BCBA141686AC0@DB6PR04MB2999.eurprd04.prod.outlook.com>
References: <1522091134-24646-1-git-send-email-roy.pledge@nxp.com>
 <1522091134-24646-3-git-send-email-roy.pledge@nxp.com>
 <5e91615b-b2b4-4fe3-4d25-1ae56624976b@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com;
x-originating-ip: [192.88.168.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR04MB2965;7:Qrkbz/T8RpXOLJm4nl8AFllt7rC/X5orNDUKaqa+3YwGRxDFoB4cspQKpOQMWAwCqGK1JUru4haSmG+N+OC7WkjkWxIwI8RaFtBLmBHYeFHMBILujeFZpdc0CCYQmndU/mEoSil2dRgZAwrm98x6d4BvDK7yEwP+FmX2okioZGmNBSl6XEt6/cg8wbctKVLshM0VPKlV37mS06GkW2kgax+B218042J6rFEhredgxPVLHFh4VQ1/a+Rt0yd2afuR
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 933baa8a-5420-44a7-5add-08d593e56aad
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB2965;
x-ms-traffictypediagnostic: DB6PR04MB2965:
x-microsoft-antispam-prvs: <DB6PR04MB2965631028378157F0480DCB86AC0@DB6PR04MB2965.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197)(275809806118684);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DB6PR04MB2965;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB2965;
x-forefront-prvs: 0624A2429E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39380400002)(39860400002)(366004)(199004)(51914003)(189003)(3846002)(186003)(33656002)(26005)(2501003)(3280700002)(2900100001)(106356001)(66066001)(76176011)(6116002)(81156014)(8676002)(8936002)(486005)(486005)(59450400001)(476003)(7736002)(9686003)(6506007)(53546011)(55016002)(2906002)(102836004)(81166006)(5250100002)(229853002)(305945005)(74316002)(25786009)(478600001)(110136005)(4326008)(99286004)(105586002)(5660300001)(14454004)(446003)(53936002)(6246003)(97736004)(86362001)(7696005)(54906003)(3660700001)(68736007)(2201001)(39060400002)(6436002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB2965;H:DB6PR04MB2999.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: rI78ycv8ousnTVN8dM/xPsQ+BoRYAhJB4yRXbz8ng/YOkkirqw+oHGH7HEGfhV5CA2UzXxgep4/9qrhDhrV+1jwo2MXvAXSO1K6cQQ6CztocVIuExArhLKf1rogZwGCKaSexURyk216c4Zr9vuBHUTTk8TYlDcwrtnl9Dl2ETXk8sXGYwMNm19LFfzUHFAFi/7IRxpED5a2zZOUo7QtTrOl5LnzBhp4B8qSbRg2DH1h0PAoKk1bkktyE55Q2AqYVp961q1r/NFDhmQMNmlFHjMrl2NqKWT/l610Nu6EphNM4cA6AaGEd8dMnpjqiMpvfrXivwDD1vp68dciesRw4Gg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 933baa8a-5420-44a7-5add-08d593e56aad
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2018 13:19:48.8864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB2965
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596028263549902602?=
X-GMAIL-MSGID: =?utf-8?q?1596097080108544292?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/27/2018 7:05 AM, Robin Murphy wrote:=0A=
> Hi Roy,=0A=
>=0A=
> On 26/03/18 20:05, Roy Pledge wrote:=0A=
>> The error path in the dpaa2_dpio_probe() function was not properly=0A=
>> unmapping the QBMan device memory on the error path. This was also=0A=
>> missing from the dpaa2_dpio_release() function.=0A=
>>=0A=
>> Also addresses a memory leak of the device private data structure.=0A=
>>=0A=
>> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>=0A=
>> ---=0A=
>>    drivers/staging/fsl-mc/bus/dpio/dpio-driver.c | 49 ++++++++++++++++++=
+--------=0A=
>>    1 file changed, 34 insertions(+), 15 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c b/drivers/sta=
ging/fsl-mc/bus/dpio/dpio-driver.c=0A=
>> index e00f473..e7a0009 100644=0A=
>> --- a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c=0A=
>> +++ b/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c=0A=
>> @@ -28,6 +28,7 @@ MODULE_DESCRIPTION("DPIO Driver");=0A=
>>    =0A=
>>    struct dpio_priv {=0A=
>>    	struct dpaa2_io *io;=0A=
>> +	struct dpaa2_io_desc desc;=0A=
>>    };=0A=
>>    =0A=
>>    static irqreturn_t dpio_irq_handler(int irq_num, void *arg)=0A=
>> @@ -85,7 +86,6 @@ static int register_dpio_irq_handlers(struct fsl_mc_de=
vice *dpio_dev, int cpu)=0A=
>>    static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)=0A=
>>    {=0A=
>>    	struct dpio_attr dpio_attrs;=0A=
>> -	struct dpaa2_io_desc desc;=0A=
>>    	struct dpio_priv *priv;=0A=
>>    	int err =3D -ENOMEM;=0A=
>>    	struct device *dev =3D &dpio_dev->dev;=0A=
>> @@ -117,7 +117,7 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dp=
io_dev)=0A=
>>    		dev_err(dev, "dpio_get_attributes() failed %d\n", err);=0A=
>>    		goto err_get_attr;=0A=
>>    	}=0A=
>> -	desc.qman_version =3D dpio_attrs.qbman_version;=0A=
>> +	priv->desc.qman_version =3D dpio_attrs.qbman_version;=0A=
>>    =0A=
>>    	err =3D dpio_enable(dpio_dev->mc_io, 0, dpio_dev->mc_handle);=0A=
>>    	if (err) {=0A=
>> @@ -126,9 +126,9 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dp=
io_dev)=0A=
>>    	}=0A=
>>    =0A=
>>    	/* initialize DPIO descriptor */=0A=
>> -	desc.receives_notifications =3D dpio_attrs.num_priorities ? 1 : 0;=0A=
>> -	desc.has_8prio =3D dpio_attrs.num_priorities =3D=3D 8 ? 1 : 0;=0A=
>> -	desc.dpio_id =3D dpio_dev->obj_desc.id;=0A=
>> +	priv->desc.receives_notifications =3D dpio_attrs.num_priorities ? 1 : =
0;=0A=
>> +	priv->desc.has_8prio =3D dpio_attrs.num_priorities =3D=3D 8 ? 1 : 0;=
=0A=
>> +	priv->desc.dpio_id =3D dpio_dev->obj_desc.id;=0A=
>>    =0A=
>>    	/* get the cpu to use for the affinity hint */=0A=
>>    	if (next_cpu =3D=3D -1)=0A=
>> @@ -139,19 +139,28 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *=
dpio_dev)=0A=
>>    	if (!cpu_possible(next_cpu)) {=0A=
>>    		dev_err(dev, "probe failed. Number of DPIOs exceeds NR_CPUS.\n");=
=0A=
>>    		err =3D -ERANGE;=0A=
>> -		goto err_allocate_irqs;=0A=
>> +		goto err_too_many_cpu;=0A=
>>    	}=0A=
>> -	desc.cpu =3D next_cpu;=0A=
>> +	priv->desc.cpu =3D next_cpu;=0A=
>>    =0A=
>>    	/*=0A=
>>    	 * Set the CENA regs to be the cache inhibited area of the portal to=
=0A=
>>    	 * avoid coherency issues if a user migrates to another core.=0A=
>>    	 */=0A=
>> -	desc.regs_cena =3D memremap(dpio_dev->regions[1].start,=0A=
>> -				  resource_size(&dpio_dev->regions[1]),=0A=
>> -				  MEMREMAP_WC);=0A=
>> -	desc.regs_cinh =3D ioremap(dpio_dev->regions[1].start,=0A=
>> -				 resource_size(&dpio_dev->regions[1]));=0A=
>> +	priv->desc.regs_cena =3D memremap(dpio_dev->regions[1].start,=0A=
>> +					resource_size(&dpio_dev->regions[1]),=0A=
>> +					MEMREMAP_WC);=0A=
> Since you already have some devres-managed resources in this driver,=0A=
> maybe use devm_memremap? (and perhaps convert the existing ioremap too)=
=0A=
That would make since - will do.=0A=
>=0A=
>> +	if (!priv->desc.regs_cena) {=0A=
>> +		dev_err(dev, "memremap failed\n");=0A=
>> +		goto err_too_many_cpu;=0A=
>> +	}=0A=
>> +=0A=
>> +	priv->desc.regs_cinh =3D ioremap(dpio_dev->regions[1].start,=0A=
>> +				       resource_size(&dpio_dev->regions[1]));=0A=
>> +	if (!priv->desc.regs_cinh) {=0A=
>> +		dev_err(dev, "ioremap failed\n");=0A=
>> +		goto err_ioremap_failed;=0A=
>> +	}=0A=
>>    =0A=
>>    	err =3D fsl_mc_allocate_irqs(dpio_dev);=0A=
>>    	if (err) {=0A=
>> @@ -159,11 +168,11 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *=
dpio_dev)=0A=
>>    		goto err_allocate_irqs;=0A=
>>    	}=0A=
>>    =0A=
>> -	err =3D register_dpio_irq_handlers(dpio_dev, desc.cpu);=0A=
>> +	err =3D register_dpio_irq_handlers(dpio_dev, priv->desc.cpu);=0A=
>>    	if (err)=0A=
>>    		goto err_register_dpio_irq;=0A=
>>    =0A=
>> -	priv->io =3D dpaa2_io_create(&desc);=0A=
>> +	priv->io =3D dpaa2_io_create(&priv->desc);=0A=
>>    	if (!priv->io) {=0A=
>>    		dev_err(dev, "dpaa2_io_create failed\n");=0A=
>>    		goto err_dpaa2_io_create;=0A=
>> @@ -171,7 +180,7 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dp=
io_dev)=0A=
>>    =0A=
>>    	dev_info(dev, "probed\n");=0A=
>>    	dev_dbg(dev, "   receives_notifications =3D %d\n",=0A=
>> -		desc.receives_notifications);=0A=
>> +		priv->desc.receives_notifications);=0A=
>>    	dpio_close(dpio_dev->mc_io, 0, dpio_dev->mc_handle);=0A=
>>    	fsl_mc_portal_free(dpio_dev->mc_io);=0A=
>>    =0A=
>> @@ -182,6 +191,10 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *d=
pio_dev)=0A=
>>    err_register_dpio_irq:=0A=
>>    	fsl_mc_free_irqs(dpio_dev);=0A=
>>    err_allocate_irqs:=0A=
>> +	iounmap(priv->desc.regs_cinh);=0A=
>> +err_ioremap_failed:=0A=
>> +	memunmap(priv->desc.regs_cena);=0A=
> ...then you wouldn't need to worry about this.=0A=
>=0A=
>> +err_too_many_cpu:=0A=
>>    	dpio_disable(dpio_dev->mc_io, 0, dpio_dev->mc_handle);=0A=
>>    err_get_attr:=0A=
>>    	dpio_close(dpio_dev->mc_io, 0, dpio_dev->mc_handle);=0A=
>> @@ -189,6 +202,7 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dp=
io_dev)=0A=
>>    	fsl_mc_portal_free(dpio_dev->mc_io);=0A=
>>    err_mcportal:=0A=
>>    	dev_set_drvdata(dev, NULL);=0A=
>> +	devm_kfree(dev, priv);=0A=
> The whole point of devm_* is that you don't need to do this - the devres=
=0A=
> entries are freed automatically by the driver core upon probe failure or=
=0A=
> driver detach, i.e. priv was never leaking.=0A=
Right - Not sure what I was thinking yesterday. I think I saw the alloc =0A=
without free and instinctively=0A=
added it.=A0 I will remove this.=0A=
>=0A=
>>    err_priv_alloc:=0A=
>>    	return err;=0A=
>>    }=0A=
>> @@ -230,8 +244,13 @@ static int dpaa2_dpio_remove(struct fsl_mc_device *=
dpio_dev)=0A=
>>    =0A=
>>    	dpio_close(dpio_dev->mc_io, 0, dpio_dev->mc_handle);=0A=
>>    =0A=
>> +	iounmap(priv->desc.regs_cinh);=0A=
>> +	memunmap(priv->desc.regs_cena);=0A=
>> +=0A=
>>    	fsl_mc_portal_free(dpio_dev->mc_io);=0A=
>>    =0A=
>> +	devm_kfree(dev, priv);=0A=
>> +=0A=
>>    	dev_set_drvdata(dev, NULL);=0A=
> Note that clearing drvdata is something else the driver core already=0A=
> does at about the same time as cleaning up devres entries (see=0A=
> __device_release_driver() and the failure path of really_probe(), in=0A=
> drivers/base/dd.c), so this has been similarly superfluous all along.=0A=
Yes I'll clean this up too.=A0 Thanks for the comments, this will make =0A=
things better for sure.=0A=
>=0A=
> Robin.=0A=
>=0A=
=0A=
