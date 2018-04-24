Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1982094-1524530110-2-5772572225105690785
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524530109; b=P9gKfVbDj4UvRbme5h5Mzt2CbsKM5PUWGwUQdAA0TmBkz8BRQ6
    OGFyQMq+SdDWZDiis5m5fjSrIscv8uySZ5qLTU8iJb7NKmFU7a9mSQ9aHQYOMd1/
    TD1/N6uc6jvFnU5CtRi4G3D2qaH/sy5tyypYdaQxUes0Ij2NdAzuTGwik9VqFU7q
    FKSy510dPK6UM9GbNslDeGrVdTgF0Vx0hvBbBuOgzF9DhE1zPFzlSAw6VDUaISRh
    XvFy5tOSemQNGZduTQubtKP13GudXg2aiOjXeDVghDE8tn2P5qPkYcRYfD1+MDAN
    1Zs4EET+2whlHr1zV4frt5yjCdM0a/a5r90g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524530109; bh=8/ZZY
    YoNvnCtOYTTxwUS6goWO1WSebKCHjrIGZK5ySw=; b=u+EqhiCNl4isUT5L7VG30
    Lg1YTiUd4s93B3+sw45NVS4665bIZrnFGBr7A7SOnp5xuLjLfe7hBBdtxyRs41DX
    p3JBt21388Wz7Dv8uyTt10Bbo604sTpcGvEubvQDvlb/in9Rx5nF8WV8xt8cz2Zp
    cSFPbuoxxaBWMlavFQcnYbQ7NGLzZGP+2Gyfm2QK6+CaFD6WyssCRvyjGdMmCvvk
    iExyndkQkT7kDjd3n2hFIqRTRSMJdQOKMUh6Dv/rVKljgzwgkwz2mx11RmDeFwbU
    KQXILaJiic5H6HAa1zMGzsy81vr2IP17oAXYt+T+PQyK5lGQQombSiq3Nqktdguy
    w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=DMbPFGh8 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fC2A8iuh;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=DMbPFGh8 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fC2A8iuh;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDbSIm4hjPPlk2uZsLXr5NmFRj+LqkKyPkqP3ZiKLUft9MkhAq11SmgvJ6TL7M+YrrrKKuegKtJoaL+qv/qz5QshOMleHx2Loz8itX1yKs5IcQAfpM8J
    047lSIFDM76D556H/0a8Iw4vDmZnFQu0ZSvfJxydOYNIGHrfRCzX72vezisG6UPkigUQRUqRWknTmi2tdsdiEXnjglMyFcxainuNcUvXoLY6p+MXNQUD0haI
    EO3XMShXrG9M+k0ait//8w==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=1FiBMPE2lCMA:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=NEAV23lmAAAA:8 a=bt8Zh30PAAAA:8 a=mDV3o1hIAAAA:8 a=DDOyTI_5AAAA:8
    a=Z2hNRN0_p6zEBN8XdV0A:9 a=CjuIK1q_8ugA:10 a=_FVE-zBwftR9WsbkzFJk:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx48MqrQ6elxc9nHvhmfwPv+7kWxLjXHnVX9zoSNxlaWxpPFSr35xLor1qXI9ri1dObHuMtELSg==
Subject: Re: [PATCH] staging: bcm2835-audio: Disconnect and free vchi_instance
 on module_exit()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20180417050028.19372-1-k.marinushkin@gmail.com>
 <20180423135024.GA2337@kroah.com>
From: Kirill Marinushkin <k.marinushkin@gmail.com>
Message-ID: <7e2dbb73-f93d-7b87-2fa0-d8b40f4a11a5@gmail.com>
Date: Tue, 24 Apr 2018 02:35:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180423135024.GA2337@kroah.com>
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
 Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org,
 Eric Anholt <eric@anholt.net>, Andy Shevchenko <andy.shevchenko@gmail.com>,
 bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/23/18 15:50, Greg Kroah-Hartman wrote:
> On Tue, Apr 17, 2018 at 07:00:28AM +0200, Kirill Marinushkin wrote:
>> In the current implementation, vchi_instance is inited during the first
>> call of bcm2835_audio_open_connection(), and is never freed. It causes a
>> memory leak when the module `snd_bcm2835` is removed.
>>
>> Here is how this commit fixes it:
>>
>> * the VCHI context (including vchi_instance) is created once in the
>>   platform's devres
>> * the VCHI context is allocated and connected once during module_init()
>> * all created bcm2835_chips have a pointer to this VCHI context
>> * bcm2835_audio_open_connection() can access the VCHI context through the
>>   associated bcm2835_chip
>> * the VCHI context is disconnected and freed once during module_exit()
>>
>> After this commit is applied, I don't see other issues with the module's
>> init/exit, so I also remove the associated TODO task.
>>
>> Steps to reproduce the memory leak before this commit:
> <snip>
>
> Patch dropped due to kbuild complaints.
>
> Please fix up and resend.
>
> thanks,
>
> greg k-h

Hello Greg,

Due to which complains of kbuild is the patch dropped?
I would like to fix the complains, but I don't see any errors or warnings on my
side.
Are you sure that the kbuild test robot did it's job correctly? The log says:

>> it may well be a FALSE warning

Please show me what is wrong in my patch.

The log from kbuild test robot says:

>> [auto build test WARNING on staging/staging-testing]
>> [also build test WARNING on v4.17-rc1]
>> [cannot apply to anholt/for-next]
>> [if your patch is applied to the wrong git tree, please drop us a note to
help improve the system]
>>
>> url:
https://github.com/0day-ci/linux/commits/Kirill-Marinushkin/staging-bcm2835-audio-Disconnect-and-free-vchi_instance-on-module_exit/20180417-193147
>> config: arm-allmodconfig
>> compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
>> reproduce:
>> wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
-O ~/bin/make.cross
>> chmod +x ~/bin/make.cross
>> make.cross ARCH=arm allmodconfig
>> make.cross ARCH=arm
>>
>> Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
>> http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

I cannot clone from the given url, because it does not exist.
I cannot use the compiler from the log, because it is built for x86_64, and my
host machine is i686.
Below are the steps how I tried to reproduce the issue, but errors or warnings
didn't happen.

I applied the patch on top of the following upstream tag:
60cc43fc8884 (tag: v4.17-rc1) Linux 4.17-rc1

And executed:
make CROSS_COMPILE=arm-linux-gnueabihf- --jobs=4 ARCH=arm allmodconfig
make CROSS_COMPILE=arm-linux-gnueabihf- --jobs=4 ARCH=arm

But the compilation succeed without any errors or warnings.

My compiler version is:
arm-linux-gnueabihf-gcc (crosstool-NG linaro-1.13.1-4.8-2014.01 - Linaro GCC
2013.11) 4.8.3 20140106 (prerelease)

Best Regards,
Kirill

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
