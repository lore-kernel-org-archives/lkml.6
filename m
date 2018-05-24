Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1733193-1527156186-2-13879757580378086944
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527156185; b=h9tzVB4MH+Fymc0JBaBzwlgfXYL0ckRtDMZmLuK0uOG/Ebp3u/
    i/iCSOGBnQsgR6sOyr6RRih5iFexI1rcgUk1aaOVF8ouWbZ30VT4NpZe/WPw5sQ5
    /PMjSWJQ41Uf41RVGGlioCscrpabcvsrFGTl0ZU8q0Si5pb+E6rkNCF96sp95yoO
    Tj+83ZEiY1vBvU2DoFybEWonRQBu1Dxji/7sDkSe5OPAN+8f+r/8bF8WZFOjxbg6
    8mXJR+FF9MIN4VZvJGo9EDtcYKxNpB/ZaFHnbGeeF5mvEt+1NpDUMa+7CPK4J4i6
    zxKN7gLi0H6FDCVkwBbj705yyYB79Ocr+dkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1527156185; bh=Fafm3
    rzpw/rtrBv/2Zy7IO+E+HQWMK1v7hK/wwjvwtA=; b=MKJD2LhzVBx7NSM6zubI5
    fQsmDlzewgjtnzFaBAIk3dILK6/qLhRQ89uLneUVB/a650o8zOILTlcl/9wKPzX9
    3vXfxBEGQcZYoaOaWZr0N1Fgl4sjwWk9g4zd9RgLOslSGUPdQOJMPcSi8rPCBE1B
    r/2rm1SIxs8bZ5U0IoO8nzE4Fc3Y5rrNCy3r2mswq3EylSy0m6THPdZNPCbDhknA
    FCgB+TK6Mo4p0Pqe7VcDwFqBhT2RIgkCnv9ME7yZogceGJpAS0M5NG4RX4Qe3/UI
    bonc+/Nqm5HPyAIS2IernrNAC57t7bU6R/7doA0GpkrXuaEGnEVh67Eg5Zyf0uov
    Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=R0PrAPNJ x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=linuxfoundation.org
    header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=R0PrAPNJ x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=linuxfoundation.org
      header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAsZ+bZEzwYW2M+zQVZIXZR6OyT2yCtbuwNWTz/NKWEjZBFNwdzh3qdOWGHy/5TeLTUJ1qwg+uWhqgWJD0897rREsFeTvS255xfF3+NDlbESxJEX0xbh
    Ke1QDTv4YF+PjPrYih2d4GPMtoilX8ZhtBOEqoqQ0WtMPcoP60La1nX4nj6LsHQ8wClTlJBF7f3trWX1ODn+/drSMnnwrcnvjCzDGZlTsSC9/vk1jIQNsc1w
    CFs8WokOezEjjKyKZruf/g==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=-VAfIpHNAAAA:8
    a=5mpuRNi4AAAA:8 a=ag1SF4gXAAAA:8 a=Q-fNiiVtAAAA:8 a=UEFuTGg-AAAA:8
    a=JfrnYn6hAAAA:8 a=lTbjQzD5AAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=DDOyTI_5AAAA:8 a=pHgQ_2nTsn63BQ3JXkIA:9 a=CjuIK1q_8ugA:10
    a=srlwD-8ojaedGGhPAyx8:22 a=eHWn0xJZPbZ7L6UZR85b:22 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=Fp8MccfUoT0GBdDC_Lng:22 a=mz-9cL3ZSiV3bxg4Spyn:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=w8YF5asEQ23juLwKoPR8:22 a=AjGcO6oz07-iQ99wixmX:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4.16 090/161] staging: bcm2835-audio: Release resources on
 module_exit()
