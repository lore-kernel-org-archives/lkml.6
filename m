Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AG47ELvlf8bK3o1ca2FdmP8Sv8LmDzYK5MOK8O6moyJ27Tqx7qVLjP6j2q9+uv5HvF/8IXHL1ZNc
ARC-Seal: i=1; a=rsa-sha256; t=1521375801; cv=none;
        d=google.com; s=arc-20160816;
        b=q6yikh/CtzR1Y4wMZvjAtEWDD5BVDMv8OSmjqAVnZ6j4RlxsoInlZWAkR8vj9z38Ph
         ox5SdNpAYB3BxENCZdmC2F4P02ieUAdnsA0+o+qs4Yk27tk4JNxw3V9jGO9lYQNrcSKy
         7cByiFXX1gF4s0h/iES2zsRimxgXrz3WETyzpJvG2nN+CfLq9FsesMXxQ/dV7BmS/sdT
         3CHKwIotTlAjQAR4y+QchE3BU5wBntVaFPcJqyoIJOdyiucEfX7xk7QvTXshGpQsJ8lU
         pWrnqfQ7VVaANyNv9XVt7jTO5ae+NdN48ngvoM7H2Clpvt1DMcjrsy818mIaYP4D6ual
         Ga5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=vr5KAh3N0dkfKswwI4YdsBkReRm0CqNfMQcW1ZqGeDg=;
        b=RSeShWAZjBj9uBHOslUO58wqtlzsglbsH7s1KvbOtkRLIMa30q7GxoqQvP3D19CQLL
         AnXqCr2DhG1vIKMms084FfI77Y0cSuZTir6Gp5vVcnZHChc7OR9/lXSRV2j0MomIjbgC
         7xNVy5Ar6HVkpmFvWuOUSTuUhhFvbZf2kLFr7zaRusV3lXnOb+6FXvYvWKuYv5gAWaUf
         2Pjob1ReYlV/Qwj/U5Sx2HHZjmZQ+89M4mmkamS9rSnPCTiH88OdJwwjX2cNPFFndJgM
         S6J9J+LcSmcRgOZ/o5/psboEiGCk6B6GZXUJnVhKYmQry93FZXIKbeItdfnuH63/5+pD
         A9xQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D2F320855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 18 Mar 2018 12:23:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: John Syne <john3909@gmail.com>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Hartmut Knaack <knaack.h@gmx.de>, daniel.baluta@nxp.com
Subject: meter ABI: (was Re: [PATCH v2 1/3] staging:iio:meter: Replaces
 IIO_DEV_ATTR_CH_OFF by IIO_DEVICE_ATTR)
Message-ID: <20180318122312.0d395367@archlinux>
In-Reply-To: <A8E3184B-765B-4730-A076-C3FCF487EAE3@gmail.com>
References: <cover.1520382753.git.rodrigosiqueiramelo@gmail.com>
	<3af0e5a795059a8418cf08ff29f05f8d5e00da9b.1520382753.git.rodrigosiqueiramelo@gmail.com>
	<20180307200730.08ed3c2f@archlinux>
	<20180309003733.aichruo53vqryafg@smtp.gmail.com>
	<20180310151045.4570e85d@archlinux>
	<79D3051B-FF2F-4DD3-AF75-F6A4BAD81838@gmail.com>
	<20180317203037.1093cc11@archlinux>
	<A8E3184B-765B-4730-A076-C3FCF487EAE3@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595278152164006674?=
X-GMAIL-MSGID: =?utf-8?q?1595278152164006674?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 17 Mar 2018 23:11:45 -0700
John Syne <john3909@gmail.com> wrote:

> Hi Jonathan,
Hi John and All,

I'd love to get some additional input on this from anyone interested.
There are a lot of weird and wonderful derived quantities in an energy
meter and it seems we need to make some fundamental changes to support
them - including potentially a userspace breaking change to the event
code description.

>=20
> Here is the complete list of registers for the ADE7878 which I copied fro=
m the data sheet. I added a column =E2=80=9CIIO Attribute=E2=80=9D which I =
hope follows your IIO ABI. Please make any changes you feel are incorrect. =
BTW, there are several registers that cannot be generalized and are used pu=
rely for chip configuration. I think we should add a new naming convention,=
 namely {register}_{<chip-register-name>}. Also, I see in the sys_bus_iio d=
oc
> in_accel_x_peak_raw
>=20
> so shouldn=E2=80=99t the phase be represented as follows:
>=20
> in_current_A_scale
I'm still confused.  What does A represent here?  I assumed that was a wild
card for the channel number before but clearly not.

Ah, you are labelling the 3 separate phases as A, B and C. Hmm.
I guess they sort of look like axis, and sort of like independent channels.
So could be indexed or done via modifiers depending on how you look at it.

Hmm. With neutral in there as well I guess we need to make them
modifiers (but might change my mind later ;)

Particularly as we are using the the modifier for RMS under the previous
plan... It appears we should treat that instead like we did for peak
and do it as an additional info mask element.  The problem with doing that
on a continuous measurement is that we can't treat it as a channel to
be output through the buffered interface.

So again we have run out of space. It's increasingly looking like we need
room for another field in the events - to cleanly represent computed values.

Hmm. What is the current usage? - it's been a while so I had to go
look in the header.

0-15 Channel (lots of channels)
31-16 Channel 2  (36 modifiers - lots of channels)
47-32 Channel Type (31 used so far - this looks most likely to run out of
space in the long run so leave this one alone).
54-48 Event Direction (4 used)
55 Differential  (1: channel 2 as differential pair 0: as a modifier)
63-56 Event Type (6 used)

So I think we can pinch bit 53 as another flag to indicate we have
a computed value or possibly bit 63 as event types are few and
far between as well.

Probably reasonable to assume we never have 16 bits worth
of channels and computed channels at the same time?
Hence I think we can steal bits off the top of Channel.
How many do we need?  Not sure unfortunately but feels like
8 should be plenty.

