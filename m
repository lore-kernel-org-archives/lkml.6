Return-Path: <Vitor.Soares@synopsys.com>
X-Google-Smtp-Source: AH8x227dVLFCHb0PEJh1B4Iy9nUTMTumj/0HldpoCH0bNZC9Y9tL2bFgKpNtxBlhDS49hc0L3GcM
ARC-Seal: i=1; a=rsa-sha256; t=1519747448; cv=none;
        d=google.com; s=arc-20160816;
        b=K7Fz9yVsAwyyWjPZnth9m0BpEYhVtXI6XKGCDci+tu+c2yVPuBuS+NGzkJiq9xB3RH
         rYtzCJmZljhcxYM29BEiT5mU0QPX5dnRDPELayUKoRv1Fu/XW8655yoz2j8zd0MLFz26
         AQ8TdgSluTmNEnFL/7Nu9TAuy74avlLwDtduutzxRJx58Hjsk0iOB4sm+3CBiDhimHZZ
         MCpwUjl6OnjrhochhJpK2RBa716OT/WguoO36/v8ipmu6yOFOMkE5fzCuaZiEsvKUGXc
         FwLymuBTh3VP89uHk7EvTiXIUGEguRFZ62Ni6cS9KIoOn8E2gH3xLeWAxvGCdn5o+8/E
         9MWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=JCZogMdxyHMRDxYnN5vCR1cq/Rv5UmGsKyLTE8I5cpM=;
        b=iI92TNS+oOIl7Q28m4sT49iaTXGHCReqLP83ADQzJnOVOR1BzuwGXjNnvjpgZDxY4W
         9L6ZYcFCFlo9N8NQEqPkYzPqjljAeBOwp7Ho9Y7S40ZkhI2TryPPbbRE3w2iWoFiTkim
         hPc4u4soBwOtKyTSiqwUO/r+pGIiErAt/HmizgH3NCH3kU7v8c3+8JCL4qsm/UOaq9h1
         XhBZge3W6VSKAcM7kOKcWRow7iErDRI1TvOEKEu8f1IssvzwAgEZtk3D91y88axDd976
         PxNhTr1126ICNhx9BkVEeYY4/bZf2Sok4WDs031HQ+piG5erHY6op6iLrtUVZia0YxOt
         H0HQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of vitor.soares@synopsys.com designates 198.182.60.111 as permitted sender) smtp.mailfrom=Vitor.Soares@synopsys.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=synopsys.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of vitor.soares@synopsys.com designates 198.182.60.111 as permitted sender) smtp.mailfrom=Vitor.Soares@synopsys.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=synopsys.com
Subject: Re: [PATCH v2 2/7] i3c: Add core I3C infrastructure
To: Boris Brezillon <boris.brezillon@bootlin.com>, Vitor Soares
	<Vitor.Soares@synopsys.com>
CC: Boris Brezillon <boris.brezillon@free-electrons.com>, Wolfram Sang
	<wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, <linux-doc@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka
	<psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas
	<adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos
	<dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, "Cyprian
 Wronka" <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Thomas
 Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>,
	Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark
 Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Geert Uytterhoeven" <geert@linux-m68k.org>,
	Linus Walleij <linus.walleij@linaro.org>
References: <20171214151610.19153-1-boris.brezillon@free-electrons.com>
 <20171214151610.19153-3-boris.brezillon@free-electrons.com>
 <b39f9016-b2ff-6d8d-96b3-945f32ab2b67@synopsys.com>
 <20180223213000.407461d2@bbrezillon>
 <1b8fe82f-079b-6f55-0e59-5773027faa8e@synopsys.com>
 <20180226213607.7161bb0a@bbrezillon>
From: Vitor Soares <Vitor.Soares@synopsys.com>
Message-ID: <b9c057ad-47a0-fa35-0f30-8d465d40b6f0@synopsys.com>
Date: Tue, 27 Feb 2018 16:03:58 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226213607.7161bb0a@bbrezillon>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: pt-PT
X-Originating-IP: [10.107.19.101]
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1586772916728163872?=
X-GMAIL-MSGID: =?utf-8?q?1593570700378235923?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Boris


