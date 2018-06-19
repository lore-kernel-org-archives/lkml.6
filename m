Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B421C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC3B42075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pados.hu header.i=@pados.hu header.b="ktiSJf5R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC3B42075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=pados.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757055AbeFSJvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 05:51:02 -0400
Received: from erza.pados.hu ([176.9.136.194]:40686 "EHLO erza.pados.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755866AbeFSJu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 05:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pados.hu;
         s=february2016; h=References:In-Reply-To:Cc:To:Subject:Message-ID:From:
        Content-Transfer-Encoding:Content-Type:Date:MIME-Version:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TgQ9VyCdVOhgG/gzwq8aFkt7A3LTChhySTa9Y2/PDDI=; b=ktiSJf5RGCDVevAt16qsGeFHEY
        oO6KFWUAGfGyry05rwztsSZZRQ1sOkvAdfLC5EqOMPVBS9l/rZfyHjw8ArzE1Ste+CMw/PliFrf4B
        /ohhcVixHYrE6TdoJKrqJojnCw68sEi6u6J9K5XcLwLfL08jPZKUVNj1FJW4m2gMOFXrSz9k2IkTM
        wmg2cBj8nM/eknSqI6zXk3MsQVLmFyqt29QAU82yxaZDq+eRsw58hoGZV1511pLfRt/cVrSr32TR7
        oD3aRDJBVbDsoR4w0dGueqfYCGJr0H1w8pJRUdstXNxrsobRTcTDnI91/BQOxMKItApi0Btq/1kV5
        5rEf4Jcw==;
Received: from localhost ([127.0.0.1] helo=webmail.pados.hu)
        by erza with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <pados@pados.hu>)
        id 1fVDHs-0000DT-D3; Tue, 19 Jun 2018 11:50:56 +0200
MIME-Version: 1.0
Date:   Tue, 19 Jun 2018 09:50:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.0
From:   "Karoly Pados" <pados@pados.hu>
Message-ID: <0b27c3da292fa1f4b360614685fe8aa4@pados.hu>
Subject: Re: [PATCH] USB: serial: cp210x: Improve baudrate support for
 CP2102N
To:     "Johan Hovold" <johan@kernel.org>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20180619091528.GN32411@localhost>
References: <20180619091528.GN32411@localhost>
 <20180615212957.26539-1-pados@pados.hu>
