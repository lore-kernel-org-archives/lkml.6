Return-Path: <boris.brezillon@bootlin.com>
X-Google-Smtp-Source: AH8x227sMNFX3wER9+sfWfxxiM4ljDee3oy/N2vOxIHp/s/yuQh8vws20SELi8wOThWS6J55rtfj
ARC-Seal: i=1; a=rsa-sha256; t=1519761484; cv=none;
        d=google.com; s=arc-20160816;
        b=XJfDNRxcaQQFDoPbAIXq500oad2i4/A/9DbIZpb3MZEZlwVvDHYlJjJu/bfPQBDojH
         hEDBixraDe0VR/qY52U9v6e/Z4nJKLFSZl410fgjv1u7KDGs4I7nRY+TrYl7BPdyIMho
         FgUT7AtD8zZqC4kFQylY9cgQq3ApfNrtGmFG7/SnAjg33KJCQGBxdYCWAw1U+HWMebyk
         tpozmW3kBv1Ciz1Inq3TtO8+3XurYyDKc/CYxI+5LiZcKqH5TE9znSltbCJtV7SpIm2J
         YZEuvDV8oAift8MziioPMupMtjJNOBOpToFSrjn1fUc7cme0b4vx/zoe4IRBLq79W+U+
         r/4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=teoOqom53EXg6xQO7FpCJ2iR7OmH4rLjfGFjlXq/aCk=;
        b=GNu0FyCwhjUq/7VlTsd3ngJB+0/7Y5t+uWfo8Q6woYVaOHU0aUjpH6/KChtfSbgBWi
         4r+Su0aaFb71YhWxSHKesVGCMCAE66D8V8ym6cUibhYfTY4LLFD/XE3K2M7BG50ub70V
         rRiBLMKss5HNeuWkhrHiJB9Cmy5Rx7e4R/5YvYqBZhERNQiezScjZV6w+nxuCLvYBquq
         o6GLbvsjFw4reF9ECgoURt7kN9OmBbbSm/m3CWf1ukq+ixDyDccsn1743hw13uhCGCTn
         AU9yt6ckEO28IlgACrommJmnXeZoQEsPl9SdPgSZnE5O6RGh9eJzzhMmDA7hxUBTRvxn
         whWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Date: Tue, 27 Feb 2018 20:57:50 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Vitor Soares <Vitor.Soares@synopsys.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Wolfram Sang
 <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, <linux-doc@vger.kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw
 Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan
 Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian
 Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>,
 "Cyprian Wronka" <cwronka@cadence.com>, Suresh Punnoose
 <sureshp@cadence.com>, Thomas Petazzoni
 <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob
 Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland
 <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar
 Gala <galak@codeaurora.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Geert Uytterhoeven"
 <geert@linux-m68k.org>, Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 2/7] i3c: Add core I3C infrastructure
Message-ID: <20180227205750.4466e71e@bbrezillon>
In-Reply-To: <b9c057ad-47a0-fa35-0f30-8d465d40b6f0@synopsys.com>
References: <20171214151610.19153-1-boris.brezillon@free-electrons.com>
	<20171214151610.19153-3-boris.brezillon@free-electrons.com>
	<b39f9016-b2ff-6d8d-96b3-945f32ab2b67@synopsys.com>
	<20180223213000.407461d2@bbrezillon>
	<1b8fe82f-079b-6f55-0e59-5773027faa8e@synopsys.com>
	<20180226213607.7161bb0a@bbrezillon>
	<b9c057ad-47a0-fa35-0f30-8d465d40b6f0@synopsys.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1586772916728163872?=
X-GMAIL-MSGID: =?utf-8?q?1593585418488274308?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Vitor,

On Tue, 27 Feb 2018 16:03:58 +0000
Vitor Soares <Vitor.Soares@synopsys.com> wrote:

