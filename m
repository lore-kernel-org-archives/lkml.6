Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3477952-1524594388-2-3544453963285648126
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524594387; b=p4tlkCDcgVXp7D7x030cTwLKh4RxwsX/3BYdXx7Iew20G+kROI
    4JvNGfDXwvnBUk5ynsqcuZalSKXk8Zjq5mD5pVgYdQAmR5KizAWrzjBSggMR2ofX
    8X4tOQzhDHdZfPv4EvmfSyimsQwJIsRSIyz2HvxA51/8Gsukxkn2nI75unOTEdV8
    l++o07zTrOKW35C/IbIWq3Ha0ATAGyFD5TZPgl42G7OPmpRUWiAsyeuPgIdac8f/
    w6OjQbPB1fbrlLyddlGND+7lFanehzHE06Ht9O2My92ygoO5gGu78EA6j/BZYp+Z
    T2JzbMMuIMuXRL3Nb8yRDfdTEFjfwdMlvDfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524594387; bh=+T9qy
    A89gvcmmrvrh/lmJ1lVe0L7jEkZvBnHAPhRSTo=; b=c8fQhpdmGlDlJ8a0yzNSM
    TzHJo2OFzhDvjFdVbAGsTiqGy0rN5sMCO/1pFvB0qxv6hheA4tVb9Uu5y6rmuYOX
    U0HI8Y4CU8ozx50X96/X/DqQFd83TyVywxY4H4O89vLYeu/gePWYwH9KaLpNHFWT
    3HOvodQaz8jI6fNtRzRZhVTysBRA9mMGw/jhN3wxSBfKX78z8S7mSw7fuwYWNsBP
    5mZ/zaCqivM3QGqXZ7GCjer9w7EmNtf2On43BlNF4rxb1jpke8J9CWu/t4ZFWorN
    y4m8Tqw3vUsO6GDYY9T9k7bHhoVd/mTDsWdpNqcHiBKl25uVQitKP5dJhcNUUisa
    Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Fjb+f7v1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=O6i+4wWZ;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Fjb+f7v1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=O6i+4wWZ;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMVLjlcruR+1ngNbuHlknAbg89qdLoQDyNdTe8eqXmRcxKZRR+oKAtAGXJhd745WrA8VwKznWctVQebes1P/1O3x9ycF7IwMcetSYw0ZbNz/f62F8TW/
    iqWsIhzk77BYrnf5IhLmxRKat25Ri7iU4G9sRW3mEznKHbSF0mFqKYC0ysZPApP+pakblolH5tKVK/u1KKY1l3f7ImELx/TCEWGvRErusz5JpzwUHR50naSA
    +57YJU4p4g41eLBIVD77nA==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=1FiBMPE2lCMA:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=-VAfIpHNAAAA:8 a=5mpuRNi4AAAA:8
    a=ag1SF4gXAAAA:8 a=Q-fNiiVtAAAA:8 a=JfrnYn6hAAAA:8 a=lTbjQzD5AAAA:8
    a=VwQbUJbxAAAA:8 a=DDOyTI_5AAAA:8 a=Oj9ldfZ-xZMSPbt2Qp0A:9 a=CjuIK1q_8ugA:10
    a=cvBusfyB2V15izCimMoJ:22 a=srlwD-8ojaedGGhPAyx8:22 a=eHWn0xJZPbZ7L6UZR85b:22
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=Fp8MccfUoT0GBdDC_Lng:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=w8YF5asEQ23juLwKoPR8:22 a=AjGcO6oz07-iQ99wixmX:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4/on5BjGBtL+tV321IB6ishABvGATGFwe3BJ7yYKcSgdeOhwCplcwGqII1zPUjqYehsPcziDg==
Subject: Re: [RESEND PATCH] staging: bcm2835-audio: Disconnect and free
 vchi_instance on module_exit()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Eric Anholt <eric@anholt.net>,
 Stefan Wahren <stefan.wahren@i2se.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
References: <20180424071618.GB17825@kroah.com>
 <20180424074459.7215-1-k.marinushkin@gmail.com>
From: Kirill Marinushkin <k.marinushkin@gmail.com>
Message-ID: <9e4fc4a0-370b-9101-2809-4040de58553c@gmail.com>
Date: Tue, 24 Apr 2018 20:27:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180424074459.7215-1-k.marinushkin@gmail.com>
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
Cc: devel@driverdev.osuosl.org, bcm-kernel-feedback-list@broadcom.com,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

