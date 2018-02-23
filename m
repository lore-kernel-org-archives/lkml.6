Return-Path: <arend.vanspriel@broadcom.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519382378; cv=none;
        d=google.com; s=arc-20160816;
        b=0EzBE4UQjRPvKxVBLiJ4aEewd3Su5EAtMx2Y1DJlsSwIwl08DmeQcmyauGAO4npQr4
         m+xolT3HELIpmIvu9IUa9HjJOv575RQAoYEt6H9dUEDuJBg9dvKou3k+fq+8wKW0qBwl
         P/QqjjT3rdUshMmPtKeSA4pOII6CBz31/AYeZB0Hb4HAOVJk0ZTY9h7W4K7i5Gjo/BJx
         zbTDf02LPybLPIqnXDISLktU1MQ+nz/B3F0UsBlc5JNDwruodyYfp7eVfJgcjtrdET/b
         31EGV/Iqml2XTe3eQtwZPCZlIoOOnwZLm51i94K3g4abbPSUyMdRy7+XosKUz/cvu4Py
         k7vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:dkim-signature
         :arc-authentication-results;
        bh=+cUTUz562rN2+6B6NwOMrX3wg8nSvlROV/qwidXLZ2A=;
        b=Nlghhggmpt4Su1Rp8EavjxlXMhNzcRkBBVPkCDcGxKk8bMlZie2ZM7Qhg6+Zxvb9Yj
         qYNuoY02gnIOBSQL+VA76EnHtANXICzMuRPwmCCYEPO8GNvbLP1YnHn1SFp49YXi8MKh
         4tuelMhmc298XWqt7vRPwLfGt48e1N8tQYz/9DiOsSkZEMZiLJwYuNA+2faD7aj/jX4R
         pIRxLoOu+jQYT3C9hECXR4aAf8JQn733CXx07eDlloC8t9ore0YDvTb5DdtHfTqguBgd
         jB/xb/+2z0eola8Qo0PhatIEIUi/JEgvdJUPxFgRv2WKQs+KvBgtnvZaWhFBOV1fLC/B
         eqCg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@broadcom.com header.s=google header.b=QMm8pI03;
       spf=pass (google.com: domain of arend.vanspriel@broadcom.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arend.vanspriel@broadcom.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=broadcom.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@broadcom.com header.s=google header.b=QMm8pI03;
       spf=pass (google.com: domain of arend.vanspriel@broadcom.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arend.vanspriel@broadcom.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=broadcom.com
X-Google-Smtp-Source: AH8x226YqKrDatosybEDh5K1zyiuAm56GJXCo/DEY1ChW3rv4KIlN3LUlvAgbQSpgdDDo1Tlk6lEWA==
Subject: Re: [PATCH 2/3] mwifiex: support sysfs initiated device coredump
To: Brian Norris <briannorris@chromium.org>
References: <1519210220-22437-1-git-send-email-arend.vanspriel@broadcom.com>
 <1519210220-22437-3-git-send-email-arend.vanspriel@broadcom.com>
 <20180221225903.GA42395@rodete-desktop-imager.corp.google.com>
 <5A8EB4F4.2030103@broadcom.com>
 <20180222193547.GA78462@rodete-desktop-imager.corp.google.com>
Cc: Kalle Valo <kvalo@codeaurora.org>, Marcel Holtmann <marcel@holtmann.org>,
 linux-wireless@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Johannes Berg <johannes@sipsolutions.net>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5A8FEF68.5080900@broadcom.com>
Date: Fri, 23 Feb 2018 11:39:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <20180222193547.GA78462@rodete-desktop-imager.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593007398864870404?=
X-GMAIL-MSGID: =?utf-8?q?1593187896874792806?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

+ Johannes (for devcoredump documentation question).

On 2/22/2018 8:35 PM, Brian Norris wrote:
> Hi Arend,
>
> On Thu, Feb 22, 2018 at 01:17:56PM +0100, Arend van Spriel wrote:
>> On 2/21/2018 11:59 PM, Brian Norris wrote:
>>> On Wed, Feb 21, 2018 at 11:50:19AM +0100, Arend van Spriel wrote:
>>>> Since commit 3c47d19ff4dc ("drivers: base: add coredump driver ops")
>>>> it is possible to initiate a device coredump from user-space. This
>>>> patch adds support for it adding the .coredump() driver callback.
>>>> As there is no longer a need to initiate it through debugfs remove
>>>> that code.
>>>>
>>>> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>>>> ---
>>>>    drivers/net/wireless/marvell/mwifiex/debugfs.c | 31 +-------------------------
>>>>    drivers/net/wireless/marvell/mwifiex/pcie.c    | 19 ++++++++++++++--
>>>>    drivers/net/wireless/marvell/mwifiex/sdio.c    | 13 +++++++++++
>>>>    drivers/net/wireless/marvell/mwifiex/usb.c     | 14 ++++++++++++
>>>>    4 files changed, 45 insertions(+), 32 deletions(-)
>>>
>>> The documentation doesn't really say [1], but is the coredump supposed
>>> to happen synchronously? Because the mwifiex implementation is
>>> asynchronous, whereas it looks like the brcmfmac one is synchronous.
>>
>> Well, that depends on the eye of the beholder I guess. From user-space
>> perspective it is asynchronous regardless. A write access to the coredump
>> sysfs file eventually results in a uevent when the devcoredump entry is
>> created, ie. after driver has made a dev_coredump API call. Whether the
>> driver does that synchronously or asynchronously is irrelevant as far as
>> user-space is concerned.
>
> Is it really? The driver infrastructure seems to guarantee that the
> entirety of a driver's ->coredump() will complete before returning from
> the write. So it might be reasonable for some user to assume (based on
> implementation details, e.g., of brcmfmac) that the devcoredump will be
> ready by the time the write() syscall returns, absent documentation that
> says otherwise. But then, that's not how mwifiex works right now, so
> they might be surprised if they switch drivers.

Ok. I already agreed that the uevent behavior should be documented. The 
error handling you are bringing up below was something I realized as 
well. I am not familiar with mwifiex to determine what it can say about 
the coredump succeeding before scheduling the work.

> Anyway, *I'm* already personally used to these dumps being asynchronous,
> and writing tooling to listen for the uevent instead. But that doesn't
> mean everyone will be.
>
> Also, due to the differences in async/sync, mwifiex doesn't really
> provide you much chance for error handling, because most errors would be
> asynchronous. So brcmfmac's "coredump" has more chance for user programs
> to error-check than mwifiex's (due to the asynchronous nature) [1].
>
> BTW, I push on this mostly because this is migrating from a debugfs
> feature (that is easy to hand-wave off as not really providing a
> consistent/stable API, etc., etc.) to a documented sysfs feature. If it
> were left to rot in debugfs, I probably wouldn't be as bothered ;)

I appreciate it. The documentation is not in the stable ABI folder yet 
so I welcome any and all improvements. Might learn a thing or two from it.

>>> Brian
>>>
>>> [1] In fact, the ABI documentation really just describes kernel
>>> internals, rather than documenting any user-facing details, from what I
>>> can tell.
>>
>> You are right. Clearly I did not reach the end my learning curve here. I
>> assumed referring to the existing dev_coredump facility was sufficient, but
>> maybe it is worth a patch to be more explicit and mention the uevent
>> behavior. Also dev_coredump facility may be disabled upon which the trigger
>> will have no effect in sysfs. In the kernel the data passed by the driver is
>> simply freed by dev_coredump facility.
>
> Is there any other documentation for the coredump feature? I don't
> really see much.

Any other than the code itself you mean? I am not sure. Maybe Johannes 
knows.

> Brian
>
> [1] Oh wait, but I see that while ->coredump() has an integer return
> code...the caller ignores it:
>
> static ssize_t coredump_store(struct device *dev, struct device_attribute *attr,
> 			    const char *buf, size_t count)
> {
> 	device_lock(dev);
> 	if (dev->driver->coredump)
> 		dev->driver->coredump(dev);
> 	device_unlock(dev);
>
> 	return count;
> }
> static DEVICE_ATTR_WO(coredump);
>
> Is that a bug or a feature?

Yeah. Let's call it a bug. Just not sure what to go for. Return the 
error or change coredump callback to void return type.

Regards,
Arend
