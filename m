Return-Path: <boris.brezillon@bootlin.com>
X-Google-Smtp-Source: AH8x224ODKxoGXAR8Jw4F5g9ltY7bB9d/t7Ar177zOCit7RDiPubQznz5vYRkcl0dGgr/GthXNJ3
ARC-Seal: i=1; a=rsa-sha256; t=1519417813; cv=none;
        d=google.com; s=arc-20160816;
        b=P62fVKcYmlweEQEcBYSwcSblEdSkxbyZfXZPVNPxcLuy8TIk9DLhKHwvSbUwfR2TBq
         eY2uaO93T/v4dVc1yG50lxYg2bZj5Spr570GB1lHVzU5LKYTVRxZr89glZY1KBcHA7yQ
         YXg4VbOLeMNVJJIY6hnqkAaQelWjGx960mNELoMXJK7YpiHSJAhytyODGo6uFEJ97C/m
         prxsk3PJT/pg0hC18DXnMelMHMyUN52hnpXIMqf/3Pwwr7lo7wZ00j2IjUezSkNLVsfq
         reukjfjwlOhEIyDS3881qd0rAqZZVCHBuy3q9sfmRNSGk2KavmBYGYzzGOvlrDJlIg6V
         rghA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=j4Tj9MCbdZOBT6TP6B/eG4T5iO3dY3Vc4JwQZJSeIU4=;
        b=K60Ah/smNfSZECGys0VV9Uv9eubtrME1aMsnUQKjVwzw1sX+/uQuSUXTT1Jiuhq1vY
         QnXwFEBrW89XICNvVtwh8EQvBzVTH09+ipfAElR4ABWjyCVNP4lbR2qHqZ2emXN5ERw6
         tomQOWm6QSpcNudLERjB9v+pmd76AbZ62/1JcoGzmI48qgWnA3YUMMgf+bISGF/Q5wgC
         /aaETqh5IlbzlFGfkyzH0WWmrJWqGHPT4RyhAxJZnyFalLGiIysYkakJeY2cmdmipo6M
         9BK9QJbC4c3749AoF/MWgwxR9Gsqm9NIorZ0pprw+cDqyejk94Q7OdGAcuBCbc0QExcV
         nCDw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Date: Fri, 23 Feb 2018 21:30:00 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Vitor Soares <Vitor.Soares@synopsys.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Wolfram Sang
 <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, <linux-doc@vger.kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw
 Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan
 Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian
 Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>,
 Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose
 <sureshp@cadence.com>, Thomas Petazzoni
 <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, "Rob
 Herring" <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark
 Rutland <mark.rutland@arm.com>, Ian Campbell
 <ijc+devicetree@hellion.org.uk>, "Kumar Gala" <galak@codeaurora.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Linus Walleij
 <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 2/7] i3c: Add core I3C infrastructure
Message-ID: <20180223213000.407461d2@bbrezillon>
In-Reply-To: <b39f9016-b2ff-6d8d-96b3-945f32ab2b67@synopsys.com>
References: <20171214151610.19153-1-boris.brezillon@free-electrons.com>
	<20171214151610.19153-3-boris.brezillon@free-electrons.com>
	<b39f9016-b2ff-6d8d-96b3-945f32ab2b67@synopsys.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1586772916728163872?=
X-GMAIL-MSGID: =?utf-8?q?1593225052921051268?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Vitor,

On Fri, 23 Feb 2018 16:56:14 +0000
Vitor Soares <Vitor.Soares@synopsys.com> wrote:

> Hi Boris,
>=20
> =C3=80s 3:16 PM de 12/14/2017, Boris Brezillon escreveu:
> > +
> > +enum i3c_addr_slot_status i3c_bus_get_addr_slot_status(struct i3c_bus =
*bus,
> > +						       u16 addr)
> > +{
> > +	int status, bitpos =3D addr * 2;
> > +
> > +	if (addr > I2C_MAX_ADDR)
> > +		return I3C_ADDR_SLOT_RSVD;
> > +
> > +	status =3D bus->addrslots[bitpos / BITS_PER_LONG];
> > +	status >>=3D bitpos % BITS_PER_LONG;
> > +
> > +	return status & I3C_ADDR_SLOT_STATUS_MASK;
> > +} =20
>=20
> I don't understand the size of addr. The I3C only allow 7-bit addresses.
>=20
> Is the addrslots used to store the addresses and its status?

No, slots are used for both I2C and I3C addresses, and an I2C address
can be 10-bits wide, hence the u16 type.


[...]

