Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-257181-1520338487-2-12403318576979645487
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520338486; b=bCtsFmShMG8Ez7kceBZasOBZPqkd1ZjquNQa3tn7ey2BcA3
    WfZmVkryTsZUbccbwNpDB3DZ+DWZIc2+8QBAp9VD18PoWa7MXhtkQmGOSv7e9iqn
    hm3oMe2Fk6vWXQ8RZyg5lgQNP9Ak7dzGiQ6V1dz11CosyUiVCzZ6Zkwn/G9KJABB
    S60NRikvsrpFfOyhKPD4Sknoe2FF3cu/o7m/OwPQ4tsSUtivWaqpx47g+PtD8L2m
    ZrL/WPYmsV6CPYtStg5PfqW9RNWJeAsm01yy6dRGPXTK19l+kLNNy7gJZv/RJTOP
    WiK6aNFJG4iVrJlB/ECc0b0ppo0WkZ1kuh4EP8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520338486; bh=l
    u+V0hvmz5feWPwltPi2kXNjpqyxRpIBKtuePBwJN3k=; b=WOdIn6I3FVUlyqaZA
    3kqX29HLBZnrYoBxfAkPLCqYaBeCa7xDLxqXfss6LXwavyCzKWc8QHwRzL6/G7Jh
    CWZFR79NL8YX/CyoT46SXVlCAJV82FgemrkjnfVHPdMDivWeBKmlEFAUCbBLzEgE
    22yUklopTfkenpaAj1fhqrw5/lAcOM2HtiEWei0DRVGGwCEp3nxhm1X/u3XOxjFX
    fvnQMCQS863Id25nFCSC77o6W2yPxbkS5fCcupOOIHGNQT8fm2tZICb7jRsHjic5
    ZhLnlF03dnc+BVWXNURDKFW+Qj3dM9YfJpAMrBCYdnHFdGIVkW5RRN2VIjBebtM/
    uRTfw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 6 Mar 2018 04:14:41 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kirill Marinushkin <k.marinushkin@gmail.com>
Subject: Re: [PATCH] staging: bcm2835-audio: Release resources on module_exit()
Message-ID: <20180306121441.GA7177@kroah.com>
References: <20180305055254.29875-1-k.marinushkin@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180305055254.29875-1-k.marinushkin@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, devel@driverdev.osuosl.org,
 Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org,
 Eric Anholt <eric@anholt.net>, Michael Zoran <mzoran@crowfest.net>,
 bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 05, 2018 at 06:52:54AM +0100, Kirill Marinushkin wrote:
