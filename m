Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B7DC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA0220693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pados.hu header.i=@pados.hu header.b="tcS+IemI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEA0220693
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=pados.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754351AbeFTJpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:45:17 -0400
Received: from erza.pados.hu ([176.9.136.194]:46380 "EHLO erza.pados.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754061AbeFTJpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pados.hu;
         s=february2016; h=References:In-Reply-To:Cc:To:Subject:Message-ID:From:
        Content-Transfer-Encoding:Content-Type:Date:MIME-Version:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eGczEHpgtc2PhiYiHW4GmWIwLVmKt62frtj/rrwX4ks=; b=tcS+IemInclTuy+x0CWYG2PDDg
        9L5vV5geMoO81UtNIcThbW0Pd3TpYGrXnfdQHO32pK1VEfJZ8kZZnxBfpuE/EPJZcLXZzAS9zByu0
        xVEh0Wl0D4PNFqZ4cInuWx3+EAqAkBHK0C6ZVkKUaPT6LDTZ3d0HykRs5M8ikym3wS9ymZ7akCdNs
        YeAjHCx+wdypsZqPzcx+GDG/FQsCJTWKlyciaz82qcE2GLGRYFSoHNzD6l+fiqNTStzbfeHIquNE2
        6SFRhdpHHnTdfAvTzmrYkrtHE9uN/NwlyBgRmKp92vxjvq71fU364SzXD7/YyCscFmvW2Lh8mNYyA
        sEjUfQ+g==;
Received: from localhost ([127.0.0.1] helo=webmail.pados.hu)
        by erza with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <pados@pados.hu>)
        id 1fVZfn-0006pz-Dm; Wed, 20 Jun 2018 11:45:08 +0200
MIME-Version: 1.0
Date:   Wed, 20 Jun 2018 09:45:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.0
From:   "Karoly Pados" <pados@pados.hu>
Message-ID: <b2526c441d5d99b5f491b78cf9e84475@pados.hu>
Subject: Re: [PATCH] USB: serial: cp210x: Implement GPIO support for
 CP2102N
To:     "Johan Hovold" <johan@kernel.org>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20180620082507.GO32411@localhost>
References: <20180620082507.GO32411@localhost>
 <20180617182503.23080-1-pados@pados.hu>
X-Spam_score: -2.9
X-Spam_report: Spam detection software, running on the system "erza",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  OK, though if you allow me a few comments and explanations:
    > You're gonna need to unify a lot of this with the current implementation
    > for cp2105 however. > This also relates to your later points about unifying
    the cp2105 an cp2102n: The implementation for the cp2102n ended up pretty
    different. Both in initializaiton as well as normal operation, partially
   due to the better config/input/alt.function support for the cp2102n. At this
    point I though it is much more readable if I just create separate code hierarchies
    than having to pollute everything with ifs and switch-cases. [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
  0.0 URIBL_BLOCKED          ADMINISTRATOR NOTICE: The query to URIBL was blocked.
                             See
                             http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
                              for more information.
                             [URIs: real-time.com]
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK, though if you allow me a few comments and explanations:=0A=0A=0A> You=
're gonna need to unify a lot of this with the current implementation=0A>=
 for cp2105 however.=0A>=0AThis also relates to your later points about u=
nifying the cp2105 an cp2102n:=0AThe implementation for the cp2102n ended=
 up pretty different. Both in initializaiton=0Aas well as normal operatio=
n, partially due to the better config/input/alt.function=0Asupport for th=
e cp2102n. At this point I though it is much more readable if I just crea=
te=0Aseparate code hierarchies than having to pollute everything with ifs=
 and switch-cases.=0A=0AAnd maybe most importantly, I cannot test on the =
cp2105, so I cannot check if I've broken=0Aanything by mistake, and since=
 it is the odd bird anyway among most devices, =0AI though it is pretty l=
ogical not to touch its code but instead create a new skeleton for=0Aothe=
rs.=0A=0AOf course you're the boss and whatever you say I will do, but I =
wanted to explain my reasons=0A(or at least let you know my arguments).=
=0A=0A> I was going to comment on the odd coding style above, when I noti=
ced=0A> that you've copied this implementation from a silabs forum post. =
Not=0A> good at all (as there was no indication of any license).=0A> =0AN=
ot quite. It is not from a forum post, but from a SiLabs Knowledge Base a=
rticle=0A(https://www.silabs.com/community/interface/knowledge-base.entry=
.html/2017/06/12/fletcher_checksumfo-TeDF)=0AThat article states explicit=
ly that the code was taken from Wikipedia, so it is CC-SA, which is to=0A=
the best of my knowledge 1) compatible with GPL, and 2) does not require =
attribution if the original material=0Ais missing it, and it does. So AFA=
ICT we are clear on the licensing front.=0A=0ADo you still want me to rem=
ove the checksum check?=0A=0A> So for cp2105 we decided against implement=
ing an input mode. We at least=0A> need to be consistent here, so I sugge=
st starting with dropping those=0A>=0AAgain, you're the boss, but I do fi=
nd this odd. These are different devices and thankfully now=0Athere'd be =
better support for the cp2102n, and you're asking me to remove input supp=
ort for=0Aconsistency reasons. To remove a feature for one device just be=
cause it wasn't correctly implemented=0Ain another and wanting to stay co=
nsistent with the missing support is very odd for me tbh.=0AI know I'm in=
 no position, but please let me ask you once to please reconsider this.=
