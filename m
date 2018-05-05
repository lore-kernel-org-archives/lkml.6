Return-Path: <khc@pm.waw.pl>
X-Google-Smtp-Source: AB8JxZqm5ZdETFATSe8/Fsa4aXQDLlnWBpQTzyKi73EbWU6GyPegULPUNLFrUCZNh6DVs8/4xkd/
ARC-Seal: i=1; a=rsa-sha256; t=1525552009; cv=none;
        d=google.com; s=arc-20160816;
        b=HpFz9xI1S/beHLwl2AkkQ6OdWwK4dj70nM2vHHF6/Lb3wPL8V3I+VAlVjZsgUvpjyh
         QcUr/7bRXhdciTJpAd/5LTeEA3OoXnQ5Xl8vdRefGw4CFOICIhAck97nE5x5YAKIszLz
         l43pTFOKR3JcBurYzf3e9ZdnR6A2zma1iEEgK481Qndmi30SfmfzkaXZIvMJ9appzoEy
         CXCstGqR1xVE5nwdAjW/U5OmNMCp36KmomGnS/mYO8haXSXbr4FcgCDy7FJ0eGgqR3ya
         gz6HOd+nYeyYmls8rItO7ueKkQnEBZP7FfiN9582acC9kF/5yoI9pVd1odlCCswgkzWM
         r1Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:in-reply-to:date:references:subject:cc:to
         :from:arc-authentication-results;
        bh=Kj6FKB6Df8UGjwwauhyzgpKIImCOH9UBLFWq1e8D++k=;
        b=QCUVZZIAInJ3Tzn7ui/qcLe576WAKNrwF+j6c245tribc3fYhIaGDyHzwf75Q14Oj5
         vHrws6wBd1muN43Ne3GFkIX87yl8orBcM1nmnohklL9C4Zg7CRdQIuhFt/xaAC15ulTu
         MFCW2eIKc8RFKLedop1MctBgOzcJ/WmnP0bGJ66MSild8UiMAs4/sXXUU+p8EzB70q91
         XKloeP8HUWtMEKwpgBbFB4m/p2gCLCnDcD5cC1ROIeZIvUlwDCAKVlX5iRWGRgWCB0qw
         M/pZRltPbwbcm5aNwKjpj66zGiG9lPu84hGaXszM5Rk6nxeshChWjPsr5Qb1M3OIF2GU
         3UaQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of khc@pm.waw.pl designates 91.202.125.194 as permitted sender) smtp.mailfrom=khc@pm.waw.pl
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of khc@pm.waw.pl designates 91.202.125.194 as permitted sender) smtp.mailfrom=khc@pm.waw.pl
From: Krzysztof Halasa <khc@pm.waw.pl>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: gregkh@linuxfoundation.org,  akpm@linux-foundation.org,  keescook@chromium.org,  josh@joshtriplett.org,  teg@jklm.no,  wagi@monom.org,  hdegoede@redhat.com,  andresx7@gmail.com,  zohar@linux.vnet.ibm.com,  kubakici@wp.pl,  shuah@kernel.org,  mfuzzey@parkeon.com,  dhowells@redhat.com,  pali.rohar@gmail.com,  tiwai@suse.de,  kvalo@codeaurora.org,  arend.vanspriel@broadcom.com,  zajec5@gmail.com,  nbroeking@me.com,  markivx@codeaurora.org,  broonie@kernel.org,  dmitry.torokhov@gmail.com,  dwmw2@infradead.org,  torvalds@linux-foundation.org,  Abhay_Salunke@dell.com,  bjorn.andersson@linaro.org,  jewalt@lgsinnovations.com,  oneukum@suse.com,  cantabile.desu@gmail.com,  ast@fb.com,  hare@suse.com,  jejb@linux.vnet.ibm.com,  martin.petersen@oracle.com,  davem@davemloft.net,  maco@android.com,  arve@android.com,  tkjos@android.com,  linux-kernel@vger.kernel.org,  linux-fsdevel@vger.kernel.org,  linux-scsi@vger.kernel.org,  linux-wireless@vger.kernel.org,  netdev@vger.kernel.org
Subject: Re: [PATCH v5 0/6] firmware_loader: cleanups for v4.18
References: <20180504174356.13227-1-mcgrof@kernel.org>
	<m3lgczcjt7.fsf@pm.waw.pl> <20180504195835.GU27853@wotan.suse.de>
Date: Sat, 05 May 2018 22:26:46 +0200
In-Reply-To: <20180504195835.GU27853@wotan.suse.de> (Luis R. Rodriguez's
	message of "Fri, 4 May 2018 19:58:35 +0000")
Message-ID: <m3a7td6e7t.fsf@pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599556382367072293?=
X-GMAIL-MSGID: =?utf-8?q?1599657223513802534?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

"Luis R. Rodriguez" <mcgrof@kernel.org> writes:

> So we can nuke CONFIG_WANXL_BUILD_FIRMWARE now?

I'm uncertain I understand why do you want it, or maybe what are you
trying to do at all.

And what use would wanxlfw.S (the assembly source) have if the option is
removed?

>> It's more about delivering the .S source for the firmware, I guess.
>> Nobody is expected to build it. The fw is about 2.5 KB and is directly
>> linked with the driver.
>
> :P Future work I guess would be to just use the firmware API and stuff
> it into linux-firmware?

Who's going to make it happen?
The last time I checked (several years ago), wanXL worked. Who's going
to test it after the change?

I assume linux-firmware could include fw source and there would be means
to build the binary.

Just to be sure: the wanXL firmware has exactly nothing to do with FW
loader, nothing depends on it (nor the other way around), it's just
(with the rest of the wanXL code) an old piece of a driver for an old
card.

The question is, what do we gain by messing with it?
-- 
Krzysztof Halasa
