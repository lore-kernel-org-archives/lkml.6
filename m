Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752939AbeDQCOd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 22:14:33 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:42906 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbeDQCOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 22:14:31 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID w3H2EIBm032193, This message is accepted by code: ctloc85258
From: =?big5?B?U2h1bWluZyBbrVOu0bvKXQ==?= <shumingf@realtek.com>
To: "'Stephen Rothwell'" <sfr@canb.auug.org.au>,
        "'Mark Brown'" <broonie@kernel.org>,
        "'Liam Girdwood'" <lgirdwood@gmail.com>
CC: "'Linux-Next Mailing List'" <linux-next@vger.kernel.org>,
        "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
        Bard Liao <bardliao@realtek.com>
Subject: RE: linux-next: build failure after merge of the sound-asoc tree
Thread-Topic: linux-next: build failure after merge of the sound-asoc tree
Thread-Index: AQHT1ef6ysKNXptkuUapHHAwwgF8/aQEKF6ggAAN9XA=
Date: Tue, 17 Apr 2018 02:14:12 +0000
Message-ID: <10317AB43303BA4884D7AF9C2EBCFF40020DBC26@RTITMBSV02.realtek.com.tw>
References: <20180417110232.19225908@canb.auug.org.au>
 <10317AB43303BA4884D7AF9C2EBCFF40020DBB1B@RTITMBSV02.realtek.com.tw>
In-Reply-To: <10317AB43303BA4884D7AF9C2EBCFF40020DBB1B@RTITMBSV02.realtek.com.tw>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.102.105]
Content-Type: text/plain; charset="big5"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3H2EfPR032691

Hi all,

I already sent the patch. 
http://mailman.alsa-project.org/pipermail/alsa-devel/2018-April/134522.html

I apologize for the inconvenience.

Thanks!

Regards,
Shuming Fan


-----Original Message-----
From: Shuming [­S®Ñ»Ê] 
Sent: Tuesday, April 17, 2018 9:23 AM
To: 'Stephen Rothwell'; Mark Brown; Liam Girdwood
Cc: Linux-Next Mailing List; Linux Kernel Mailing List
Subject: RE: linux-next: build failure after merge of the sound-asoc tree

Hi all,

I think I miss the header file (#include <linux/acpi.h>) I will fix it ASAP. Sorry about that.

Thanks!

Regards,
Shuming Fan


-----Original Message-----
From: Stephen Rothwell [mailto:sfr@canb.auug.org.au]
Sent: Tuesday, April 17, 2018 9:03 AM
To: Mark Brown; Liam Girdwood
Cc: Linux-Next Mailing List; Linux Kernel Mailing List; Shuming [­S®Ñ»Ê]
Subject: linux-next: build failure after merge of the sound-asoc tree

Hi all,

After merging the sound-asoc tree, today's linux-next build (x86_64
allmodconfig) failed like this:

sound/soc/codecs/rt1305.c:1179:23: error: implicit declaration of function 'ACPI_PTR'; did you mean 'ERR_PTR'? [-Werror=implicit-function-declaration]
   .acpi_match_table = ACPI_PTR(rt1305_acpi_match)
                       ^~~~~~~~
                       ERR_PTR
sound/soc/codecs/rt1305.c:1179:23: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
sound/soc/codecs/rt1305.c:1179:23: note: (near initialization for 'rt1305_i2c_driver.driver.acpi_match_table')
sound/soc/codecs/rt1305.c:1179:23: error: initializer element is not constant
sound/soc/codecs/rt1305.c:1179:23: note: (near initialization for 'rt1305_i2c_driver.driver.acpi_match_table')

Caused by commit

  29bc643ddd7e ("ASoC: rt1305: Add RT1305/RT1306 amplifier driver")

I have used the sound-asoc tree from next-20180416 for today.

--
Cheers,
Stephen Rothwell

------Please consider the environment before printing this e-mail.
