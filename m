Return-Path: <cantabile.desu@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519841009; cv=none;
        d=google.com; s=arc-20160816;
        b=xchufWuOS8ir3HHSGXmyPBFn1pdjPs5YdahC28g60/hqgwrZbQn6ffCazEcCDK+lvL
         x/FtF/1qI1la9oHgLpXtb+pY9rWhHKcvZR+qpbH/kmguPAfFzK/QBY7kohoS08vK0JHy
         T8BIOGj3v1OFDzNdPB3QdLWgKN221mJhQftthE05lVy2rXtLJYfduuZwONMHfpBHAgYm
         ZExLGrcOHTM+Plim+T6RKCIvLIoZKtCflAG/WqUfrQ+5DGkbRr7tJ4fKF1p+Im8FxgmQ
         gDodiDFRowvsM4CL0FGmFe9nu4hNoP/lR5xuV4ICNiCC4jDEWTKL1XFOYa+tnuj+DXe3
         cFAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=FR23LaymO81GezoPv0NlBORWf1sCxUAv/2YDoV1YtcI=;
        b=EmretRv+uk9AuKoLjH9BrTcmRhZ4OOCZPTonL2urAICw6ndHnBGVSetAwk6euVFxh6
         MmH4AtLyljp1nmQUD2PTUsEnwyzmH4h+piK3jRgGvu9kIZvSUYwQcIt75PoaRGna2zRj
         Q98Z7qPD5HxKsHOAgr+Eq6fNTnZKKfMxsMXsW39NxiZV1/4+v3Sp0JymTc9z1n0Oy3eP
         8oZM6UO13m8D0oV6TylZigfHbrMwU41QbCfOaDdcuhjDq5iPSsyblsd+AaZ3QdxawIoa
         gBlbA23Gz7v6GZVIlZUqYRr0gwN2n18tfE/d7X3qt3YglD+27ksqrdDbFr60vyJGzvHr
         vooQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=M56aucza;
       spf=pass (google.com: domain of cantabile.desu@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=cantabile.desu@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=M56aucza;
       spf=pass (google.com: domain of cantabile.desu@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=cantabile.desu@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELv4lKkiB0+S5d/EL09JaB/353K8YyaMs3Ar7imecfq6gEvOAgMNLxT3cnGbOPRIjxb83zNLsw==
Subject: Re: [RFT 0/7] firmware: enable caching of firmware for reboot
 optimization
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: kubakici@wp.pl, gregkh@linuxfoundation.org, akpm@linux-foundation.org,
 linux-wireless@vger.kernel.org, keescook@chromium.org, shuah@kernel.org,
 mfuzzey@parkeon.com, zohar@linux.vnet.ibm.com, dhowells@redhat.com,
 pali.rohar@gmail.com, tiwai@suse.de, arend.vanspriel@broadcom.com,
 zajec5@gmail.com, nbroeking@me.com, markivx@codeaurora.org,
 stephen.boyd@linaro.org, broonie@kernel.org, dmitry.torokhov@gmail.com,
 dwmw2@infradead.org, torvalds@linux-foundation.org, Abhay_Salunke@dell.com,
 bjorn.andersson@linaro.org, jewalt@lgsinnovations.com, oneukum@suse.com,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20180227232101.20786-1-mcgrof@kernel.org>
From: cantabile <cantabile.desu@gmail.com>
Message-ID: <49e9d9c3-1352-e204-ff95-5cf10f14bd35@gmail.com>
Date: Wed, 28 Feb 2018 20:03:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180227232101.20786-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593598192477821921?=
X-GMAIL-MSGID: =?utf-8?q?1593668806726050396?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 28/02/18 01:20, Luis R. Rodriguez wrote:
> Cantabile, please give these patches a spin and let me know if it fixes
> your reported issue. They depend on other pending patches I have in line
> waiting to be merged so the easiest I thing I think is for you to test my
> 20180227-firmware-cache branch [0], based on Linus' tree. To get that
> tree, cd into your Linus git tree and do:
> 
> git remote add mcgrof https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git
> git checkout -b 20180227-firmware-cache mcgrof/20180227-firmware-cache
> 
> Please let me know if this resolves your issue and thanks for your report.
> 

I confirmed that request_firmware_cache is called, and the firmware is 
loaded from the cache when resuming from hibernation. The bug is fixed. 
Thank you.