> >>>
> >>> The speed R/W speed limitation is encoded in the device object, so, if
> >>> the controller has to configure that on a per-transfer basis, one
> >>> solution would be to pass the device to the ->priv_xfers().   =20
> >> The speed R/W limitation is only for private transfers. Also the devic=
e can have
> >> a limitation to write and not for read data.
> >> This information is obtained with the command GETMXDS which returns th=
e Maximum
> >> Sustained Data Rate for non-CCC messages. =20
> > And that's exactly what I expose in i3c_device_info, which is embedded
> > in i3c_device, so you should have all the information you need to
> > determine the speed in the controller driver if ->priv_xfer() is passed
> > the device attached to those transfers. Would that be okay if we pass an
> > i3c_device object to ->priv_xfers()? =20
>=20
> If you pass the i3c_device to ->priv_xfer(), then you won't need the addr=
ess too.

That's true. So how about we pass the i3c_device to ->priv_xfer() and
drop the address field in i3c_priv_xfer. Or we could remove the address
field add an i3c_device pointer in i3c_priv_xfer, this way, if we ever
need to do cross-device sequence we'll be able to support it.

>=20
> Maybe someone else can give other point of view.

That'd be great, but I'd like to hear your opinion, because it's not
clear to me what you think of my suggestion.


> >> Either important is the SETDASA for declared I3C devices. So the DAA p=
rocess
> >> should start by send an SETDASA and them ENTDAA CCC command. =20
> > My understanding was that SETDASA was not mandatory, and was only useful
> > when one wants to assign a specific dynamic address to a slave that has
> > a static address (which is again not mandatory).
> > I've tested it, and even devices with a static address participate to
> > the DAA procedure if they've not been assigned a dynamic address yet,
> > so I don't see the need for this SETDASA step if you don't need to
> > assign a particular dynamic address to the device.
> >
> > Could you tell me why you think SETDASA is required? =20
>=20
> Yes, you are right... But in my opinion it is required as it does part of=
 DAA
> process.

As Przemek said in his reply, I don't think it's required, at least not
for the initial implementation. I'm definitely not saying we should
never support the feature, but it can easily be added afterwards.

BTW, can you give me a scenario where you'll want to assign a specific
dynamic address to a device before DAA takes place (by DAA, I mean what
happens after ENTDAA, which AIUI is what DAA describes)? I know it's
described in the spec, and might become useful at some point, but right
now, for a general purpose OS like Linux, I don't see a good reason to
assign a dynamic address using SETDASA.

>=20
> >>>>> +static u32 i3c_master_i2c_functionalities(struct i2c_adapter *adap)
> >>>>> +{
> >>>>> +	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_I2C | I2C_FUNC_10BIT_ADDR;
> >>>>> +}     =20
> >>>> =C2=A0Is I2C_FUNC_10BIT_ADDR allowed ?   =20
> >>> According to "Table 4 I 2 C Features Allowed in I3C Slaves", yes (at
> >>> least that my understanding). And the Cadence controller supports it.=
   =20
> >> The table say the oposite. The I2C extended address feature is not use=
d on I3C
> >> bus, thus this feature shall be disable. =20
> > Actually, I was wrong when initially mentioning this table: it's about
> > I2C features supported on I3C slaves, so not really what we're looking
> > for. Here, we're wondering if I2C-only devices can have 10-bit
> > addresses. The Cadence controller supports that, so there's probably
> > nothing preventing use of 10-bit addresses for I2C transfers, but maybe
> > not all I3C master controllers support that, so we should probably
> > let the I3C master driver implement this method. =20
>=20
> The spec says that is "not used" so it will not interface with I3C bus.

Again, I should not have pointed you to this chapter, because it does
not describe what the I3C bus accept, but what I3C slave acting like
I2C devices accept (basically what they accept before being assigned a
dynamic address).

If you see in the I3C spec that I2C transfers using 10-bit addresses
is forbidden, could you tell me where it's stated, because I didn't
find it.=20