@Greg

> I have no idea as the patch is long gone from my queue now. If you
> think all is fine, please resend it and I will be glad to review it
> again.

Stefan, Dan and Andy explained me, what caused the compiler warning in my patch,
and why I couldn't reproduce it. I will fix the root cause, and send the patch v2.


@Stefan

> this is an old toolchain. You can download newer ones here (even for i686):
>
https://releases.linaro.org/components/toolchain/binaries/7.2-2017.11/arm-linux-gnueabihf/


Thank you for the hint. Looks like I will be able to catch this compiler warning
with the newer toolchain.


@Dan

> kbuild is complaining that "err" is uninitialized here but for some
> reason the line numbers are off. It's a real bug.

Thank you for the review. Yes, indeed, this is not correct. I will fix it.


@Andy

> AFAIR I gave you a tag and you again missed it.
> Before sending anything just check twice if all prerequisites are fulfilled.

I think you mix it up. This is a new patch, you didn't review it before.


> And yes, kbuild bot is right. You need to return known value.

Yes, that's right. I will fix it.


Best Regards,
Kirill


On 04/24/18 09:44, Kirill Marinushkin wrote:
> In the current implementation, vchi_instance is inited during the first
> call of bcm2835_audio_open_connection(), and is never freed. It causes a
> memory leak when the module `snd_bcm2835` is removed.
>
> Here is how this commit fixes it:
>
> * the VCHI context (including vchi_instance) is created once in the
>   platform's devres
> * the VCHI context is allocated and connected once during module_init()
> * all created bcm2835_chips have a pointer to this VCHI context
> * bcm2835_audio_open_connection() can access the VCHI context through the
>   associated bcm2835_chip
> * the VCHI context is disconnected and freed once during module_exit()
>
> After this commit is applied, I don't see other issues with the module's
> init/exit, so I also remove the associated TODO task.
>
> Steps to reproduce the memory leak before this commit:
>
> ~~~~
> root@raspberrypi:/home/pi# aplay test0.wav
> Playing WAVE 'test0.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Ster
> ^CAborted by signal Interrupt...
> root@raspberrypi:/home/pi# rmmod snd_bcm2835
> root@raspberrypi:/home/pi# modprobe snd_bcm2835
> root@raspberrypi:/home/pi# aplay test0.wav
> Playing WAVE 'test0.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Ster
> ^CAborted by signal Interrupt...
> root@raspberrypi:/home/pi# echo scan > /sys/kernel/debug/kmemleak
> root@raspberrypi:/home/pi# cat /sys/kernel/debug/kmemleak
> unreferenced object 0xb6794c00 (size 128):
>   comm "aplay", pid 406, jiffies 36870 (age 116.650s)
>   hex dump (first 32 bytes):
>     08 a5 82 81 01 00 00 00 08 4c 79 b6 08 4c 79 b6  .........Ly..Ly.
>     00 00 00 00 00 00 00 00 ad 4e ad de ff ff ff ff  .........N......
>   backtrace:
>     [<802af5e0>] kmem_cache_alloc_trace+0x294/0x3d0
>     [<806ce620>] vchiq_initialise+0x98/0x1b0
>     [<806d0b34>] vchi_initialise+0x24/0x34
>     [<7f1311ec>] 0x7f1311ec
>     [<7f1303bc>] 0x7f1303bc
>     [<7f130590>] 0x7f130590
>     [<7f111fd8>] snd_pcm_open_substream+0x68/0xc4 [snd_pcm]
>     [<7f112108>] snd_pcm_open+0xd4/0x248 [snd_pcm]
>     [<7f112334>] snd_pcm_playback_open+0x4c/0x6c [snd_pcm]
>     [<7f0e250c>] snd_open+0xa8/0x14c [snd]
>     [<802ce590>] chrdev_open+0xac/0x188
>     [<802c57b4>] do_dentry_open+0x10c/0x314
>     [<802c6ba8>] vfs_open+0x5c/0x88
>     [<802d9a68>] path_openat+0x368/0x944
>     [<802dacd4>] do_filp_open+0x70/0xc4
>     [<802c6f70>] do_sys_open+0x110/0x1d4
> ~~~~
>
> Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Stefan Wahren <stefan.wahren@i2se.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: linux-rpi-kernel@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devel@driverdev.osuosl.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  .../vc04_services/bcm2835-audio/bcm2835-vchiq.c    | 64 +++++++++++++---------
>  .../staging/vc04_services/bcm2835-audio/bcm2835.c  | 43 ++++++++++++++-
>  .../staging/vc04_services/bcm2835-audio/bcm2835.h  | 12 ++++
>  3 files changed, 91 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
> index 3c6f1d91d22d..389a18f9350a 100644
> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
> @@ -33,7 +33,6 @@
>  
>  /* ---- Include Files -------------------------------------------------------- */
>  
> -#include "interface/vchi/vchi.h"
>  #include "vc_vchi_audioserv_defs.h"
>  
>  /* ---- Private Constants and Types ------------------------------------------ */
> @@ -371,14 +370,46 @@ static int vc_vchi_audio_deinit(struct bcm2835_audio_instance *instance)
>  	return 0;
>  }
>  
> +int bcm2835_new_vchi_ctx(struct bcm2835_vchi_ctx *vchi_ctx)
> +{
> +	int ret;
> +
> +	/* Initialize and create a VCHI connection */
> +	ret = vchi_initialise(&vchi_ctx->vchi_instance);
> +	if (ret) {
> +		LOG_ERR("%s: failed to initialise VCHI instance (ret=%d)\n",
> +			__func__, ret);
> +
> +		return -EIO;
> +	}
> +
> +	ret = vchi_connect(NULL, 0, vchi_ctx->vchi_instance);
> +	if (ret) {
> +		LOG_ERR("%s: failed to connect VCHI instance (ret=%d)\n",
> +			__func__, ret);
> +
> +		kfree(vchi_ctx->vchi_instance);
> +		vchi_ctx->vchi_instance = NULL;
> +
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +void bcm2835_free_vchi_ctx(struct bcm2835_vchi_ctx *vchi_ctx)
> +{
> +	/* Close the VCHI connection - it will also free vchi_instance */
> +	WARN_ON(vchi_disconnect(vchi_ctx->vchi_instance));
> +
> +	vchi_ctx->vchi_instance = NULL;
> +}
> +
>  static int bcm2835_audio_open_connection(struct bcm2835_alsa_stream *alsa_stream)
>  {
> -	static VCHI_INSTANCE_T vchi_instance;
> -	static VCHI_CONNECTION_T *vchi_connection;
> -	static int initted;
>  	struct bcm2835_audio_instance *instance =
>  		(struct bcm2835_audio_instance *)alsa_stream->instance;
> -	int ret;
> +	struct bcm2835_vchi_ctx *vhci_ctx = alsa_stream->chip->vchi_ctx;
>  
>  	LOG_INFO("%s: start\n", __func__);
>  	BUG_ON(instance);
> @@ -390,28 +421,9 @@ static int bcm2835_audio_open_connection(struct bcm2835_alsa_stream *alsa_stream
>  		return 0;
>  	}
>  
> -	/* Initialize and create a VCHI connection */
> -	if (!initted) {
> -		ret = vchi_initialise(&vchi_instance);
> -		if (ret) {
> -			LOG_ERR("%s: failed to initialise VCHI instance (ret=%d)\n",
> -				__func__, ret);
> -
> -			return -EIO;
> -		}
> -		ret = vchi_connect(NULL, 0, vchi_instance);
> -		if (ret) {
> -			LOG_ERR("%s: failed to connect VCHI instance (ret=%d)\n",
> -				__func__, ret);
> -
> -			kfree(vchi_instance);
> -			return -EIO;
> -		}
> -		initted = 1;
> -	}
> -
>  	/* Initialize an instance of the audio service */
> -	instance = vc_vchi_audio_init(vchi_instance, &vchi_connection, 1);
> +	instance = vc_vchi_audio_init(vhci_ctx->vchi_instance,
> +				      &vhci_ctx->vchi_connection, 1);
>  
>  	if (IS_ERR(instance)) {
>  		LOG_ERR("%s: failed to initialize audio service\n", __func__);
> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
> index 9030d71a3d0b..009c972d93d6 100644
> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
> @@ -65,6 +65,36 @@ static int snd_devm_add_child(struct device *dev, struct device *child)
>  	return 0;
>  }
>  
> +static void bcm2835_devm_free_vchi_ctx(struct device *dev, void *res)
> +{
> +	struct bcm2835_vchi_ctx *vchi_ctx = res;
> +
> +	bcm2835_free_vchi_ctx(vchi_ctx);
> +}
> +
> +static int bcm2835_devm_add_vchi_ctx(struct device *dev)
> +{
> +	struct bcm2835_vchi_ctx *vchi_ctx;
> +	int ret;
> +
> +	vchi_ctx = devres_alloc(bcm2835_devm_free_vchi_ctx, sizeof(*vchi_ctx),
> +				GFP_KERNEL);
> +	if (!vchi_ctx)
> +		return -ENOMEM;
> +
> +	memset(vchi_ctx, 0, sizeof(*vchi_ctx));
> +
> +	ret = bcm2835_new_vchi_ctx(vchi_ctx);
> +	if (ret) {
> +		devres_free(vchi_ctx);
> +		return ret;
> +	}
> +
> +	devres_add(dev, vchi_ctx);
> +
> +	return 0;
> +}
> +
>  static void snd_bcm2835_release(struct device *dev)
>  {
>  	struct bcm2835_chip *chip = dev_get_drvdata(dev);
> @@ -106,8 +136,6 @@ static int snd_bcm2835_dev_free(struct snd_device *device)
>  	struct bcm2835_chip *chip = device->device_data;
>  	struct snd_card *card = chip->card;
>  
> -	/* TODO: free pcm, ctl */
> -
>  	snd_device_free(card, chip);
>  
>  	return 0;
> @@ -133,6 +161,13 @@ static int snd_bcm2835_create(struct snd_card *card,
>  
>  	chip->card = card;
>  
> +	chip->vchi_ctx = devres_find(card->dev->parent,
> +				     bcm2835_devm_free_vchi_ctx, NULL, NULL);
> +	if (!chip->vchi_ctx) {
> +		kfree(chip);
> +		return err;
> +	}
> +
>  	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
>  	if (err) {
>  		kfree(chip);
> @@ -403,6 +438,10 @@ static int snd_bcm2835_alsa_probe_dt(struct platform_device *pdev)
>  			 numchans);
>  	}
>  
> +	err = bcm2835_devm_add_vchi_ctx(dev);
> +	if (err)
> +		return err;
> +
>  	err = snd_add_child_devices(dev, numchans);
>  	if (err)
>  		return err;
> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
> index f1e43e45fd67..1c82c2ee47dc 100644
> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
> @@ -26,6 +26,8 @@
>  #include <sound/pcm-indirect.h>
>  #include <linux/workqueue.h>
>  
> +#include "interface/vchi/vchi.h"
> +
>  /*
>   * #define AUDIO_DEBUG_ENABLE
>   * #define AUDIO_VERBOSE_DEBUG_ENABLE
> @@ -97,6 +99,11 @@ enum snd_bcm2835_ctrl {
>  	PCM_PLAYBACK_DEVICE,
>  };
>  
> +struct bcm2835_vchi_ctx {
> +	VCHI_INSTANCE_T vchi_instance;
> +	VCHI_CONNECTION_T *vchi_connection;
> +};
> +
>  /* definition of the chip-specific record */
>  struct bcm2835_chip {
>  	struct snd_card *card;
> @@ -115,6 +122,8 @@ struct bcm2835_chip {
>  	unsigned int opened;
>  	unsigned int spdif_status;
>  	struct mutex audio_mutex;
> +
> +	struct bcm2835_vchi_ctx *vchi_ctx;
>  };
>  
>  struct bcm2835_alsa_stream {
> @@ -153,6 +162,9 @@ int snd_bcm2835_new_simple_pcm(struct bcm2835_chip *chip,
>  int snd_bcm2835_new_hdmi_ctl(struct bcm2835_chip *chip);
>  int snd_bcm2835_new_headphones_ctl(struct bcm2835_chip *chip);
>  
> +int bcm2835_new_vchi_ctx(struct bcm2835_vchi_ctx *vchi_ctx);
> +void bcm2835_free_vchi_ctx(struct bcm2835_vchi_ctx *vchi_ctx);
> +
>  int bcm2835_audio_open(struct bcm2835_alsa_stream *alsa_stream);
>  int bcm2835_audio_close(struct bcm2835_alsa_stream *alsa_stream);
>  int bcm2835_audio_set_params(struct bcm2835_alsa_stream *alsa_stream,

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