Às 8:36 PM de 2/26/2018, Boris Brezillon escreveu:
> Hi Vitor,
>
> On Mon, 26 Feb 2018 18:58:15 +0000
> Vitor Soares <Vitor.Soares@synopsys.com> wrote:
>
>>>>> +/**
>>>>> + * i3c_device_do_priv_xfers() - do I3C SDR private transfers directed to a
>>>>> + *				specific device
>>>>> + *
>>>>> + * @dev: device with which the transfers should be done
>>>>> + * @xfers: array of transfers
>>>>> + * @nxfers: number of transfers
>>>>> + *
>>>>> + * Initiate one or several private SDR transfers with @dev.
>>>>> + *
>>>>> + * This function can sleep and thus cannot be called in atomic context.
>>>>> + *
>>>>> + * Return: 0 in case of success, a negative error core otherwise.
>>>>> + */
>>>>> +int i3c_device_do_priv_xfers(struct i3c_device *dev,
>>>>> +			     struct i3c_priv_xfer *xfers,
>>>>> +			     int nxfers)
>>>>> +{
>>>>> +	struct i3c_master_controller *master;
>>>>> +	int i, ret;
>>>>> +
>>>>> +	master = i3c_device_get_master(dev);
>>>>> +	if (!master)
>>>>> +		return -EINVAL;
>>>>> +
>>>>> +	i3c_bus_normaluse_lock(master->bus);
>>>>> +	for (i = 0; i < nxfers; i++)
>>>>> +		xfers[i].addr = dev->info.dyn_addr;
>>>>> +
>>>>> +	ret = i3c_master_do_priv_xfers_locked(master, xfers, nxfers);
>>>>> +	i3c_bus_normaluse_unlock(master->bus);
>>>>> +
>>>>> +	return ret;
>>>>> +}
>>>>> +EXPORT_SYMBOL_GPL(i3c_device_do_priv_xfers);    
>>>>  The controller should know the speed mode for each xfer. The SDR0 mode 
>>>> is used by default but if any device have read or write speed 
>>>> limitations the controller can use SDRx.  
>>> I might be wrong, but that's not my understanding of the spec. A device
>>> can express a speed limitation for SDR priv transfers, but this
>>> limitation applies to all SDR transfers.
>>>
>>> The speed R/W speed limitation is encoded in the device object, so, if
>>> the controller has to configure that on a per-transfer basis, one
>>> solution would be to pass the device to the ->priv_xfers().  
>> The speed R/W limitation is only for private transfers. Also the device can have
>> a limitation to write and not for read data.
>> This information is obtained with the command GETMXDS which returns the Maximum
>> Sustained Data Rate for non-CCC messages.
> And that's exactly what I expose in i3c_device_info, which is embedded
> in i3c_device, so you should have all the information you need to
> determine the speed in the controller driver if ->priv_xfer() is passed
> the device attached to those transfers. Would that be okay if we pass an
> i3c_device object to ->priv_xfers()?

If you pass the i3c_device to ->priv_xfer(), then you won't need the address too.

Maybe someone else can give other point of view.

