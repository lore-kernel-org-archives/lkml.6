Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3536989-1522148727-5-12874427156580720281
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522148726; b=WtunygYHKLTNTMqGCY/CCbAzXb2XRdka1R2SFhZCOtURARb
    aioFyXoAaFeKlqLfPXVCp8Xu1t2KVXgPAocJCxdIPfbtimOCvmIV+uCAFe/S1Au7
    EVNkffMx5orYqF7bNAoA4MJKvUNhvaVlVhxrLp6G3Jyj1xOYURfsBUpBMTsBgzPc
    edxpD2zTCvYcVkQ/74irW9GRAbJQBY+G1siVqQGLirGpOaguBP1p3jDO8Ib2Bq5T
    y4tFI6GMS3DGczvZC6BUQcpFzTSt1PG+goVfmoslQypV9UY676/wIVVEkpnHCSHJ
    Qs96C+30Ukh3fh38P4ZqqAI99Ps3f/mKrQwgebg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=arctest; t=
    1522148726; bh=LS9cncHDySa+splvDqW3PiswxPb/5M5zDffHrAVuWtE=; b=t
    KOb6rn2uZ3te16Diac3A3zN3xWIPaemuukF859kdsooEIZRNU3oWObZOtGLwSiNZ
    6RfXmD8Dbnz4obi5uvVjpFmToIoXXTwcmmQ62V15EWTwz9JdY2hw5Sqk2m9rZOJ9
    XTAiPUu6HEMiWvoHkhkIwr0emkPoo5v9LDWJXhYt0dBmC9Fy5rst35rvcA5KCke3
    OpwkV2LYryD7/eeSIHutbAA0ZSRoSpE5BqAW3Y/MHRUDMK7mvql3bbJBpoJ55TMK
    rmLPyX1iOcTKWpEtCN+rt8yPb+7LDRKTAPGahwAIt753B/0UOQOJTOW/+c04Rwml
    ZHIucX5EjbHj1Fe2dBqFA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKODUll0KWfiJCAFozVU+QlvHDyoyIlXAB0oTk6v8DyhAqDk5SxbDgf+1lBnS4YO/nbEO0QkTIvsZiLIeT7gNqWAO0Nf6w58akSbcSEFsOEqMuaK9xna
    IDcwFUeNjdbiN1Idpl1bsIjq7hmqIf8bv2Pr3y9CiH3jKj35KknGaAXComx8B4R1kYbUXfxO0f1tdrfdF6VcpnlSg4FuplMGcO2n2bdLyv3b9g5f3T4aJMfR
    2qAtjPnECfYoVvg0atvEvA==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=8AirrxEcAAAA:8 a=DDOyTI_5AAAA:8
    a=AH1QtUY25BoyzHJE0G8A:9 a=-rCcgGEI4V2tDyUc:21 a=E8O_A_qRuvc6oJ7T:21
    a=CjuIK1q_8ugA:10 a=ST-jHhOKWsTCqRlWije3:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Subject: Re: [PATCH v3 2/4] drivers/staging/fsl-mc: Fix DPIO error path issues
To: roy.pledge@nxp.com, devel@driverdev.osuosl.org,
 linux-arm-kernel@lists.infradead.org
References: <1522091134-24646-1-git-send-email-roy.pledge@nxp.com>
 <1522091134-24646-3-git-send-email-roy.pledge@nxp.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <5e91615b-b2b4-4fe3-4d25-1ae56624976b@arm.com>
Date: Tue, 27 Mar 2018 12:05:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1522091134-24646-3-git-send-email-roy.pledge@nxp.com>
Content-Language: en-US
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: catalin.marinas@arm.com, arnd@arndb.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, leoyang.li@nxp.com, stuyoder@gmail.com,
 horia.geanta@nxp.com, laurentiu.tudor@nxp.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Roy,