=0A=0AThe way it was done for the cp2105 where we make everything and eve=
ryone on the system=0Athink that a pin is "out" but in reality is an inpu=
t is quirky to say the least, while=0Aat the same time it also does not m=
ake sure that an input pin (which is of course not marked as such)=0Ais r=
eally an input.  Why amputate the cp2102n like this if it has been alread=
y implemented correctly?=0AIf we wanted to stay consistent with half-deve=
loped and incomplete drivers then there'd be no=0Aimprovements to Linux. =
=0A=0A> Please be more specific here; what do you mean by not correspondi=
ng to=0A> reality.=0A>=0AIt means that I've found GPIO4-6 occupying bits =
which were documented doing completely other things,=0Aand those other th=
ings occupying reserved bits even though they were documented occupying t=
he places=0Awhere GPIOs 4-6 were.=0A=0A> No need to check for this in eve=
ry callback; move to=0A> cp210x_gpio_request().=0A>=0AWouldn't this preve=
nt the disabled GPIOs from being created in the first place?=0AI very muc=
h want to create them in every case, because otherwise it becomes a PITA =
=0Afor both the driver and consumers:=0A- For the driver a PITA, because =
the disabled GPIOs can be any and non-continuous,=0Aso the module would n=
eed to dynamically and arbitrarily remap logical GPIOs to hardware GPIO n=
umbers.=0A- For consumers a PITA, because it would mean GPIOs can change =
names depending on the current configuration=0Aof the device. On one devi=
ce GPIO.3 would be called GPIO.2, on another GPIO.1 etc. My intention=0Ah=
ere is that applications should be able to use the real ID of the GPIO an=
d expect that GPIO.3 (base+offset 3)=0Ais actually GPIO.3 and not somethi=
ng else.=0A=0ABest,=0AKaroly=0A=0AJune 20, 2018 10:25 AM, "Johan Hovold" =
<johan@kernel.org> wrote:=0A=0A> On Sun, Jun 17, 2018 at 08:25:03PM +0200=
, Karoly Pados wrote:=0A> =0A>> Pretty much what the title says. No other=
 functions/devices=0A>> touched. Tested on CP2102N-QFN28.=0A>> =0A>> Limi=
tation: Even though the QFN28 package has 7 GPIOs,=0A>> this patch allows=
 to control only the first 4.=0A>> What I've found using reverse engineer=
ing regarding the=0A>> other 3 pins collides both with reality and with o=
ther=0A>> documented functions, so I did not dare to just use my=0A>> fin=
dings because I cannot test on other packages.=0A>> Instead, I decided to=
 play it safe and only support 4 GPIOs.=0A> =0A> Thanks for the patch. Ni=
