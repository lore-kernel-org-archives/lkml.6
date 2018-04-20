Return-Path: <jorge.sanjuan@codethink.co.uk>
X-Google-Smtp-Source: AIpwx4/JuBf70gwsV6vZb43yo3PoGJDjElpcpckkihp3iiJFKMB4vL+7tx41AdyuQum5dMhjL2us
ARC-Seal: i=1; a=rsa-sha256; t=1524243819; cv=none;
        d=google.com; s=arc-20160816;
        b=YhjOvA8qhctAkt/Kh6IPj0kAnNRNLSL3/6yheb2K4E93eRTiwcUZaX6RVJt2Ly5me1
         iRWQGlM+V5SvW1uSRT25IBqzrVWMNnyZ803lZkJv3rgWMOybr/X4zLqGR3KuCMCottf/
         8gvujEVwpMZ5okH+mXwMu+UtaasZlnvGTqSoUB6A69vJ4U1UfC8Tzin3KradOORTtQFW
         vu5mDEzZbKsRekkM/+BrG5AcMRDK4CZseKOIjKQJp+4Qjcsyu1O35w6D0cJhPNKtFbXt
         jqhH1g/UFwJsxI9mOIBcIb69uNcs0NIZ04E/ylT6Xxap2Onga6mZwWt3cuce3faJEUnr
         MkIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=n2gUFmcN7Wk8GZcS/ha9XuM/ObH3P/FLHavXMY+svVU=;
        b=uzaLN7Ss4LtfcxzALoMyYaZC3OBMlQSjZJH2uhZVdfnki+we4W3DDR4bY59bBtQ8Ke
         hI+glBR6XqygTgGDCLdQl3NorYrO1TMK9rvCbMWSWPWPGTRYgk9L+ILS2AS2yZ/yJYWc
         dZmJnCmugfdAn11yKhysGtMrL9mfRt7hekdcIJJduS9ZoGD8Q2JfUKFFXpozlsbHKk3T
         4Kn6/vqvbTB5NKz2kBnCGuAhmNVqfKMDDJnNM23QCfs5gyRf4zKTXjmaMEhiVhvxo39I
         KpqElPzxEt/eJdf/55ADA2Lnzt79SSzf+jo3Zevj3IsytqpfKKWH+FPEqdBP3TbnjurZ
         a2pA==
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
Subject: [PATCH 0/4] ALSA: usb: UAC3 new features.
Date: Fri, 20 Apr 2018 18:03:23 +0100
Message-Id: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598285487756615401?=
X-GMAIL-MSGID: =?utf-8?q?1598285487756615401?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
 include/linux/usb/audio-v3.h   |  14 ++++
 include/uapi/linux/usb/audio.h |  13 ++-
 sound/usb/mixer.c              | 175 ++++++++++++++++++++++++++++++++++++-----
 sound/usb/stream.c             |  19 ++++-
 5 files changed, 204 insertions(+), 24 deletions(-)

-- 
2.11.0