>=20
> >> BTW it is optional on I2C devices. =20
> > You mean I2C controllers? When an I2C device has a 10bit address, the
> > controller has to support this mode to communicate with the device, at
> > least that's my understanding. But we're digressing a bit. The
> > question is not whether I2C devices can optionally use a 10 bit
> > address, but whether I3C master controller can support this mode for
> > I2C transfers to I2C-only devices. =20
>=20
> By the i2c spec the 10-bit address is optional, however the 7-bit address=
 is
> mandatory.

The controller is not forced to support this feature, I think I already
said I agree on this aspect. But if you have a device with a 10-bit
address, it has to be connected to a controller that supports this
feature otherwise it won't work.

So, let's sum-up: I3C controllers can support I2C transfers with 10bit
addresses, but this feature should be optional. I think we might also
want to support optimized smbus methods, so maybe we should just let
I3C controllers fill the i2c_adapter object as they wish.


> >>>>> +/**
> >>>>> + * struct i3c_ccc_setda - payload passed to ENTTM CCC
> >>>>> + *
> >>>>> + * @mode: one of the &enum i3c_ccc_test_mode modes
> >>>>> + *
> >>>>> + * Information passed to the ENTTM CCC to instruct an I3C device t=
o enter a
> >>>>> + * specific test mode.
> >>>>> + */
> >>>>> +struct i3c_ccc_setda {
> >>>>> +	u8 addr;
> >>>>> +} __packed;     =20
> >>>> =C2=A0what do you mean with struct? Maybe setdasa? if so, what is th=
e addr?   =20
> >> Do you have the function to use this structure? Because one command us=
e the
> >> static address and the other use the dynamic address.

Forgot to answer this one in my previous reply. Unicast CCC commands
are always passed the destination in i3c_ccc_cmd->dest[x].addr, so, in
case of SETDASA, i3c_ccc_cmd->dest[x].addr will be the static address,
and in case of SETNEWDA i3c_ccc_cmd->dest[x].addr will be the old
dynamic address. In both cases, the payload will be a single byte
describing the new dynamic address, hence the common i3c_ccc_setda
struct.

> >> =20
> >>>>   =20
> >>>> =C2=A0> +/**
> >>>>> + * enum i3c_sdr_max_data_rate - max data rate values for private S=
DR transfers
> >>>>> + */
> >>>>> +enum i3c_sdr_max_data_rate {
> >>>>> +	I3C_SDR_DR_FSCL_MAX,
> >>>>> +	I3C_SDR_DR_FSCL_8MHZ,
> >>>>> +	I3C_SDR_DR_FSCL_6MHZ,
> >>>>> +	I3C_SDR_DR_FSCL_4MHZ,
> >>>>> +	I3C_SDR_DR_FSCL_2MHZ,
> >>>>> +};     =20
> >>>> Can you change the names to:
> >>>>
> >>>> I3C_SDR0_FSCL_MAX,
> >>>> I3C_SDR1_FSCL_8MHZ,
> >>>> I3C_SDR2_FSCL_6MHZ,
> >>>> I3C_SDR3_FSCL_4MHZ,
> >>>> I3C_SDR4_FSCL_2MHZ,
> >>>>
> >>>> thus the data rate isn't repeated.   =20
> >>> What's the problem with the name I use? Moreover, I see no mention to
> >>> the SDR0,1,2,3,4 modes in the public spec.   =20
> >> When you get the GETMXDS information, the maxWr and maxRd came from 0 =
to 4, so
> >> in my opinion I think in this way is easier to have a relationship. =20
> > It's an emum, and there's no mention of the SDRX modes you're using
> > here in the I3C spec. I guess it's named this way in your I3C
> > controller datasheet. I personally don't see a good reason to add SDRX
> > in the name, but if you insist... =20
>=20
> The idea is to say that it is SDR mode and the value that GETMXDS command
> return. It is what makes sense to me.