The other element of this is we add a new field to iio_chan_spec
to contain 'derived_type' or something like that which has
rms and sum squared etc. Over time we can move some of those
from the modifiers and free up a few entires there.
So modifier might be "X and Y and Z" with a derived_type of=20
sum_squared to give existing sum_squared_x_y_z but no
rush on that.

Anyhow so now we have an extra element to play that will result
in a different channel.

Whilst here we should think about any other mods needed to
that event structure.  It is a little unfortunate that this
will be a breaking change for any old userspace code playing
with new drivers but it can't be helped as we didn't have
reserved values in the original definition (oops).

At somepoint we may need to add the 'shared by derived_value'
info mask but I think we can ignore that for now (seems
moderately unlikely to have anything in it!)
>=20
> But for now, I followed your instructions from your reply.
>=20
> After finalizing this one, I will work on the ADE9000, which as way more =
registers ;-)
>=20
> Once we can agree on the register naming, I will update the ADE7854 drive=
r for Rodrigo, which will go a long way to getting it out of staging.
I'll edit to fit with new scheme and insert indexes which I think would be
preferred though optional under the ABI as we only have one of each type/
>=20
> Address	Register	IIO Attribute	R/W	Bit Length	Bit Length During Communica=
tions	Type	Default Value	Description
> 0x4380	AIGAIN	in_current0_phaseA_scale	R/W	24	32 ZPSE	S	0x000000	Phase A =
current gain adjust.
A, B, C, N aren't obvious to the lay reader so I suggest we burn a few char=
acters and stick phase in for ABC and just have neutral for
the neutral one. Not sure about capitalization or not though.

> 0x4381	AVGAIN	in_voltage0_phaseA_scale	R/W	24	32 ZPSE	S	0x000000	Phase A =
voltage gain adjust.
> 0x4382	BIGAIN	in_current0_phaseB_scale	R/W	24	32 ZPSE	S	0x000000	Phase B =
current gain adjust.
> 0x4383	BVGAIN	in_voltage0_phaseB_scale	R/W	24	32 ZPSE	S	0x000000	Phase B =
voltage gain adjust.
> 0x4384	CIGAIN	in_current0_phaseC_scale	R/W	24	32 ZPSE	S	0x000000	Phase C =
current gain adjust.
> 0x4385	CVGAIN	in_voltage0_phaseC_scale	R/W	24	32 ZPSE	S	0x000000	Phase C =
voltage gain adjust.
> 0x4386	NIGAIN	in_current0_neutral_scale	R/W	24	32 ZPSE	S	0x000000	Neutral=
 current gain adjust (ADE7868 and ADE7878 only).
> 0x4387	AIRMSOS	in_current0_phaseA_rms_offset	R/W	24	32 ZPSE	S	0x000000	Ph=
ase A current rms offset.
> 0x4388	AVRMSOS	in_voltage0_phaseA_rms_offset	R/W	24	32 ZPSE	S	0x000000	Ph=
ase A voltage rms offset.
> 0x4389	BIRMSOS	in_current0_phaseB_rms_offset	R/W	24	32 ZPSE	S	0x000000	Ph=
ase B current rms offset.
> 0x438A	BVRMSOS	in_voltage0_phaseB_rms_offset	R/W	24	32 ZPSE	S	0x000000	Ph=
ase B voltage rms offset.
> 0x438B	CIRMSOS	in_current0_phaseC_rms_offset	R/W	24	32 ZPSE	S	0x000000	Ph=
ase C current rms offset.
> 0x438C	CVRMSOS	in_voltage0_phaseC_rms_offset	R/W	24	32 ZPSE	S	0x000000	Ph=
ase C voltage rms offset.
> 0x438D	NIRMSOS	in_current0_neutral_rms_offset	R/W	24	32 ZPSE	S	0x000000	N=
eutral current rms offset (ADE7868 and ADE7878 only).
> 0x438E	AVAGAIN	in_powerapparent0_phaseA_scale	R/W	24	32 ZPSE	S	0x000000	P=
hase A apparent power gain adjust.
> 0x438F	BVAGAIN	in_powerapparent0_phaseB_scale	R/W	24	32 ZPSE	S	0x000000	P=
hase B apparent power gain adjust.
> 0x4390	CVAGAIN	in_powerapparent0_phaseC_scale	R/W	24	32 ZPSE	S	0x000000	P=
hase C apparent power gain adjust.
> 0x4391	AWGAIN	in_power0_phaseA_scale	R/W	24	32 ZPSE	S	0x000000	Phase A to=
tal active power gain adjust.
> 0x4392	AWATTOS	in_power0_phaseA_offset	R/W	24	32 ZPSE	S	0x000000	Phase A =
total active power offset adjust.
> 0x4393	BWGAIN	in_power0_phaseB_scale	R/W	24	32 ZPSE	S	0x000000	Phase B to=
tal active power gain adjust.
> 0x4394	BWATTOS	in_power0_phaseB_offset	R/W	24	32 ZPSE	S	0x000000	Phase B =
total active power offset adjust.
> 0x4395	CWGAIN	in_power0_PhaseC_scale	R/W	24	32 ZPSE	S	0x000000	Phase C to=
tal active power gain adjust.
> 0x4396	CWATTOS	in_power0_phaseC_offset	R/W	24	32 ZPSE	S	0x000000	Phase C =
total active power offset adjust.
> 0x4397	AVARGAIN	in_powerreactive0_phaseA_scale	R/W	24	32 ZPSE	S	0x000000	=
Phase A total reactive power gain adjust (ADE7858, ADE7868, and ADE7878).
> 0x4398	AVAROS	in_powerreactive0_phaseA_offset	R/W	24	32 ZPSE	S	0x000000	P=
hase A total reactive power offset adjust (ADE7858, ADE7868, and ADE7878).
> 0x4399	BVARGAIN	in_powerreactive0_phaseB_scale	R/W	24	32 ZPSE	S	0x000000	=
Phase B total reactive power gain adjust (ADE7858, ADE7868, and ADE7878).
> 0x439A	BVAROS	in_powerreactive0_phaseB_offset	R/W	24	32 ZPSE	S	0x000000	P=
hase B total reactive power offset adjust (ADE7858, ADE7868, and ADE7878).
> 0x439B	CVARGAIN	in_powerreactive0_phaseC_scale	R/W	24	32 ZPSE	S	0x000000	=
Phase C total reactive power gain adjust (ADE7858, ADE7868, and ADE7878).
> 0x439C	CVAROS	in_powerreactive0_phaseC_offset	R/W	24	32 ZPSE	S	0x000000	P=
hase C total reactive power offset adjust (ADE7858, ADE7868, and ADE7878).
> 0x439D	AFWGAIN	in_power0_phaseA_fundamental_scale	R/W	24	32 ZPSE	S	0x0000=
00	Phase A fundamental active power gain adjust. Location reserved for ADE7=
854, ADE7858, and ADE7868.
Hmm. fundamental is the oddity here.  I here because  it is sort of a deriv=
ed value
and sort of a filter applied.  Can it be sensible combined with RMS? probab=
ly not but
it can be combined with peak for example (which I'd also ideally move into
the derived representation.).

