Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752765AbeDPALW (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 20:11:22 -0400
Received: from mout.web.de ([212.227.15.3]:49763 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751799AbeDPALV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 20:11:21 -0400
Subject: Re: [RFC] Passing luks passphrase from grub to systemd
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: linux-kernel@vger.kernel.org
References: <2907407.5HaPOCmciK@natalenko.name>
From: Hansjoerg Lipp <hjlipp@web.de>
Message-ID: <a215d375-6fb1-d01e-63f2-48d98fc6bbc2@web.de>
Date: Mon, 16 Apr 2018 02:11:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2907407.5HaPOCmciK@natalenko.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:+vp1LzcX/eCG6SY7rWAhp0yliX3UecEcGM4bsHn7/FOGhkKob4j
 /muVFqNAjnzt1Y0cjYF80iLLOcXJGtcla8Aw6BxVH/VUoGGIg4TQr++Sd6ZSHzit8zslmSI
 Tsbilq1hq86eXyxFKmodvFNFavocuxFm6fu1U5SMm2vCCaj3UY61z/ZehzIeqXHMbqkqW2v
 9Y+vfXmkUxikOOveCrUEQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LSCqd81uNU0=:etzhVWtRyUiKVdtNAo60Zv
 1jfUACZfJEzZ65qyMoajqIcVF+sxx4tH322n+5avprfOWuWuIYpZVC3/IEGGXfQPBwiwVXqOm
 pzPruHFnY8CKGpFEeS/NFSWKkZH1wXfbb5Bg5QKkLqXP7qSyGpiCR/qBTBZ88jDK5XSRgSGRC
 vtxooLqKtC6aROxBmL7P4YeCyI3AxCo1f04mp3IO8EZdwSW3MnTvFLD+vGwbhGLpxzPrJ5aR1
 pfnH1BTLDH67cb3Q7/YuaKKW1YseGNQUQdwl6f0dIHZYre6SoK0ZOyW8kGu3nGwgImBA3/Is7
 H/73UwjOf3s88NgGBbCmlVprUm+iTnepHohx7g/UhbIIhJ3z/Ohv6V6ozEEmV0ALz44y5Ph9X
 nJA96dcz95KlsuaYRO1nhsdA0CvD0rjwPUOqOs64TQGCTiPEveHF5si5IeGN8iFS/kR4cm433
 QxZW+ECB36wwWqGYxa1kTF18FarJXRyFKdmM6jMeT9QnRx+IA3KIrljm0zcaBI5rpw/aZXdHm
 hIo0XIwxTvDa4o9dyvzUbaLobhhylF5gNeS2EnJof7ckTMRD5NLRGkpljURB7r+z9gaic7XL4
 C20HDIRTefLlvYBm3Dp4LxqhXwCidtcCLYq8yKZ6DlXhdKk5+HS7AEE923NUxW2mvh7YMxhpz
 kk26WfQIfbvFliLpsSgZYfcxHNkhwE4wIk9vldPDiKdt0/SitHdIe3n0DB/0zerPkgI1jaBsH
 pZylZeEa+A6dFENjKV+J57XszmhJLV9hvLZMDlYVuX5a2sF8oybABN3eyrUr4KKAlg5nCLjyz
 /FQ/f1/O2ddAOb68QjGT+OCURhE+oTcYO/XuZbKCb06ZCYVLaE=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Oleksandr.

Am 16.04.2018 um 00:25 schrieb Oleksandr Natalenko:
>> as I'm stuck with a (non-EFI x86_64) system with encrypted root
>> partition, I have to enter the passphrase twice (grub needs it for
>> getting the kernel etc., systemd needs it for mounting the root
>> partition). This can be quite inconvenient, especially if the passphrase
>> is long and contains special characters, and grub assumes a different
>> keyboard layout.
> 
> Just fill another LUKS slot with a randomly generated key file and add that 
> file to your initramfs (which already resides on encrypted /boot, right?). If 
> your distro cannot do that, you should probably fixing things there, not 
> adding ugly hacks to the kernel.

Yes, I never considered this proof of concept code as a good solution (I
don't want to get it into the kernel!), it was meant as a starting point
for discussing whether there is need for some mechanism to get data like
this from the boot loader to the init process, and if so, how to do it
right (and it was actually fun to learn a bit about all this).

I'm thankful for your hint how I could solve my personal luks problem in
a clean way (although it somehow does not feel right to have a key file
accessible to probable malware while the machine is running; of course a
paranoid thought of me...).

Kind regards and thanks again
Hansjoerg
