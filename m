Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA41C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB7320831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiJghZ7g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB7320831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbeKCEoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:44:01 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43872 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbeKCEoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:44:01 -0400
Received: by mail-qk1-f194.google.com with SMTP id r71so4829918qkr.10;
        Fri, 02 Nov 2018 12:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9rmbQ7Y+mf50LmmU1LleL7tj5epEkS5t6EQlSZLwzwM=;
        b=ZiJghZ7gX6BM9z6/IJdSeDnG6Wqb78ouu62oHEwlUKwhL36CvgPxmhYvvS32rrFerx
         +TRVVCkb0WJ0nBulsxChwGmMVV+0iWfCqdHpuSiGRqocCwVo5LSIFXe3vMXaCEICMjvV
         UNYxjNxGYwkCqk+LU5uJgoVgTg9CjOIy1cAzO3rhfUJlmPfQzgTZhj9dY3H4PvffoYZi
         VmVwIsF/QXYCHiW0h3TDsh4wTLzZseEQpVJ2Fqnw5CEtXkcUVg3ef6N5ifeHvOofxX+V
         zzD+25v+iGZrcbvdZ9xeQk2BCvF0+F6TzBfkbZ/gkNBy05/WOO0S253pm6i/KTIQd2YB
         I2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9rmbQ7Y+mf50LmmU1LleL7tj5epEkS5t6EQlSZLwzwM=;
        b=CcK6qCN0AxrLzgj5rFl20uoGiNFdDH6VEB33DAT/F7cAfTor603ngbK0kWBJj0DFrv
         BwtM7O2C8vI0mJbJhkYsM929N9ckxRVqCkPA6Y6vY76Yc4e1hrvIQ2ctfi9bpV26DCTk
         yQZ4hZp5AHfbWMNrOmyr4+SsTB9866Js816Tajzmxnk3cax4ZCxafaQhRW1647CGMmWw
         zTCbeXpayrMHI6EPn3swkyiWrdPpki+VJoJ+/mCks8VercFvllwoEB8/xzPzezPqu9Ww
         VXyrSrx4GMKrATDubE+DBP+Ho24Emn0uX6ls4JTWoPEULkilFC8FPA+GBGEgppWUmeQN
         hvmw==
X-Gm-Message-State: AGRZ1gKsfd9uxeZ3V5DvWxHiQIGFlcbNf3ursKZcMUtCVqS81UYprp51
        OfMhsXj2ChIp+mV1lrWC6d9aU5GeuXptLeXmzZCAZDTq
X-Google-Smtp-Source: AJdET5f7evMns7gh7RiHl0uz2rZGYugYW85CwTuW+in8O8hkUmI9cO0G+iuN5ZlXC+ueIkZIba/76IGFQRg17nEuYQc=
X-Received: by 2002:a37:1f44:: with SMTP id f65mr11425141qkf.33.1541187333934;
 Fri, 02 Nov 2018 12:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <20181101002128.28884-1-jprvita@endlessm.com>
In-Reply-To: <20181101002128.28884-1-jprvita@endlessm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Nov 2018 21:35:22 +0200
Message-ID: <CAHp75VdzYf_CXiBzVrOUw+R5ZA8O-+_PGJ-Cv-q7QTXpvG0dVA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix display off hotkey on Asus machines
To:     =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux@endlessm.com,
        =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 2:21 AM Jo=C3=A3o Paulo Rechi Vita <jprvita@gmail.co=
