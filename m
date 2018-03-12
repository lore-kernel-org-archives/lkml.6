Return-Path: <gilad@benyossef.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520859418; cv=none;
        d=google.com; s=arc-20160816;
        b=kvNzxZ/tpv1pC/3GVnOMFJb0FnQmj8FmrVbJfUYSekHTdQJLpEILeoN2gqdB87YyTq
         mj8C76xBB9O26iOPuO2bYnt6afM+QtowkGn5tljvBjmOMl4oiM57MlkGfUejjkWg/J0T
         1nNWZTbj9HgXS44omYelKieNt/rP5eOzYtfSDVP+Jo6F+njppFoHRhquFIJsNf3Uikyu
         /dixQilwHdM418STFPIoG4xIpRKItqNifcArwmC/rniDqbxJPnU3tJn/7KxqPgg8r11C
         bMIxjoOwxQbvixP+fipP18x67YVQJ/ctoTKvrFC+/6iRfB0qWvY0iiMOo4+aqtnPoIET
         Pxyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Knq3dwC7QeYy0JYGG6CWjlCL/iXrdFsuYojkaiajjD0=;
        b=vbR2xwkOkrEBt+eXl+mMTQof2dJ1bRTVSfIcemkCeTOErPVJqghQhJAxtaLI9P4Wtf
         y0orFEaxn0GjVo3/rCIoYdVYb9Whlke/0kcFw+hQIdGpRLUN9gO3936oF7ivNZ86Yjsb
         CKem7jgYrzdfG6ecpqQ2wTAcpDEbqEnkDz2x1TNNAxNd7LgMM+aI8t2rbtw+YwP3vutM
         BzMF35Wo/9Rt2r8NiwBv4pRRsmkMlnO1Z269bE1XYGosGtkQLZlFteHAhNhCcv2+6kE7
         Ocout+Mhv1ia6UXpD4eYp6XjvlRv8t8/pG5o1lUBA3iBsuotMDSso19MQunINPSv4GCF
         dz8g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@benyossef-com.20150623.gappssmtp.com header.s=20150623 header.b=UAr160E2;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of gilad@benyossef.com) smtp.mailfrom=gilad@benyossef.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@benyossef-com.20150623.gappssmtp.com header.s=20150623 header.b=UAr160E2;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of gilad@benyossef.com) smtp.mailfrom=gilad@benyossef.com
