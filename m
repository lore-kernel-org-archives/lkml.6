Return-Path: <john3909@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521094217; cv=none;
        d=google.com; s=arc-20160816;
        b=h75fKCgEwC8ClMUZANryJ6t1lKemFLVsQN3MgA1jo5KMs+nTvUjB5vV4Z14wnzGyiC
         uUZAUK3E9s8x/Gr7/LRF1PhBxvYdFjVOTS+5P+W7TDOy4lymk7HBw+mFUYmvVte203XB
         n9LngSExk8sDEEA/nLweI7vzbIWZN67EC1A7GXQ0ZV2BgOI9QPi9BCpteY2kx0LxclE5
         x/SZP1zo7JKgnkbBZJ9sHhdYhqqh6RFUNtKkIDHz5Tfbpanhe3IKxDTbe5QIhnTxnX7l
         69+wfXeXFsk66To4CaNdhaA6a81BSLCiH7iDWUv0XqNxRwh3ckNQu+SGowlEDWBFQ6xY
         K3wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:dkim-signature:arc-authentication-results;
        bh=Exsl7DlZOCx0m6WGj9wSLVHl3JmPCr1Jb9ufBCbzet4=;
        b=TJMxH16W6wGhlnu791Vg3zukVY3WnfQUFllZ+P+H/Ln7LmoxC66qc+8Bizw7dI2SXa
         +LXJvM4JlPh2Wd8suC4FZbotVzX5bOBnvNcuA1gq7r5Id5H5PbmfY9jyr2WlwaVMcnkf
         9kHllSo5PJA7ABTzSVGyDcbK7Y1Iyq0MtxzQ3gH0C4sTuPqV0XrPeG7Ac1dsbBbbI2tk
         S4FMPm23xtDxv7x6Wicev8sj7wODML/d/FVtNySp6Yf4S2vNxKB0ZSJC8dhIVVP3m7QK
         KOS3uxwlLS/ZXU7iC4LkS32gOxwQ4veE5CJaoXNgiRkcMBhLHjM65ArRo10N0gajuqG5
         h39g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ij4mGmFs;
       spf=pass (google.com: domain of john3909@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=john3909@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ij4mGmFs;
       spf=pass (google.com: domain of john3909@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=john3909@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELv+keQvf94BaZ6jbRBieFD+zwETGfYxiSkIAKZfK3P1QxTgrphoMlcOjtKPKKa0T2Ldfxxm3w==
From: John Syne <john3909@gmail.com>
Message-Id: <4D87E044-D5D7-4103-9CFE-ED4B1267D1AE@gmail.com>
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_D9FF0FE0-2D25-4736-B142-E2EC969D5280"
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH v2 1/3] staging:iio:meter: Replaces IIO_DEV_ATTR_CH_OFF by
 IIO_DEVICE_ATTR
Date: Wed, 14 Mar 2018 23:10:08 -0700
In-Reply-To: <20180310151045.4570e85d@archlinux>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 devel@driverdev.osuosl.org,
 Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Hartmut Knaack <knaack.h@gmx.de>,
 daniel.baluta@nxp.com
To: Jonathan Cameron <jic23@kernel.org>
References: <cover.1520382753.git.rodrigosiqueiramelo@gmail.com>
 <3af0e5a795059a8418cf08ff29f05f8d5e00da9b.1520382753.git.rodrigosiqueiramelo@gmail.com>
 <20180307200730.08ed3c2f@archlinux>
 <20180309003733.aichruo53vqryafg@smtp.gmail.com>
 <20180310151045.4570e85d@archlinux>
X-Mailer: Apple Mail (2.3445.5.20)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594237578169642590?=
X-GMAIL-MSGID: =?utf-8?q?1594982889394254628?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--Apple-Mail=_D9FF0FE0-2D25-4736-B142-E2EC969D5280
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi Jonathan,

I have been looking at the IIO ABI docs and if I understand correctly, =
the idea is to use consistent naming conventions? So for example, =
looking at the ADE7854 datasheet, the naming matching the ADE7854 =
registers would be as follows:

{direction}_{type}_{index}_{modifier}_{info_mask}

AIGAIN	-	In_current_a_gain
AVGAIN	-	in_voltage_a_gain
BIGAIN	-	in_current_b_gain
BVGAIN	-	in_voltage_b_gain
=E2=80=94
How do we represent the rms and offset
AIRMSOS	-	in_current_a_rmsoffset
AVRMSOS	-	in_voltage_a_rmsoffset
=E2=80=94
Here I don=E2=80=99t understand how to represent both the phase and the =
active/reactive/apparent power components. Do we combine the phase and =
quadrature part like this
AVAGAIN		-	in_power_a_gain				/* =
apparent power */
=E2=80=94
AWGAIN		-	in_power_ai_gain				=
/* active power */
=E2=80=94
AVARGAIN	-	in_power_aq_gain				=
/* reactive power */
=E2=80=94
Now here it becomes more complicated. Not sure how this gets handled.=20
AFWATTOS	-	in_power_a_active/fundamental/offset
=E2=80=94
AWATTHR	-	in_energy_ai_accumulation
=E2=80=94
AVARHR		-	in_energy_aq_accumulation
=E2=80=94
IPEAK		-	in_current_peak
=E2=80=94

I=E2=80=99ll leave it there, because there are some even more =
complicated register naming issues.

Regards,
John





> On Mar 10, 2018, at 7:10 AM, Jonathan Cameron <jic23@kernel.org> =
wrote:
>=20
> On Thu, 8 Mar 2018 21:37:33 -0300
> Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com =
<mailto:rodrigosiqueiramelo@gmail.com>> wrote:
>=20
>> On 03/07, Jonathan Cameron wrote:
>>> On Tue, 6 Mar 2018 21:43:47 -0300
>>> Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:
>>>=20
>>>> The macro IIO_DEV_ATTR_CH_OFF is a wrapper for IIO_DEVICE_ATTR, =
with a
>>>> tiny change in the name definition. This extra macro does not =
improve
>>>> the readability and also creates some checkpatch errors.
>>>>=20
>>>> This patch fixes the checkpatch.pl errors:
>>>>=20
>>>> staging/iio/meter/ade7753.c:391: ERROR: Use 4 digit octal (0777) =
not
>>>> decimal permissions
>>>> staging/iio/meter/ade7753.c:395: ERROR: Use 4 digit octal (0777) =
not
>>>> decimal permissions
>>>> staging/iio/meter/ade7759.c:331: ERROR: Use 4 digit octal (0777) =
not
>>>> decimal permissions
>>>> staging/iio/meter/ade7759.c:335: ERROR: Use 4 digit octal (0777) =
not
>>>> decimal permissions
>>>>=20
>>>> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> =20
>>>=20
>>> Hmm. I wondered a bit about this one. It's a correct patch in of
>>> itself but the interface in question doesn't even vaguely conform
>>> to any of defined IIO ABI.  Anyhow, it's still and improvement so
>>> I'll take it. =20
>>=20
>> I am not sure if I understood the comment about the ABI. The meter
>> interface is wrong because it uses things like IIO_DEVICE_ATTR? It
>> should use iio_info together with *write_raw and *read_raw. Right? Is =
it
>> the ABI problem that you refer?
> The ABI is about the userspace interface of IIO.  It is defined
> in Documentation/ABI/testing/sysfs-bus-iio*
> So this documents the naming of sysfs attributes and (more or less)
> describes a consistent interface to userspace across lots of different
> types of devices.
>=20
> A lot of these older drivers in staging involve a good deal of ABI =
that
> was not reviewed or discussed.  That is one of the biggest reasons we
> didn't take them out of staging in the first place.
>=20
> In order for generic userspace programs to have any idea what to do
> with these devices this all needs to be fixed.
>=20
> There may well be cases where we need to expand the existing ABI to
> cover new things.   That's fine, but it has to be done with full
> review of the relevant documentation patches.
>=20
> Incidentally if you want an easy driver to work on moving out of =
staging
> then first thing to do is to compare what it shows to userspace with =
these
> docs.  If it's totally different then you have a big job on your hands
> as often ABI can take a lot of discussion and a long time to establish
> a consensus.
>=20
> Jonathan
>=20
>=20
>>=20
>> Thanks :)
>>=20
>>> Applied to the togreg branch of iio.git and pushed out as testing
>>> for the autobuilders to play with it.
>>>=20
>>> I also added the removal of the header define which is no
>>> longer used.
>>>=20
>>> Please note, following discussions with Michael, I am going to send
>>> an email announcing an intent to drop these meter drivers next
>>> cycle unless someone can provide testing for any attempt to
>>> move them out of staging.  I'm still taking patches on the basis
>>> that 'might' happen - but I wouldn't focus on these until we
>>> have some certainty on whether they will be around long term!
>>>=20
>>> Jonathan
>>>=20
>>>> ---
>>>> drivers/staging/iio/meter/ade7753.c | 18 ++++++++++--------
>>>> drivers/staging/iio/meter/ade7759.c | 18 ++++++++++--------
>>>> 2 files changed, 20 insertions(+), 16 deletions(-)
>>>>=20
>>>> diff --git a/drivers/staging/iio/meter/ade7753.c =
b/drivers/staging/iio/meter/ade7753.c
>>>> index c44eb577dc35..275e8dfff836 100644
>>>> --- a/drivers/staging/iio/meter/ade7753.c
>>>> +++ b/drivers/staging/iio/meter/ade7753.c
>>>> @@ -388,14 +388,16 @@ static IIO_DEV_ATTR_VPERIOD(0444,
>>>> 		ade7753_read_16bit,
>>>> 		NULL,
>>>> 		ADE7753_PERIOD);
>>>> -static IIO_DEV_ATTR_CH_OFF(1, 0644,
>>>> -		ade7753_read_8bit,
>>>> -		ade7753_write_8bit,
>>>> -		ADE7753_CH1OS);
>>>> -static IIO_DEV_ATTR_CH_OFF(2, 0644,
>>>> -		ade7753_read_8bit,
>>>> -		ade7753_write_8bit,
>>>> -		ADE7753_CH2OS);
>>>> +
>>>> +static IIO_DEVICE_ATTR(choff_1, 0644,
>>>> +			ade7753_read_8bit,
>>>> +			ade7753_write_8bit,
>>>> +			ADE7753_CH1OS);
>>>> +
>>>> +static IIO_DEVICE_ATTR(choff_2, 0644,
>>>> +			ade7753_read_8bit,
>>>> +			ade7753_write_8bit,
>>>> +			ADE7753_CH2OS);
>>>>=20
>>>> static int ade7753_set_irq(struct device *dev, bool enable)
>>>> {
>>>> diff --git a/drivers/staging/iio/meter/ade7759.c =
b/drivers/staging/iio/meter/ade7759.c
>>>> index 1decb2b8afab..c078b770fa53 100644
>>>> --- a/drivers/staging/iio/meter/ade7759.c
>>>> +++ b/drivers/staging/iio/meter/ade7759.c
>>>> @@ -328,14 +328,16 @@ static IIO_DEV_ATTR_ACTIVE_POWER_GAIN(0644,
>>>> 		ade7759_read_16bit,
>>>> 		ade7759_write_16bit,
>>>> 		ADE7759_APGAIN);
>>>> -static IIO_DEV_ATTR_CH_OFF(1, 0644,
>>>> -		ade7759_read_8bit,
>>>> -		ade7759_write_8bit,
>>>> -		ADE7759_CH1OS);
>>>> -static IIO_DEV_ATTR_CH_OFF(2, 0644,
>>>> -		ade7759_read_8bit,
>>>> -		ade7759_write_8bit,
>>>> -		ADE7759_CH2OS);
>>>> +
>>>> +static IIO_DEVICE_ATTR(choff_1, 0644,
>>>> +			ade7759_read_8bit,
>>>> +			ade7759_write_8bit,
>>>> +			ADE7759_CH1OS);
>>>> +
>>>> +static IIO_DEVICE_ATTR(choff_2, 0644,
>>>> +			ade7759_read_8bit,
>>>> +			ade7759_write_8bit,
>>>> +			ADE7759_CH2OS);
>>>>=20
>>>> static int ade7759_set_irq(struct device *dev, bool enable)
>>>> { =20
>>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" =
in
>> the body of a message to majordomo@vger.kernel.org =
<mailto:majordomo@vger.kernel.org>
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html =
<http://vger.kernel.org/majordomo-info.html>
>=20
> _______________________________________________
> devel mailing list
> devel@linuxdriverproject.org <mailto:devel@linuxdriverproject.org>
> =
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel =
<http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>=


--Apple-Mail=_D9FF0FE0-2D25-4736-B142-E2EC969D5280
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D"">Hi =
Jonathan,<div class=3D""><br class=3D""></div><div class=3D"">I have =
been looking at the IIO ABI docs and if I understand correctly, the idea =
is to use consistent naming conventions? So for example, looking at the =
ADE7854 datasheet, the naming matching the ADE7854 registers would be as =
follows:</div><div class=3D""><br class=3D""></div><div =
class=3D"">{direction}_{type}_{index}_{modifier}_{info_mask}</div><div =
class=3D""><br class=3D""></div><div class=3D"">AIGAIN<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>-<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>In_current_a_gain</div><div class=3D"">AVGAIN<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>-<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>in_voltage_a_gain</div><div class=3D"">BIGAIN<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>-<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>in_current_b_gain</div><div class=3D"">BVGAIN<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>-<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>in_voltage_b_gain</div><div class=3D"">=E2=80=94</div><div =
class=3D"">How do we represent the rms and offset</div><div =
class=3D"">AIRMSOS<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>-<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>in_current_a_rmsoffset</div><div =
class=3D"">AVRMSOS<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>-<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>in_voltage_a_rmsoffset</div><div =
class=3D"">=E2=80=94</div><div class=3D"">Here I don=E2=80=99t =
understand how to represent both the phase and the =
active/reactive/apparent power components. Do we combine the phase and =
quadrature part like this</div><div class=3D"">AVAGAIN<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>-<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>in_power_a_gain<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">				</span>/* =
apparent power */</div><div class=3D"">=E2=80=94</div><div =
class=3D"">AWGAIN<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
		</span>-<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>in_power_ai_gain<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">				=
</span>/* active power */</div><div class=3D"">=E2=80=94</div><div =
class=3D"">AVARGAIN<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>-<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>in_power_aq_gain<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">				=
</span>/* reactive power */</div><div class=3D"">=E2=80=94</div><div =
class=3D"">Now here it becomes more complicated. Not sure how this gets =
handled.&nbsp;</div><div class=3D"">AFWATTOS<span class=3D"Apple-tab-span"=
 style=3D"white-space:pre">	</span>-<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_power_a_active/fundamental/offset</div><div =
class=3D"">=E2=80=94</div><div class=3D"">AWATTHR<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>-<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>in_energy_ai_accumulation</div><div class=3D"">=E2=80=94</div><div =
class=3D"">AVARHR<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
		</span>-<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_energy_aq_accumulation</div><div class=3D"">=E2=80=94</div><div =
class=3D"">IPEAK<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
	</span>-<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>in_current_peak</div><div class=3D"">=E2=80=94</div><div =
class=3D""><br class=3D""></div><div class=3D"">I=E2=80=99ll leave it =
there, because there are some even more complicated register naming =
issues.<br class=3D""><div class=3D"">
<div style=3D"color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D""><div =
class=3D""><br class=3D"Apple-interchange-newline">Regards,</div><div =
class=3D"">John</div><div class=3D""><br class=3D""></div><div =
class=3D""><br class=3D""></div></div><br =
class=3D"Apple-interchange-newline" style=3D"color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px;"><br =
class=3D"Apple-interchange-newline">

</div>
<div><br class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D"">On Mar 10, 2018, at 7:10 AM, Jonathan Cameron &lt;<a =
href=3D"mailto:jic23@kernel.org" class=3D"">jic23@kernel.org</a>&gt; =
wrote:</div><br class=3D"Apple-interchange-newline"><div class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">On Thu, 8 Mar 2018 21:37:33 =
-0300</span><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">Rodrigo Siqueira &lt;</span><a =
href=3D"mailto:rodrigosiqueiramelo@gmail.com" style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" =
class=3D"">rodrigosiqueiramelo@gmail.com</a><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">&gt; wrote:</span><br style=3D"font-family:=
 Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D"">On 03/07, Jonathan Cameron =
wrote:<br class=3D""><blockquote type=3D"cite" class=3D"">On Tue, 6 Mar =
2018 21:43:47 -0300<br class=3D"">Rodrigo Siqueira &lt;<a =
href=3D"mailto:rodrigosiqueiramelo@gmail.com" =
class=3D"">rodrigosiqueiramelo@gmail.com</a>&gt; wrote:<br class=3D""><br =
class=3D""><blockquote type=3D"cite" class=3D"">The macro =
IIO_DEV_ATTR_CH_OFF is a wrapper for IIO_DEVICE_ATTR, with a<br =
class=3D"">tiny change in the name definition. This extra macro does not =
improve<br class=3D"">the readability and also creates some checkpatch =
errors.<br class=3D""><br class=3D"">This patch fixes the checkpatch.pl =
errors:<br class=3D""><br class=3D"">staging/iio/meter/ade7753.c:391: =
ERROR: Use 4 digit octal (0777) not<br class=3D"">decimal permissions<br =
class=3D"">staging/iio/meter/ade7753.c:395: ERROR: Use 4 digit octal =
(0777) not<br class=3D"">decimal permissions<br =
class=3D"">staging/iio/meter/ade7759.c:331: ERROR: Use 4 digit octal =
(0777) not<br class=3D"">decimal permissions<br =
class=3D"">staging/iio/meter/ade7759.c:335: ERROR: Use 4 digit octal =
(0777) not<br class=3D"">decimal permissions<br class=3D""><br =
class=3D"">Signed-off-by: Rodrigo Siqueira &lt;<a =
href=3D"mailto:rodrigosiqueiramelo@gmail.com" =
class=3D"">rodrigosiqueiramelo@gmail.com</a>&gt; &nbsp;<br =
class=3D""></blockquote><br class=3D"">Hmm. I wondered a bit about this =
one. It's a correct patch in of<br class=3D"">itself but the interface =
in question doesn't even vaguely conform<br class=3D"">to any of defined =
IIO ABI. &nbsp;Anyhow, it's still and improvement so<br class=3D"">I'll =
take it. &nbsp;<br class=3D""></blockquote><br class=3D"">I am not sure =
if I understood the comment about the ABI. The meter<br =
class=3D"">interface is wrong because it uses things like =
IIO_DEVICE_ATTR? It<br class=3D"">should use iio_info together with =
*write_raw and *read_raw. Right? Is it<br class=3D"">the ABI problem =
that you refer?<br class=3D""></blockquote><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">The ABI is about the userspace interface =
of IIO. &nbsp;It is defined</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">in =
Documentation/ABI/testing/sysfs-bus-iio*</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">So this documents the naming of =
sysfs attributes and (more or less)</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">describes a consistent interface =
to userspace across lots of different</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">types of devices.</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br=
 style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">A lot of these older drivers in staging involve =
a good deal of ABI that</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">was not reviewed or discussed. =
&nbsp;That is one of the biggest reasons we</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">didn't take them out of staging in the first =
place.</span><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">In order for generic userspace =
programs to have any idea what to do</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">with these devices this all =
needs to be fixed.</span><br style=3D"font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">There may well be cases where we =
need to expand the existing ABI to</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">cover new things. =
&nbsp;&nbsp;That's fine, but it has to be done with full</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">review of the relevant documentation =
patches.</span><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">Incidentally if you want an easy =
driver to work on moving out of staging</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">then first thing to do is to =
compare what it shows to userspace with these</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">docs. &nbsp;If it's totally different then you =
have a big job on your hands</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">as often ABI can take a lot of =
discussion and a long time to establish</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">a consensus.</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br=
 style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">Jonathan</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br=
 style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D""><br class=3D"">Thanks :)<br =
class=3D""><br class=3D""><blockquote type=3D"cite" class=3D"">Applied =
to the togreg branch of iio.git and pushed out as testing<br =
class=3D"">for the autobuilders to play with it.<br class=3D""><br =
class=3D"">I also added the removal of the header define which is no<br =
class=3D"">longer used.<br class=3D""><br class=3D"">Please note, =
following discussions with Michael, I am going to send<br class=3D"">an =
email announcing an intent to drop these meter drivers next<br =
class=3D"">cycle unless someone can provide testing for any attempt =
to<br class=3D"">move them out of staging. &nbsp;I'm still taking =
patches on the basis<br class=3D"">that 'might' happen - but I wouldn't =
focus on these until we<br class=3D"">have some certainty on whether =
they will be around long term!<br class=3D""><br class=3D"">Jonathan<br =
class=3D""><br class=3D""><blockquote type=3D"cite" class=3D"">---<br =
class=3D"">drivers/staging/iio/meter/ade7753.c | 18 =
++++++++++--------<br class=3D"">drivers/staging/iio/meter/ade7759.c | =
18 ++++++++++--------<br class=3D"">2 files changed, 20 insertions(+), =
16 deletions(-)<br class=3D""><br class=3D"">diff --git =
a/drivers/staging/iio/meter/ade7753.c =
b/drivers/staging/iio/meter/ade7753.c<br class=3D"">index =
c44eb577dc35..275e8dfff836 100644<br class=3D"">--- =
a/drivers/staging/iio/meter/ade7753.c<br class=3D"">+++ =
b/drivers/staging/iio/meter/ade7753.c<br class=3D"">@@ -388,14 +388,16 =
@@ static IIO_DEV_ATTR_VPERIOD(0444,<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ade7753_read_16bit,<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>NULL,<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ADE7753_PERIOD);<br class=3D"">-static IIO_DEV_ATTR_CH_OFF(1, =
0644,<br class=3D"">-<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>ade7753_read_8bit,<br class=3D"">-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ade7753_write_8bit,<br class=3D"">-<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ADE7753_CH1OS);<br =
class=3D"">-static IIO_DEV_ATTR_CH_OFF(2, 0644,<br class=3D"">-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ade7753_read_8bit,<br class=3D"">-<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ade7753_write_8bit,<br =
class=3D"">-<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ADE7753_CH2OS);<br class=3D"">+<br class=3D"">+static =
IIO_DEVICE_ATTR(choff_1, 0644,<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ade7753_read_8bit,<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ade7753_write_8bit,<br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ADE7753_CH1OS);<br class=3D"">+<br class=3D"">+static =
IIO_DEVICE_ATTR(choff_2, 0644,<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ade7753_read_8bit,<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ade7753_write_8bit,<br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ADE7753_CH2OS);<br class=3D""><br class=3D"">static int =
ade7753_set_irq(struct device *dev, bool enable)<br class=3D"">{<br =
class=3D"">diff --git a/drivers/staging/iio/meter/ade7759.c =
b/drivers/staging/iio/meter/ade7759.c<br class=3D"">index =
1decb2b8afab..c078b770fa53 100644<br class=3D"">--- =
a/drivers/staging/iio/meter/ade7759.c<br class=3D"">+++ =
b/drivers/staging/iio/meter/ade7759.c<br class=3D"">@@ -328,14 +328,16 =
@@ static IIO_DEV_ATTR_ACTIVE_POWER_GAIN(0644,<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ade7759_read_16bit,<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ade7759_write_16bit,<br =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ADE7759_APGAIN);<br class=3D"">-static IIO_DEV_ATTR_CH_OFF(1, =
0644,<br class=3D"">-<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>ade7759_read_8bit,<br class=3D"">-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ade7759_write_8bit,<br class=3D"">-<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ADE7759_CH1OS);<br =
class=3D"">-static IIO_DEV_ATTR_CH_OFF(2, 0644,<br class=3D"">-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ade7759_read_8bit,<br class=3D"">-<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ade7759_write_8bit,<br =
class=3D"">-<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ADE7759_CH2OS);<br class=3D"">+<br class=3D"">+static =
IIO_DEVICE_ATTR(choff_1, 0644,<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ade7759_read_8bit,<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ade7759_write_8bit,<br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ADE7759_CH1OS);<br class=3D"">+<br class=3D"">+static =
IIO_DEVICE_ATTR(choff_2, 0644,<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ade7759_read_8bit,<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ade7759_write_8bit,<br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ADE7759_CH2OS);<br class=3D""><br class=3D"">static int =
ade7759_set_irq(struct device *dev, bool enable)<br class=3D"">{ =
&nbsp;<br class=3D""></blockquote><br class=3D""></blockquote>--<br =
class=3D"">To unsubscribe from this list: send the line "unsubscribe =
linux-iio" in<br class=3D"">the body of a message to<span =
class=3D"Apple-converted-space">&nbsp;</span><a =
href=3D"mailto:majordomo@vger.kernel.org" =
class=3D"">majordomo@vger.kernel.org</a><br class=3D"">More majordomo =
info at &nbsp;<a href=3D"http://vger.kernel.org/majordomo-info.html" =
class=3D"">http://vger.kernel.org/majordomo-info.html</a><br =
class=3D""></blockquote><br style=3D"font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" =
class=3D"">_______________________________________________</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">devel mailing list</span><br style=3D"font-family:=
 Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><a =
href=3D"mailto:devel@linuxdriverproject.org" style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" =
class=3D"">devel@linuxdriverproject.org</a><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><a =
href=3D"http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev=
-devel" style=3D"font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px;" =
class=3D"">http://driverdev.linuxdriverproject.org/mailman/listinfo/driver=
dev-devel</a></div></blockquote></div><br class=3D""></div></body></html>=

--Apple-Mail=_D9FF0FE0-2D25-4736-B142-E2EC969D5280--
