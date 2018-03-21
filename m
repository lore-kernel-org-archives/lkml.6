Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-637178-1521661853-2-18128418988140777964
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521661852; b=IX+DrCuEnV7LGb/rN8+MxnQvMF6L6G+gFemR48yN2GqGHwA
    7x4h1hoVgOyYpTsNJHTgvGVmaosfRskRvH1oiHZuo/34smqzOwouqWVMQO01IXM1
    fcEaLP3Y80NsKG3+4QAmnosMZaCvf7UK1AF0E9WNBNnZODtqP0kpOEOTaJlWqnJ9
    XRoDRXN/UD9cmCwTLwU02zTAzAO2f9DEp1n2a+wCdvU+TitM1Fu7BHeKeyAZs+JG
    f7Sed71v2cofRBIGennvNWISXFn/Yk9g65s4emv2RqP9agOAnjELExXC7migVKcw
    ZwB/6zwic2vaNhLXxdXgZca0jJw66jSBo3IGp/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521661852; bh=W
    CR0s3WByXlFfCboyPWnG3L/zilMB8BarvluKV6OIys=; b=ETHxszy5uGomSN5ml
    6dmS06B6AoiRkPfo1yabTbkj06ofE79mvx+6DvKzRnotq9zpmYvZcqWUC9yZRDLx
    JndbGKQWcxLFtwDKn6XsgENhUueSU784/giGvAxmo8+SrVUibqMXv+d4Q9yC/L7c
    IdO/VI3oTYnXpBzIgcPamDMDdjTdqie2FR+vvMgMUYhjycNKl/5KIyGSWHn+iM6p
    Za5JzNQ/BJhbbgeDmxUOd+BIP8sF48nYeVjtJ/HTgcfV83AVw8b3MG6YSmjIOls5
    WHbA1AnPiVKgfSwgFVDniXTUY7xYsRrG1DW8WY0q5/1qYDyRqwm0cCrF8ZjuTsee
    qU4Xw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=BWwIkpJM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=mpu/91AA;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=BWwIkpJM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=mpu/91AA;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELu6qHHLaLZutxAWzqwvsS1MScEJFqKzUs3NDcQh/LLVKOFQ5Raw7BlmM6iJI7I56h7sV6atGw==
Subject: Re: [PATCH v3] staging: bcm2835-audio: Release resources on
 module_exit()
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <15cc84cc-a887-7473-d64c-00c23e930e0d@gmail.com>
 <20180321184827.1043-1-k.marinushkin@gmail.com>
 <CAHp75VcwFRVX7RTSWv2R_7Hr=gzrwK1aJA8Unypx6zQ49neGjA@mail.gmail.com>
From: Kirill Marinushkin <k.marinushkin@gmail.com>
Message-ID: <3547aeb4-4866-1878-9c5d-ed9e1403cb56@gmail.com>
Date: Wed, 21 Mar 2018 20:51:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcwFRVX7RTSWv2R_7Hr=gzrwK1aJA8Unypx6zQ49neGjA@mail.gmail.com>
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, devel@driverdev.osuosl.org,
 Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>,
 Ray Jui <rjui@broadcom.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Eric Anholt <eric@anholt.net>, Michael Zoran <mzoran@crowfest.net>,
 bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
 linux-rpi-kernel@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/21/18 20:24, Andy Shevchenko wrote:
> On Wed, Mar 21, 2018 at 8:48 PM, Kirill Marinushkin
> <k.marinushkin@gmail.com> wrote:
>> In the current implementation, `rmmod snd_bcm2835` does not release
>> resources properly. It causes an oops when trying to list sound devices.
>>
>> This commit fixes it.
>>
>> The details WRT allocation / free are described below.
>>
>> Device structure WRT allocation:
>>
>> pdev
>>   \childdev[]
>>     \card
>>       \chip
>>         \pcm
>>         \ctl
>>
>> Allocation / register sequence:
>>
>> * childdev: devm_kzalloc      - freed during driver detach
>> * childdev: device_initialize - freed during device_unregister
>> * pdev: devres_alloc          - freed during driver detach
>> * childdev: device_add        - removed during device_unregister
>> * pdev, childdev: devres_add  - freed during driver detach
>> * card: snd_card_new          - freed during snd_card_free
>> * chip: kzalloc               - freed during kfree
>> * card, chip: snd_device_new  - freed during snd_device_free
>> * chip: new_pcm               - TODO: free pcm
>> * chip: new_ctl               - TODO: free ctl
>> * card: snd_card_register     - unregistered during snd_card_free
>>
>> Free / unregister sequence:
>>
>> * card: snd_card_free
>> * card, chip: snd_device_free
>> * childdev: device_unregister
>> * chip: kfree
>>
>> Steps to reproduce the issue before this commit:
>>
>> ~~~~
>> $ rmmod snd_bcm2835
>> $ aplay -L
>> [  138.648130] Unable to handle kernel paging request at virtual address 7f1343c0
>> [  138.660415] pgd = ad8f0000
>> [  138.665567] [7f1343c0] *pgd=3864c811, *pte=00000000, *ppte=00000000
>> [  138.674887] Internal error: Oops: 7 [#1] SMP ARM
>> [  138.683571] Modules linked in: sha256_generic cfg80211 rfkill snd_pcm snd_timer
>>  snd fixed uio_pdrv_genirq uio ip_tables x_tables ipv6 [last unloaded: snd_bcm2835
>> ]
>> [  138.706594] CPU: 3 PID: 463 Comm: aplay Tainted: G        WC       4.15.0-rc1-v
>> 7+ #6
>> [  138.719833] Hardware name: BCM2835
>> [  138.726016] task: b877ac00 task.stack: aebec000
>> [  138.733408] PC is at try_module_get+0x38/0x24c
>> [  138.740813] LR is at snd_ctl_open+0x58/0x194 [snd]
>> [  138.748485] pc : [<801c4d5c>]    lr : [<7f0e6b2c>]    psr: 20000013
>> [  138.757709] sp : aebedd60  ip : aebedd88  fp : aebedd84
>> [  138.765884] r10: 00000000  r9 : 00000004  r8 : 7f0ed440
>> [  138.774040] r7 : b7e469b0  r6 : 7f0e6b2c  r5 : afd91900  r4 : 7f1343c0
>> [  138.783571] r3 : aebec000  r2 : 00000001  r1 : b877ac00  r0 : 7f1343c0
>> [  138.793084] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
>> [  138.803300] Control: 10c5387d  Table: 2d8f006a  DAC: 00000055
>> [  138.812064] Process aplay (pid: 463, stack limit = 0xaebec210)
>> [  138.820868] Stack: (0xaebedd60 to 0xaebee000)
>> [  138.828207] dd60: 00000000 b848d000 afd91900 00000000 b7e469b0 7f0ed440 aebedda4 aebedd88
>> [  138.842371] dd80: 7f0e6b2c 801c4d30 afd91900 7f0ea4dc 00000000 b7e469b0 aebeddcc aebedda8
>> [  138.856611] dda0: 7f0e250c 7f0e6ae0 7f0e2464 b8478ec0 b7e469b0 afd91900 7f0ea388 00000000
>> [  138.870864] ddc0: aebeddf4 aebeddd0 802ce590 7f0e2470 8090ab64 afd91900 afd91900 b7e469b0
>> [  138.885301] dde0: afd91908 802ce4e4 aebede1c aebeddf8 802c57b4 802ce4f0 afd91900 aebedea8
>> [  138.900110] de00: b7fa4c00 00000000 00000000 00000004 aebede3c aebede20 802c6ba8 802c56b4
>> [  138.915260] de20: aebedea8 00000000 aebedf5c 00000000 aebedea4 aebede40 802d9a68 802c6b58
>> [  138.930661] de40: b874ddd0 00000000 00000000 00000001 00000041 00000000 afd91900 aebede70
>> [  138.946402] de60: 00000000 00000000 00000002 b7e469b0 b8a87610 b8d6ab80 801852f8 00080000
>> [  138.962314] de80: aebedf5c aebedea8 00000001 80108464 aebec000 00000000 aebedf4c aebedea8
>> [  138.978414] dea0: 802dacd4 802d970c b8a87610 b8d6ab80 a7982bc6 00000009 af363019 b9231480
>> [  138.994617] dec0: 00000000 b8c038a0 b7e469b0 00000101 00000002 00000238 00000000 00000000
>> [  139.010823] dee0: 00000000 aebedee8 00080000 0000000f aebedf3c aebedf00 802ed7e4 80843f94
>> [  139.027025] df00: 00000003 00080000 b9231490 b9231480 00000000 00080000 af363000 00000000
>> [  139.043229] df20: 00000005 00000002 ffffff9c 00000000 00080000 ffffff9c af363000 00000003
>> [  139.059430] df40: aebedf94 aebedf50 802c6f70 802dac70 aebec000 00000000 00000001 00000000
>> [  139.075629] df60: 00020000 00000004 00000100 00000001 7ebe577c 0002e038 00000000 00000005
>> [  139.091828] df80: 80108464 aebec000 aebedfa4 aebedf98 802c7060 802c6e6c 00000000 aebedfa8
>> [  139.108025] dfa0: 801082c0 802c7040 7ebe577c 0002e038 7ebe577c 00080000 00000b98 e81c8400
>> [  139.124222] dfc0: 7ebe577c 0002e038 00000000 00000005 7ebe57e4 00a20af8 7ebe57f0 76f87394
>> [  139.140419] dfe0: 00000000 7ebe55c4 76ec88e8 76df1d9c 60000010 7ebe577c 00000000 00000000
>> [  139.156715] [<801c4d5c>] (try_module_get) from [<7f0e6b2c>] (snd_ctl_open+0x58/0x194 [snd])
>> [  139.173222] [<7f0e6b2c>] (snd_ctl_open [snd]) from [<7f0e250c>] (snd_open+0xa8/0x14c [snd])
>> [  139.189683] [<7f0e250c>] (snd_open [snd]) from [<802ce590>] (chrdev_open+0xac/0x188)
>> [  139.205465] [<802ce590>] (chrdev_open) from [<802c57b4>] (do_dentry_open+0x10c/0x314)
>> [  139.221347] [<802c57b4>] (do_dentry_open) from [<802c6ba8>] (vfs_open+0x5c/0x88)
>> [  139.236788] [<802c6ba8>] (vfs_open) from [<802d9a68>] (path_openat+0x368/0x944)
>> [  139.248270] [<802d9a68>] (path_openat) from [<802dacd4>] (do_filp_open+0x70/0xc4)
>> [  139.263731] [<802dacd4>] (do_filp_open) from [<802c6f70>] (do_sys_open+0x110/0x1d4)
>> [  139.279378] [<802c6f70>] (do_sys_open) from [<802c7060>] (SyS_open+0x2c/0x30)
>> [  139.290647] [<802c7060>] (SyS_open) from [<801082c0>] (ret_fast_syscall+0x0/0x28)
>> [  139.306021] Code: e3c3303f e5932004 e2822001 e5832004 (e5943000)
>> [  139.316265] ---[ end trace 7f3f7f6193b663ed ]---
>> [  139.324956] note: aplay[463] exited with preempt_count 1
>> ~~~~
>>
> Sorry, just noticed that devm part doesn't make sense after your patch
> and misleading.
> So, after addressing it, FWIW,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

I will check about devm

>
> P.S. I didn't get why do you need an empty ->remove() stub. Doesn't
> work without it?

In the v1 of this patch, it didn't. But now, when the probing is improved since then, I will check this also

>
>> Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
>> Cc: Eric Anholt <eric@anholt.net>
>> Cc: Stefan Wahren <stefan.wahren@i2se.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Florian Fainelli <f.fainelli@gmail.com>
>> Cc: Ray Jui <rjui@broadcom.com>
>> Cc: Scott Branden <sbranden@broadcom.com>
>> Cc: bcm-kernel-feedback-list@broadcom.com
>> Cc: Michael Zoran <mzoran@crowfest.net>
>> Cc: linux-rpi-kernel@lists.infradead.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: devel@driverdev.osuosl.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>  .../staging/vc04_services/bcm2835-audio/bcm2835.c  | 57 ++++++++++++----------
>>  1 file changed, 30 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
>> index 8f2d508183b2..125efc55ecb9 100644
>> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
>> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
>> @@ -36,6 +36,10 @@ MODULE_PARM_DESC(enable_compat_alsa,
>>  static void snd_devm_unregister_child(struct device *dev, void *res)
>>  {
>>         struct device *childdev = *(struct device **)res;
>> +       struct bcm2835_chip *chip = dev_get_drvdata(childdev);
>> +       struct snd_card *card = chip->card;
>> +
>> +       snd_card_free(card);
>>
>>         device_unregister(childdev);
>>  }
>> @@ -61,6 +65,13 @@ static int snd_devm_add_child(struct device *dev, struct device *child)
>>         return 0;
>>  }
>>
>> +static void snd_devm_release(struct device *dev)
>> +{
>> +       struct bcm2835_chip *chip = dev_get_drvdata(dev);
>> +
>> +       kfree(chip);
>> +}
>> +
>>  static struct device *
>>  snd_create_device(struct device *parent,
>>                   struct device_driver *driver,
>> @@ -76,6 +87,7 @@ snd_create_device(struct device *parent,
>>         device_initialize(device);
>>         device->parent = parent;
>>         device->driver = driver;
>> +       device->release = snd_devm_release;
>>
>>         dev_set_name(device, "%s", name);
>>
>> @@ -86,18 +98,19 @@ snd_create_device(struct device *parent,
>>         return device;
>>  }
>>
>> -static int snd_bcm2835_free(struct bcm2835_chip *chip)
>> -{
>> -       kfree(chip);
>> -       return 0;
>> -}
>> -
>>  /* component-destructor
>>   * (see "Management of Cards and Components")
>>   */
>>  static int snd_bcm2835_dev_free(struct snd_device *device)
>>  {
>> -       return snd_bcm2835_free(device->device_data);
>> +       struct bcm2835_chip *chip = device->device_data;
>> +       struct snd_card *card = chip->card;
>> +
>> +       /* TODO: free pcm, ctl */
>> +
>> +       snd_device_free(card, chip);
>> +
>> +       return 0;
>>  }
>>
>>  /* chip-specific constructor
>> @@ -122,7 +135,7 @@ static int snd_bcm2835_create(struct snd_card *card,
>>
>>         err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
>>         if (err) {
>> -               snd_bcm2835_free(chip);
>> +               kfree(chip);
>>                 return err;
>>         }
>>
>> @@ -130,31 +143,14 @@ static int snd_bcm2835_create(struct snd_card *card,
>>         return 0;
>>  }
>>
>> -static void snd_devm_card_free(struct device *dev, void *res)
>> -{
>> -       struct snd_card *snd_card = *(struct snd_card **)res;
>> -
>> -       snd_card_free(snd_card);
>> -}
>> -
>>  static struct snd_card *snd_devm_card_new(struct device *dev)
>>  {
>> -       struct snd_card **dr;
>>         struct snd_card *card;
>>         int ret;
>>
>> -       dr = devres_alloc(snd_devm_card_free, sizeof(*dr), GFP_KERNEL);
>> -       if (!dr)
>> -               return ERR_PTR(-ENOMEM);
>> -
>>         ret = snd_card_new(dev, -1, NULL, THIS_MODULE, 0, &card);
>> -       if (ret) {
>> -               devres_free(dr);
>> +       if (ret)
>>                 return ERR_PTR(ret);
>> -       }
>> -
>> -       *dr = card;
>> -       devres_add(dev, dr);
>>
>>         return card;
>>  }
>> @@ -313,7 +309,7 @@ static int snd_add_child_device(struct device *device,
>>                 return err;
>>         }
>>
>> -       dev_set_drvdata(child, card);
>> +       dev_set_drvdata(child, chip);
>>         dev_info(child, "card created with %d channels\n", numchans);
>>
>>         return 0;
>> @@ -414,6 +410,12 @@ static int snd_bcm2835_alsa_probe_dt(struct platform_device *pdev)
>>         return 0;
>>  }
>>
>> +static int snd_bcm2835_alsa_remove(struct platform_device *pdev)
>> +{
>> +       /* trigger snd_devm_unregister_child() */
>> +       return 0;
>> +}
>> +
>>  #ifdef CONFIG_PM
>>
>>  static int snd_bcm2835_alsa_suspend(struct platform_device *pdev,
>> @@ -437,6 +439,7 @@ MODULE_DEVICE_TABLE(of, snd_bcm2835_of_match_table);
>>
>>  static struct platform_driver bcm2835_alsa0_driver = {
>>         .probe = snd_bcm2835_alsa_probe_dt,
>> +       .remove = snd_bcm2835_alsa_remove,
>>  #ifdef CONFIG_PM
>>         .suspend = snd_bcm2835_alsa_suspend,
>>         .resume = snd_bcm2835_alsa_resume,
>> --
>> 2.13.6
>>
>
>

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