X-Google-Smtp-Source: AG47ELtyhAiyCiGYS91JsuZDGeZuWFIfH21vHL/VJAdruOnl4Q+f1zWvqamUOZOxMehkY2dLtcqHEvYHXlnaIoqDNcM=
MIME-Version: 1.0
X-Originating-IP: [65.152.116.130]
In-Reply-To: <20180308171409.GA21632@kroah.com>
References: <1520498678-32175-1-git-send-email-gilad@benyossef.com> <20180308171409.GA21632@kroah.com>
From: Gilad Ben-Yossef <gilad@benyossef.com>
Date: Mon, 12 Mar 2018 05:56:57 -0700
Message-ID: <CAOtvUMfSd4k_sDcn7pDY_r_pOqx8C9dTkK=nhkqQSuGYDjmAaA@mail.gmail.com>
Subject: Re: [PATCH] staging: ccree: remove ccree staging copy
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ofir Drang <ofir.drang@arm.com>, devel@driverdev.osuosl.org,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594358433276712536?=
X-GMAIL-MSGID: =?utf-8?q?1594736685528163695?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 8, 2018 at 9:14 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Thu, Mar 08, 2018 at 08:44:38AM +0000, Gilad Ben-Yossef wrote:
>> Now when the ccree driver has been accepted into the cryptodev tree
>> we can remove the staging tree copy.
>
> Yeah!  Nice job.
>
>>
>> Please note that this commit may cause a merge conflict with the
>> cryptodev tree since we needed to disable the staging copy in order
>> to get the new copy to compile but the resolution is trivial.
>>
>> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
>> ---
>>  drivers/staging/Kconfig                  |    2 -
>>  drivers/staging/Makefile                 |    1 -
>>  drivers/staging/ccree/Kconfig            |   27 -
>>  drivers/staging/ccree/Makefile           |    7 -
>>  drivers/staging/ccree/TODO               |   10 -
>>  drivers/staging/ccree/cc_aead.c          | 2704 ------------------------------
>>  drivers/staging/ccree/cc_aead.h          |  109 --
>>  drivers/staging/ccree/cc_buffer_mgr.c    | 1651 ------------------
>>  drivers/staging/ccree/cc_buffer_mgr.h    |   74 -
>>  drivers/staging/ccree/cc_cipher.c        | 1165 -------------
>>  drivers/staging/ccree/cc_cipher.h        |   74 -
>>  drivers/staging/ccree/cc_crypto_ctx.h    |  170 --
>>  drivers/staging/ccree/cc_debugfs.c       |  101 --
>>  drivers/staging/ccree/cc_debugfs.h       |   32 -
>>  drivers/staging/ccree/cc_driver.c        |  474 ------
>>  drivers/staging/ccree/cc_driver.h        |  194 ---
>>  drivers/staging/ccree/cc_fips.c          |  111 --
>>  drivers/staging/ccree/cc_fips.h          |   37 -
>>  drivers/staging/ccree/cc_hash.c          | 2296 -------------------------
>>  drivers/staging/ccree/cc_hash.h          |  114 --
>>  drivers/staging/ccree/cc_host_regs.h     |  142 --
>>  drivers/staging/ccree/cc_hw_queue_defs.h |  590 -------
>>  drivers/staging/ccree/cc_ivgen.c         |  280 ----
>>  drivers/staging/ccree/cc_ivgen.h         |   55 -
>>  drivers/staging/ccree/cc_kernel_regs.h   |  167 --
>>  drivers/staging/ccree/cc_lli_defs.h      |   59 -
>>  drivers/staging/ccree/cc_pm.c            |  122 --
>>  drivers/staging/ccree/cc_pm.h            |   57 -
>>  drivers/staging/ccree/cc_request_mgr.c   |  713 --------
>>  drivers/staging/ccree/cc_request_mgr.h   |   51 -
>>  drivers/staging/ccree/cc_sram_mgr.c      |  107 --
>>  drivers/staging/ccree/cc_sram_mgr.h      |   65 -
>>  32 files changed, 11761 deletions(-)
>>  delete mode 100644 drivers/staging/ccree/Kconfig
>>  delete mode 100644 drivers/staging/ccree/Makefile
>>  delete mode 100644 drivers/staging/ccree/TODO
>>  delete mode 100644 drivers/staging/ccree/cc_aead.c
>>  delete mode 100644 drivers/staging/ccree/cc_aead.h
>>  delete mode 100644 drivers/staging/ccree/cc_buffer_mgr.c
>>  delete mode 100644 drivers/staging/ccree/cc_buffer_mgr.h
>>  delete mode 100644 drivers/staging/ccree/cc_cipher.c
>>  delete mode 100644 drivers/staging/ccree/cc_cipher.h
>>  delete mode 100644 drivers/staging/ccree/cc_crypto_ctx.h
>>  delete mode 100644 drivers/staging/ccree/cc_debugfs.c
>>  delete mode 100644 drivers/staging/ccree/cc_debugfs.h
>>  delete mode 100644 drivers/staging/ccree/cc_driver.c
>>  delete mode 100644 drivers/staging/ccree/cc_driver.h
>>  delete mode 100644 drivers/staging/ccree/cc_fips.c
>>  delete mode 100644 drivers/staging/ccree/cc_fips.h
>>  delete mode 100644 drivers/staging/ccree/cc_hash.c
>>  delete mode 100644 drivers/staging/ccree/cc_hash.h
>>  delete mode 100644 drivers/staging/ccree/cc_host_regs.h
>>  delete mode 100644 drivers/staging/ccree/cc_hw_queue_defs.h
>>  delete mode 100644 drivers/staging/ccree/cc_ivgen.c
>>  delete mode 100644 drivers/staging/ccree/cc_ivgen.h
>>  delete mode 100644 drivers/staging/ccree/cc_kernel_regs.h
>>  delete mode 100644 drivers/staging/ccree/cc_lli_defs.h
>>  delete mode 100644 drivers/staging/ccree/cc_pm.c
>>  delete mode 100644 drivers/staging/ccree/cc_pm.h
>>  delete mode 100644 drivers/staging/ccree/cc_request_mgr.c
>>  delete mode 100644 drivers/staging/ccree/cc_request_mgr.h
>>  delete mode 100644 drivers/staging/ccree/cc_sram_mgr.c
>>  delete mode 100644 drivers/staging/ccree/cc_sram_mgr.h
>>
>> diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
>> index e95ab68..7802c26 100644
>> --- a/drivers/staging/Kconfig
>> +++ b/drivers/staging/Kconfig
>> @@ -114,8 +114,6 @@ source "drivers/staging/greybus/Kconfig"
>>
>>  source "drivers/staging/vc04_services/Kconfig"
>>
>> -source "drivers/staging/ccree/Kconfig"
>> -
>>  source "drivers/staging/typec/Kconfig"
>>
>>  source "drivers/staging/vboxvideo/Kconfig"
>> diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
>> index af8cd6a..56afa21 100644
>> --- a/drivers/staging/Makefile
>> +++ b/drivers/staging/Makefile
>> @@ -49,6 +49,5 @@ obj-$(CONFIG_MOST)          += most/
>>  obj-$(CONFIG_KS7010)         += ks7010/
>>  obj-$(CONFIG_GREYBUS)                += greybus/
>>  obj-$(CONFIG_BCM2835_VCHIQ)  += vc04_services/
>> -obj-$(CONFIG_CRYPTO_DEV_CCREE)       += ccree/
>>  obj-$(CONFIG_DRM_VBOXVIDEO)  += vboxvideo/
>>  obj-$(CONFIG_PI433)          += pi433/
>> diff --git a/drivers/staging/ccree/Kconfig b/drivers/staging/ccree/Kconfig
>> deleted file mode 100644
>> index c94dfe8..0000000
>
> This patch doesn't apply at all.  Does it work for you when using 'git
> am' to import it?

Sorry, my bad. I tried to save the mailing list a patch of 12k lines
of code of just deleting stuff so I've used the git-format -D option.

Apparently that is not how this is done.

>
> Should I just do this "by hand" instead?
>

Yes please.

Many thanks,
Gilad

-- 
Gilad Ben-Yossef
Chief Coffee Drinker

"If you take a class in large-scale robotics, can you end up in a
situation where the homework eats your dog?"
 -- Jean-Baptiste Queru