m> wrote:
>
> Asus laptops have a hotkey function on the F7 key to turn the display
> backlight OFF, labeled with a screen with a X inside, as shown on
> https://dlcdnimgs.asus.com/websites/global/products/Xep1ZcSY8dyWXK11/imag=
es/keyboard.png
>
> This hotkey worked on very few Asus models, where the EC acts on the
> backlight and input events are generated only to notify userspace of the
> backlight status. On these machines the first hotkey press turns the
> display backlight OFF and notifies the OS with 0x34, which asus-nb-wmi
> forwards to userspace as KEY_DISPLAY_OFF, and a second press turns it
> back ON and notifies the OS with 0x33, which asus-nb-wmi forwards to
> userspace as KEY_DISPLAYTOGGLE. No other keys turn the display backlight
> back ON, but their input is forwarded normally to the application under
> focus.
>
> But for the majority of models, the EC actually does not act on the
> backlight and we simply get a 0x33 notification every time the key is
> pressed, or alternating values of 0x33 / 0x34. We have confirmed this
> behavior on the following models: E203NAS, GL553VE, X441NC, X441UVK,
> X541UVK, X555DG, X555UB, X555UQ, X560UD, X570ZD and X705FD, and the DSDT
> on these machines and the working one (only confirmed on N552VW) is the
> same for the query involved here.
>
> After trying to get information from Asus for quite some time on how
> this works on Windows, we finally recently got a contact that was able
> to give us a definitive answer and a specification for this feature.
> According this contact the 0x33 / 0x34 is an old behavior and all newer
> machines should only be notifying the OS with 0x35 instead, as newer ECs
> don't control the backlight anymore. When a 0x35 notification is
> received the OS should act on the display backlight. From the spec
> (machine-translated from Chinese):
>
>   1.4 Fn+F7
>   Function introduction
>
>   After the user presses Fn + F7, the screen will be closed through the
>   Windows API. The user will immediately open the screen with the mouse
>   and keyboard.
>   The API used can be found in the Sample URL:
>   https://code.msdn.microsoft.com/windowsdesktop/Coalescable-Timer-Sample=
-d9da954c
>   BIOS implementation
>   Increase Notify code
>   LCD On: 0x33 (display OSD)
>   LCD Off: 0x34 (display OSD)
>   LCD Switch: 0x35 (using API switch)
>
> The behavior on Windows with the ATKACPI driver from Asus installed
> matches what is described above, with the hotkey turning OFF the
> backlight of all connected displays with a fading effect, and any cursor
> input or key press turning the backlight back ON. The key press or
> cursor input is passed through to the application under focus or under
> the cursor.
>
> With this information from the spec, a simple analysis of the DSDT
> (pasted on the first commit of this series) shows that in order to have
> the firmware notify the OS with 0x35 and have the OS act on the
> backlight, we need to call WMNB(ASUS_WMI_DEVID_BACKLIGHT=3D=3D0x00050011,=
 2)
> on the _WDG device. Then we can simply map that scan code to the
> appropriate key code in the driver.
>
> In include/uapi/linux/input-event-codes.h KEY_DISPLAY_OFF is defined as
> "display device to off state", but it is not actually handled by
> userspace on a GNOME+Xorg stack. There are also KEY_SCREENSAVER and
> KEY_SCREENLOCK / KEY_COFFEE. The former seems to be ignored by userspace
> as well (and its value is higher than 255 so it can't be handled by Xorg
> IIUC), and the later is mapped to XF86ScreenSaver by Xorg and triggers
> the lock screen action on GNOME. KEY_SCREENLOCK seems to be what closest
> matches the behavior described above in a Xorg world. I am not sure if
> any of this changes with Wayland, so any clarifications in that regard
> would be greatly appreciated.
>

Pushed to my review and testing queue, thanks!

> Jo=C3=A3o Paulo Rechi Vita (3):
>   asus-wmi: Tell the EC the OS will handle the display off hotkey
>   asus-nb-wmi: Map 0x35 to KEY_SCREENLOCK
>   asus-nb-wmi: Drop mapping of 0x33 and 0x34 scan codes
>
>  drivers/platform/x86/asus-nb-wmi.c | 3 +--
>  drivers/platform/x86/asus-wmi.c    | 3 ++-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> --
> 2.19.1
>


--=20
With Best Regards,
Andy Shevchenko
