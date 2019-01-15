Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206D8C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C961820645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547565021;
	bh=hC4AzYGa1Q7GEBk1kKL1GaidCpGeGQI5fqTQraiLswE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B1I+5uAlUbNcp/KWHFazYhby7aphiBleLE8V45dO23ZZsSrjLxYKUvZO9VQfbKaGo
	 iSDcNVAqr8GLSOcpvvjXw+0tByZmS91ndXbjE6J/AgQiUtWwzUwIRCdgCkgOVJdWaM
	 VrR0HLT/pWBLPWef+WVbXn1xa9NZxtAN6WOPEP7U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbfAOPKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:10:19 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52254 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfAOPKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:10:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Db29ic5zFVV5gaR1M4QE6LdV4+bbkMU2Qqtf/rmz6kQ=; b=ib1oVg8yRarXe4oiOpD7NSLaV
        X9eqyg2ET03K1K13FFN6cV4zqm0fX1dbNXuDazYUWaH6bAtH1lBtAOOeF/GLsGlNNbJ0UtY/Yo5Rp
        xHAPmagpqv+4GZpfHgS3/uAQYhCnA6qQYVThjid+4b+uw/L8ObM1AQASHKvZyDA0NLZ9I=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gjQLx-0008MC-W7; Tue, 15 Jan 2019 15:10:10 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5ABC41127848; Tue, 15 Jan 2019 15:10:09 +0000 (GMT)
Date:   Tue, 15 Jan 2019 15:10:09 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Martin Sperl <kernel@martin.sperl.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
Subject: Re: Regression: spi: core: avoid waking pump thread from spi_sync
 instead run teardown delayed
Message-ID: <20190115151009.GC5522@sirena.org.uk>
References: <f86eaebb-0359-13be-f4a2-4f2b8832252e@nvidia.com>
 <7C4A5EFC-8235-40C8-96E1-E6020529DF72@martin.sperl.org>
 <aabd916e-005e-6cda-25d7-8ab875afa7a0@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1SQmhf2mF2YjsYvc"
Content-Disposition: inline
In-Reply-To: <aabd916e-005e-6cda-25d7-8ab875afa7a0@nvidia.com>
X-Cookie: Violence is molding.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1SQmhf2mF2YjsYvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 15, 2019 at 02:26:02PM +0000, Jon Hunter wrote:

> It seems that __spi_pump_messages() is getting called several times
> during boot when registering the spi-flash, then after the spi-flash has
> been registered, about a 1 sec later spi_pump_idle_teardown() is called
> (as expected), but exits because 'ctlr->running' is true. However,
> spi_pump_idle_teardown() is never called again and when we suspend we
> are stuck in the busy/running state. In this case should something be
> scheduling spi_pump_idle_teardown() again? Although even if it does I
> don't see where the busy flag would be cleared in this path?

Right, I think with the current code we just shouldn't be checking for
busy in teardown, since there's now a fairly big delay between idle and
actually turning the hardware off the name is just super misleading and
the logic confused.  I don't have time to test right now but does
something like the below which changes it to a flag for the hardware
being powered up work:

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 3b2a9a6b990d..0170b0ef5d37 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -358,9 +358,6 @@ static int stm32_qspi_setup(struct spi_device *spi)
 	struct stm32_qspi_flash *flash;
 	u32 cr, presc;
=20
-	if (ctrl->busy)
-		return -EBUSY;
-
 	if (!spi->max_speed_hz)
 		return -EINVAL;
=20
diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 5f19016bbf10..3d746a0782eb 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -152,11 +152,6 @@ static int ti_qspi_setup(struct spi_device *spi)
 	int clk_div =3D 0, ret;
 	u32 clk_ctrl_reg, clk_rate, clk_mask;