On 26/03/18 20:05, Roy Pledge wrote:
> The error path in the dpaa2_dpio_probe() function was not properly
> unmapping the QBMan device memory on the error path. This was also
> missing from the dpaa2_dpio_release() function.
> 
> Also addresses a memory leak of the device private data structure.
> 
> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
> ---
>   drivers/staging/fsl-mc/bus/dpio/dpio-driver.c | 49 +++++++++++++++++++--------
>   1 file changed, 34 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c b/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
> index e00f473..e7a0009 100644
> --- a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
> +++ b/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
> @@ -28,6 +28,7 @@ MODULE_DESCRIPTION("DPIO Driver");
>   
>   struct dpio_priv {
>   	struct dpaa2_io *io;
> +	struct dpaa2_io_desc desc;
>   };
>   
>   static irqreturn_t dpio_irq_handler(int irq_num, void *arg)
> @@ -85,7 +86,6 @@ static int register_dpio_irq_handlers(struct fsl_mc_device *dpio_dev, int cpu)
>   static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
>   {
>   	struct dpio_attr dpio_attrs;
> -	struct dpaa2_io_desc desc;
>   	struct dpio_priv *priv;
>   	int err = -ENOMEM;
>   	struct device *dev = &dpio_dev->dev;
> @@ -117,7 +117,7 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
>   		dev_err(dev, "dpio_get_attributes() failed %d\n", err);
>   		goto err_get_attr;
>   	}
> -	desc.qman_version = dpio_attrs.qbman_version;
> +	priv->desc.qman_version = dpio_attrs.qbman_version;
>   
>   	err = dpio_enable(dpio_dev->mc_io, 0, dpio_dev->mc_handle);
>   	if (err) {
> @@ -126,9 +126,9 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
>   	}
>   
>   	/* initialize DPIO descriptor */
> -	desc.receives_notifications = dpio_attrs.num_priorities ? 1 : 0;
> -	desc.has_8prio = dpio_attrs.num_priorities == 8 ? 1 : 0;
> -	desc.dpio_id = dpio_dev->obj_desc.id;
> +	priv->desc.receives_notifications = dpio_attrs.num_priorities ? 1 : 0;
> +	priv->desc.has_8prio = dpio_attrs.num_priorities == 8 ? 1 : 0;
> +	priv->desc.dpio_id = dpio_dev->obj_desc.id;
>   
>   	/* get the cpu to use for the affinity hint */
>   	if (next_cpu == -1)
> @@ -139,19 +139,28 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
>   	if (!cpu_possible(next_cpu)) {
>   		dev_err(dev, "probe failed. Number of DPIOs exceeds NR_CPUS.\n");
>   		err = -ERANGE;
> -		goto err_allocate_irqs;
> +		goto err_too_many_cpu;
>   	}
> -	desc.cpu = next_cpu;
> +	priv->desc.cpu = next_cpu;
>   
>   	/*
>   	 * Set the CENA regs to be the cache inhibited area of the portal to
>   	 * avoid coherency issues if a user migrates to another core.
>   	 */
> -	desc.regs_cena = memremap(dpio_dev->regions[1].start,
> -				  resource_size(&dpio_dev->regions[1]),
> -				  MEMREMAP_WC);
> -	desc.regs_cinh = ioremap(dpio_dev->regions[1].start,
> -				 resource_size(&dpio_dev->regions[1]));
> +	priv->desc.regs_cena = memremap(dpio_dev->regions[1].start,
> +					resource_size(&dpio_dev->regions[1]),
> +					MEMREMAP_WC);

Since you already have some devres-managed resources in this driver, 
maybe use devm_memremap? (and perhaps convert the existing ioremap too)

> +	if (!priv->desc.regs_cena) {
> +		dev_err(dev, "memremap failed\n");
> +		goto err_too_many_cpu;
> +	}
> +
> +	priv->desc.regs_cinh = ioremap(dpio_dev->regions[1].start,
> +				       resource_size(&dpio_dev->regions[1]));
> +	if (!priv->desc.regs_cinh) {
> +		dev_err(dev, "ioremap failed\n");
> +		goto err_ioremap_failed;
> +	}
>   
>   	err = fsl_mc_allocate_irqs(dpio_dev);
>   	if (err) {
> @@ -159,11 +168,11 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
>   		goto err_allocate_irqs;
>   	}
>   
> -	err = register_dpio_irq_handlers(dpio_dev, desc.cpu);
> +	err = register_dpio_irq_handlers(dpio_dev, priv->desc.cpu);
>   	if (err)
>   		goto err_register_dpio_irq;
>   
> -	priv->io = dpaa2_io_create(&desc);
> +	priv->io = dpaa2_io_create(&priv->desc);
>   	if (!priv->io) {
>   		dev_err(dev, "dpaa2_io_create failed\n");
>   		goto err_dpaa2_io_create;
> @@ -171,7 +180,7 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
>   
>   	dev_info(dev, "probed\n");
>   	dev_dbg(dev, "   receives_notifications = %d\n",
> -		desc.receives_notifications);
> +		priv->desc.receives_notifications);
>   	dpio_close(dpio_dev->mc_io, 0, dpio_dev->mc_handle);
>   	fsl_mc_portal_free(dpio_dev->mc_io);
>   
> @@ -182,6 +191,10 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
>   err_register_dpio_irq:
>   	fsl_mc_free_irqs(dpio_dev);
>   err_allocate_irqs:
> +	iounmap(priv->desc.regs_cinh);
> +err_ioremap_failed:
> +	memunmap(priv->desc.regs_cena);

...then you wouldn't need to worry about this.

> +err_too_many_cpu:
>   	dpio_disable(dpio_dev->mc_io, 0, dpio_dev->mc_handle);
>   err_get_attr:
>   	dpio_close(dpio_dev->mc_io, 0, dpio_dev->mc_handle);
> @@ -189,6 +202,7 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
>   	fsl_mc_portal_free(dpio_dev->mc_io);
>   err_mcportal:
>   	dev_set_drvdata(dev, NULL);
> +	devm_kfree(dev, priv);

The whole point of devm_* is that you don't need to do this - the devres 
entries are freed automatically by the driver core upon probe failure or 
driver detach, i.e. priv was never leaking.

>   err_priv_alloc:
>   	return err;
>   }
> @@ -230,8 +244,13 @@ static int dpaa2_dpio_remove(struct fsl_mc_device *dpio_dev)
>   
>   	dpio_close(dpio_dev->mc_io, 0, dpio_dev->mc_handle);
>   
> +	iounmap(priv->desc.regs_cinh);
> +	memunmap(priv->desc.regs_cena);
> +
>   	fsl_mc_portal_free(dpio_dev->mc_io);
>   
> +	devm_kfree(dev, priv);
> +
>   	dev_set_drvdata(dev, NULL);

Note that clearing drvdata is something else the driver core already 
does at about the same time as cleaning up devres entries (see 
__device_release_driver() and the failure path of really_probe(), in 
drivers/base/dd.c), so this has been similarly superfluous all along.

Robin.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