Date: Thu, 24 May 2018 11:38:35 +0200
Message-Id: <20180524093029.222420874@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, devel@driverdev.osuosl.org,
 Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, stable@vger.kernel.org,
 Sasha Levin <alexander.levin@microsoft.com>, Eric Anholt <eric@anholt.net>,
 Michael Zoran <mzoran@crowfest.net>, bcm-kernel-feedback-list@broadcom.com,
 linux-rpi-kernel@lists.infradead.org, Ray Jui <rjui@broadcom.com>,
 Kirill Marinushkin <k.marinushkin@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kirill Marinushkin <k.marinushkin@gmail.com>

[ Upstream commit 626118b472d2eb45f83a0276a18d3e6a01c69f6a ]

In the current implementation, `rmmod snd_bcm2835` does not release
resources properly. It causes an oops when trying to list sound devices.

This commit fixes it.

The details WRT allocation / free are described below.

Device structure WRT allocation:

pdev
  \childdev[]
    \card
      \chip
        \pcm
        \ctl

Allocation / register sequence:

* childdev: devm_kzalloc      - freed during driver detach
* childdev: device_initialize - freed during device_unregister
* pdev: devres_alloc          - freed during driver detach
* childdev: device_add        - removed during device_unregister
* pdev, childdev: devres_add  - freed during driver detach
* card: snd_card_new          - freed during snd_card_free
* chip: kzalloc               - freed during kfree
* card, chip: snd_device_new  - freed during snd_device_free
* chip: new_pcm               - TODO: free pcm
* chip: new_ctl               - TODO: free ctl
* card: snd_card_register     - unregistered during snd_card_free

Free / unregister sequence:

* card: snd_card_free
* card, chip: snd_device_free
* childdev: device_unregister
* chip: kfree

Steps to reproduce the issue before this commit:

~~~~
$ rmmod snd_bcm2835
$ aplay -L
[  138.648130] Unable to handle kernel paging request at virtual address 7f1343c0
[  138.660415] pgd = ad8f0000
[  138.665567] [7f1343c0] *pgd=3864c811, *pte=00000000, *ppte=00000000
[  138.674887] Internal error: Oops: 7 [#1] SMP ARM
[  138.683571] Modules linked in: sha256_generic cfg80211 rfkill snd_pcm snd_timer
 snd fixed uio_pdrv_genirq uio ip_tables x_tables ipv6 [last unloaded: snd_bcm2835
]
[  138.706594] CPU: 3 PID: 463 Comm: aplay Tainted: G        WC       4.15.0-rc1-v
7+ #6
[  138.719833] Hardware name: BCM2835
[  138.726016] task: b877ac00 task.stack: aebec000
[  138.733408] PC is at try_module_get+0x38/0x24c
[  138.740813] LR is at snd_ctl_open+0x58/0x194 [snd]
[  138.748485] pc : [<801c4d5c>]    lr : [<7f0e6b2c>]    psr: 20000013
[  138.757709] sp : aebedd60  ip : aebedd88  fp : aebedd84
[  138.765884] r10: 00000000  r9 : 00000004  r8 : 7f0ed440
[  138.774040] r7 : b7e469b0  r6 : 7f0e6b2c  r5 : afd91900  r4 : 7f1343c0
[  138.783571] r3 : aebec000  r2 : 00000001  r1 : b877ac00  r0 : 7f1343c0
[  138.793084] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[  138.803300] Control: 10c5387d  Table: 2d8f006a  DAC: 00000055
[  138.812064] Process aplay (pid: 463, stack limit = 0xaebec210)
[  138.820868] Stack: (0xaebedd60 to 0xaebee000)
[  138.828207] dd60: 00000000 b848d000 afd91900 00000000 b7e469b0 7f0ed440 aebedda4 aebedd88
[  138.842371] dd80: 7f0e6b2c 801c4d30 afd91900 7f0ea4dc 00000000 b7e469b0 aebeddcc aebedda8
[  138.856611] dda0: 7f0e250c 7f0e6ae0 7f0e2464 b8478ec0 b7e469b0 afd91900 7f0ea388 00000000
[  138.870864] ddc0: aebeddf4 aebeddd0 802ce590 7f0e2470 8090ab64 afd91900 afd91900 b7e469b0
[  138.885301] dde0: afd91908 802ce4e4 aebede1c aebeddf8 802c57b4 802ce4f0 afd91900 aebedea8
[  138.900110] de00: b7fa4c00 00000000 00000000 00000004 aebede3c aebede20 802c6ba8 802c56b4
[  138.915260] de20: aebedea8 00000000 aebedf5c 00000000 aebedea4 aebede40 802d9a68 802c6b58
[  138.930661] de40: b874ddd0 00000000 00000000 00000001 00000041 00000000 afd91900 aebede70
[  138.946402] de60: 00000000 00000000 00000002 b7e469b0 b8a87610 b8d6ab80 801852f8 00080000
[  138.962314] de80: aebedf5c aebedea8 00000001 80108464 aebec000 00000000 aebedf4c aebedea8
[  138.978414] dea0: 802dacd4 802d970c b8a87610 b8d6ab80 a7982bc6 00000009 af363019 b9231480
[  138.994617] dec0: 00000000 b8c038a0 b7e469b0 00000101 00000002 00000238 00000000 00000000
[  139.010823] dee0: 00000000 aebedee8 00080000 0000000f aebedf3c aebedf00 802ed7e4 80843f94
[  139.027025] df00: 00000003 00080000 b9231490 b9231480 00000000 00080000 af363000 00000000
[  139.043229] df20: 00000005 00000002 ffffff9c 00000000 00080000 ffffff9c af363000 00000003
[  139.059430] df40: aebedf94 aebedf50 802c6f70 802dac70 aebec000 00000000 00000001 00000000
[  139.075629] df60: 00020000 00000004 00000100 00000001 7ebe577c 0002e038 00000000 00000005
[  139.091828] df80: 80108464 aebec000 aebedfa4 aebedf98 802c7060 802c6e6c 00000000 aebedfa8
[  139.108025] dfa0: 801082c0 802c7040 7ebe577c 0002e038 7ebe577c 00080000 00000b98 e81c8400
[  139.124222] dfc0: 7ebe577c 0002e038 00000000 00000005 7ebe57e4 00a20af8 7ebe57f0 76f87394
[  139.140419] dfe0: 00000000 7ebe55c4 76ec88e8 76df1d9c 60000010 7ebe577c 00000000 00000000
[  139.156715] [<801c4d5c>] (try_module_get) from [<7f0e6b2c>] (snd_ctl_open+0x58/0x194 [snd])
[  139.173222] [<7f0e6b2c>] (snd_ctl_open [snd]) from [<7f0e250c>] (snd_open+0xa8/0x14c [snd])
[  139.189683] [<7f0e250c>] (snd_open [snd]) from [<802ce590>] (chrdev_open+0xac/0x188)
[  139.205465] [<802ce590>] (chrdev_open) from [<802c57b4>] (do_dentry_open+0x10c/0x314)
[  139.221347] [<802c57b4>] (do_dentry_open) from [<802c6ba8>] (vfs_open+0x5c/0x88)
[  139.236788] [<802c6ba8>] (vfs_open) from [<802d9a68>] (path_openat+0x368/0x944)
[  139.248270] [<802d9a68>] (path_openat) from [<802dacd4>] (do_filp_open+0x70/0xc4)
[  139.263731] [<802dacd4>] (do_filp_open) from [<802c6f70>] (do_sys_open+0x110/0x1d4)
[  139.279378] [<802c6f70>] (do_sys_open) from [<802c7060>] (SyS_open+0x2c/0x30)
[  139.290647] [<802c7060>] (SyS_open) from [<801082c0>] (ret_fast_syscall+0x0/0x28)
[  139.306021] Code: e3c3303f e5932004 e2822001 e5832004 (e5943000)
[  139.316265] ---[ end trace 7f3f7f6193b663ed ]---
[  139.324956] note: aplay[463] exited with preempt_count 1
~~~~

Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Eric Anholt <eric@anholt.net>
Cc: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: Michael Zoran <mzoran@crowfest.net>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-rpi-kernel@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: devel@driverdev.osuosl.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/vc04_services/bcm2835-audio/bcm2835.c |   54 ++++++++----------
 1 file changed, 25 insertions(+), 29 deletions(-)

--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
@@ -25,6 +25,10 @@ MODULE_PARM_DESC(enable_compat_alsa,
 static void snd_devm_unregister_child(struct device *dev, void *res)
 {
 	struct device *childdev = *(struct device **)res;
+	struct bcm2835_chip *chip = dev_get_drvdata(childdev);
+	struct snd_card *card = chip->card;
+
+	snd_card_free(card);
 
 	device_unregister(childdev);
 }
@@ -50,6 +54,13 @@ static int snd_devm_add_child(struct dev
 	return 0;
 }
 
+static void snd_bcm2835_release(struct device *dev)
+{
+	struct bcm2835_chip *chip = dev_get_drvdata(dev);
+
+	kfree(chip);
+}
+
 static struct device *
 snd_create_device(struct device *parent,
 		  struct device_driver *driver,
@@ -65,6 +76,7 @@ snd_create_device(struct device *parent,
 	device_initialize(device);
 	device->parent = parent;
 	device->driver = driver;
+	device->release = snd_bcm2835_release;
 
 	dev_set_name(device, "%s", name);
 
@@ -75,18 +87,19 @@ snd_create_device(struct device *parent,
 	return device;
 }
 
-static int snd_bcm2835_free(struct bcm2835_chip *chip)
-{
-	kfree(chip);
-	return 0;
-}
-
 /* component-destructor
  * (see "Management of Cards and Components")
  */
 static int snd_bcm2835_dev_free(struct snd_device *device)
 {
-	return snd_bcm2835_free(device->device_data);
+	struct bcm2835_chip *chip = device->device_data;
+	struct snd_card *card = chip->card;
+
+	/* TODO: free pcm, ctl */
+
+	snd_device_free(card, chip);
+
+	return 0;
 }
 
 /* chip-specific constructor
@@ -111,7 +124,7 @@ static int snd_bcm2835_create(struct snd
 
 	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
 	if (err) {
-		snd_bcm2835_free(chip);
+		kfree(chip);
 		return err;
 	}
 
@@ -119,31 +132,14 @@ static int snd_bcm2835_create(struct snd
 	return 0;
 }
 
-static void snd_devm_card_free(struct device *dev, void *res)
+static struct snd_card *snd_bcm2835_card_new(struct device *dev)
 {
-	struct snd_card *snd_card = *(struct snd_card **)res;
-
-	snd_card_free(snd_card);
-}
-
-static struct snd_card *snd_devm_card_new(struct device *dev)
-{
-	struct snd_card **dr;
 	struct snd_card *card;
 	int ret;
 
-	dr = devres_alloc(snd_devm_card_free, sizeof(*dr), GFP_KERNEL);
-	if (!dr)
-		return ERR_PTR(-ENOMEM);
-
 	ret = snd_card_new(dev, -1, NULL, THIS_MODULE, 0, &card);
-	if (ret) {
-		devres_free(dr);
+	if (ret)
 		return ERR_PTR(ret);
-	}
-
-	*dr = card;
-	devres_add(dev, dr);
 
 	return card;
 }
@@ -260,7 +256,7 @@ static int snd_add_child_device(struct d
 		return PTR_ERR(child);
 	}
 
-	card = snd_devm_card_new(child);
+	card = snd_bcm2835_card_new(child);
 	if (IS_ERR(card)) {
 		dev_err(child, "Failed to create card");
 		return PTR_ERR(card);
@@ -302,7 +298,7 @@ static int snd_add_child_device(struct d
 		return err;
 	}
 
-	dev_set_drvdata(child, card);
+	dev_set_drvdata(child, chip);
 	dev_info(child, "card created with %d channels\n", numchans);
 
 	return 0;


_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
