Return-Path: <hdegoede@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519740491; cv=none;
        d=google.com; s=arc-20160816;
        b=PUrx+qtVlHgYDNH3Ix1jMzYksSUzx2B/sUjbSMZdwov2QwwwEdbVmjhphWBzO7fhIX
         JXoNQeS9ACxMfcB39HE6er88amnKVFLVtdlOtaaBpjMBTrqyUqtJoogSCUXOjvjRWRPJ
         CV8arwrPAyJg6Gr6PJLoyBqBcRH1g5jzBZFdVAIh0dVGGeTuZICCMDY1UKl0UXhH4yw+
         xnntFhlYXBCcqaKlcDow6Bu7uDpKylwNcnuDYPV6zUKa2sT7TpyV+FNsa9qkDu2khwCP
         W4jRquHqa2ln9ZXYKyov4nH/2DNZSaoc4C3oZjLJL6XtKuDL9oEVol1dQAOzxx5r8Qnx
         uy8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=O4VeGHCesqv/nZQZ9eBsmkDedFTkpc3HWAWNmVc5CD8=;
        b=rlufUGxLuEZSVwXSC3O4gm+20bWo5uMDjUPXqOCWQNiDp1LKW0rWGqEka8Hq+iChVd
         YDDpkSS13izSG3rppopG/q6Ga8rhbS2u3dg9a1ex7GAtgPmwU3yipO1gN+n2reJn2RlU
         fCkParxHYQGSpnkQ3VH8XgthLjnb+5WScpbxZ74r7np6oYjtO+XPYshroZ0wPACQZE86
         u39IAzp+0gvS0d2+XZCw+8EB++nIIqTfbbnWG/IQHBCrNT6DTvesMounP2zaIHhdSofF
         9qT/Ao26qBempEOB1KXC8MZXyG7Nd+ndwC12QEcTak+L5KDZQ9+jvCCRpJQtKNvHJMny
         6Q9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AH8x227mcq2HkQsaAUxoRkFte/rBBPKSsi2xAcQWmTcvvfZNzlbS3DE+JVY3aS4fFSlotDLOfmu0mA==
Subject: Re: [PATCH] Bluetooth: btusb: Restore QCA Rome suspend/resume fix
 with a "rewritten" version
To: Brian Norris <briannorris@chromium.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Bluez mailing list <linux-bluetooth@vger.kernel.org>,
 linux-serial@vger.kernel.org,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 stable <stable@vger.kernel.org>, Leif Liddy <leif.linux@gmail.com>,
 Matthias Kaehlcke <mka@chromium.org>, Daniel Drake <drake@endlessm.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Matadeen Mishra <matadeen@qti.qualcomm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Guenter Roeck <linux@roeck-us.net>
References: <20180108094416.4789-1-hdegoede@redhat.com>
 <20180213022455.GA151190@rodete-desktop-imager.corp.google.com>
 <8cd918fd-bf6f-70ac-e561-e7deffa695f0@redhat.com>
 <20180216022721.GA69988@rodete-desktop-imager.corp.google.com>
 <345b0de8-1a23-d2f8-bc56-507eadf7faa7@redhat.com>
 <6B37F6AC-1103-4FCF-A5DC-4BA236A7B11B@holtmann.org>
 <1a08612e-2531-3711-ec0f-a867e86d0009@redhat.com>
 <20180216175955.GA80944@rodete-desktop-imager.corp.google.com>
 <a846c1ac-7dea-a30a-4133-32eac606d101@redhat.com>
 <20180223031216.GA230265@rodete-desktop-imager.corp.google.com>
 <a6090910-7941-b194-c094-7ce3ef047974@redhat.com>
 <CA+ASDXOGhi4t2R5qrbXHTFkjtzvUL=qHxkJqku4XKJ6u8Wr+cg@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <cdf043ef-b7d5-61f9-b8ea-7e75cb22485f@redhat.com>
Date: Tue, 27 Feb 2018 15:07:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CA+ASDXOGhi4t2R5qrbXHTFkjtzvUL=qHxkJqku4XKJ6u8Wr+cg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592481108912063395?=
X-GMAIL-MSGID: =?utf-8?q?1593563406173684051?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 27-02-18 03:29, Brian Norris wrote:
> On Thu, Feb 22, 2018 at 11:14 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> On 23-02-18 04:12, Brian Norris wrote:
>>> Hmm? I'm not sure I completely follow here when you say "he was not
>>> hitting the firmware loading race". If things were functioning fine with
>>> system suspend (but not with autosuspend), then he's not seeing the
>>> controller (quoting commit fd865802c66b) "losing power during suspend".
>>
>>
>> He was running a kernel with the original "fd865802c66b Bluetooth: btusb:
>> fix QCA Rome suspend/resume" commit, which fixes regular suspend for
>> devices which are "losing power during suspend", but does nothing for
>> runtime-suspend.
>>
>> He ran tests both with and without runtime-pm enabled with that same kernel
>> and he needed to disable runtime-pm to get working bluetooth.
> 
> Did he ever test with commit fd865802c66b reverted?
> 
> My symptoms were exactly the same as you described. BT was broken as
> of v4.14 if I had runtime suspend enabled. Things were fine if I
> either (a) reverted the patch or (b) disabled runtime suspend. I
> obviously preferred (a), which is why I continued to complain :)
> 
> Did your tester ever try (a)? If not, then I don't think you've really
> ensured that he really needed a "fixed" version; he may not have
> needed the patch at all.
> 
> Or an alternative question: did that system work on an older Fedora
> release (and presumably an older kernel)? If so, then he probably also
> did not need that patch.
> 
>>> So, that would suggest he could only be seeing the race (as I was), and
>>> that his machine does not deserve a RESET_RESUME quirk?
>>
>>
>> I hope my above answer helps to clarify why I believe the quirk is
>> necessary on his machine.
> 
> I'm sorry, but no it doesn't. If anything, it suggests to me even more
> that it may not have been necessary.

Ok, I've started another test-kernel build for the reporter this time
without any quirks at all and I've asked him to test.

Regards,

Hans