> 0x439E	AFWATTOS	in_power0_phaseA_fundamental_offset	R/W	24	32 ZPSE	S	0x00=
0000	Phase A fundamental active power offset adjust. Location reserved for =
ADE7854, ADE7858, and ADE7868.
> 0x439F	BFWGAIN	in_power0_phaseB_fundamental_scale	R/W	24	32 ZPSE	S	0x0000=
00	Phase B fundamental active power gain adjust (ADE7878 only).
> 0x43A0	BFWATTOS	in_power0_phaseB_fundamental_offset	R/W	24	32 ZPSE	S	0x00=
0000	Phase B fundamental active power offset adjust (ADE7878 only).
> 0x43A1	CFWGAIN	in_power0_phaseC_fundamental_scale	R/W	24	32 ZPSE	S	0x0000=
00	Phase C fundamental active power gain adjust.
> 0x43A2	CFWATTOS	in_power0_phaseC_fundamental_offset	R/W	24	32 ZPSE	S	0x00=
0000	Phase C fundamental active power offset adjust (ADE7878 only).
> 0x43A3	AFVARGAIN	in_powerreactive0_phaseA_fundamental_scale	R/W	24	32 ZPS=
E	S	0x000000	Phase A fundamental reactive power gain adjust (ADE7878 only).
> 0x43A4	AFVAROS	in_powerreactive0_phaseA_fundamental_offset	R/W	24	32 ZPSE=
	S	0x000000	Phase A fundamental reactive power offset adjust (ADE7878 only).
> 0x43A5	BFVARGAIN	in_powerreactive0_phaseB_fundamental_scale	R/W	24	32 ZPS=
E	S	0x000000	Phase B fundamental reactive power gain adjust (ADE7878 only).
> 0x43A6	BFVAROS	in_powerreactive0_phaseB_fundamental_offset	R/W	24	32 ZPSE=
	S	0x000000	Phase B fundamental reactive power offset adjust (ADE7878 only).
> 0x43A7	CFVARGAIN	in_powerreactive0_phaseC_fundamental_scale	R/W	24	32 ZPS=
E	S	0x000000	Phase C fundamental reactive power gain adjust (ADE7878 only).
> 0x43A8	CFVAROS	in_powerreactive0_phaseC_fundamental_offset	R/W	24	32 ZPSE=
	S	0x000000	Phase C fundamental reactive power offset adjust (ADE7878 only).
> 0x43A9	VATHR1	regiister_VATHR1	R/W	24	32 ZP	U	0x000000	Most significant 2=
4 bits of VATHR[47:0] threshold used in phase apparent power datapath.
Do not expose these to userspace. Why would it care?

> 0x43AA	VATHR0	register_VATHR0	R/W	24	32 ZP	U	0x000000	Less significant 24=
 bits of VATHR[47:0] threshold used in phase apparent power datapath.
> 0x43AB	WTHR1	register_WTHR1	R/W	24	32 ZP	U	0x000000	Most significant 24 b=
its of WTHR[47:0] threshold used in phase total/fundamental active power da=
tapath.
> 0x43AC	WTHR0	register_WTHR0	R/W	24	32 ZP	U	0x000000	Less significant 24 b=
its of WTHR[47:0] threshold used in phase total/fundamental active power da=
tapath.
> 0x43AD	VARTHR1	register_VARTHR1	R/W	24	32 ZP	U	0x000000	Most significant =
24 bits of VARTHR[47:0] threshold used in phase total/fundamental reactive =
power datapath (ADE7858, ADE7868, and ADE7878).
> 0x43AE	VARTHR0	register_VARTHR0	R/W	24	32 ZP	U	0x000000	Less significant =
24 bits of VARTHR[47:0] threshold used in phase total/fundamental reactive =
power datapath (ADE7858, ADE7868, and ADE7878).
> 0x43AF	Reserved		N/A4	N/A4	N/A4	N/A4	0x000000	This memory location should=
 be kept at 0x000000 for proper operation.
> 0x43B0	VANOLOAD	register_VANOLOAD	R/W	24	32 ZPSE	S	0x0000000	No load thre=
shold in the apparent power datapath.
This one is kind of an event parameter, but one that controls internal cree=
p prevention.
This will be a driver specific attr I think for now. We may add it to info_=
mask
later if we get lots of meter drivers.=20
Something like
in_power0_no_load_thresh though I haven't really thought about it or looked
for similar precedence.


> 0x43B1	APNOLOAD	register_APNOLOAD	R/W	24	32 ZPSE	S	0x0000000	No load thre=
shold in the total/fundamental active power datapath.
in_activepower0_no_load_thresh
> 0x43B2	VARNOLOAD	register_VARNOLOAD	R/W	24	32 ZPSE	S	0x0000000	No load th=
reshold in the total/fundamental reactive power datapath. Location reserved=
 for ADE7854.
in_reactivpower0_no_load_thresh

> 0x43B3	VLEVEL	register_VLEVEL	R/W	24	32 ZPSE	S	0x000000	Register used in =
the algorithm that computes the fundamental active and reactive powers (ADE=
7878 only).
This one looks like a characteristic of the circuit attached.  So should be=
 devicetree
or similar and not exposed to userspace.