ce to see this finally be implemented for=0A> further device types.=0A> =
=0A> You're gonna need to unify a lot of this with the current implementa=
tion=0A> for cp2105 however.=0A> =0A>> Signed-off-by: Karoly Pados <pados=
@pados.hu>=0A>> ---=0A>> drivers/usb/serial/cp210x.c | 259 ++++++++++++++=
+++++++++++++++++++++-=0A>> 1 file changed, 257 insertions(+), 2 deletion=
s(-)=0A>> =0A>> diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/se=
rial/cp210x.c=0A>> index 793b86252c46..adb450185ce8 100644=0A>> --- a/dri=
vers/usb/serial/cp210x.c=0A>> +++ b/drivers/usb/serial/cp210x.c=0A>> @@ -=
6,7 +6,8 @@=0A>> *=0A>> * Support to set flow control line levels using T=
IOCMGET and TIOCMSET=0A>> * thanks to Karl Hiramoto karl@hiramoto.org. RT=
SCTS hardware flow=0A>> - * control thanks to Munir Nassar nassarmu@real-=
time.com=0A>> + * control thanks to Munir Nassar nassarmu@real-time.com.=
=0A>> + * GPIO support for CP2102N thanks to Karoly Pados.=0A> =0A> No ne=
ed to thank yourself here. This was added by the original author=0A> (who=
 appears to have partly been developing this driver out-of-tree) to=0A> c=
