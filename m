Return-Path: <jorge.sanjuan@codethink.co.uk>
X-Google-Smtp-Source: AB8JxZpiUP3FI3A4SQvnR3qcWR8TINmeUzpjcZuPoc8vil+obaRnBmjXE80X1TNfWkeaanHS7ssp
ARC-Seal: i=1; a=rsa-sha256; t=1524590696; cv=none;
        d=google.com; s=arc-20160816;
        b=FQE6KCvDHVgGrxHHiHDTOystNznS0WQMSfOgkc9FXS1CssWKVycoPg8A9R2X9IDD6i
         qSkbpvZVuE1KsbExlu0oARUX4tUC8DVEzBhHRc4WHB8jaFY6e4meTx+qoNbA3DxqXbam
         YOOnJSs4epZzyieOisghU/9k22W/M5+PjuOJwU5EB7hxkbMuQSFS+jFnBb1A+qcEJ3R1
         HUMHCToCVLFXnAwzR/JCrOJ8DjP0UyNMWwI9JswLwco7iOwlH3b+X2REt2L7YdWwThtA
         oFDHLXJnU71MqsW+fhf9AoNV4Z0dHt+Mja8aYNffD48svpdPyvA5h5VIDqi4cmNOzz+P
         8l/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=40Y3ekkKuNvjZxIWP4ZW83rJm+Uc5LprTImJuh4E5xg=;
        b=XmrWJ6xCVt2D1fYVjcomNcGT1/DcMv9FgiVzojwjG3FFfLFknhGC32x0gSjTGjeIdh
         N6o5v/mvl0byLlI5oreuh3jDBUxq0wLx2e4C0j9Ni0UVMAgW5pW5OPumqUA3+08gd8Zz
         dhcB61VtokCjqQ1Ws5PU+FmAaQjIg7AtNrGnKZhjR9cNGBP8NblFjd+27WM+7Mv7Fvb9
         SS2cluDu/aw7AuHiRg3IB7/5xJ+/dDphyveH5+W2K+eCfXhYbjygVK5+76aX8p2WUXvS
         XGkMz1T/i1Uf6w/LDZgE+9wgZM2xNVxxiR1f3i8M7okhkV897gGguKv7wemfdHESOo+q
         DXeQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jorge.sanjuan@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=jorge.sanjuan@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jorge.sanjuan@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=jorge.sanjuan@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
From: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
To: tiwai@suse.com
Cc: alsa-devel@alsa-project.org,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Subject: [PATCH v2 0/4] ALSA: usb: UAC3 new features.
Date: Tue, 24 Apr 2018 18:24:41 +0100
Message-Id: <20180424172445.31928-1-jorge.sanjuan@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk>
References: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598285487756615401?=
X-GMAIL-MSGID: =?utf-8?q?1598649213743248844?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

v2 fixes:
 - If/else statements braces style fixes.
 - Add wrapping function to mixer unit code.
 - Make connectors control kctl struct const.
 - Little endian to cpu conversion in several places.
 - Sing off and add Fixes tag to fixup commit.
 - Remove flex-array for a struct that is used statically.

Now that the UAC3 patch [1] has made it to linux-next I have some extra
features to make a UAC3 device fully work in Linux. Including Jack 
insertion control that I have put on top of this other patch [2] for 
UAC2. Also adding support for the UAC3 Mixer Unit which is most likely
to appear in most headset type devices.

UAC3 devices also require to have a Basic Audio Device (BADD) in a separate 
config for which both Ruslan Bilovol and myself have submited different 
approaches[3][4] but I don't know what the final merge will be. Once there 
is official support for BADD, we'll need to test it with an actual UAC3 
device to confirm it all wokrs.

All this features are tested with an actual UAC3 device that is still in
development. For this patch series, only the legacy config (#1. UAC1/UAC2)
and the UAC3 config have been tested. The BADD config is only tested using
and updated verison of [4].

[1]: https://patchwork.kernel.org/patch/10298179/
[2]: https://patchwork.kernel.org/patch/10305847/
[3]: https://patchwork.kernel.org/patch/10340851/
[4]: https://www.spinics.net/lists/alsa-devel/msg71617.html

Based on linux-next tag: next-20180420

Jorge Sanjuan (3):
  ALSA: usb-audio: UAC3. Add support for mixer unit.
  ALSA: usb-audio: Use Class Specific EP for UAC3 devices.
  ALSA: usb-audio: UAC3 Add support for connector insertion.

Michael Drake (1):
  ALSA: usb-audio: ADC3: Fix channel mapping conversion for ADC3.

 include/linux/usb/audio-v2.h   |   7 ++
 include/linux/usb/audio-v3.h   |  14 +++
 include/uapi/linux/usb/audio.h |  13 ++-
 sound/usb/mixer.c              | 195 +++++++++++++++++++++++++++++++++++++----
 sound/usb/stream.c             |  11 ++-
 5 files changed, 217 insertions(+), 23 deletions(-)

-- 
2.11.0