> In the current implementation, `rmmod snd_bcm2835` does not release
> resources properly. It causes an oops when trying to list sound devices.
> 
> This commit fixes it.
> 
> Steps to reproduce:
> 
> ~~~~
> $ rmmod snd_bcm2835
> $ aplay -L
> [  138.648130] Unable to handle kernel paging request at virtual address 7f1343c0
> [  138.660415] pgd = ad8f0000
> [  138.665567] [7f1343c0] *pgd=3864c811, *pte=00000000, *ppte=00000000
> [  138.674887] Internal error: Oops: 7 [#1] SMP ARM
> [  138.683571] Modules linked in: sha256_generic cfg80211 rfkill snd_pcm snd_timer
>  snd fixed uio_pdrv_genirq uio ip_tables x_tables ipv6 [last unloaded: snd_bcm2835
> ]
> [  138.706594] CPU: 3 PID: 463 Comm: aplay Tainted: G        WC       4.15.0-rc1-v
> 7+ #6
> [  138.719833] Hardware name: BCM2835
> [  138.726016] task: b877ac00 task.stack: aebec000
> [  138.733408] PC is at try_module_get+0x38/0x24c
> [  138.740813] LR is at snd_ctl_open+0x58/0x194 [snd]
> [  138.748485] pc : [<801c4d5c>]    lr : [<7f0e6b2c>]    psr: 20000013
> [  138.757709] sp : aebedd60  ip : aebedd88  fp : aebedd84
> [  138.765884] r10: 00000000  r9 : 00000004  r8 : 7f0ed440
> [  138.774040] r7 : b7e469b0  r6 : 7f0e6b2c  r5 : afd91900  r4 : 7f1343c0
> [  138.783571] r3 : aebec000  r2 : 00000001  r1 : b877ac00  r0 : 7f1343c0
> [  138.793084] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> [  138.803300] Control: 10c5387d  Table: 2d8f006a  DAC: 00000055
> [  138.812064] Process aplay (pid: 463, stack limit = 0xaebec210)
> [  138.820868] Stack: (0xaebedd60 to 0xaebee000)
> [  138.828207] dd60: 00000000 b848d000 afd91900 00000000 b7e469b0 7f0ed440 aebedda4 aebedd88
> [  138.842371] dd80: 7f0e6b2c 801c4d30 afd91900 7f0ea4dc 00000000 b7e469b0 aebeddcc aebedda8
> [  138.856611] dda0: 7f0e250c 7f0e6ae0 7f0e2464 b8478ec0 b7e469b0 afd91900 7f0ea388 00000000
> [  138.870864] ddc0: aebeddf4 aebeddd0 802ce590 7f0e2470 8090ab64 afd91900 afd91900 b7e469b0
> [  138.885301] dde0: afd91908 802ce4e4 aebede1c aebeddf8 802c57b4 802ce4f0 afd91900 aebedea8
> [  138.900110] de00: b7fa4c00 00000000 00000000 00000004 aebede3c aebede20 802c6ba8 802c56b4
> [  138.915260] de20: aebedea8 00000000 aebedf5c 00000000 aebedea4 aebede40 802d9a68 802c6b58
> [  138.930661] de40: b874ddd0 00000000 00000000 00000001 00000041 00000000 afd91900 aebede70
> [  138.946402] de60: 00000000 00000000 00000002 b7e469b0 b8a87610 b8d6ab80 801852f8 00080000
> [  138.962314] de80: aebedf5c aebedea8 00000001 80108464 aebec000 00000000 aebedf4c aebedea8
> [  138.978414] dea0: 802dacd4 802d970c b8a87610 b8d6ab80 a7982bc6 00000009 af363019 b9231480
> [  138.994617] dec0: 00000000 b8c038a0 b7e469b0 00000101 00000002 00000238 00000000 00000000
> [  139.010823] dee0: 00000000 aebedee8 00080000 0000000f aebedf3c aebedf00 802ed7e4 80843f94
> [  139.027025] df00: 00000003 00080000 b9231490 b9231480 00000000 00080000 af363000 00000000
> [  139.043229] df20: 00000005 00000002 ffffff9c 00000000 00080000 ffffff9c af363000 00000003
> [  139.059430] df40: aebedf94 aebedf50 802c6f70 802dac70 aebec000 00000000 00000001 00000000
> [  139.075629] df60: 00020000 00000004 00000100 00000001 7ebe577c 0002e038 00000000 00000005
> [  139.091828] df80: 80108464 aebec000 aebedfa4 aebedf98 802c7060 802c6e6c 00000000 aebedfa8
> [  139.108025] dfa0: 801082c0 802c7040 7ebe577c 0002e038 7ebe577c 00080000 00000b98 e81c8400
> [  139.124222] dfc0: 7ebe577c 0002e038 00000000 00000005 7ebe57e4 00a20af8 7ebe57f0 76f87394
> [  139.140419] dfe0: 00000000 7ebe55c4 76ec88e8 76df1d9c 60000010 7ebe577c 00000000 00000000
> [  139.156715] [<801c4d5c>] (try_module_get) from [<7f0e6b2c>] (snd_ctl_open+0x58/0x194 [snd])
> [  139.173222] [<7f0e6b2c>] (snd_ctl_open [snd]) from [<7f0e250c>] (snd_open+0xa8/0x14c [snd])
> [  139.189683] [<7f0e250c>] (snd_open [snd]) from [<802ce590>] (chrdev_open+0xac/0x188)
> [  139.205465] [<802ce590>] (chrdev_open) from [<802c57b4>] (do_dentry_open+0x10c/0x314)
> [  139.221347] [<802c57b4>] (do_dentry_open) from [<802c6ba8>] (vfs_open+0x5c/0x88)
> [  139.236788] [<802c6ba8>] (vfs_open) from [<802d9a68>] (path_openat+0x368/0x944)
> [  139.248270] [<802d9a68>] (path_openat) from [<802dacd4>] (do_filp_open+0x70/0xc4)
> [  139.263731] [<802dacd4>] (do_filp_open) from [<802c6f70>] (do_sys_open+0x110/0x1d4)
> [  139.279378] [<802c6f70>] (do_sys_open) from [<802c7060>] (SyS_open+0x2c/0x30)
> [  139.290647] [<802c7060>] (SyS_open) from [<801082c0>] (ret_fast_syscall+0x0/0x28)
> [  139.306021] Code: e3c3303f e5932004 e2822001 e5832004 (e5943000)
> [  139.316265] ---[ end trace 7f3f7f6193b663ed ]---
> [  139.324956] note: aplay[463] exited with preempt_count 1
> ~~~~
> 
> Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Stefan Wahren <stefan.wahren@i2se.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: Michael Zoran <mzoran@crowfest.net>
> Cc: linux-rpi-kernel@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devel@driverdev.osuosl.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  .../staging/vc04_services/bcm2835-audio/bcm2835.c  | 37 +++++++++++-----------
>  1 file changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
> index 8f2d508183b2..01187df7d85f 100644
> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
> @@ -36,6 +36,11 @@ MODULE_PARM_DESC(enable_compat_alsa,
>  static void snd_devm_unregister_child(struct device *dev, void *res)
>  {
>  	struct device *childdev = *(struct device **)res;
> +	struct snd_card *snd_card =
> +		(struct snd_card *)dev_get_drvdata(childdev);
> +
> +	snd_card_free(snd_card);
> +	dev_set_drvdata(childdev, NULL);
>  
>  	device_unregister(childdev);
>  }
> @@ -61,6 +66,11 @@ static int snd_devm_add_child(struct device *dev, struct device *child)
>  	return 0;
>  }
>  
> +static void snd_devm_release(struct device *dev)
> +{
> +	/* avoid warnings when releasing the resources */
> +}

As per the in-kernel documentation, I get to make fun of you for trying
to "fool" the kernel here :(

Please please please do not do stuff like this.  There is a good reason
the kernel is warning you that you need to do something "real" here.  I
didn't put that logic in the kernel for no good reason, so don't try to
"shut it up" by being sneaky and trying to fool it.

Properly clean up your memory here, that is what is needed.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
