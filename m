Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48960C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D285420664
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKCXQp+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D285420664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbeKAJWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 05:22:14 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:38832 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbeKAJWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 05:22:13 -0400
Received: by mail-ed1-f54.google.com with SMTP id c1-v6so15185540ede.5;
        Wed, 31 Oct 2018 17:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7RD1SEGi1002teKqjOAkkLcBBNLPRJx6v1rhE378itw=;
        b=VKCXQp+JSP5JkUn9poH1ZGCyWNuoibzLPWJB8aa3ReRHXuPVQ99xOW4s/8wnDHGrOR
         QB9gJ5KfwooWX7pdUuwnhIeQwclW+qZKSYbcPRl2VVkn/mMiwMdltQLzGLyblrM4J5bj
         PhXC9A8WUm18mNg1kHwhPJOmzCjiqgNKOQZCS5pzAKzXIwtPbqLhutg5CngOxXJ3YEpn
         ABjTScwpcufRZSK0nTN1IU+4ZS+oz3x6glcDP1Awl+74GoYD1qkjcBzxm288HlDuaWj9
         KUeF97JJ3Gdetbjmhrz7udZpOir+rto45O+Ch9A/REkLtTMn1oeHcBYuy+tCDoI4hhh0
         3L+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7RD1SEGi1002teKqjOAkkLcBBNLPRJx6v1rhE378itw=;
        b=GVGGJ0DnR4WtKJQNMY98ye4xB6qq908p9I/e95hk6YvpK7lt1R+uxQH8lUc2cfFTP1
         mhTKgEYn9m3wRFPwaPbHQy3t+UYw6r82wACesTDvUHlr9QPs90LcLOZoGXi4YTPA8dPh
         JYlBKZRArXxSbkklVO8lHtWGJEDuvb+ecIzAgwMEPsHXv2MHEFPBqlMFbZ9eB0/Rseql
         uD7ufxYWVVPj17RdSGJkQh/M49VI+1MyslbWNH/SuFq767NH5VSI94LAPnq8h217qLzh
         mIv0pmrkn70jpXMDjxxLMcdBtf9pZg8yBMGAyu26LWvtBntvtzpI7Tkqxh7MCokdCov5
         r29g==
X-Gm-Message-State: AGRZ1gLZNlSg+T758tV3FSByvgQWyiWkvYifxmZ+0arOPJ7aeCx3gK4+
        VPeClBS4Nkm/KLTJUSLJiAg=
X-Google-Smtp-Source: AJdET5cae026X1H3fzsluf/uSUEd0+rkKeLOmzScFQHO3t57W6QQfDHWk1HuLX0VUuj4lheYS176sA==
X-Received: by 2002:a17:906:e287:: with SMTP id gg7-v6mr2852356ejb.128.1541031699397;
        Wed, 31 Oct 2018 17:21:39 -0700 (PDT)
Received: from kiddo.lan ([2601:602:9400:bc9f::a3c])
        by smtp.gmail.com with ESMTPSA id b9-v6sm2981468ejd.3.2018.10.31.17.21.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 17:21:38 -0700 (PDT)
From:   "=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=" <jprvita@gmail.com>
X-Google-Original-From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>
To:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Cc:     hadess@hadess.net, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>
Subject: [PATCH 0/3] Fix display off hotkey on Asus machines
Date:   Wed, 31 Oct 2018 17:21:25 -0700
Message-Id: <20181101002128.28884-1-jprvita@endlessm.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Asus laptops have a hotkey function on the F7 key to turn the display
backlight OFF, labeled with a screen with a X inside, as shown on
https://dlcdnimgs.asus.com/websites/global/products/Xep1ZcSY8dyWXK11/images/keyboard.png

This hotkey worked on very few Asus models, where the EC acts on the
backlight and input events are generated only to notify userspace of the
backlight status. On these machines the first hotkey press turns the
display backlight OFF and notifies the OS with 0x34, which asus-nb-wmi
forwards to userspace as KEY_DISPLAY_OFF, and a second press turns it
back ON and notifies the OS with 0x33, which asus-nb-wmi forwards to
userspace as KEY_DISPLAYTOGGLE. No other keys turn the display backlight
back ON, but their input is forwarded normally to the application under
focus.

But for the majority of models, the EC actually does not act on the
backlight and we simply get a 0x33 notification every time the key is
pressed, or alternating values of 0x33 / 0x34. We have confirmed this
behavior on the following models: E203NAS, GL553VE, X441NC, X441UVK,
X541UVK, X555DG, X555UB, X555UQ, X560UD, X570ZD and X705FD, and the DSDT
on these machines and the working one (only confirmed on N552VW) is the
same for the query involved here.

After trying to get information from Asus for quite some time on how
this works on Windows, we finally recently got a contact that was able
to give us a definitive answer and a specification for this feature.
According this contact the 0x33 / 0x34 is an old behavior and all newer
machines should only be notifying the OS with 0x35 instead, as newer ECs
don't control the backlight anymore. When a 0x35 notification is
received the OS should act on the display backlight. From the spec
(machine-translated from Chinese):

  1.4 Fn+F7
  Function introduction

  After the user presses Fn + F7, the screen will be closed through the
  Windows API. The user will immediately open the screen with the mouse
  and keyboard.
  The API used can be found in the Sample URL:
  https://code.msdn.microsoft.com/windowsdesktop/Coalescable-Timer-Sample-d9da954c
  BIOS implementation
  Increase Notify code
  LCD On: 0x33 (display OSD)
  LCD Off: 0x34 (display OSD)
  LCD Switch: 0x35 (using API switch)

The behavior on Windows with the ATKACPI driver from Asus installed
matches what is described above, with the hotkey turning OFF the
backlight of all connected displays with a fading effect, and any cursor
input or key press turning the backlight back ON. The key press or
cursor input is passed through to the application under focus or under
the cursor.

With this information from the spec, a simple analysis of the DSDT
(pasted on the first commit of this series) shows that in order to have
the firmware notify the OS with 0x35 and have the OS act on the
backlight, we need to call WMNB(ASUS_WMI_DEVID_BACKLIGHT==0x00050011, 2)
on the _WDG device. Then we can simply map that scan code to the
appropriate key code in the driver.

In include/uapi/linux/input-event-codes.h KEY_DISPLAY_OFF is defined as
"display device to off state", but it is not actually handled by
userspace on a GNOME+Xorg stack. There are also KEY_SCREENSAVER and
KEY_SCREENLOCK / KEY_COFFEE. The former seems to be ignored by userspace
as well (and its value is higher than 255 so it can't be handled by Xorg
IIUC), and the later is mapped to XF86ScreenSaver by Xorg and triggers
the lock screen action on GNOME. KEY_SCREENLOCK seems to be what closest
matches the behavior described above in a Xorg world. I am not sure if
any of this changes with Wayland, so any clarifications in that regard
would be greatly appreciated.

João Paulo Rechi Vita (3):
  asus-wmi: Tell the EC the OS will handle the display off hotkey
  asus-nb-wmi: Map 0x35 to KEY_SCREENLOCK
  asus-nb-wmi: Drop mapping of 0x33 and 0x34 scan codes

 drivers/platform/x86/asus-nb-wmi.c | 3 +--
 drivers/platform/x86/asus-wmi.c    | 3 ++-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.19.1