=20
-	if (spi->master->busy) {
-		dev_dbg(qspi->dev, "master busy doing other transfers\n");
-		return -EBUSY;
-	}
-
 	if (!qspi->spi_max_frequency) {
 		dev_err(qspi->dev, "spi max frequency not defined\n");
 		return -EINVAL;
diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 9f83e1b17aa1..a173a3114813 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -487,22 +487,6 @@ static int zynqmp_qspi_setup_transfer(struct spi_devic=
e *qspi,
 	return 0;
 }
=20
-/**
- * zynqmp_qspi_setup:	Configure the QSPI controller
- * @qspi:	Pointer to the spi_device structure
- *
- * Sets the operational mode of QSPI controller for the next QSPI transfer,
- * baud rate and divisor value to setup the requested qspi clock.
- *
- * Return:	0 on success; error value otherwise.
- */
-static int zynqmp_qspi_setup(struct spi_device *qspi)
-{
-	if (qspi->master->busy)
-		return -EBUSY;
-	return 0;
-}
-
 /**
  * zynqmp_qspi_filltxfifo:	Fills the TX FIFO as long as there is room in
  *				the FIFO or the bytes required to be
@@ -1088,7 +1072,6 @@ static int zynqmp_qspi_probe(struct platform_device *=
pdev)
=20
 	master->num_chipselect =3D GQSPI_DEFAULT_NUM_CS;
=20
-	master->setup =3D zynqmp_qspi_setup;
 	master->set_cs =3D zynqmp_qspi_chipselect;
 	master->transfer_one =3D zynqmp_qspi_start_transfer;
 	master->prepare_transfer_hardware =3D zynqmp_prepare_transfer_hardware;
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 06b9139664a3..6d10ad9d768f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1234,7 +1234,7 @@ static void __spi_pump_messages(struct spi_controller=
 *ctlr, bool in_kthread)
=20
 	/* Check if the queue is idle */
 	if (list_empty(&ctlr->queue) || !ctlr->running) {
-		if (!ctlr->busy) {
+		if (!ctlr->hw_active) {
 			spin_unlock_irqrestore(&ctlr->queue_lock, flags);
 			return;
 		}
@@ -1252,10 +1252,10 @@ static void __spi_pump_messages(struct spi_controll=
er *ctlr, bool in_kthread)
 		list_first_entry(&ctlr->queue, struct spi_message, queue);
=20
 	list_del_init(&ctlr->cur_msg->queue);
-	if (ctlr->busy)
+	if (ctlr->hw_active)
 		was_busy =3D true;
 	else
-		ctlr->busy =3D true;
+		ctlr->hw_active =3D true;
 	spin_unlock_irqrestore(&ctlr->queue_lock, flags);
=20
 	mutex_lock(&ctlr->io_mutex);
@@ -1362,10 +1362,6 @@ static void spi_pump_idle_teardown(struct kthread_wo=
rk *work)
 	if (ctlr->running)
 		goto out;
=20
-	/* if the controller is busy then exit */
-	if (ctlr->busy)
-		goto out;
-
 	/* if the controller is idling then exit
 	 * this is actually a bit strange and would indicate that
 	 * this function is scheduled twice, which should not happen
@@ -1374,7 +1370,6 @@ static void spi_pump_idle_teardown(struct kthread_wor=
k *work)
 		goto out;
=20
 	/* set up the initial states */
-	ctlr->busy =3D false;
 	ctlr->idling =3D true;
 	spin_unlock_irqrestore(&ctlr->queue_lock, flags);
=20
@@ -1384,15 +1379,17 @@ static void spi_pump_idle_teardown(struct kthread_w=
ork *work)
 	kfree(ctlr->dummy_tx);
 	ctlr->dummy_tx =3D NULL;
=20
-	/* unprepare hardware */
-	if (ctlr->unprepare_transfer_hardware &&
-	    ctlr->unprepare_transfer_hardware(ctlr))
-		dev_err(&ctlr->dev,
-			"failed to unprepare transfer hardware\n");
-	/* handle pm */
-	if (ctlr->auto_runtime_pm) {
-		pm_runtime_mark_last_busy(ctlr->dev.parent);
-		pm_runtime_put_autosuspend(ctlr->dev.parent);
+	if (ctlr->hw_active) {
+		/* unprepare hardware */
+		if (ctlr->unprepare_transfer_hardware &&
+		    ctlr->unprepare_transfer_hardware(ctlr))
+			dev_err(&ctlr->dev,
+				"failed to unprepare transfer hardware\n");
+		/* handle pm */
+		if (ctlr->auto_runtime_pm) {
+			pm_runtime_mark_last_busy(ctlr->dev.parent);
+			pm_runtime_put_autosuspend(ctlr->dev.parent);
+		}
 	}
=20
 	/* mark controller as idle */
@@ -1401,6 +1398,7 @@ static void spi_pump_idle_teardown(struct kthread_wor=
k *work)
 	/* finally put us from idling into stopped */
 	spin_lock_irqsave(&ctlr->queue_lock, flags);
 	ctlr->idling =3D false;
+	ctlr->hw_active =3D false;
=20
 out:
 	spin_unlock_irqrestore(&ctlr->queue_lock, flags);
@@ -1411,7 +1409,7 @@ static int spi_init_queue(struct spi_controller *ctlr)
 	struct sched_param param =3D { .sched_priority =3D MAX_RT_PRIO - 1 };
=20
 	ctlr->running =3D false;
-	ctlr->busy =3D false;
+	ctlr->hw_active =3D false;
=20
 	kthread_init_worker(&ctlr->kworker);
 	ctlr->kworker_task =3D kthread_run(kthread_worker_fn, &ctlr->kworker,
@@ -1520,7 +1518,7 @@ static int spi_start_queue(struct spi_controller *ctl=
r)
=20
 	spin_lock_irqsave(&ctlr->queue_lock, flags);
=20
-	if (ctlr->running || ctlr->busy) {
+	if (ctlr->running || ctlr->hw_active) {
 		spin_unlock_irqrestore(&ctlr->queue_lock, flags);
 		return -EBUSY;
 	}
@@ -1543,18 +1541,19 @@ static int spi_stop_queue(struct spi_controller *ct=
lr)
 	spin_lock_irqsave(&ctlr->queue_lock, flags);
=20
 	/*
-	 * This is a bit lame, but is optimized for the common execution path.
-	 * A wait_queue on the ctlr->busy could be used, but then the common
-	 * execution path (pump_messages) would be required to call wake_up or
-	 * friends on every SPI message. Do this instead.
+	 * This is a bit sad, but is optimized for the common execution path.
+	 * A wait_queue on the ctlr->hw_active could be used, but then
+	 * the common execution path (pump_messages) would be required
+	 * to call wake_up or friends on every SPI message. Do this
+	 * instead.
 	 */
-	while ((!list_empty(&ctlr->queue) || ctlr->busy) && limit--) {
+	while ((!list_empty(&ctlr->queue) || ctlr->hw_active) && limit--) {
 		spin_unlock_irqrestore(&ctlr->queue_lock, flags);
 		usleep_range(10000, 11000);
 		spin_lock_irqsave(&ctlr->queue_lock, flags);
 	}
=20
-	if (!list_empty(&ctlr->queue) || ctlr->busy)
+	if (!list_empty(&ctlr->queue) || ctlr->hw_active)
 		ret =3D -EBUSY;
 	else
 		ctlr->running =3D false;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 79ad62e2487c..d9b7be89e50b 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -343,7 +343,7 @@ static inline void spi_unregister_driver(struct spi_dri=
ver *sdrv)
  *                    in-flight message
  * @cur_msg_mapped: message has been mapped for DMA
  * @xfer_completion: used by core transfer_one_message()
- * @busy: message pump is busy
+ * @hw_active: message pump has hardware powered up
  * @running: message pump is running
  * @rt: whether this queue is set to run as a realtime task
  * @auto_runtime_pm: the core should ensure a runtime PM reference is held
@@ -538,7 +538,7 @@ struct spi_controller {
 	struct list_head		queue;
 	struct spi_message		*cur_msg;
 	bool				idling;
-	bool				busy;
+	bool				hw_active;
 	bool				running;
 	bool				rt;
 	bool				auto_runtime_pm;

--1SQmhf2mF2YjsYvc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw999AACgkQJNaLcl1U
h9CFZgf/ZgHzpfNolv8wgO1rMfTckSe3KxszLPqo57EQEvboaSJ+fuCDdUe8X4x5
z10gYX3HCEVaaUSCaO4QZS/JJwDrZfgOJ9gAJYATcsQ39xLo/j2QZCXAG4jrM8xg
oXakulm6iXMAHnmo1pJUW1mAAwHCfIOBciCAMlWpnLLeD/TeK5vC2nGdeGxpQewg
QxtBKKZexuokLtxpfx/GTtIsUQfgy83Q7dOZYwiNo/HviernlSEtK0o60eV95nFq
YSfrf9X6dEcfP5r/l4T32ZQAT1rJ06t1M3smeETve3JnkZduYrSwr0h//EYWbaAu
up2QjeCXy4UrVzxerhwwzZ/nEQ/Y6w==
=q6jL
-----END PGP SIGNATURE-----

--1SQmhf2mF2YjsYvc--