Still don't see why this is needed, since what we care about here is
the actual max SCL frequency, which is given in the enum name. But I
don't want to argue more on this minor aspect, so, if everyone is okay,
I'll switch to your solution.

> >>>>> +
> >>>>> +/**
> >>>>> + * struct i3c_hdr_cmd - I3C HDR command
> >>>>> + * @mode: HDR mode selected for this command
> >>>>> + * @code: command opcode
> >>>>> + * @addr: I3C dynamic address
> >>>>> + * @ndatawords: number of data words (a word is 16bits wide)
> >>>>> + * @data: input/output buffer
> >>>>> + */
> >>>>> +struct i3c_hdr_cmd {
> >>>>> +	enum i3c_hdr_mode mode;
> >>>>> +	u8 code;
> >>>>> +	u8 addr;
> >>>>> +	int ndatawords;
> >>>>> +	union {
> >>>>> +		u16 *in;
> >>>>> +		const u16 *out;
> >>>>> +	} data;
> >>>>> +};   =20
> >> Please mention that the @code is what will define if the transfer is r=
ead or write. =20
> > Well, I think it's pretty clear in the definition you'll find in the
> > ccc.h file, but I can add a comment here too if you like. =20
>=20
> I don't find it in ccc.h file. Anyway is not good to put this definition =
there
> because is not related.

Oops! Sorry, I mixed the CCC and HDR stuff. It's indeed not clear that
@code defines the transfer direction. I'll clarify this aspect.=20
=20
> >> I think the DAA process should be more generic, right now is only made=
 through
> >> the ENTDAA command with (cmd.ndests =3D 1).
> >> I mean, shouldn't this be made by the core? First doing DAA for the de=
vices
> >> declared and them try do discover the rest of devices on the bus. =20
> > Can you detail a bit more? If the only part you're complaining about is
> > pre-assignment of dynamic addresses with SETDASA when a device is
> > declared in the DT with a reg and dynamic-address property, then yes, I
> > think I can provide an helper for that. But this helper would still have
> > to be called from the master controller driver (from ->bus_init() or
> > after a Hot-Join).
> >
> > Now, if the question is, is there a way we can automate things even more
> > and completely implement DAA from the core? I doubt it, because the way
> > the core will trigger DAA, expose discovered devices or allow you to
> > declare manually assigned addresses is likely to be
> > controller-dependent. =20
>=20
> Please refer to figure 90 of public specification. As you can see the DAA
> process should start with SETDASA command.

Only if devices with a static address needs to be assigned a specific
dynamic address. At least, that's my understanding. Are there plans to
create devices that would only reply to SETDASA commands but ignore
ENTDAA ones?

>=20
> With the current flow of this patch the DAA process is limited to ENTDAA =
command
> only.

As a first step, yes. But again, nothing is set in stone, and the
SETDASA step can be added afterwards. As said above, I fail to see a
use case where it's really required (note that I said required, not
useful).

>=20
> > When I designed the framework I took the decision to base my work on the
> > spec rather than focusing on the I3C master controller I had to support
> > (Cadence). This is the reason I decided to keep the interface as simple
> > as possible at the risk of encouraging code-duplication (at first)
> > rather than coming up with an interface that is designed with a single
> > controller in mind and having to break things every time a new
> > controller comes out.
> >
> > Thank you for you comments, but I'd like to know if some of my design
> > choices are blocking you to support your controller. What I've seen so
> > far is a collection of things that might be relevant to fix (though
> > most of them are subject to interpretation and/or a matter of taste),
> > but nothing that should really block you.
> >
> > Can you clarify that, and maybe come back with a list of things that you
> > think are preventing you from properly supporting the Synopsys
> > controller?
> >
> > Thanks,
> >
> > Boris  =20
>=20
> As you can check from my=C2=A0 comments my concerns are about the i3c spe=
cification
> without the controller in mind.

Okay, then we're on the same page.

Regards,

Boris

--=20
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
