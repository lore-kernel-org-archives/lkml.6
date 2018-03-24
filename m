Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3936627-1521898433-2-2005945557984223400
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521898433; b=UorOnxSnwEh8YYzdKktwD7pgCoQN9HajLdXdPt4Gj+Uwbqn
    qEgWpUkcIwbtVAh8AfVkIjnQ8dRaCLG3H9wy5gxI28pIFrspABlG2VivbBiKP8Gy
    iRPoL8PWLe4Gg++eF7/Sr1Q3CoLR965XtBX1dYZ6EiJDiJmR4w3tm2grvi3t/e+U
    jyWLNZxTGLJ3yJvWczmMQne1Rnu67qJ5hm0Zy+9oZ3RQ1KvUHRQtrzG2CL2d1bOT
    8obvWLOoY9/hQDkr8QgfRHj2hdlNvdRF+fTvciR1VutDXwGJeuOpQ5M5CTfZuMfC
    OZMTZrr/pWBL9jg+rC+0NVs4NR5NEIgeCysrWsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521898433; bh=g
    rSwIAUmhqRhp/KO285n+azXRlhqYLC6g3Yb1NdKZcw=; b=AaLUTLR6awrBqyPk7
    89Mj9npnI2HMGT72kbGfziXGuGLNLWXw0WNE8AaadTl0/lR/HHdKosYBXxSdaIWA
    HzHfQLgzISB1A5dUXkBfynLc2MK1NH89KvTEy9JkHGJ1SiidApZjD5vBDkLyn26I
    G5HcDW43/MJI1hVMgpXMfa2KvYcDYfSuRbsZ7SUaaSKt0awnlqawnMXOIvOy9puM
    S1ZLFUvstMYX5Yz/uCxK0R1IyBTEydiFpCinKmXOLAG9mFjPdcQhDgfH8R5o30eZ
    /3VBiR7j/trmtKqP6eVK+ViOUkmnHElPvhJvbrwyLpKEFBCLDS64sMJxIf3PVYFL
    BXKMA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 336892178B
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 24 Mar 2018 13:33:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH 02/11] staging: iio: tsl2x7x: correct interrupt handler
 trigger
Message-ID: <20180324133340.1b5f32e4@archlinux>
In-Reply-To: <20180321102912.5130-3-masneyb@onstation.org>
References: <20180321102912.5130-1-masneyb@onstation.org>
 <20180321102912.5130-3-masneyb@onstation.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
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
Cc: devel@driverdev.osuosl.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, Jon.Brenner@ams.com,
 pmeerw@pmeerw.net, knaack.h@gmx.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 21 Mar 2018 06:29:03 -0400
Brian Masney <masneyb@onstation.org> wrote:

> tsl2x7x_event_handler() was not called as expected when the device was
> asserting a hardware interrupt. This patch changes the interrupt line
> trigger from rising to falling.
I guess the original test board used for driver development must have
inverted this for some reason and hence was miss configured.

Anyhow, good catch.
Applied to the togreg branch of iio.git.

Thanks,

Jonathan

> 
> The driver was tested on a TSL2772 hooked up to a Raspberry Pi 2. The
> interrupt pin also had a 10K pull-up resistor per the requirements from
> the datasheet. The relevant device tree binding:
> 
> &i2c1 {
> 	tsl2772@39 {
> 		compatible = "amstaos,tsl2772";
> 		reg = <0x39>;
> 		interrupt-parent = <&gpio>;
> 		interrupts = <22 0x2>;
> 	};
> };
> 
> With this patch, iio_event_monitor now shows the events when the
> channels are outside the defined interrupt thresholds.
> 
> $ sudo ./iio_event_monitor tsl2772
> Found IIO device with name tsl2772 with device number 0
> Event: time: 1478193460053760446, type: proximity, channel: 0, evtype:
> thresh, direction: either
> ...
> Event: time: 1478193463020270185, type: illuminance, channel: 0, evtype:
> thresh, direction: either
> ...
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  drivers/staging/iio/light/tsl2x7x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 82cf9d853b18..59921850a226 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -1763,7 +1763,7 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
>  		ret = devm_request_threaded_irq(&clientp->dev, clientp->irq,
>  						NULL,
>  						&tsl2x7x_event_handler,
> -						IRQF_TRIGGER_RISING |
> +						IRQF_TRIGGER_FALLING |
>  						IRQF_ONESHOT,
>  						"TSL2X7X_event",
>  						indio_dev);

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