> > +/**
> > + * i3c_device_do_priv_xfers() - do I3C SDR private transfers directed =
to a
> > + *				specific device
> > + *
> > + * @dev: device with which the transfers should be done
> > + * @xfers: array of transfers
> > + * @nxfers: number of transfers
> > + *
> > + * Initiate one or several private SDR transfers with @dev.
> > + *
> > + * This function can sleep and thus cannot be called in atomic context.
> > + *
> > + * Return: 0 in case of success, a negative error core otherwise.
> > + */
> > +int i3c_device_do_priv_xfers(struct i3c_device *dev,
> > +			     struct i3c_priv_xfer *xfers,
> > +			     int nxfers)
> > +{
> > +	struct i3c_master_controller *master;
> > +	int i, ret;
> > +
> > +	master =3D i3c_device_get_master(dev);
> > +	if (!master)
> > +		return -EINVAL;
> > +
> > +	i3c_bus_normaluse_lock(master->bus);
> > +	for (i =3D 0; i < nxfers; i++)
> > +		xfers[i].addr =3D dev->info.dyn_addr;
> > +
> > +	ret =3D i3c_master_do_priv_xfers_locked(master, xfers, nxfers);
> > +	i3c_bus_normaluse_unlock(master->bus);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(i3c_device_do_priv_xfers); =20
>=20
> =C2=A0The controller should know the speed mode for each xfer. The SDR0 m=
ode=20
> is used by default but if any device have read or write speed=20
> limitations the controller can use SDRx.

I might be wrong, but that's not my understanding of the spec. A device
can express a speed limitation for SDR priv transfers, but this
limitation applies to all SDR transfers.

The speed R/W speed limitation is encoded in the device object, so, if
the controller has to configure that on a per-transfer basis, one
solution would be to pass the device to the ->priv_xfers().

>=20
> This could be also applied to i2c transfers.

Not really. The max SCL frequency is something that applies to the
whole bus, because all I2C devices have to decode the address when
messages are sent on the bus to determine if they should ignore or
process the message.

> > +#endif /* I3C_INTERNAL_H */
> > diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> > new file mode 100644
> > index 000000000000..1c85abac08d5
> > --- /dev/null
> > +++ b/drivers/i3c/master.c
> > @@ -0,0 +1,1433 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2017 Cadence Design Systems Inc.
> > + *
> > + * Author: Boris Brezillon<boris.brezillon@free-electrons.com>
> > + */
> > +
> > +#include <linux/slab.h>
> > +
> > +#include "internals.h"
> > +
> > +/**
> > + * i3c_master_entdaa_locked() - start a DAA (Dynamic Address Assignmen=
t)
> > + *				procedure
> > + * @master: master used to send frames on the bus
> > + *
> > + * Send a ENTDAA CCC command to start a DAA procedure.
> > + *
> > + * Note that this function only sends the ENTDAA CCC command, all the =
logic
> > + * behind dynamic address assignment has to be handled in the I3C mast=
er
> > + * driver.
> > + *
> > + * This function must be called with the bus lock held in write mode.
> > + *
> > + * Return: 0 in case of success, a negative error code otherwise.
> > + */
> > +int i3c_master_entdaa_locked(struct i3c_master_controller *master)
> > +{
> > +	struct i3c_ccc_cmd_dest dest =3D { };
> > +	struct i3c_ccc_cmd cmd =3D { };
> > +	int ret;
> > +
> > +	dest.addr =3D I3C_BROADCAST_ADDR;
> > +	cmd.dests =3D &dest;
> > +	cmd.ndests =3D 1;
> > +	cmd.rnw =3D false;
> > +	cmd.id =3D I3C_CCC_ENTDAA;
> > +
> > +	ret =3D i3c_master_send_ccc_cmd_locked(master, &cmd);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(i3c_master_entdaa_locked); =20
>=20
> =C2=A0can you explain the process?

Not sure what you mean. The ENTDAA is just a CCC command that is used
to trigger a DAA procedure. What the master controller does when it
sends such a command is likely to be controller dependent, and it might
even be possible that you don't need to call this function in your
controller driver to trigger a DAA. If you want more details about the
bus initialization steps and how the ENTDAA CCC command fits into it I
recommend reading section "5.1.4 Bus Initialization and Dynamic Address
Assignment Mode"

> the command is only execute once, what if=20
> there is more devices on the bus?

Again, I'm not sure what you mean. The ENTDAA command is sent every
time a controller wants to discover new devices on the bus, that can be
when initializing the bus, after a Hot Join event or simply triggered
by the user (the last case is not supported yet though).

Now, if you're interested in what happens after an ENTDAA CCC is sent,
the controller will keep sending RepeatedStart until there's no more
devices acking the request. You can have a look at "B.3 Error Types in
Dynamic Address Arbitration" for more details.

>=20
> =C2=A0> +
> > +/**
> > + * i3c_master_defslvs_locked() - send a DEFSLVS CCC command
> > + * @master: master used to send frames on the bus
> > + *
> > + * Send a DEFSLVS CCC command containing all the devices known to the =
@master.
> > + * This is useful when you have secondary masters on the bus to propag=
ate
> > + * device information.
> > + *
> > + * This should be called after all I3C devices have been discovered (i=
n other
> > + * words, after the DAA procedure has finished) and instantiated in
> > + * i3c_master_controller_ops->bus_init().
> > + * It should also be called if a master ACKed an Hot-Join request and =
assigned
> > + * a dynamic address to the device joining the bus.
> > + *
> > + * This function must be called with the bus lock held in write mode.
> > + *
> > + * Return: 0 in case of success, a negative error code otherwise.
> > + */
> > +int i3c_master_defslvs_locked(struct i3c_master_controller *master)
> > +{
> > +	struct i3c_ccc_cmd_dest dest =3D {
> > +		.addr =3D I3C_BROADCAST_ADDR,
> > +	};
> > +	struct i3c_ccc_cmd cmd =3D {
> > +		.id =3D I3C_CCC_DEFSLVS,
> > +		.dests =3D &dest,
> > +		.ndests =3D 1,
> > +	};
> > +	struct i3c_ccc_defslvs *defslvs;
> > +	struct i3c_ccc_dev_desc *desc;
> > +	struct i3c_device *i3cdev;
> > +	struct i2c_device *i2cdev;
> > +	struct i3c_bus *bus;
> > +	bool send =3D false;
> > +	int ndevs =3D 0, ret;
> > +
> > +	if (!master)
> > +		return -EINVAL;
> > +
> > +	bus =3D i3c_master_get_bus(master);
> > +	i3c_bus_for_each_i3cdev(bus, i3cdev) {
> > +		ndevs++;
> > +		if (I3C_BCR_DEVICE_ROLE(i3cdev->info.bcr) =3D=3D I3C_BCR_I3C_MASTER)
> > +			send =3D true;
> > +	}
> > +
> > +	/* No other master on the bus, skip DEFSLVS. */
> > +	if (!send)
> > +		return 0;
> > +
> > +	i3c_bus_for_each_i2cdev(bus, i2cdev)
> > +		ndevs++;
> > +
> > +	dest.payload.len =3D sizeof(*defslvs) +
> > +			   ((ndevs - 1) * sizeof(struct i3c_ccc_dev_desc));
> > +	defslvs =3D kzalloc(dest.payload.len, GFP_KERNEL);
> > +	if (!defslvs)
> > +		return -ENOMEM;
> > +
> > +	dest.payload.data =3D defslvs;
> > +
> > +	defslvs->count =3D ndevs;
> > +	defslvs->master.bcr =3D master->this->info.bcr;
> > +	defslvs->master.dcr =3D master->this->info.dcr;
> > +	defslvs->master.dyn_addr =3D master->this->info.dyn_addr;
> > +	defslvs->master.static_addr =3D I3C_BROADCAST_ADDR; =20
>=20
> =C2=A0Why defslvs->master.static_addr =3D I3C_BROADCAST_ADDR?

I just follow what's document in "5.1.9.3.7 Define List of Slaves
(DEFSLVS)"

>=20
> =C2=A0> +
> > +	desc =3D defslvs->slaves;
> > +	i3c_bus_for_each_i2cdev(bus, i2cdev) {
> > +		desc->lvr =3D i2cdev->lvr;
> > +		desc->static_addr =3D i2cdev->info.addr;
> > +		desc++;
> > +	}
> > +
> > +	i3c_bus_for_each_i3cdev(bus, i3cdev) {
> > +		/* Skip the I3C dev representing this master. */
> > +		if (i3cdev =3D=3D master->this)
> > +			continue;
> > +
> > +		desc->bcr =3D i3cdev->info.bcr;
> > +		desc->dcr =3D i3cdev->info.dcr;
> > +		desc->dyn_addr =3D i3cdev->info.dyn_addr;
> > +		desc->static_addr =3D i3cdev->info.static_addr;
> > +		desc++;
> > +	}
> > +
> > +	ret =3D i3c_master_send_ccc_cmd_locked(master, &cmd);
> > +	kfree(defslvs);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(i3c_master_defslvs_locked);
> > +
> > +
> > +static int i3c_master_i2c_adapter_xfer(struct i2c_adapter *adap,
> > +				       struct i2c_msg *xfers, int nxfers)
> > +{
> > +	struct i3c_master_controller *master =3D i2c_adapter_to_i3c_master(ad=
ap);
> > +	int i, ret;
> > +
> > +	for (i =3D 0; i < nxfers; i++) {
> > +		enum i3c_addr_slot_status status;
> > +
> > +		status =3D i3c_bus_get_addr_slot_status(master->bus,
> > +						      xfers[i].addr);
> > +		if (status !=3D I3C_ADDR_SLOT_I2C_DEV)
> > +			return -EINVAL;
> > +	}
> > +
> > +	ret =3D i3c_master_do_i2c_xfers(master, xfers, nxfers);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return nxfers;
> > +}
> > +
> > +static u32 i3c_master_i2c_functionalities(struct i2c_adapter *adap)
> > +{
> > +	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_I2C | I2C_FUNC_10BIT_ADDR;
> > +} =20
>=20
> =C2=A0Is I2C_FUNC_10BIT_ADDR allowed ?

According to "Table 4 I 2 C Features Allowed in I3C Slaves", yes (at
least that my understanding). And the Cadence controller supports it.

>=20
> =C2=A0> diff --git a/drivers/i3c/master/Kconfig b/drivers/i3c/master/Kcon=
fig
> > new file mode 100644
> > index 000000000000..e69de29bb2d1
> > diff --git a/drivers/i3c/master/Makefile b/drivers/i3c/master/Makefile
> > new file mode 100644
> > index 000000000000..e69de29bb2d1
> > diff --git a/include/linux/i3c/ccc.h b/include/linux/i3c/ccc.h
> > new file mode 100644
> > index 000000000000..ff3e1a3e2c4c
> > --- /dev/null
> > +++ b/include/linux/i3c/ccc.h
> > @@ -0,0 +1,380 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2017 Cadence Design Systems Inc.
> > + *
> > + * Author: Boris Brezillon<boris.brezillon@free-electrons.com>
> > + */
> > +
> > +
> > +/**
> > + * enum i3c_ccc_test_mode - enum listing all available test modes
> > + *
> > + * @I3C_CCC_EXIT_TEST_MODE: exit test mode
> > + * @I3C_CCC_VENDOR_TEST_MODE: enter vendor test mode
> > + */
> > +enum i3c_ccc_test_mode {
> > +	I3C_CCC_EXIT_TEST_MODE,
> > +	I3C_CCC_VENDOR_TEST_MODE,
> > +};
> > +
> > +/**
> > + * struct i3c_ccc_enttm - payload passed to ENTTM CCC
> > + *
> > + * @mode: one of the &enum i3c_ccc_test_mode modes
> > + *
> > + * Information passed to the ENTTM CCC to instruct an I3C device to en=
ter a
> > + * specific test mode.
> > + */
> > +struct i3c_ccc_enttm {
> > +	u8 mode;
> > +} __packed;
> > +
> > +/**
> > + * struct i3c_ccc_setda - payload passed to ENTTM CCC
> > + *
> > + * @mode: one of the &enum i3c_ccc_test_mode modes
> > + *
> > + * Information passed to the ENTTM CCC to instruct an I3C device to en=
ter a
> > + * specific test mode.
> > + */
> > +struct i3c_ccc_setda {
> > +	u8 addr;
> > +} __packed; =20
>=20
> =C2=A0what do you mean with struct? Maybe setdasa? if so, what is the add=
r?
>=20
> =C2=A0> +/**
> > + * enum i3c_sdr_max_data_rate - max data rate values for private SDR t=
ransfers
> > + */
> > +enum i3c_sdr_max_data_rate {
> > +	I3C_SDR_DR_FSCL_MAX,
> > +	I3C_SDR_DR_FSCL_8MHZ,
> > +	I3C_SDR_DR_FSCL_6MHZ,
> > +	I3C_SDR_DR_FSCL_4MHZ,
> > +	I3C_SDR_DR_FSCL_2MHZ,
> > +}; =20
> Can you change the names to:
>=20
> I3C_SDR0_FSCL_MAX,
> I3C_SDR1_FSCL_8MHZ,
> I3C_SDR2_FSCL_6MHZ,
> I3C_SDR3_FSCL_4MHZ,
> I3C_SDR4_FSCL_2MHZ,
>=20
> thus the data rate isn't repeated.

What's the problem with the name I use? Moreover, I see no mention to
the SDR0,1,2,3,4 modes in the public spec.

>=20
> > +
> > +/**
> > + * enum i3c_tsco - clock to data turn-around
> > + */
> > +enum i3c_tsco {
> > +	I3C_TSCO_LT_8NS,
> > +	I3C_TSCO_LT_9NS,
> > +	I3C_TSCO_LT_10NS,
> > +	I3C_TSCO_LT_11NS,
> > +	I3C_TSCO_LT_12NS,
> > +}; =20
> what's the meaning of _LT_ ?

This I don't remember. I'll drop it in the next version.

> > +
> > +#endif /* I3C_CCC_H */
> > diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
> > new file mode 100644
> > index 000000000000..83958d3a02e2
> > --- /dev/null
> > +++ b/include/linux/i3c/device.h
> > @@ -0,0 +1,321 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2017 Cadence Design Systems Inc.
> > + *
> > + * Author: Boris Brezillon<boris.brezillon@free-electrons.com>
> > + */
> > +
> > +#ifndef I3C_DEV_H
> > +#define I3C_DEV_H
> > +
> > +#include <linux/device.h>
> > +#include <linux/i2c.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +
> > +/**
> > + * enum i3c_hdr_mode - HDR mode ids
> > + * @I3C_HDR_DDR: DDR mode
> > + * @I3C_HDR_TSP: TSP mode
> > + * @I3C_HDR_TSL: TSL mode
> > + */
> > +enum i3c_hdr_mode {
> > +	I3C_HDR_DDR,
> > +	I3C_HDR_TSP,
> > +	I3C_HDR_TSL,
> > +};
> > +
> > +/**
> > + * struct i3c_hdr_cmd - I3C HDR command
> > + * @mode: HDR mode selected for this command
> > + * @code: command opcode
> > + * @addr: I3C dynamic address
> > + * @ndatawords: number of data words (a word is 16bits wide)
> > + * @data: input/output buffer
> > + */
> > +struct i3c_hdr_cmd {
> > +	enum i3c_hdr_mode mode;
> > +	u8 code;
> > +	u8 addr;
> > +	int ndatawords;
> > +	union {
> > +		u16 *in;
> > +		const u16 *out;
> > +	} data;
> > +};
> > +
> > +/* Private SDR read transfer */
> > +#define I3C_PRIV_XFER_READ		BIT(0)
> > +/*
> > + * Instruct the controller to issue a STOP after a specific transfer i=
nstead
> > + * of a REPEATED START.
> > + */
> > +#define I3C_PRIV_XFER_STOP		BIT(1)
> > +
> > +/**
> > + * struct i3c_priv_xfer - I3C SDR private transfer
> > + * @addr: I3C dynamic address
> > + * @len: transfer length in bytes of the transfer
> > + * @flags: combination of I3C_PRIV_XFER_xxx flags
> > + * @data: input/output buffer
> > + */
> > +struct i3c_priv_xfer {
> > +	u8 addr;
> > +	u16 len;
> > +	u32 flags;
> > +	struct {
> > +		void *in;
> > +		const void *out;
> > +	} data;
> > +}; =20
>=20
> =C2=A0Same as above, i3c_sdr_max_data_rate to change the bus scl.

If I'm understanding the spec correctly, that's not something you want
to change on a per-transfer basis. The constraint is on the device
itself and should IMO not be part of the i3c_priv_xfer struct.

>=20
> =C2=A0> +
> > +/**
> > + * enum i3c_dcr - I3C DCR values
> > + * @I3C_DCR_GENERIC_DEVICE: generic I3C device
> > + */
> > +enum i3c_dcr {
> > +	I3C_DCR_GENERIC_DEVICE =3D 0,
> > +};
> > +
> > +#define I3C_PID_MANUF_ID(pid)		(((pid) & GENMASK_ULL(47, 33)) >> 33)
> > +#define I3C_PID_RND_LOWER_32BITS(pid)	(!!((pid) & BIT_ULL(32)))
> > +#define I3C_PID_RND_VAL(pid)		((pid) & GENMASK_ULL(31, 0))
> > +#define I3C_PID_PART_ID(pid)		(((pid) & GENMASK_ULL(31, 16)) >> 16)
> > +#define I3C_PID_INSTANCE_ID(pid)	(((pid) & GENMASK_ULL(15, 12)) >> 12)
> > +#define I3C_PID_EXTRA_INFO(pid)		((pid) & GENMASK_ULL(11, 0))
> > +
> > +#define I3C_BCR_DEVICE_ROLE(bcr)	((bcr) & GENMASK(7, 6))
> > +#define I3C_BCR_I3C_SLAVE		(0 << 6)
> > +#define I3C_BCR_I3C_MASTER		(1 << 6)
> > +#define I3C_BCR_HDR_CAP			BIT(5)
> > +#define I3C_BCR_BRIDGE			BIT(4)
> > +#define I3C_BCR_OFFLINE_CAP		BIT(3)
> > +#define I3C_BCR_IBI_PAYLOAD		BIT(2)
> > +#define I3C_BCR_IBI_REQ_CAP		BIT(1)
> > +#define I3C_BCR_MAX_DATA_SPEED_LIM	BIT(0)
> > +
> > +/**
> > + * struct i3c_device_info - I3C device information
> > + * @pid: Provisional ID
> > + * @bcr: Bus Characteristic Register
> > + * @dcr: Device Characteristic Register
> > + * @static_addr: static/I2C address
> > + * @dyn_addr: dynamic address
> > + * @hdr_cap: supported HDR modes
> > + * @max_read_ds: max read speed information
> > + * @max_write_ds: max write speed information
> > + * @max_ibi_len: max IBI payload length
> > + * @max_read_turnaround: max read turn-around time in micro-seconds
> > + * @max_read_len: max private SDR read length in bytes
> > + * @max_write_len: max private SDR write length in bytes
> > + *
> > + * These are all basic information that should be advertised by an I3C=
 device.
> > + * Some of them are optional depending on the device type and device
> > + * capabilities.
> > + * For each I3C slave attached to a master with
> > + * i3c_master_add_i3c_dev_locked(), the core will send the relevant CC=
C command
> > + * to retrieve these data.
> > + */
> > +struct i3c_device_info {
> > +	u64 pid;
> > +	u8 bcr;
> > +	u8 dcr;
> > +	u8 static_addr;
> > +	u8 dyn_addr;
> > +	u8 hdr_cap;
> > +	u8 max_read_ds;
> > +	u8 max_write_ds;
> > +	u8 max_ibi_len;
> > +	u32 max_read_turnaround;
> > +	u16 max_read_len;
> > +	u16 max_write_len;
> > +};
> > + =20
>=20
> =C2=A0is this information filled with data provided from CCC commands?

Yes, they are.

>=20
> =C2=A0> +
> > +#endif /* I3C_DEV_H */
> > diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
> > new file mode 100644
> > index 000000000000..7ec9a4821bac
> > --- /dev/null
> > +++ b/include/linux/i3c/master.h
> > @@ -0,0 +1,564 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2017 Cadence Design Systems Inc.
> > + *
> > + * Author: Boris Brezillon<boris.brezillon@free-electrons.com>
> > + */
> > +
> > +#ifndef I3C_MASTER_H
> > +#define I3C_MASTER_H
> > +
> > +#include <linux/i2c.h>
> > +#include <linux/i3c/ccc.h>
> > +#include <linux/i3c/device.h>
> > +#include <linux/spinlock.h>
> > +
> > +#define I3C_HOT_JOIN_ADDR		0x2
> > +#define I3C_BROADCAST_ADDR		0x7e
> > +#define I3C_MAX_ADDR			GENMASK(6, 0)
> > +
> > +struct i3c_master_controller;
> > +struct i3c_bus;
> > +
> > +/**
> > + * struct i3c_i2c_dev - I3C/I2C common information
> > + * @node: node element used to insert the device into the I2C or I3C d=
evice
> > + *	  list
> > + * @bus: I3C bus this device is connected to
> > + * @master: I3C master that instantiated this device. Will be used to =
send
> > + *	    I2C/I3C frames on the bus
> > + * @master_priv: master private data assigned to the device. Can be us=
ed to
> > + *		 add master specific information
> > + *
> > + * This structure is describing common I3C/I2C dev information.
> > + */
> > +struct i3c_i2c_dev {
> > +	struct list_head node;
> > +	struct i3c_bus *bus;
> > +	struct i3c_master_controller *master;
> > +	void *master_priv;
> > +};
> > +
> > +#define I3C_LVR_I2C_INDEX_MASK		GENMASK(7, 5)
> > +#define I3C_LVR_I2C_INDEX(x)		((x) << 5)
> > +#define I3C_LVR_I2C_FM_MODE		BIT(4)
> > +
> > +#define I2C_MAX_ADDR			GENMASK(9, 0) =20
>=20
> =C2=A0why 10-bit address?
>=20

Because some I2C devices have 10-bit addresses.

> =C2=A0> +
> > +/**
> > + * struct i2c_device - I2C device object
> > + * @common: inherit common I3C/I2C description
> > + * @info: I2C board info used to instantiate the I2C device. If you are
> > + *	  using DT to describe your hardware, this will be filled for you
> > + * @client: I2C client object created by the I2C framework. This will =
only
> > + *	    be valid after i3c_master_register() returns
> > + * @lvr: Legacy Virtual Register value as described in the I3C specifi=
cation
> > + *
> > + * I2C device object. Note that the real I2C device is represented by
> > + * i2c_device->client, but we need extra information to handle the dev=
ice when
> > + * it's connected to an I3C bus, hence the &struct i2c_device wrapper.
> > + *
> > + * The I2C framework is not impacted by this new representation.
> > + */
> > +struct i2c_device {
> > +	struct i3c_i2c_dev common;
> > +	struct i2c_board_info info;
> > +	struct i2c_client *client;
> > +	u8 lvr;
> > +};
> > + =20
>=20
> =C2=A0It is usefull to know the speed limitations of the device.

See my previous explanation about I2C and the max frequency. BTW, the
FM vs FM+ information is already encoded in the ->lvr field.

>=20
> =C2=A0> +
> > +/**
> > + * enum i3c_addr_slot_status - I3C address slot status
> > + * @I3C_ADDR_SLOT_FREE: address is free
> > + * @I3C_ADDR_SLOT_RSVD: address is reserved
> > + * @I3C_ADDR_SLOT_I2C_DEV: address is assigned to an I2C device
> > + * @I3C_ADDR_SLOT_I3C_DEV: address is assigned to an I3C device
> > + * @I3C_ADDR_SLOT_STATUS_MASK: address slot mask
> > + *
> > + * On an I3C bus, addresses are assigned dynamically, and we need to k=
now which
> > + * addresses are free to use and which ones are already assigned.
> > + *
> > + * Addresses marked as reserved are those reserved by the I3C protocol
> > + * (broadcast address, ...).
> > + */
> > +enum i3c_addr_slot_status {
> > +	I3C_ADDR_SLOT_FREE,
> > +	I3C_ADDR_SLOT_RSVD,
> > +	I3C_ADDR_SLOT_I2C_DEV,
> > +	I3C_ADDR_SLOT_I3C_DEV,
> > +	I3C_ADDR_SLOT_STATUS_MASK =3D 3,
> > +};
> > +
> > +/**
> > + * struct i3c_bus - I3C bus object
> > + * @dev: device to be registered to the device-model
> > + * @cur_master: I3C master currently driving the bus. Since I3C is mul=
ti-master
> > + *		this can change over the time. Will be used to let a master
> > + *		know whether it needs to request bus ownership before sending
> > + *		a frame or not
> > + * @id: bus ID. Assigned by the framework when register the bus
> > + * @addrslots: a bitmap with 2-bits per-slot to encode the address sta=
tus and
> > + *	       ease the DAA (Dynamic Address Assignment) procedure (see
> > + *	       &enum i3c_addr_slot_status)
> > + * @mode: bus mode (see &enum i3c_bus_mode)
> > + * @scl_rate: SCL signal rate for I3C and I2C mode
> > + * @devs: 2 lists containing all I3C/I2C devices connected to the bus
> > + * @lock: read/write lock on the bus. This is needed to protect against
> > + *	  operations that have an impact on the whole bus and the devices
> > + *	  connected to it. For example, when asking slaves to drop their
> > + *	  dynamic address (RSTDAA CCC), we need to make sure no one is tryi=
ng
> > + *	  to send I3C frames to these devices.
> > + *	  Note that this lock does not protect against concurrency between
> > + *	  devices: several drivers can send different I3C/I2C frames through
> > + *	  the same master in parallel. This is the responsibility of the
> > + *	  master to guarantee that frames are actually sent sequentially and
> > + *	  not interlaced
> > + *
> > + * The I3C bus is represented with its own object and not implicitly d=
escribed
> > + * by the I3C master to cope with the multi-master functionality, wher=
e one bus
> > + * can be shared amongst several masters, each of them requesting bus =
ownership
> > + * when they need to.
> > + */
> > +struct i3c_bus {
> > +	struct device dev;
> > +	struct i3c_device *cur_master;
> > +	int id;
> > +	unsigned long addrslots[((I2C_MAX_ADDR + 1) * 2) / BITS_PER_LONG];
> > +	enum i3c_bus_mode mode;
> > +	struct {
> > +		unsigned long i3c;
> > +		unsigned long i2c;
> > +	} scl_rate;
> > +	struct {
> > +		struct list_head i3c;
> > +		struct list_head i2c;
> > +	} devs;
> > +	struct rw_semaphore lock;
> > +}; =20
> Can you explain the addrslots[] ?

It's a bitmap encoding the status of I3C/I2C addresses: are they
assigned, reserved of free, and if they are assigned is it an I3C or
I2C device. That's particularly useful to master controller drivers
to know which addresses they can assign during DAA.

I'll try to clarify it in the kernel-doc header. =20

> > +
> > +static inline struct i3c_device *dev_to_i3cdev(struct device *dev)
> > +{
> > +	return container_of(dev, struct i3c_device, dev);
> > +}
> > +
> > +struct i3c_master_controller;
> > +
> > +/**
> > + * struct i3c_master_controller_ops - I3C master methods
> > + * @bus_init: hook responsible for the I3C bus initialization. This
> > + *	      initialization should follow the steps described in the I3C
> > + *	      specification. This hook is called with the bus lock held in
> > + *	      write mode, which means all _locked() helpers can safely be
> > + *	      called from there
> > + * @bus_cleanup: cleanup everything done in
> > + *		 &i3c_master_controller_ops->bus_init(). This function is
> > + *		 optional and should only be implemented if
> > + *		 &i3c_master_controller_ops->bus_init() attached private data
> > + *		 to I3C/I2C devices. This hook is called with the bus lock
> > + *		 held in write mode, which means all _locked() helpers can
> > + *		 safely be called from there
> > + * @supports_ccc_cmd: should return true if the CCC command is support=
ed, false
> > + *		      otherwise
> > + * @send_ccc_cmd: send a CCC command
> > + * @send_hdr_cmds: send one or several HDR commands. If there is more =
than one
> > + *		   command, they should ideally be sent in the same HDR
> > + *		   transaction
> > + * @priv_xfers: do one or several private I3C SDR transfers
> > + * @i2c_xfers: do one or several I2C transfers
> > + * @request_ibi: attach an IBI handler to an I3C device. This implies =
defining
> > + *		 an IBI handler and the constraints of the IBI (maximum payload
> > + *		 length and number of pre-allocated slots).
> > + *		 Some controllers support less IBI-capable devices than regular
> > + *		 devices, so this method might return -%EBUSY if there's no
> > + *		 more space for an extra IBI registration
> > + * @free_ibi: free an IBI previously requested with ->request_ibi(). T=
he IBI
> > + *	      should have been disabled with ->disable_irq() prior to that
> > + * @enable_ibi: enable the IBI. Only valid if ->request_ibi() has been=
 called
> > + *		prior to ->enable_ibi(). The controller should first enable
> > + *		the IBI on the controller end (for example, unmask the hardware
> > + *		IRQ) and then send the ENEC CCC command (with the IBI flag set)
> > + *		to the I3C device
> > + * @disable_ibi: disable an IBI. First send the DISEC CCC command with=
 the IBI
> > + *		 flag set and then deactivate the hardware IRQ on the
> > + *		 controller end
> > + * @recycle_ibi_slot: recycle an IBI slot. Called every time an IBI ha=
s been
> > + *		      processed by its handler. The IBI slot should be put back
> > + *		      in the IBI slot pool so that the controller can re-use it
> > + *		      for a future IBI
> > + *
> > + * One of the most important hooks in these ops is
> > + * &i3c_master_controller_ops->bus_init(). Here is a non-exhaustive li=
st of
> > + * things that should be done in &i3c_master_controller_ops->bus_init(=
):
> > + *
> > + * 1) call i3c_master_set_info() with all information describing the m=
aster
> > + * 2) ask all slaves to drop their dynamic address by sending the RSTD=
AA CCC
> > + *    with i3c_master_rstdaa_locked()
> > + * 3) ask all slaves to disable IBIs using i3c_master_disec_locked()
> > + * 4) start a DDA procedure by sending the ENTDAA CCC with
> > + *    i3c_master_entdaa_locked(), or using the internal DAA logic prov=
ided by
> > + *    your controller =20
> You mean SETDASA CCC command?

No, I really mean ENTDAA and DAA. By internal DAA logic I mean that
some controllers are probably automating the whole DAA procedure, while
others may let the SW control every step.

Thanks for your review.

Boris

--=20
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