> 0x43B5	DICOEFF	register_DICOEFF	R/W	24	32 ZPSE	S	0x0000000	Register used =
in the digital integrator algorithm. If the integrator is turned on, it mus=
t be set at 0xFF8000. In practice, it is transmitted as 0xFFF8000.
no userspace interface.

> 0x43B6	HPFDIS	register_HPFDIS	R/W	24	32 ZP	U	0x000000	Disables/enables th=
e HPF in the current datapath (see Table 34).
We have controls for high pass filters, you'll need to map on to them.
Disable is usually setting 3DB point to 0 IIRC.

> 0x43B8	ISUMLVL	register_ISUMLVL	R/W	24	32 ZPSE	S	0x000000	Threshold used =
in comparison between the sum of phase currents and the neutral current (AD=
E7868 and ADE7878 only).
This is an event threshold so needs to map to the events infrastructure
as best we can.  It's actually a pain to describe so may be device specific=
 ABI.

> 0x43BF	ISUM	register_ISUM	R	28	32 ZP	S	N/A4	Sum of IAWV, IBWV, and ICWV r=
egisters (ADE7868 and ADE7878 only).
So this would be using a modifier for AandBandC phases (similar to the Xand=
YanZ ones for mems devices and
a derived value of sum I think So would look something like.
in_current0_phaseA&phaseB&phaseC_sum and yet another channel

> 0x43C0	AIRMS	in_current0_phaseA_rms	R	24	32 ZP	S	N/A4	Phase A current rms=
 value.
> 0x43C1	AVRMS	in_voltage0_phaseA_rms	R	24	32 ZP	S	N/A4	Phase A voltage rms=
 value.
> 0x43C2	BIRMS	in_current0_phaseB_rms	R	24	32 ZP	S	N/A4	Phase B current rms=
 value.
> 0x43C3	BVRMS	in_voltage0_phaseB_rms	R	24	32 ZP	S	N/A4	Phase B voltage rms=
 value.
> 0x43C4	CIRMS	in_current0_phaseC_rms	R	24	32 ZP	S	N/A4	Phase C current rms=
 value.
> 0x43C5	CVRMS	in_voltage0_phaseC_rms	R	24	32 ZP	S	N/A4	Phase C voltage rms=
 value.
> 0x43C6	NIRMS	in_current0_neutral_rms	R	24	32 ZP	S	N/A4	Neutral current rm=
s value (ADE7868 and ADE7878 only).
> 0xE228	Run	register_Run	R/W	16	16	U	0x0000	Run register starts and stops =
the DSP. See the Digital Signal Processor section for more details.
Not exposed to userspace.

> 0xE400	AWATTHR	in_energy0_phaseA_raw	R	32	32	S	0x00000000	Phase A total a=
ctive energy accumulation.
> 0xE401	BWATTHR	in_energy0_phaseB_raw	R	32	32	S	0x00000000	Phase B total a=
ctive energy accumulation.
> 0xE402	CWATTHR	in_energy0_phaseC_raw	R	32	32	S	0x00000000	Phase C total a=
ctive energy accumulation.
> 0xE403	AFWATTHR	in_energy0_phaseA_fundamental_raw	R	32	32	S	0x00000000	Ph=
ase A fundamental active energy accumulation (ADE7878 only).
> 0xE404	BFWATTHR	in_energy0_phaseB_fundamental_raw	R	32	32	S	0x00000000	Ph=
ase B fundamental active energy accumulation (ADE7878 only).
> 0xE405	CFWATTHR	in_energy0_phaseC_fundamental_raw	R	32	32	S	0x00000000	Ph=
ase C fundamental active energy accumulation (ADE7878 only).
> 0xE406	AVARHR	in_energyreactive0_phaseA_raw	R	32	32	S	0x00000000	Phase A =
total reactive energy accumulation (ADE7858, ADE7868, and ADE7878 only).
> 0xE407	BVARHR	in_energyreactive0_phaseB_raw	R	32	32	S	0x00000000	Phase B =
total reactive energy accumulation (ADE7858, ADE7868, and ADE7878 only).
> 0xE408	CVARHR	in_energyreactive0_phaseC_raw	R	32	32	S	0x00000000	Phase C =
total reactive energy accumulation (ADE7858, ADE7868, and ADE7878 only).
> 0xE409	AFVARHR	in_energyreactive0_phaseA_fundamental_raw	R	32	32	S	0x0000=
0000	Phase A fundamental reactive energy accumulation (ADE7878 only).
> 0xE40A	BFVARHR	in_energyreactive0_phaseB_fundamental_raw	R	32	32	S	0x0000=
0000	Phase B fundamental reactive energy accumulation (ADE7878 only).
> 0xE40B	CFVARHR	in_energyreactive0_phaseC_fundamental_raw	R	32	32	S	0x0000=
0000	Phase C fundamental reactive energy accumulation (ADE7878 only).
> 0xE40C	AVAHR	in_energyapparent0_phaseA_raw	R	32	32	S	0x00000000	Phase A a=
pparent energy accumulation.
> 0xE40D	BVAHR	in_energyapparent0_phaseB_raw	R	32	32	S	0x00000000	Phase B a=
pparent energy accumulation.
> 0xE40E	CVAHR	in_energyapparent0_phaseC_raw	R	32	32	S	0x00000000	Phase C a=
pparent energy accumulation.
> 0xE500	IPEAK	in_current0_peak	R	32	32	U	N/A	Current peak register. See Fi=
gure 50 and Table 35 for details about its composition.
Oh goody. I have no idea how we expose the which phase element of this
cleanly.  One option I suppose is to have in_current0_phaseA_peak etc
and have all but the current peak return an error when read? It is a bit
nasty but only so much we can do and keep with a consistent interface.

> 0xE501	VPEAK	in_voltage_peak	R	32	32	U	N/A	Voltage peak register. See Fig=
ure 50 and Table 36 for details about its composition.
Same as peak.

> 0xE502	STATUS0	register_STATUS0	R/W	32	32	U	N/A	Interrupt Status Register=
 0. See Table 37.
> 0xE503	STATUS1	register_STATUS1	R/W	32	32	U	N/A	Interrupt Status Register=
 1. See Table 38.
No userspace interface except via events interface or error reports.

> 0xE504	AIMAV	in_currentA_mav	R	20	32 ZP	U	N/A	Phase A current mean absolu=
te value computed during PSM0 and PSM1 modes (ADE7868 and ADE7878 only).
Probably a longer name as mav is cryptic.
in_current0_phaseA_meanabs_raw - it could have a scale and all sorts of fun.
So I think this needs to be using the new derived infrastructure proposed h=
ere
rather than being an info_mask element.

> 0xE505	BIMAV	in_currentB_mav	R	20	32 ZP	U	N/A	Phase B current mean absolu=
te value computed during PSM0 and PSM1 modes (ADE7868 and ADE7878 only).
> 0xE506	CIMAV	in_currentC_mav	R	20	32 ZP	U	N/A	Phase C current mean absolu=
te value computed during PSM0 and PSM1 modes (ADE7868 and ADE7878 only).
> 0xE507	OILVL	register_OILVL	R/W	24	32 ZP	U	0xFFFFFF	Overcurrent threshold.
> 0xE508	OVLVL	register_OVLVL	R/W	24	32 ZP	U	0xFFFFFF	Overvoltage threshold.
These presumably result in interrupts? (I'm running out of time so not chec=
king)
In which case standard event interface should work.

> 0xE509	SAGLVL	register_SAGLVL	R/W	24	32 ZP	U	0x000000	Voltage SAG level t=
hreshold.
That's another event I think...=20

> 0xE50A	MASK0	register_MASK0	R/W	32	32	U	0x00000000	Interrupt Enable Regis=
ter 0. See Table 39.
> 0xE50B	MASK1	register_MASK1	R/W	32	32	U	0x00000000	Interrupt Enable Regis=
ter 1. See Table 40.

> 0xE50C	IAWV	in_currentA_instantaneous	R	24	32 SE	S	N/A	Instantaneous valu=
e of Phase A current.
> 0xE50D	IBWV	in_currentB_instantaneous	R	24	32 SE	S	N/A	Instantaneous valu=
e of Phase B current.
> 0xE50E	ICWV	in_currentC_instantaneous	R	24	32 SE	S	N/A	Instantaneous valu=
e of Phase C current.
> 0xE50F	INWV	in_currentN_instantaneous	R	24	32 SE	S	N/A	Instantaneous valu=
e of neutral current (ADE7868 and ADE7878 only).
> 0xE510	VAWV	in_voltageA_instantaneous	R	24	32 SE	S	N/A	Instantaneous valu=
e of Phase A voltage.
> 0xE511	VBWV	in_voltageB_instantaneous	R	24	32 SE	S	N/A	Instantaneous valu=
e of Phase B voltage.
> 0xE512	VCWV	in_voltageC_instantaneous	R	24	32 SE	S	N/A	Instantaneous valu=
e of Phase C voltage.
OK, this is getting silly.  I presume this means the values above are filte=
red and these
aren't?  If so you need to have channels for both and different filter valu=
es.

> 0xE513	AWATT	in_powerA_instantaneous	R	24	32 SE	S	N/A	Instantaneous value=
 of Phase A total active power.
> 0xE514	BWATT	in_powerB_instantaneous	R	24	32 SE	S	N/A	Instantaneous value=
 of Phase B total active power.
> 0xE515	CWATT	in_powerC_instantaneous	R	24	32 SE	S	N/A	Instantaneous value=
 of Phase C total active power.
> 0xE516	AVAR	in_powerreactiveA_instantaneous	R	24	32 SE	S	N/A	Instantaneou=
s value of Phase A total reactive power (ADE7858, ADE7868, and ADE7878 only=
).
> 0xE517	BVAR	in_powerreactiveB_instantaneous	R	24	32 SE	S	N/A	Instantaneou=
s value of Phase B total reactive power (ADE7858, ADE7868, and ADE7878 only=
).
> 0xE518	CVAR	in_powerreactiveC_instantaneous	R	24	32 SE	S	N/A	Instantaneou=
s value of Phase C total reactive power (ADE7858, ADE7868, and ADE7878 only=
).
> 0xE519	AVA	in_powerapparentA_instantaneous	R	24	32 SE	S	N/A	Instantaneous=
 value of Phase A apparent power.
> 0xE51A	BVA	in_powerapparentB_instantaneous	R	24	32 SE	S	N/A	Instantaneous=
 value of Phase B apparent power.
> 0xE51B	CVA	in_powerappatentC_instantaneous	R	24	32 SE	S	N/A	Instantaneous=
 value of Phase C apparent power.
Same for all of these.

> 0xE51F	CHECKSUM	register_CHECKSUM	R	32	32	U	0x33666787	Checksum verificat=
ion. See the Checksum Register section for details.
Not exposed to userspace.

> 0xE520	VNOM	in_voltage_rms_nominal	R/W	24	32 ZP	S	0x000000	Nominal phase =
voltage rms used in the alternative computation of the apparent power. When=
 the VNOMxEN bit is set, the applied voltage input in the corresponding pha=
se is ignored and all corresponding rms voltage instances are replaced by t=
he value in the VNOM register.
Why would this be done?  Sounds like something that is a circuit design time
decision so a job for DT to me.

> 0xE600	PHSTATUS	in_current_phase_peak	R	16	16	U	N/A	Phase peak register. =
See Table 41.
> 0xE601	ANGLE0	register_ANGLE0	R	16	16	U	N/A	Time Delay 0. See the Time In=
terval Between Phases section for details.
> 0xE602	ANGLE1	register_ANGLE1	R	16	16	U	N/A	Time Delay 1. See the Time In=
terval Between Phases section for details.
> 0xE603	ANGLE2	register_ANGLE2	R	16	16	U	N/A	Time Delay 2. See the Time In=
terval Between Phases section for details.
Hmm. More fun.  These are derived values between to phase measurements.=20
The phase as a modifier falls down a bit here - if we had just treated
them as channels we could have done this a differential angle channel.
Right now I'm not sure how we do this, could do it as a derived values so s=
omething like
in_angle0_phaseA&phaseB_diff_raw etc but that feels odd.
This one needs more thought.

> 0xE604 to 0xE606	Reserved							These addresses should not be written for=
 proper operation.
> 0xE607	PERIOD	register_PERIOD	R	16	16	U	N/A	Network line period.
Superficially this sounds like a channel free element so shared_by_all.

> 0xE608	PHNOLOAD	register_PHNOLOAD	R	16	16	U	N/A	Phase no load register. S=
ee Table 42.
Hmm. So this is kind of a set of events with but without I think an interru=
pt.
Odd.

> 0xE60C	LINECYC	register_LINECYC	R/W	16	16	U	0xFFFF	Line cycle accumulatio=
n mode count.
in_count0_raw probably though it's a bit of a stretch.

> 0xE60D	ZXTOUT	register_ZXTOUT	R/W	16	16	U	0xFFFF	Zero-crossing timeout co=
unt.
This is going to be another top level one I think and device specific for n=
ow.

> 0xE60E	COMPMODE	register_COMPMODE	R/W	16	16	U	0x01FF	Computation-mode reg=
ister. See Table 43.
If there is stuff to control in here it need breaking out.

> 0xE60F	Gain	register_Gain	R/W	16	16	U	0x0000	PGA gains at ADC inputs. See=
 Table 44.
Oh goody another scale value. Needs breaking up into separate controls.
Do these directly effect the measured output voltage etc? If they do then
I'm not sure how to separate the two gains, there ought to be a 'right'
answer.  If this is about matching to the circuit present then they
should probably be coming from DT or simillar.


> 0xE610	CFMODE	register_CFMODE	R/W	16	16	U	0x0E88	CFx configuration regist=
er. See Table 45.
> 0xE611	CF1DEN	register_CF1DEN	R/W	16	16	U	0x0000	CF1 denominator.
> 0xE612	CF2DEN	register_CF2DEN	R/W	16	16	U	0x0000	CF2 denominator.
> 0xE613	CF3DEN	register_CF3DEN	R/W	16	16	U	0x0000	CF3 denominator.
Are these things that should be in DT?  Look very quickly like they are tod=
o with other circuits nearby.

> 0xE614	APHCAL	register_APHCAL	R/W	10	16 ZP	S	0x0000	Phase calibration of =
Phase A. See Table 46.
> 0xE615	BPHCAL	register_BPHCAL	R/W	10	16 ZP	S	0x0000	Phase calibration of =
Phase B. See Table 46.
> 0xE616	CPHCAL	register__CPHCAL	R/W	10	16 ZP	S	0x0000	Phase calibration of=
 Phase C. See Table 46.
I'm not actually sure how you would set these.  Per circuit design?

> 0xE617	PHSIGN	register_PHSIGN	R	16	16	U	N/A	Power sign register. See Tabl=
e 47.
> 0xE618	CONFIG	register_CONFIG	R/W	16	16	U	0x0000	ADE7878 configuration re=
gister. See Table 48.
> 0xE700	MMODE	register__MMODE	R/W	8	8	U	0x1C	Measurement mode register. Se=
e Table 49.
> 0xE701	ACCMODE	register__ACCMODE	R/W	8	8	U	0x00	Accumulation mode registe=
r. See Table 50.
> 0xE702	LCYCMODE	register_LCYCMODE	R/W	8	8	U	0x78	Line accumulation mode b=
ehavior. See Table 52.
> 0xE703	PEAKCYC	register_PEAKCYC	R/W	8	8	U	0x00	Peak detection half line c=
ycles.
> 0xE704	SAGCYC	register_SAGCYC	R/W	8	8	U	0x00	SAG detection half line cycl=
es.
Some of these are event controls. Map them as such.

> 0xE705	CFCYC	register_CFCYC	R/W	8	8	U	0x01	Number of CF pulses between tw=
o consecutive energy latches. See the Synchronizing Energy Registers with C=
Fx Outputs section.
> 0xE706	HSDC_CFG	register_HSDC_CFG	R/W	8	8	U	0x00	HSDC configuration regis=
ter. See Table 53.
> 0xE707	Version	register_Version	R	8	8	U		Version of die.
> 0xEBFF	Reserved			8	8			This address can be used in manipulating the SS/H=
SA pin when SPI is chosen as the active port. See the Serial Interfaces sec=
tion for details.
> 0xEC00	LPOILVL	register_LPOILVL	R/W	8	8	U	0x07	"Overcurrent threshold use=
d during PSM2 mode (ADE7868 and ADE7878
> only). See Table 54 in which the register is detailed."
> 0xEC01	CONFIG2	register_CONFIG2	R/W	8	8	U	0x00	Configuration register use=
d during PSM1 mode. See Table 55.

As you can guess I was running out of stamina towards the end of that.

I'm not totally sure of the answer I provided. It may take some more though=
t.
Ideally some others will give input on this question.

Jonathan
>=20
> Regards,
> John
>=20
>=20
>=20
>=20
>=20
> > On Mar 17, 2018, at 1:30 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> >=20
> > On Wed, 14 Mar 2018 23:12:02 -0700
> > John Syne <john3909@gmail.com> wrote:
> >  =20
> >> Hi Jonathan,
> >>=20
> >> I have been looking at the IIO ABI docs and if I understand
> >> correctly, the idea is to use consistent naming conventions? So for
> >> example, looking at the ADE7854 datasheet, the naming matching the
> >> ADE7854 registers would be as follows: =20
> >=20
> > Welcome to one of the big reasons no one tidied these drivers
> > up originally.  Still we have moved on somewhat since then
> > so similar circumstances have come up in other types of sensor.
> >  =20
> >>=20
> >> {direction}_{type}_{index}_{modifier}_{info_mask}
> >>=20
> >> AIGAIN	-	In_current_a_gain =20
> > Other than the fact that gain isn't an ABI element and that index
> > doesn't have
> > _ before it that is right.
> > in_voltageA_scale
> >=20
> > That was a weird quirk a long time back which we should probably
> > not have done (copied it from hwmon)
> >  =20
> >> AVGAIN	-	in_voltage_a_gain
> >> BIGAIN	-	in_current_b_gain
> >> BVGAIN	-	in_voltage_b_gain
> >> =E2=80=94
> >> How do we represent the rms and offset
> >> AIRMSOS	-	in_current_a_rmsoffset
> >> AVRMSOS	-	in_voltage_a_rmsoffset =20
> >=20
> > Right now we can't unfortunately though this one is easier to fix.
> > We already have modifiers for multi axis devices doing sum_squared
> > so add one of those for root_mean_square - this one is well known
> > enough that rms is fine in the string.
> >=20
> > It's a effectively a different channel be it one derived from a simple
> > one.  This is going to get tricky however as we would normally use
> > modifier to specialise a channel type - thoughts on this below.
> >  =20
> >> =E2=80=94
> >> Here I don=E2=80=99t understand how to represent both the phase and th=
e active/reactive/apparent power components. Do we combine the phase and qu=
adrature part like this
> >> AVAGAIN		-	in_power_a_gain				/* apparent power */
> >> =E2=80=94
> >> AWGAIN		-	in_power_ai_gain				/* active power */ =20
> > And that is the problem.  How do we represent the various power types.
> > Hmm. We could do it with modifiers but above we show that we have alrea=
dy used them.
> >=20
> > It would be easy enough to add yet another field to the channel spec to=
 specify
> > this but there is a problem - Events.  The event format is already pret=
ty full
> > so where do we put this extra element if we need to define a channel se=
parated
> > only by it.
> >=20
> > One thought is we could instead define these as different top level
> > IIO_CHAN_TYPES in a similar fashion to we do for relative humidity vs
> > the proposed absolute humidity.
> >=20
> > in_powerreactiveA_scale
> > in_poweractivceA_scale
> > (or in_powerrealA_scale to match with what I got taught years ago?)
> >=20
> > I presume we keep in_powerA_scale etc for the apparent power and
> > modify any docs to make that clear.
> >  =20
> >> =E2=80=94
> >> AVARGAIN	-	in_power_aq_gain				/* reactive power */
> >> =E2=80=94
> >> Now here it becomes more complicated. Not sure how this gets handled.=
=20
> >> AFWATTOS	-	in_power_a_active/fundamental/offset =20
> > Yeah, some of these are getting odd.
> > If I read this correctly this is the active power estimate based on only
> > the fundamental frequency - so no harmonics?
> >=20
> > Hmm.  This then becomes a separate channel with additional properties
> > specifying it is only the fundamental.  This feels a bit like a filter
> > be it an unusual one?  Might just be necessary to add a _fundamental_on=
ly
> > element on the end (would be info_mask if this is common enough to
> > justify that rather than using the extended methods to define it.).
> >=20
> >  =20
> >> =E2=80=94
> >> AWATTHR	-	in_energy_ai_accumulation =20
> > Great, just when I thought we had gone far enough they define reactive
> > energy which is presumably roughly the same as reactivepower * time?
> > In that case we need types for that as well.
> > in_energyreactiveA_*
> > in_energyactiveA_*
> >  =20
> >> =E2=80=94
> >> AVARHR		-	in_energy_aq_accumulation
> >> =E2=80=94
> >> IPEAK		-	in_current_peak =20
> > That one is easy as we have an info_mask element for peak and one
> > for peak_scale that has always been a bit odd but was needed somewhere.
> >  =20
> >> =E2=80=94
> >>=20
> >> I=E2=80=99ll leave it there, because there are some even more complica=
ted register naming issues. =20
> > Something to look forward to.  Gah, I always hated power engineering
> > though I taught it very briefly (I really pity those students :(
> >=20
> > Jonathan
> >  =20
> >>=20
> >> Regards,
> >> John
> >>=20
> >>=20
> >>=20
> >>=20
> >>  =20
> >>> On Mar 10, 2018, at 7:10 AM, Jonathan Cameron <jic23@kernel.org> wrot=
e:
> >>>=20
> >>> On Thu, 8 Mar 2018 21:37:33 -0300
> >>> Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:
> >>>  =20
> >>>> On 03/07, Jonathan Cameron wrote:   =20
> >>>>> On Tue, 6 Mar 2018 21:43:47 -0300
> >>>>> Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:
> >>>>>  =20
> >>>>>> The macro IIO_DEV_ATTR_CH_OFF is a wrapper for IIO_DEVICE_ATTR, wi=
th a
> >>>>>> tiny change in the name definition. This extra macro does not impr=
ove
> >>>>>> the readability and also creates some checkpatch errors.
> >>>>>>=20
> >>>>>> This patch fixes the checkpatch.pl errors:
> >>>>>>=20
> >>>>>> staging/iio/meter/ade7753.c:391: ERROR: Use 4 digit octal (0777) n=
ot
> >>>>>> decimal permissions
> >>>>>> staging/iio/meter/ade7753.c:395: ERROR: Use 4 digit octal (0777) n=
ot
> >>>>>> decimal permissions
> >>>>>> staging/iio/meter/ade7759.c:331: ERROR: Use 4 digit octal (0777) n=
ot
> >>>>>> decimal permissions
> >>>>>> staging/iio/meter/ade7759.c:335: ERROR: Use 4 digit octal (0777) n=
ot
> >>>>>> decimal permissions
> >>>>>>=20
> >>>>>> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>   =
  =20
> >>>>>=20
> >>>>> Hmm. I wondered a bit about this one. It's a correct patch in of
> >>>>> itself but the interface in question doesn't even vaguely conform
> >>>>> to any of defined IIO ABI.  Anyhow, it's still and improvement so
> >>>>> I'll take it.     =20
> >>>>=20
> >>>> I am not sure if I understood the comment about the ABI. The meter
> >>>> interface is wrong because it uses things like IIO_DEVICE_ATTR? It
> >>>> should use iio_info together with *write_raw and *read_raw. Right? I=
s it
> >>>> the ABI problem that you refer?   =20
> >>> The ABI is about the userspace interface of IIO.  It is defined
> >>> in Documentation/ABI/testing/sysfs-bus-iio*
> >>> So this documents the naming of sysfs attributes and (more or less)
> >>> describes a consistent interface to userspace across lots of different
> >>> types of devices.
> >>>=20
> >>> A lot of these older drivers in staging involve a good deal of ABI th=
at
> >>> was not reviewed or discussed.  That is one of the biggest reasons we
> >>> didn't take them out of staging in the first place.
> >>>=20
> >>> In order for generic userspace programs to have any idea what to do
> >>> with these devices this all needs to be fixed.
> >>>=20
> >>> There may well be cases where we need to expand the existing ABI to
> >>> cover new things.   That's fine, but it has to be done with full
> >>> review of the relevant documentation patches.
> >>>=20
> >>> Incidentally if you want an easy driver to work on moving out of stag=
ing
> >>> then first thing to do is to compare what it shows to userspace with =
these
> >>> docs.  If it's totally different then you have a big job on your hands
> >>> as often ABI can take a lot of discussion and a long time to establish
> >>> a consensus.
> >>>=20
> >>> Jonathan
> >>>=20
> >>>  =20
> >>>>=20
> >>>> Thanks :)
> >>>>  =20
> >>>>> Applied to the togreg branch of iio.git and pushed out as testing
> >>>>> for the autobuilders to play with it.
> >>>>>=20
> >>>>> I also added the removal of the header define which is no
> >>>>> longer used.
> >>>>>=20
> >>>>> Please note, following discussions with Michael, I am going to send
> >>>>> an email announcing an intent to drop these meter drivers next
> >>>>> cycle unless someone can provide testing for any attempt to
> >>>>> move them out of staging.  I'm still taking patches on the basis
> >>>>> that 'might' happen - but I wouldn't focus on these until we
> >>>>> have some certainty on whether they will be around long term!
> >>>>>=20
> >>>>> Jonathan
> >>>>>  =20
> >>>>>> ---
> >>>>>> drivers/staging/iio/meter/ade7753.c | 18 ++++++++++--------
> >>>>>> drivers/staging/iio/meter/ade7759.c | 18 ++++++++++--------
> >>>>>> 2 files changed, 20 insertions(+), 16 deletions(-)
> >>>>>>=20
> >>>>>> diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging=
/iio/meter/ade7753.c
> >>>>>> index c44eb577dc35..275e8dfff836 100644
> >>>>>> --- a/drivers/staging/iio/meter/ade7753.c
> >>>>>> +++ b/drivers/staging/iio/meter/ade7753.c
> >>>>>> @@ -388,14 +388,16 @@ static IIO_DEV_ATTR_VPERIOD(0444,
> >>>>>> 		ade7753_read_16bit,
> >>>>>> 		NULL,
> >>>>>> 		ADE7753_PERIOD);
> >>>>>> -static IIO_DEV_ATTR_CH_OFF(1, 0644,
> >>>>>> -		ade7753_read_8bit,
> >>>>>> -		ade7753_write_8bit,
> >>>>>> -		ADE7753_CH1OS);
> >>>>>> -static IIO_DEV_ATTR_CH_OFF(2, 0644,
> >>>>>> -		ade7753_read_8bit,
> >>>>>> -		ade7753_write_8bit,
> >>>>>> -		ADE7753_CH2OS);
> >>>>>> +
> >>>>>> +static IIO_DEVICE_ATTR(choff_1, 0644,
> >>>>>> +			ade7753_read_8bit,
> >>>>>> +			ade7753_write_8bit,
> >>>>>> +			ADE7753_CH1OS);
> >>>>>> +
> >>>>>> +static IIO_DEVICE_ATTR(choff_2, 0644,
> >>>>>> +			ade7753_read_8bit,
> >>>>>> +			ade7753_write_8bit,
> >>>>>> +			ADE7753_CH2OS);
> >>>>>>=20
> >>>>>> static int ade7753_set_irq(struct device *dev, bool enable)
> >>>>>> {
> >>>>>> diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging=
/iio/meter/ade7759.c
> >>>>>> index 1decb2b8afab..c078b770fa53 100644
> >>>>>> --- a/drivers/staging/iio/meter/ade7759.c
> >>>>>> +++ b/drivers/staging/iio/meter/ade7759.c
> >>>>>> @@ -328,14 +328,16 @@ static IIO_DEV_ATTR_ACTIVE_POWER_GAIN(0644,
> >>>>>> 		ade7759_read_16bit,
> >>>>>> 		ade7759_write_16bit,
> >>>>>> 		ADE7759_APGAIN);
> >>>>>> -static IIO_DEV_ATTR_CH_OFF(1, 0644,
> >>>>>> -		ade7759_read_8bit,
> >>>>>> -		ade7759_write_8bit,
> >>>>>> -		ADE7759_CH1OS);
> >>>>>> -static IIO_DEV_ATTR_CH_OFF(2, 0644,
> >>>>>> -		ade7759_read_8bit,
> >>>>>> -		ade7759_write_8bit,
> >>>>>> -		ADE7759_CH2OS);
> >>>>>> +
> >>>>>> +static IIO_DEVICE_ATTR(choff_1, 0644,
> >>>>>> +			ade7759_read_8bit,
> >>>>>> +			ade7759_write_8bit,
> >>>>>> +			ADE7759_CH1OS);
> >>>>>> +
> >>>>>> +static IIO_DEVICE_ATTR(choff_2, 0644,
> >>>>>> +			ade7759_read_8bit,
> >>>>>> +			ade7759_write_8bit,
> >>>>>> +			ADE7759_CH2OS);
> >>>>>>=20
> >>>>>> static int ade7759_set_irq(struct device *dev, bool enable)
> >>>>>> {     =20
> >>>>>  =20
> >>>> --
> >>>> To unsubscribe from this list: send the line "unsubscribe linux-iio"=
 in
> >>>> the body of a message to majordomo@vger.kernel.org
> >>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html  =
 =20
> >>>=20
> >>> _______________________________________________
> >>> devel mailing list
> >>> devel@linuxdriverproject.org
> >>> http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-de=
vel   =20
> >>  =20
> >  =20
>=20