>>>  
>>>> This could be also applied to i2c transfers.  
>>> Not really. The max SCL frequency is something that applies to the
>>> whole bus, because all I2C devices have to decode the address when
>>> messages are sent on the bus to determine if they should ignore or
>>> process the message.
>>>  
>>>>> +#endif /* I3C_INTERNAL_H */
>>>>> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
>>>>> new file mode 100644
>>>>> index 000000000000..1c85abac08d5
>>>>> --- /dev/null
>>>>> +++ b/drivers/i3c/master.c
>>>>> @@ -0,0 +1,1433 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>> +/*
>>>>> + * Copyright (C) 2017 Cadence Design Systems Inc.
>>>>> + *
>>>>> + * Author: Boris Brezillon<boris.brezillon@free-electrons.com>
>>>>> + */
>>>>> +
>>>>> +#include <linux/slab.h>
>>>>> +
>>>>> +#include "internals.h"
>>>>> +
>>>>> +/**
>>>>> + * i3c_master_entdaa_locked() - start a DAA (Dynamic Address Assignment)
>>>>> + *				procedure
>>>>> + * @master: master used to send frames on the bus
>>>>> + *
>>>>> + * Send a ENTDAA CCC command to start a DAA procedure.
>>>>> + *
>>>>> + * Note that this function only sends the ENTDAA CCC command, all the logic
>>>>> + * behind dynamic address assignment has to be handled in the I3C master
>>>>> + * driver.
>>>>> + *
>>>>> + * This function must be called with the bus lock held in write mode.
>>>>> + *
>>>>> + * Return: 0 in case of success, a negative error code otherwise.
>>>>> + */
>>>>> +int i3c_master_entdaa_locked(struct i3c_master_controller *master)
>>>>> +{
>>>>> +	struct i3c_ccc_cmd_dest dest = { };
>>>>> +	struct i3c_ccc_cmd cmd = { };
>>>>> +	int ret;
>>>>> +
>>>>> +	dest.addr = I3C_BROADCAST_ADDR;
>>>>> +	cmd.dests = &dest;
>>>>> +	cmd.ndests = 1;
>>>>> +	cmd.rnw = false;
>>>>> +	cmd.id = I3C_CCC_ENTDAA;
>>>>> +
>>>>> +	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
>>>>> +	if (ret)
>>>>> +		return ret;
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +EXPORT_SYMBOL_GPL(i3c_master_entdaa_locked);    
>>>>  can you explain the process?  
>>> Not sure what you mean. The ENTDAA is just a CCC command that is used
>>> to trigger a DAA procedure. What the master controller does when it
>>> sends such a command is likely to be controller dependent, and it might
>>> even be possible that you don't need to call this function in your
>>> controller driver to trigger a DAA. If you want more details about the
>>> bus initialization steps and how the ENTDAA CCC command fits into it I
>>> recommend reading section "5.1.4 Bus Initialization and Dynamic Address
>>> Assignment Mode"
>>>  
>>>> the command is only execute once, what if 
>>>> there is more devices on the bus?  
>>> Again, I'm not sure what you mean. The ENTDAA command is sent every
>>> time a controller wants to discover new devices on the bus, that can be
>>> when initializing the bus, after a Hot Join event or simply triggered
>>> by the user (the last case is not supported yet though).
>>>
>>> Now, if you're interested in what happens after an ENTDAA CCC is sent,
>>> the controller will keep sending RepeatedStart until there's no more
>>> devices acking the request. You can have a look at "B.3 Error Types in
>>> Dynamic Address Arbitration" for more details.  
>> My understanding is this command shall be executed once, this mean that only one
>> slave will assign the dynamic address (cmd.ndests = 1) and not trigger the whole
>> process of DAA.
> No, that's not what happens. The master controller is supposed to
> continue until no one replies with an Ack on the bus, and by continue I
> don't mean resend an ENTDAA, but issue a RepeatedStart followed by the
> broadcast address (0x7e).

I am sorry, you have point here. I misunderstood that the cmd.ndests = 1 is for
broadcast commands.

>> Either important is the SETDASA for declared I3C devices. So the DAA process
>> should start by send an SETDASA and them ENTDAA CCC command.
> My understanding was that SETDASA was not mandatory, and was only useful
> when one wants to assign a specific dynamic address to a slave that has
> a static address (which is again not mandatory).
> I've tested it, and even devices with a static address participate to
> the DAA procedure if they've not been assigned a dynamic address yet,
> so I don't see the need for this SETDASA step if you don't need to
> assign a particular dynamic address to the device.
>
> Could you tell me why you think SETDASA is required?

Yes, you are right... But in my opinion it is required as it does part of DAA
process.

>>>>> +static u32 i3c_master_i2c_functionalities(struct i2c_adapter *adap)
>>>>> +{
>>>>> +	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_I2C | I2C_FUNC_10BIT_ADDR;
>>>>> +}    
>>>>  Is I2C_FUNC_10BIT_ADDR allowed ?  
>>> According to "Table 4 I 2 C Features Allowed in I3C Slaves", yes (at
>>> least that my understanding). And the Cadence controller supports it.  
>> The table say the oposite. The I2C extended address feature is not used on I3C
>> bus, thus this feature shall be disable.
> Actually, I was wrong when initially mentioning this table: it's about
> I2C features supported on I3C slaves, so not really what we're looking
> for. Here, we're wondering if I2C-only devices can have 10-bit
> addresses. The Cadence controller supports that, so there's probably
> nothing preventing use of 10-bit addresses for I2C transfers, but maybe
> not all I3C master controllers support that, so we should probably
> let the I3C master driver implement this method.

The spec says that is "not used" so it will not interface with I3C bus.

>> BTW it is optional on I2C devices.
> You mean I2C controllers? When an I2C device has a 10bit address, the
> controller has to support this mode to communicate with the device, at
> least that's my understanding. But we're digressing a bit. The
> question is not whether I2C devices can optionally use a 10 bit
> address, but whether I3C master controller can support this mode for
> I2C transfers to I2C-only devices.

By the i2c spec the 10-bit address is optional, however the 7-bit address is
mandatory.

>>>  
>>>>  > diff --git a/drivers/i3c/master/Kconfig b/drivers/i3c/master/Kconfig
>>>>> new file mode 100644
>>>>> index 000000000000..e69de29bb2d1
>>>>> diff --git a/drivers/i3c/master/Makefile b/drivers/i3c/master/Makefile
>>>>> new file mode 100644
>>>>> index 000000000000..e69de29bb2d1
>>>>> diff --git a/include/linux/i3c/ccc.h b/include/linux/i3c/ccc.h
>>>>> new file mode 100644
>>>>> index 000000000000..ff3e1a3e2c4c
>>>>> --- /dev/null
>>>>> +++ b/include/linux/i3c/ccc.h
>>>>> @@ -0,0 +1,380 @@
>>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>>> +/*
>>>>> + * Copyright (C) 2017 Cadence Design Systems Inc.
>>>>> + *
>>>>> + * Author: Boris Brezillon<boris.brezillon@free-electrons.com>
>>>>> + */
>>>>> +
>>>>> +
>>>>> +/**
>>>>> + * enum i3c_ccc_test_mode - enum listing all available test modes
>>>>> + *
>>>>> + * @I3C_CCC_EXIT_TEST_MODE: exit test mode
>>>>> + * @I3C_CCC_VENDOR_TEST_MODE: enter vendor test mode
>>>>> + */
>>>>> +enum i3c_ccc_test_mode {
>>>>> +	I3C_CCC_EXIT_TEST_MODE,
>>>>> +	I3C_CCC_VENDOR_TEST_MODE,
>>>>> +};
>>>>> +
>>>>> +/**
>>>>> + * struct i3c_ccc_enttm - payload passed to ENTTM CCC
>>>>> + *
>>>>> + * @mode: one of the &enum i3c_ccc_test_mode modes
>>>>> + *
>>>>> + * Information passed to the ENTTM CCC to instruct an I3C device to enter a
>>>>> + * specific test mode.
>>>>> + */
>>>>> +struct i3c_ccc_enttm {
>>>>> +	u8 mode;
>>>>> +} __packed;
>>>>> +
>>>>> +/**
>>>>> + * struct i3c_ccc_setda - payload passed to ENTTM CCC
>>>>> + *
>>>>> + * @mode: one of the &enum i3c_ccc_test_mode modes
>>>>> + *
>>>>> + * Information passed to the ENTTM CCC to instruct an I3C device to enter a
>>>>> + * specific test mode.
>>>>> + */
>>>>> +struct i3c_ccc_setda {
>>>>> +	u8 addr;
>>>>> +} __packed;    
>>>>  what do you mean with struct? Maybe setdasa? if so, what is the addr?  
>> Do you have the function to use this structure? Because one command use the
>> static address and the other use the dynamic address.
>>
>>>>  
>>>>  > +/**
>>>>> + * enum i3c_sdr_max_data_rate - max data rate values for private SDR transfers
>>>>> + */
>>>>> +enum i3c_sdr_max_data_rate {
>>>>> +	I3C_SDR_DR_FSCL_MAX,
>>>>> +	I3C_SDR_DR_FSCL_8MHZ,
>>>>> +	I3C_SDR_DR_FSCL_6MHZ,
>>>>> +	I3C_SDR_DR_FSCL_4MHZ,
>>>>> +	I3C_SDR_DR_FSCL_2MHZ,
>>>>> +};    
>>>> Can you change the names to:
>>>>
>>>> I3C_SDR0_FSCL_MAX,
>>>> I3C_SDR1_FSCL_8MHZ,
>>>> I3C_SDR2_FSCL_6MHZ,
>>>> I3C_SDR3_FSCL_4MHZ,
>>>> I3C_SDR4_FSCL_2MHZ,
>>>>
>>>> thus the data rate isn't repeated.  
>>> What's the problem with the name I use? Moreover, I see no mention to
>>> the SDR0,1,2,3,4 modes in the public spec.  
>> When you get the GETMXDS information, the maxWr and maxRd came from 0 to 4, so
>> in my opinion I think in this way is easier to have a relationship.
> It's an emum, and there's no mention of the SDRX modes you're using
> here in the I3C spec. I guess it's named this way in your I3C
> controller datasheet. I personally don't see a good reason to add SDRX
> in the name, but if you insist...

The idea is to say that it is SDR mode and the value that GETMXDS command
return. It is what makes sense to me.

>>>>> +
>>>>> +#endif /* I3C_CCC_H */
>>>>> diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
>>>>> new file mode 100644
>>>>> index 000000000000..83958d3a02e2
>>>>> --- /dev/null
>>>>> +++ b/include/linux/i3c/device.h
>>>>> @@ -0,0 +1,321 @@
>>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>>> +/*
>>>>> + * Copyright (C) 2017 Cadence Design Systems Inc.
>>>>> + *
>>>>> + * Author: Boris Brezillon<boris.brezillon@free-electrons.com>
>>>>> + */
>>>>> +
>>>>> +#ifndef I3C_DEV_H
>>>>> +#define I3C_DEV_H
>>>>> +
>>>>> +#include <linux/device.h>
>>>>> +#include <linux/i2c.h>
>>>>> +#include <linux/mod_devicetable.h>
>>>>> +#include <linux/module.h>
>>>>> +
>>>>> +/**
>>>>> + * enum i3c_hdr_mode - HDR mode ids
>>>>> + * @I3C_HDR_DDR: DDR mode
>>>>> + * @I3C_HDR_TSP: TSP mode
>>>>> + * @I3C_HDR_TSL: TSL mode
>>>>> + */
>>>>> +enum i3c_hdr_mode {
>>>>> +	I3C_HDR_DDR,
>>>>> +	I3C_HDR_TSP,
>>>>> +	I3C_HDR_TSL,
>>>>> +};
>>>>> +
>>>>> +/**
>>>>> + * struct i3c_hdr_cmd - I3C HDR command
>>>>> + * @mode: HDR mode selected for this command
>>>>> + * @code: command opcode
>>>>> + * @addr: I3C dynamic address
>>>>> + * @ndatawords: number of data words (a word is 16bits wide)
>>>>> + * @data: input/output buffer
>>>>> + */
>>>>> +struct i3c_hdr_cmd {
>>>>> +	enum i3c_hdr_mode mode;
>>>>> +	u8 code;
>>>>> +	u8 addr;
>>>>> +	int ndatawords;
>>>>> +	union {
>>>>> +		u16 *in;
>>>>> +		const u16 *out;
>>>>> +	} data;
>>>>> +};  
>> Please mention that the @code is what will define if the transfer is read or write.
> Well, I think it's pretty clear in the definition you'll find in the
> ccc.h file, but I can add a comment here too if you like.

I don't find it in ccc.h file. Anyway is not good to put this definition there
because is not related.

>>>>> +
>>>>> +/* Private SDR read transfer */
>>>>> +#define I3C_PRIV_XFER_READ		BIT(0)
>>>>> +/*
>>>>> + * Instruct the controller to issue a STOP after a specific transfer instead
>>>>> + * of a REPEATED START.
>>>>> + */
>>>>> +#define I3C_PRIV_XFER_STOP		BIT(1)
>>>>> +
>>>>> +/**
>>>>> + * struct i3c_priv_xfer - I3C SDR private transfer
>>>>> + * @addr: I3C dynamic address
>>>>> + * @len: transfer length in bytes of the transfer
>>>>> + * @flags: combination of I3C_PRIV_XFER_xxx flags
>>>>> + * @data: input/output buffer
>>>>> + */
>>>>> +struct i3c_priv_xfer {
>>>>> +	u8 addr;
>>>>> +	u16 len;
>>>>> +	u32 flags;
>>>>> +	struct {
>>>>> +		void *in;
>>>>> +		const void *out;
>>>>> +	} data;
>>>>> +};    
>>>>  Same as above, i3c_sdr_max_data_rate to change the bus scl.  
>>> If I'm understanding the spec correctly, that's not something you want
>>> to change on a per-transfer basis. The constraint is on the device
>>> itself and should IMO not be part of the i3c_priv_xfer struct.  
>> As mention before this is important.
>> You can do the same as for struct i3c_hdr_cmd and add a enum i3c_sdr_max_data_rate.
>>
>> The @flag only have 2 bits of load, is the rest opened?
> If by open you mean that we can add more flags if we need to, then yes.
>
>>>  
>>>>  > +
>>>>> +/**
>>>>> + * enum i3c_dcr - I3C DCR values
>>>>> + * @I3C_DCR_GENERIC_DEVICE: generic I3C device
>>>>> + */
>>>>> +enum i3c_dcr {
>>>>> +	I3C_DCR_GENERIC_DEVICE = 0,
>>>>> +};
>>>>> +
>>>>> +#define I3C_PID_MANUF_ID(pid)		(((pid) & GENMASK_ULL(47, 33)) >> 33)
>>>>> +#define I3C_PID_RND_LOWER_32BITS(pid)	(!!((pid) & BIT_ULL(32)))
>>>>> +#define I3C_PID_RND_VAL(pid)		((pid) & GENMASK_ULL(31, 0))
>>>>> +#define I3C_PID_PART_ID(pid)		(((pid) & GENMASK_ULL(31, 16)) >> 16)
>>>>> +#define I3C_PID_INSTANCE_ID(pid)	(((pid) & GENMASK_ULL(15, 12)) >> 12)
>>>>> +#define I3C_PID_EXTRA_INFO(pid)		((pid) & GENMASK_ULL(11, 0))
>>>>> +
>>>>> +#define I3C_BCR_DEVICE_ROLE(bcr)	((bcr) & GENMASK(7, 6))
>>>>> +#define I3C_BCR_I3C_SLAVE		(0 << 6)
>>>>> +#define I3C_BCR_I3C_MASTER		(1 << 6)
>>>>> +#define I3C_BCR_HDR_CAP			BIT(5)
>>>>> +#define I3C_BCR_BRIDGE			BIT(4)
>>>>> +#define I3C_BCR_OFFLINE_CAP		BIT(3)
>>>>> +#define I3C_BCR_IBI_PAYLOAD		BIT(2)
>>>>> +#define I3C_BCR_IBI_REQ_CAP		BIT(1)
>>>>> +#define I3C_BCR_MAX_DATA_SPEED_LIM	BIT(0)
>>>>> +
>>>>> +/**
>>>>> + * struct i3c_device_info - I3C device information
>>>>> + * @pid: Provisional ID
>>>>> + * @bcr: Bus Characteristic Register
>>>>> + * @dcr: Device Characteristic Register
>>>>> + * @static_addr: static/I2C address
>>>>> + * @dyn_addr: dynamic address
>>>>> + * @hdr_cap: supported HDR modes
>>>>> + * @max_read_ds: max read speed information
>>>>> + * @max_write_ds: max write speed information
>>>>> + * @max_ibi_len: max IBI payload length
>>>>> + * @max_read_turnaround: max read turn-around time in micro-seconds
>>>>> + * @max_read_len: max private SDR read length in bytes
>>>>> + * @max_write_len: max private SDR write length in bytes
>>>>> + *
>>>>> + * These are all basic information that should be advertised by an I3C device.
>>>>> + * Some of them are optional depending on the device type and device
>>>>> + * capabilities.
>>>>> + * For each I3C slave attached to a master with
>>>>> + * i3c_master_add_i3c_dev_locked(), the core will send the relevant CCC command
>>>>> + * to retrieve these data.
>>>>> + */
>>>>> +struct i3c_device_info {
>>>>> +	u64 pid;
>>>>> +	u8 bcr;
>>>>> +	u8 dcr;
>>>>> +	u8 static_addr;
>>>>> +	u8 dyn_addr;
>>>>> +	u8 hdr_cap;
>>>>> +	u8 max_read_ds;
>>>>> +	u8 max_write_ds;
>>>>> +	u8 max_ibi_len;
>>>>> +	u32 max_read_turnaround;
>>>>> +	u16 max_read_len;
>>>>> +	u16 max_write_len;
>>>>> +};
>>>>> +    
>>>>  is this information filled with data provided from CCC commands?  
>>> Yes, they are.  
>> Ok, them the intention is to do this on bus_init(), right?
> Not only, it can be after a Hot-Join, or after the user has triggered a
> new DAA. Anyway, these information are retrieved anytime you add a
> device with i3c_master_add_i3c_dev_locked(), and the core uses CCC
> commands to do that.
>
>>>>> +
>>>>> +/**
>>>>> + * struct i3c_master_controller_ops - I3C master methods
>>>>> + * @bus_init: hook responsible for the I3C bus initialization. This
>>>>> + *	      initialization should follow the steps described in the I3C
>>>>> + *	      specification. This hook is called with the bus lock held in
>>>>> + *	      write mode, which means all _locked() helpers can safely be
>>>>> + *	      called from there
>>>>> + * @bus_cleanup: cleanup everything done in
>>>>> + *		 &i3c_master_controller_ops->bus_init(). This function is
>>>>> + *		 optional and should only be implemented if
>>>>> + *		 &i3c_master_controller_ops->bus_init() attached private data
>>>>> + *		 to I3C/I2C devices. This hook is called with the bus lock
>>>>> + *		 held in write mode, which means all _locked() helpers can
>>>>> + *		 safely be called from there
>>>>> + * @supports_ccc_cmd: should return true if the CCC command is supported, false
>>>>> + *		      otherwise
>>>>> + * @send_ccc_cmd: send a CCC command
>>>>> + * @send_hdr_cmds: send one or several HDR commands. If there is more than one
>>>>> + *		   command, they should ideally be sent in the same HDR
>>>>> + *		   transaction
>>>>> + * @priv_xfers: do one or several private I3C SDR transfers
>>>>> + * @i2c_xfers: do one or several I2C transfers
>>>>> + * @request_ibi: attach an IBI handler to an I3C device. This implies defining
>>>>> + *		 an IBI handler and the constraints of the IBI (maximum payload
>>>>> + *		 length and number of pre-allocated slots).
>>>>> + *		 Some controllers support less IBI-capable devices than regular
>>>>> + *		 devices, so this method might return -%EBUSY if there's no
>>>>> + *		 more space for an extra IBI registration
>>>>> + * @free_ibi: free an IBI previously requested with ->request_ibi(). The IBI
>>>>> + *	      should have been disabled with ->disable_irq() prior to that
>>>>> + * @enable_ibi: enable the IBI. Only valid if ->request_ibi() has been called
>>>>> + *		prior to ->enable_ibi(). The controller should first enable
>>>>> + *		the IBI on the controller end (for example, unmask the hardware
>>>>> + *		IRQ) and then send the ENEC CCC command (with the IBI flag set)
>>>>> + *		to the I3C device
>>>>> + * @disable_ibi: disable an IBI. First send the DISEC CCC command with the IBI
>>>>> + *		 flag set and then deactivate the hardware IRQ on the
>>>>> + *		 controller end
>>>>> + * @recycle_ibi_slot: recycle an IBI slot. Called every time an IBI has been
>>>>> + *		      processed by its handler. The IBI slot should be put back
>>>>> + *		      in the IBI slot pool so that the controller can re-use it
>>>>> + *		      for a future IBI
>>>>> + *
>>>>> + * One of the most important hooks in these ops is
>>>>> + * &i3c_master_controller_ops->bus_init(). Here is a non-exhaustive list of
>>>>> + * things that should be done in &i3c_master_controller_ops->bus_init():
>>>>> + *
>>>>> + * 1) call i3c_master_set_info() with all information describing the master
>>>>> + * 2) ask all slaves to drop their dynamic address by sending the RSTDAA CCC
>>>>> + *    with i3c_master_rstdaa_locked()
>>>>> + * 3) ask all slaves to disable IBIs using i3c_master_disec_locked()
>>>>> + * 4) start a DDA procedure by sending the ENTDAA CCC with
>>>>> + *    i3c_master_entdaa_locked(), or using the internal DAA logic provided by
>>>>> + *    your controller    
>>>> You mean SETDASA CCC command?  
>>> No, I really mean ENTDAA and DAA. By internal DAA logic I mean that
>>> some controllers are probably automating the whole DAA procedure, while
>>> others may let the SW control every step.  
>> My understanding is that i3c_master_entdaa_locked() will trigger the DAA process
>> and DAA can be done by SETDASA, ENTDAA and later after the bus initialization
>> with SETNEWDA.
> No. Only ENTDAA can trigger a DAA procedure. SETDASA is here to assign
> a single dynamic address to a device that already has a static address
> but no dynamic address yet, and SETNEWDA is here to modify the dynamic
> address of a device that already has one.

>> I think the DAA process should be more generic, right now is only made through
>> the ENTDAA command with (cmd.ndests = 1).
>> I mean, shouldn't this be made by the core? First doing DAA for the devices
>> declared and them try do discover the rest of devices on the bus.
> Can you detail a bit more? If the only part you're complaining about is
> pre-assignment of dynamic addresses with SETDASA when a device is
> declared in the DT with a reg and dynamic-address property, then yes, I
> think I can provide an helper for that. But this helper would still have
> to be called from the master controller driver (from ->bus_init() or
> after a Hot-Join).
>
> Now, if the question is, is there a way we can automate things even more
> and completely implement DAA from the core? I doubt it, because the way
> the core will trigger DAA, expose discovered devices or allow you to
> declare manually assigned addresses is likely to be
> controller-dependent.

Please refer to figure 90 of public specification. As you can see the DAA
process should start with SETDASA command.

With the current flow of this patch the DAA process is limited to ENTDAA command
only.

> When I designed the framework I took the decision to base my work on the
> spec rather than focusing on the I3C master controller I had to support
> (Cadence). This is the reason I decided to keep the interface as simple
> as possible at the risk of encouraging code-duplication (at first)
> rather than coming up with an interface that is designed with a single
> controller in mind and having to break things every time a new
> controller comes out.
>
> Thank you for you comments, but I'd like to know if some of my design
> choices are blocking you to support your controller. What I've seen so
> far is a collection of things that might be relevant to fix (though
> most of them are subject to interpretation and/or a matter of taste),
> but nothing that should really block you.
>
> Can you clarify that, and maybe come back with a list of things that you
> think are preventing you from properly supporting the Synopsys
> controller?
>
> Thanks,
>
> Boris 

As you can check from my  comments my concerns are about the i3c specification
without the controller in mind.

Best regards,
Vitor Soares