redit contributers.=0A> =0A> The git logs will keep a record of your cont=
ributions.=0A> =0A>> *=0A>> */=0A>> =0A>> @@ -229,11 +230,16 @@ struct cp=
210x_serial_private {=0A>> struct gpio_chip gc;=0A>> u8 config;=0A>> u8 g=
pio_mode;=0A>> + u8 gpio_control;=0A>> + u8 gpio_dir;=0A>> bool gpio_regi=
stered;=0A>> #endif=0A>> u8 partnum;=0A>> };=0A>> =0A>> +#define CP2102N_=
PIN_OPENDRAIN(var, pin) (!((var) & BIT(pin)))=0A>> +#define CP2102N_PIN_G=
PIO(var, pin) (!((var) & BIT(pin)))=0A> =0A> These are in fact not cp2102=
n specific. If they are at all needed in the=0A> end they should be imple=
mented as generic static functions.=0A> =0A>> +=0A>> struct cp210x_port_p=
rivate {=0A>> __u8 bInterfaceNumber;=0A>> bool has_swapped_line_ctl;=0A>>=
 @@ -349,6 +355,7 @@ static struct usb_serial_driver * const serial_drive=
rs[] =3D {=0A>> #define CP210X_GET_PORTCONFIG 0x370C=0A>> #define CP210X_=
GET_DEVICEMODE 0x3711=0A>> #define CP210X_WRITE_LATCH 0x37E1=0A>> +#defin=
e CP210X_READ_2NCONFIG 0x000E=0A> =0A> Keep the defines sorted by value.=
=0A> =0A>> /* Part number definitions */=0A>> #define CP210X_PARTNUM_CP21=
01 0x01=0A>> @@ -362,6 +369,14 @@ static struct usb_serial_driver * const=
 serial_drivers[] =3D {=0A>> #define CP210X_PARTNUM_CP2102N_QFN20 0x22=0A=
>> #define CP210X_PARTNUM_UNKNOWN 0xFF=0A>> =0A>> +#define IS_CP2102N(par=
tnum) (((partnum) =3D=3D CP210X_PARTNUM_CP2102N_QFN28) || \=0A>> + ((part=
num) =3D=3D CP210X_PARTNUM_CP2102N_QFN24) || \=0A>> + ((partnum) =3D=3D C=
P210X_PARTNUM_CP2102N_QFN20))=0A> =0A> So reuse the static helper I menti=
oned in my comments to the baudrate=0A> patch.=0A> =0A>> +=0A>> +#define =
CP210X_2NCONFIG_GPIO_CONTROL_IDX 600=0A>> +#define CP210X_2NCONFIG_GPIO_M=
ODE_IDX 581=0A>> +#define CP210X_2NCONFIG_GPIO_RSTLATCH_IDX 587=0A> =0A> =
Sort by value.=0A> =0A>> +=0A>> /* CP210X_GET_COMM_STATUS returns these 0=
x13 bytes */=0A>> struct cp210x_comm_status {=0A>> __le32 ulErrors;=0A>> =
@@ -1455,6 +1470,235 @@ static void cp210x_gpio_remove(struct usb_serial =
*serial)=0A>> }=0A>> }=0A>> =0A>> +static int cp2102n_gpio_get(struct gpi=
o_chip *gc, unsigned int gpio)=0A>> +{=0A>> + struct usb_serial *serial =
=3D gpiochip_get_data(gc);=0A>> + int result;=0A>> + u8 buf;=0A>> +=0A>> =
+ result =3D cp210x_read_vendor_block(serial, REQTYPE_DEVICE_TO_HOST,=0A>=
> + CP210X_READ_LATCH, &buf, sizeof(buf));=0A>> + if (result < 0)=0A>> + =
return result;=0A>> +=0A>> + return !!(buf & BIT(gpio));=0A>> +}=0A> =0A>=
 This should be handled in cp210x_gpio_get() by making the control=0A> re=
quest type depend on the device type.=0A> =0A> Make the cp2102n behaviour=
 the default as it is used also by some legacy=0A> devices, and explicitl=
y check for the cp2105 odd bird. We'll deal with=0A> cp2108, which=2016 g=
pios and hence uses 16-bit mask, when we get there.=0A> =0A>> +=0A>> +sta=
tic void cp2102n_gpio_set(struct gpio_chip *gc, unsigned int gpio, int va=
lue)=0A>> +{=0A>> + int result;=0A>> + struct cp210x_gpio_write buf;=0A>>=
 + struct usb_serial *serial =3D gpiochip_get_data(gc);=0A>> + struct cp2=
10x_serial_private *priv =3D usb_get_serial_data(serial);=0A>> +=0A>> + /=
* Ignore request if pin is not in our control */=0A>> + if (!CP2102N_PIN_=
GPIO(priv->gpio_control, gpio)) {=0A>> + dev_warn(&serial->interface->dev=
,=0A>> + "Cannot control GPIO with active alternate function.\n");=0A>> +=
 return;=0A>> + }=0A> =0A> No need to check for this in every callback; m=
ove to=0A> cp210x_gpio_request().=0A> =0A>> +=0A>> + buf.state =3D (value=
 =3D=3D 1) ? BIT(gpio) : 0;=0A>> + buf.mask =3D BIT(gpio);=0A>> +=0A>> + =
result =3D usb_control_msg(serial->dev,=0A>> + usb_sndctrlpipe(serial->de=
v, 0),=0A>> + CP210X_VENDOR_SPECIFIC,=0A>> + REQTYPE_HOST_TO_DEVICE,=0A>>=
 + CP210X_WRITE_LATCH,=0A>> + *(u16 *)&buf,=0A> =0A> AFAICT this will wor=
k also on big-endian machines, but the implicit=0A> endian conversions in=
volved makes my head spin. ;)=0A> =0A> It may be better to just encode th=
e masks explicitly for the default=0A> (non-cp2105) case that use wIndex:=
=0A> =0A> buf.state << 8 | buf.mask=0A> =0A> when merging this with cp210=
x_gpio_set.=0A> =0A>> + NULL, 0, USB_CTRL_SET_TIMEOUT);=0A>> +=0A>> + if =
(result < 0) {=0A>> + dev_err(&serial->interface->dev,=0A>> + "Failed to =
set GPIO value.\n");=0A>> + }=0A>> +}=0A>> +=0A>> +static int cp2102n_gpi=
o_direction_get(struct gpio_chip *gc, unsigned int gpio)=0A>> +{=0A>> + s=
truct usb_serial *serial =3D gpiochip_get_data(gc);=0A>> + struct cp210x_=
serial_private *priv =3D usb_get_serial_data(serial);=0A>> +=0A>> + retur=
n priv->gpio_dir & BIT(gpio);=0A>> +}=0A> =0A> So for cp2105 we decided a=
gainst implementing an input mode. We at least=0A> need to be consistent =
here, so I suggest starting with dropping those=0A> bits of the implement=
ation and we can have that discussion again and,=0A> depending on the out=
come, possibly enable it for all cp210x devices=0A> later.=0A> =0A>> +sta=
tic u16 fletcher16(u8 *data, u16 bytes)=0A>> +{=0A>> + u16 sum1 =3D 0xff,=
 sum2 =3D 0xff;=0A>> + u16 tlen;=0A>> +=0A>> + while (bytes) {=0A>> + tle=
n =3D bytes >=3D 20 ? 20 : bytes;=0A>> + bytes -=3D tlen;=0A>> + do {=0A>=
> + sum2 +=3D sum1 +=3D *data++;=0A>> + } while (--tlen);=0A>> + sum1 =3D=
 (sum1 & 0xff) + (sum1 >> 8);=0A>> + sum2 =3D (sum2 & 0xff) + (sum2 >> 8)=
;=0A>> + }=0A>> + /* Second reduction step to reduce sums to 8 bits */=0A=
>> + sum1 =3D (sum1 & 0xff) + (sum1 >> 8);=0A>> + sum2 =3D (sum2 & 0xff) =
+ (sum2 >> 8);=0A>> + return sum2 << 8 | sum1;=0A>> +}=0A> =0A> I was goi=
ng to comment on the odd coding style above, when I noticed=0A> that you'=
ve copied this implementation from a silabs forum post. Not=0A> good at a=
ll (as there was no indication of any license).=0A> =0A> Please remove.=
=0A> =0A> Fortunately, the below checksum is redundant so no need for you=
 to=0A> reimplement this yourself.=0A> =0A>> +=0A>> +static int cp2102n_g=
pio_init(struct usb_serial *serial)=0A>> +{=0A>> + const u16 CONFIG_SIZE =
=3D 0x02A6;=0A>> + int result;=0A>> + u16 config_csum;=0A>> + u8 *config_=
buf;=0A>> + u8 gpio_ctrl;=0A>> + u8 gpio_mode;=0A>> + u8 gpio_latch;=0A>>=
 + u8 gpio_rst_latch;=0A>> + u8 i;=0A>> + bool config_valid =3D true;=0A>=
> + struct cp210x_serial_private *priv =3D usb_get_serial_data(serial);=
=0A> =0A> Style nit: Move longer declarations towards the top of the func=
tion=0A> (reverse xmas style).=0A> =0A>> +=0A>> + /* Retrieve device conf=
iguration from the device.=0A>> + * The array received contains all custo=
mization settings=0A>> + * done at the factory/manufacturer.=0A>> + * For=
mat of the array is documented at the time of writing at=0A>> + *=0A>> ht=
tps://www.silabs.com/community/interface/knowledge-base.entry.html/2017/0=
3/31/cp2102n_setconfig-xs=0A>> a=0A>> + */=0A> =0A> Multi-line comments s=
hould use the following format=0A> =0A> /*=0A> * blah...=0A> */=0A> =0A>>=
 + config_buf =3D kmalloc(CONFIG_SIZE, GFP_KERNEL);=0A>> + if (!config_bu=
f)=0A>> + return -ENOMEM;=0A>> +=0A>> + result =3D cp210x_read_vendor_blo=
ck(serial,=0A>> + REQTYPE_DEVICE_TO_HOST,=0A>> + CP210X_READ_2NCONFIG,=0A=
>> + config_buf,=0A>> + CONFIG_SIZE);=0A>> + if (result < 0)=0A>> + retur=
n result;=0A>> +=0A>> + /* Check configuration for validity.=0A>> + * The=
 last two bytes of the array contain a fletcher16=0A>> + * checksum of al=
l the bytes before, which we can validate.=0A>> + */=0A>> + config_csum =
=3D fletcher16(config_buf, CONFIG_SIZE - 2);=0A>> + if (((config_csum & 0=
xFF) !=3D config_buf[CONFIG_SIZE - 1]) ||=0A>> + ((config_csum >> 8) !=3D=
 config_buf[CONFIG_SIZE - 2])) {=0A>> + config_valid =3D false;=0A>> + de=
v_err(&serial->interface->dev,=0A>> + "Corrupted device configuration rec=
eived\n");=0A>> + }=0A> =0A> So just drop this for now.=0A> =0A>> +=0A>> =
+ gpio_mode =3D config_buf[CP210X_2NCONFIG_GPIO_MODE_IDX];=0A>> + gpio_ct=
rl =3D config_buf[CP210X_2NCONFIG_GPIO_CONTROL_IDX];=0A>> + gpio_rst_latc=
h =3D config_buf[CP210X_2NCONFIG_GPIO_RSTLATCH_IDX];=0A>> +=0A>> + kfree(=
config_buf);=0A>> +=0A>> + if (!config_valid)=0A>> + return -EIO;=0A>> +=
=0A>> + /* We only support 4 GPIOs even on the QFN28 package because=0A>>=
 + * documentation about the CP2102N GetConfig Array=0A>> + * does not se=
em to correspond to reality on this device.=0A>> + */=0A> =0A> Please be =
more specific here; what do you mean by not corresponding to=0A> reality.=
=0A> =0A>> + priv->gc.ngpio =3D 4;=0A>> +=0A>> + /* Get default pin state=
s after reset. Needed so we can determine=0A>> + * the direction of an op=
en-drain pin.=0A>> + */=0A>> + gpio_latch =3D (gpio_rst_latch >> 3) & 0x0=
F;=0A>> +=0A>> + /* 0 indicates open-drain mode, 1 is push-pull */=0A>> +=
 priv->gpio_mode =3D (gpio_mode >> 3) & 0x0F;=0A>> +=0A>> + /* 0 indicate=
s GPIO mode, 1 is alternate function */=0A>> + priv->gpio_control =3D (gp=
io_ctrl >> 2) & 0x0F;=0A>> +=0A>> + /* The CP2102N does not strictly has =
input and output pin modes,=0A>> + * it only knows open-drain and push-pu=
ll modes which is set at=0A>> + * factory. An open-drain pin can function=
 both as an=0A>> + * input or an output. We emulate input mode for open-d=
rain pins=0A>> + * by making sure they are not driven low, and we do not =
allow=0A>> + * push-pull pins to be set as an input.=0A>> + */=0A>> + for=
 (i =3D 0; i < priv->gc.ngpio; ++i) {=0A>> + /* Set direction to "input" =
iff=0A>> + * pin is open-drain and reset value is 1=0A>> + */=0A>> + if (=
CP2102N_PIN_OPENDRAIN(priv->gpio_mode, i) &&=0A>> + (gpio_latch & BIT(i))=
) {=0A>> + priv->gpio_dir |=3D BIT(i);=0A>> + }=0A>> + }=0A> =0A> So this=
 can be simplified a bit by deferring implementing an input mode.=0A> =0A=
>> +=0A>> + priv->gc.label =3D "cp2102n";=0A>> + priv->gc.get_direction =
=3D cp2102n_gpio_direction_get;=0A>> + priv->gc.direction_input =3D cp210=
2n_gpio_direction_input;=0A>> + priv->gc.direction_output =3D cp2102n_gpi=
o_direction_output;=0A>> + priv->gc.get =3D cp2102n_gpio_get;=0A>> + priv=
->gc.set =3D cp2102n_gpio_set;=0A>> + priv->gc.owner =3D THIS_MODULE;=0A>=
> + priv->gc.parent =3D &serial->interface->dev;=0A>> + priv->gc.base =3D=
 -1;=0A>> + priv->gc.can_sleep =3D true;=0A>> +=0A>> + result =3D gpiochi=
p_add_data(&priv->gc, serial);=0A>> + if (!result)=0A>> + priv->gpio_regi=
stered =3D true;=0A> =0A> And this whole function should be merged with t=
he cp2105 implementation.=0A> Retrieving and parsing the configuration is=
 obviously going to remain=0A> type specific (and live in their own funct=
ions), but the above=0A> initialisation and registration can be shared.=
=0A> =0A>> +=0A>> + return result;=0A>> +}=0A>> +=0A>> #else=0A>> =0A>> s=
tatic int cp2105_shared_gpio_init(struct usb_serial *serial)=0A>> @@ -146=
2,6 +1706,11 @@ static int cp2105_shared_gpio_init(struct usb_serial *ser=
ial)=0A>> return 0;=0A>> }=0A>> =0A>> +static int cp2102n_gpio_init(struc=
t usb_serial *serial)=0A>> +{=0A>> + return 0;=0A>> +}=0A>> +=0A>> static=
 void cp210x_gpio_remove(struct usb_serial *serial)=0A>> {=0A>> /* Nothin=
g to do */=0A>> @@ -1522,7 +1771,13 @@ static int cp210x_attach(struct us=
b_serial *serial)=0A>> =0A>> usb_set_serial_data(serial, priv);=0A>> =0A>=
> - if (priv->partnum =3D=3D CP210X_PARTNUM_CP2105) {=0A>> + if (IS_CP210=
2N(priv->partnum)) {=0A>> + result =3D cp2102n_gpio_init(serial);=0A>> + =
if (result < 0) {=0A>> + dev_err(&serial->interface->dev,=0A>> + "GPIO in=
itialisation failed, continuing without GPIO support\n");=0A>> + }=0A>> +=
 } else if (priv->partnum =3D=3D CP210X_PARTNUM_CP2105) {=0A>> result =3D=
 cp2105_shared_gpio_init(serial);=0A>> if (result < 0) {=0A>> dev_err(&se=
rial->interface->dev,=0A> =0A> And this all should be hidden away in a co=
mmon cp210x_gpio_init()=0A> function.=0A> =0A> Thanks,=0A> Johan
