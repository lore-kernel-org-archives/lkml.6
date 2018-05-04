Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AB8JxZqxcPGbiA/5utjZX4Owcz4biElCqR29Se9dyACVxbEyfmU5VXL13oOyB4CmFTL9S41DskSW
ARC-Seal: i=1; a=rsa-sha256; t=1525455839; cv=none;
        d=google.com; s=arc-20160816;
        b=AP1tvVFW3pjUAVZTmMQIZ8C2l6uZ61yJVOgQk8oj7JZiig55eoHU8zse1pvR7O71RL
         jpSQ8ixocsbqJ6OeA4L9azVu0f3PmDX3MVP6JVFSD0ZV6ecu4hqWHTrtqthzDYYFi7QE
         k3+PUtWeFUYAEt02cB5vb332at29AJ2a2AsqIr9xLfWhnzx1AG7D8gTL8EuIPnScmdlr
         LY1U+hbqJVetTMWxzpZR1W0pXFHaKFr1dDVDrK5gJ1iUpRHVyAB2J+TTZXmnYP57EqWW
         TQdrzqz70exAZ4vMR2hV3HovDtHR4/O4vcaahV2GdtqOaOG61+1l+BknKMgScXB+YbrX
         6ECw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=E7q/Zh6QBeHiqkoWpgQOBr9NtxeZazTvUKiLs5EK5Dw=;
        b=nnvcZ47AoQnqSt7dBBunvOgCd26uqFu4z9KZexN4QvgayXZR8bJw2WKap09b/Anl/z
         3Lv/Q6ty148RR5Uuo1lcem0LlBuMRvCTk87BWHzZQXgbPecVzHkK4gUqvNp0D2Iv0kOJ
         0mir6w7gYMjLhCuOaawdPbEn7LjBmzxe6Kbgexjt/2xav0gKGbOitH8gAhB/Wnf9ETVk
         MDnUPrBGsJuWO71mkI17dX7lwOnitfmtCcZvHKxm43OZlfz/DewwgSoEA2esGlj8hg+J
         kjfmjZaZ5pJaa0GB1bEHimOXTOSjMph2ufkht35V4VQa9V87E+kYssFwDFXtqtBTmIrR
         NNmg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=zuYIeAUl;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=zuYIeAUl;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	keescook@chromium.org,
	josh@joshtriplett.org,
	teg@jklm.no,
	wagi@monom.org,
	hdegoede@redhat.com,
	andresx7@gmail.com,
	zohar@linux.vnet.ibm.com,
	kubakici@wp.pl,
	shuah@kernel.org,
	mfuzzey@parkeon.com,
	dhowells@redhat.com,
	pali.rohar@gmail.com,
	tiwai@suse.de,
	kvalo@codeaurora.org,
	arend.vanspriel@broadcom.com,
	zajec5@gmail.com,
	nbroeking@me.com,
	markivx@codeaurora.org,
	broonie@kernel.org,
	dmitry.torokhov@gmail.com,
	dwmw2@infradead.org,
	torvalds@linux-foundation.org,
	Abhay_Salunke@dell.com,
	bjorn.andersson@linaro.org,
	jewalt@lgsinnovations.com,
	oneukum@suse.com,
	cantabile.desu@gmail.com,
	ast@fb.com,
	hare@suse.com,
	jejb@linux.vnet.ibm.com,
	martin.petersen@oracle.com,
	khc@pm.waw.pl,
	davem@davemloft.net,
	maco@android.com,
	arve@android.com,
	tkjos@android.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v5 0/6] firmware_loader: cleanups for v4.18
Date: Fri,  4 May 2018 10:43:49 -0700
Message-Id: <20180504174356.13227-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599556382367072293?=
X-GMAIL-MSGID: =?utf-8?q?1599556382367072293?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Greg,

I've reviewed the pending patches for the firmware_laoder and as for
v4.18, the following 3 patches from Andres have been iterated enough
that they're ready after I made some final minor changes, mostly just
style fixes and re-arrangements in terms of order. The new API he was
suggesting to add requires just a bit more review.

The last 3 patches are my own and are new, so I'd like further review
from others on them, but considering the changes Hans de Goede is having
us consider, I think this will prove useful to his work in terms of
splitting up code and documenting things properly. One thing that was
clear -- is our Kconfig entries for FW_LOADER were *extremely* outdated,
as such I've gone ahead and updated them.

The kconfig wording update for FW_LOADER includes prior conclusions made
to help justify keeping the split of the firmware fallback sysfs
interface in terms of size which was discussed with Josh Triplett a
while ago. It also includes modern recommendations, which would otherwise
get lost, on what to do about corner case firmware situations on
provisioning situations which folks have brought to my attention before
and architectural solutions based on firmwared [0] for a few years now.
Finally this work also reveals that a couple of candidate drivers could
likely move to staging considering their age, *or* we could just remove
the respective firmware build options. SCSI folks? Networking folks? To
my surprise *nothing* has been done about PREVENT_FIRMWARE_BUILD for
them since pre-git days!  These sneaky litte buggers are:

  * CONFIG_WANXL --> CONFIG_WANXL_BUILD_FIRMWARE
  * CONFIG_SCSI_AIC79XX --> CONFIG_AIC79XX_BUILD_FIRMWARE

To this day both of these drivers are building driver *firmwares* when
the option CONFIG_PREVENT_FIRMWARE_BUILD is disabled, and they don't
even make use of the firmware API at all. I find it *highly unlikely*
pre-git day drivers are raging in new radical firmware updates these
days. I'll go put a knife into some of that unless I hear back from
SCSI or networking folks that WANXL_BUILD_FIRMWARE and
AIC79XX_BUILD_FIRMWARE are still hip and very much needed.

On my radar as well are Mimi's latest firmware_loader proposed changes,
but I think those need considerable review and attention from more security
folks, Android folks, and the linux-wireless community, our own
scattered random folks of firmware reviewer folks.

These patches are based on top of linux-next next-20180504, they are
also available in a respective git branch, both for linux-next [1] and
linux [2].

Question, and specially rants are greatly appreciated, and of course...
may the 4th be with you.

[0] https://github.com/teg/firmwared
[1] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20180504-firmware_loader
[2] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20180504-firmware_loader

  Luis

Andres Rodriguez (3):
  firmware: wrap FW_OPT_* into an enum
  firmware: use () to terminate kernel-doc function names
  firmware: rename fw_sysfs_fallback to firmware_fallback_sysfs()

Luis R. Rodriguez (3):
  firmware_loader: document firmware_sysfs_fallback()
  firmware_loader: enhance Kconfig documentation over FW_LOADER
  firmware_loader: move kconfig FW_LOADER entries to its own file

 drivers/base/Kconfig                    |  90 +++-----------
 drivers/base/firmware_loader/Kconfig    | 149 ++++++++++++++++++++++++
 drivers/base/firmware_loader/fallback.c |  46 +++++---
 drivers/base/firmware_loader/fallback.h |  18 +--
 drivers/base/firmware_loader/firmware.h |  37 ++++--
 drivers/base/firmware_loader/main.c     |  28 ++---
 6 files changed, 252 insertions(+), 116 deletions(-)
 create mode 100644 drivers/base/firmware_loader/Kconfig

-- 
2.17.0
