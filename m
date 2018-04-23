Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754205AbeDWIFI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 04:05:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53395 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754033AbeDWIFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 04:05:04 -0400
X-Google-Smtp-Source: AIpwx49IiYwIc74DyRXfzqhvi1YaAOCQIq64o9N+J1n5UdKWpkUD0HG7jEEaUx8IzF5vRpDmtIRpCw==
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [alsa-devel] [PATCH v4 3/3] ALSA: hda: Disabled unused audio
 controller for Dell platforms with Switchable Graphics
From: Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <s5hbmeew01d.wl-tiwai@suse.de>
Date: Mon, 23 Apr 2018 16:04:55 +0800
Cc: mjg59@srcf.ucam.org,
        =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        dvhart@infradead.org, andy@infradead.org,
        Mario Limonciello <mario.limonciello@dell.com>, tiwai@suse.com,
        alsa-devel@alsa-project.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <E5D0F76C-0A83-4D2C-81F7-BD5768C0A7DC@canonical.com>
References: <20180420094432.13133-1-kai.heng.feng@canonical.com>
 <20180420094432.13133-3-kai.heng.feng@canonical.com>
 <s5hbmeew01d.wl-tiwai@suse.de>
To: Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 20, 2018, at 8:10 PM, Takashi Iwai <tiwai@suse.de> wrote:
>
> On Fri, 20 Apr 2018 11:44:32 +0200,
> Kai-Heng Feng wrote:
>> Now it's a typical discrete-only system. HDMI audio comes from AMD audio
>> controller, others from Intel audio controller.
>>
>> When SG is enabled, the unused AMD audio contoller still exposes its
>> sysfs, so userspace still opens the control file and stream. If
>> userspace tries to output sound through the stream, it hangs the system.
>
> Hm, could you give more information about how it hangs?

Well, I should say "it hangs the userspace process" instead.

$ speaker-test -t wav -c 2 -D hw:CARD=HDMI,DEV=3
...and it just stopped. Can't Ctrl+C to break it.

>
>
>> @@ -1627,6 +1629,42 @@ static void check_msi(struct azx *chip)
>>  	}
>>  }
>>
>> +#if IS_ENABLED(CONFIG_DELL_LAPTOP)
>
> This should be IS_REACHABLE(), as both dell-laptop and HD-audio are
> tristate.

Thanks, will update in next version.

>
>> +static bool check_dell_switchable_gfx(struct pci_dev *pdev)
>
> I'd remove "_dell" word here.  Such a check would be likely needed for
> other vendors, and it's quite possible that the function will be
> extended to cover a wider DMI table.

Makes sense. Will also update this one.

Kai-Heng

>
>
> thanks,
>
> Takashi