X-Spam_score: -2.9
X-Spam_report: Spam detection software, running on the system "erza",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  Hello, > Pass in a struct usb_serial (or port) as a first
   argument instead which > allows for more readable code as well as for this
    to be reused to handle > other device type differences (e.g. only 2108 besides
    2102n handles > baudrates over 921.6k). > [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
  0.0 URIBL_BLOCKED          ADMINISTRATOR NOTICE: The query to URIBL was blocked.
                             See
                             http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
                              for more information.
                             [URIs: pados.hu]
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,=0A=0A> Pass in a struct usb_serial (or port) as a first argument i=
nstead which=0A> allows for more readable code as well as for this to be =
reused to handle=0A> other device type differences (e.g. only 2108 beside=
s 2102n handles=0A> baudrates over 921.6k).=0A> =0A=0ASure, will do.=0A=
=0A> Add a static helper (looks like you add a define in the gpio patch)=
=0A> cp210x_is_cp2102n(serial) here.=0A=0AYes I have macro for that in th=
e GPIO patch, and I will turn that into a=0Astatic function too.=0A=0ATo =
keep the baudrate and gpio patches independent,=0Ado you think it is a go=
od idea if I make a new patch which only adds the=0Apartnum defines and t=
he helper function first, then baudrate v2 and gpio v2=0Acan build onto i=
t?=0A=0A> You can even test for bit 0x20 in the=0A> helper if you prefer =
(we can always change that later if needed).=0A>=0A=0AIf you wish, but pe=
rsonally I think that is asking for future bugs=0Ain the long run. Even t=
hough the helper can be easily adjusted if needed,=0Awhen/if a new partnu=
m shows up which has nothing to do with the cp2102n,=0Ano one will think =
of having to adjust cp2102n-spacific code until bug reports=0Astart comin=
g in. So I'd prefer to explicitly check for the packages, but in=0Athe en=
d I'll use whatever you prefer.=0A=0AWhat do you prefer?=0A=0A> And even =
if the current code uses this odd formatting, your amendments=0A> should =
not.=0A> =0A=0AOf course. I also saw this is odd, but (apparently wrongly=
) decided to =0Astay consistent inside the function with existing code. I=
 will change=0Athat too.=0A=0AGreetings,=0AKaroly=0A=0A=0AJune 19, 2018 1=
1:16 AM, "Johan Hovold" <johan@kernel.org> wrote:=0A=0A> On Fri, Jun 15, =
2018 at 11:29:57PM +0200, Karoly Pados wrote:=0A> =0A>> The CP2102N suppo=
rts more baudrates than earlier chips by SiLabs.=0A>> This patch adds sup=
port for all rates documented in the datasheet=0A>> of this device.=0A>> =
=0A>> Signed-off-by: Karoly Pados <pados@pados.hu>=0A>> ---=0A>> drivers/=
usb/serial/cp210x.c | 39 ++++++++++++++++++++++++++-----------=0A>> 1 fil=
e changed, 28 insertions(+), 11 deletions(-)=0A>> =0A>> diff --git a/driv=
ers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c=0A>> index b1849f65=
7e01..793b86252c46 100644=0A>> --- a/drivers/usb/serial/cp210x.c=0A>> +++=
 b/drivers/usb/serial/cp210x.c=0A>> @@ -357,6 +357,9 @@ static struct usb=
_serial_driver * const serial_drivers[] =3D {=0A>> #define CP210X_PARTNUM=
_CP2104 0x04=0A>> #define CP210X_PARTNUM_CP2105 0x05=0A>> #define CP210X_=
PARTNUM_CP2108 0x08=0A>> +#define CP210X_PARTNUM_CP2102N_QFN28 0x20=0A>> =
+#define CP210X_PARTNUM_CP2102N_QFN24 0x21=0A>> +#define CP210X_PARTNUM_C=
P2102N_QFN20 0x22=0A>> #define CP210X_PARTNUM_UNKNOWN 0xFF=0A>> =0A>> /* =
CP210X_GET_COMM_STATUS returns these 0x13 bytes */=0A>> @@ -758,8 +761,12=
 @@ static int cp210x_get_line_ctl(struct usb_serial_port *port, u16 *ctl=
)=0A>> /*=0A>> * cp210x_quantise_baudrate=0A>> * Quantises the baud rate =
as per AN205 Table 1=0A>> + * The CP2102N is fully (except for baud rate =
aliasing) software-=0A>> + * compatible, but supports some additional bau=
drates. However, there is=0A>> + * no quantitisation table available for =
this model, so in this case we=0A>> + * take the supported baudrate which=
 is closest to the requested one.=0A>> */=0A>> -static unsigned int cp210=
x_quantise_baudrate(unsigned int baud)=0A>> +static unsigned int cp210x_q=
uantise_baudrate(unsigned int baud, bool cp2102n)=0A> =0A> Pass in a stru=
ct usb_serial (or port) as a first argument instead which=0A> allows for =
more readable code as well as for this to be reused to handle=0A> other d=
evice type differences (e.g. only 2108 besides 2102n handles=0A> baudrate=
s over 921.6k).=0A> =0A>> {=0A>> if (baud <=3D 300)=0A>> baud =3D 300;=0A=
>> @@ -790,10 +797,17 @@ static unsigned int cp210x_quantise_baudrate(uns=
igned int baud)=0A>> else if (baud <=3D 491520) baud =3D 460800;=0A>> els=
e if (baud <=3D 567138) baud =3D 500000;=0A>> else if (baud <=3D 670254) =
baud =3D 576000;=0A>> - else if (baud < 1000000)=0A>> - baud =3D 921600;=
=0A>> - else if (baud > 2000000)=0A>> - baud =3D 2000000;=0A>> + else if =
(cp2102n) {=0A> =0A> Add a static helper (looks like you add a define in =
the gpio patch)=0A> cp210x_is_cp2102n(serial) here. You can even test for=
 bit 0x20 in the=0A> helper if you prefer (we can always change that late=
r if needed).=0A> =0A>> + if (baud <=3D 960800) baud =3D 921600;=0A>> + e=
lse if (baud <=3D 1100000) baud =3D 1000000;=0A>> + else if (baud <=3D 13=
50000) baud =3D 1200000;=0A>> + else if (baud <=3D 1750000) baud =3D 1500=
000;=0A>> + else if (baud <=3D 2500000) baud =3D 2000000;=0A>> + else bau=
d =3D 3000000;=0A> =0A> And even if the current code uses this odd format=
ting, your amendments=0A> should not.=0A> =0A>> + } else {=0A>> + if (bau=
d < 1000000) baud =3D 921600;=0A>> + else if (baud > 2000000) baud =3D 20=
00000;=0A>> + }=0A>> return baud;=0A>> }=0A>> =0A>> @@ -1045,16 +1059,19 =
@@ static void cp210x_get_termios_port(struct usb_serial_port *port,=0A>>=
 static void cp210x_change_speed(struct tty_struct *tty,=0A>> struct usb_=
serial_port *port, struct ktermios *old_termios)=0A>> {=0A>> - u32 baud;=
=0A>> -=0A>> - baud =3D tty->termios.c_ospeed;=0A>> + bool is_cp2102n;=0A=
>> + u32 baud =3D tty->termios.c_ospeed;=0A>> + struct cp210x_serial_priv=
ate *priv =3D usb_get_serial_data(port->serial);=0A>> =0A>> - /* This map=
s the requested rate to a rate valid on cp2102 or cp2103,=0A>> - * or to =
an arbitrary rate in [1M,2M].=0A>> + /* This maps the requested rate to a=
 rate valid on cp2102(n) or=0A>> + * cp2103 or to an arbitrary rate in [1=
M,2M].=0A>> *=0A>> * NOTE: B0 is not implemented.=0A>> */=0A>> - baud =3D=
 cp210x_quantise_baudrate(baud);=0A>> + is_cp2102n =3D (priv->partnum =3D=
=3D CP210X_PARTNUM_CP2102N_QFN28) ||=0A>> + (priv->partnum =3D=3D CP210X_=
PARTNUM_CP2102N_QFN24) ||=0A>> + (priv->partnum =3D=3D CP210X_PARTNUM_CP2=
102N_QFN20);=0A>> + baud =3D cp210x_quantise_baudrate(baud, is_cp2102n);=
=0A> =0A> So most of these changes would not be needed. Just pass in port=
->serial=0A> to cp210x_quantise_baudrate().=0A> =0A> Thanks,=0A> Johan
