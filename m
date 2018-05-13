Return-Path: <samuel.thibault@ens-lyon.org>
X-Google-Smtp-Source: AB8JxZrcnDAnhA+AS25pznFqsu+UJ7BcFkDKOWT001Zz9R8e2je8q1Fw15G6R4W72HhZ+mGN0zrd
ARC-Seal: i=1; a=rsa-sha256; t=1526241928; cv=none;
        d=google.com; s=arc-20160816;
        b=I8eMSlY7YLS9APgqrZtPWftOikpvZNep2Hk0FhdHlFO28ceYap7kVb8pexUBPVUQXo
         KK0a/FP0AP7jFN9UhrNwzkPBaAQgbyeIhMXmH/UfsFUbJ3K3k2GDWV+W9A0UfKLpUPD4
         sS8e7uP6AMJaXZYTqRbBNAGCJfpMXrm/owWRSLVbsC99aXLu3P2/glU89JYneCFwTTHK
         O1dddWuYtmOvP7suSNnf23hCcoVJSZyGthGR9DDccHdAuJFL0I7TAqwro0DXeoL+BPyB
         1FvsUSoz8j5nnXr7rv++yChMSnAM/dl2uME4BfY3v2n2Di7W0/XLx+WhPCmUX8Xw/bcS
         EoIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:organization:content-disposition:mime-version
         :mail-followup-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=kq5jvocZLURa7PSeVV+RO2r+88H4ajAUPXgVqxdzcck=;
        b=UlTqKVI+McLXl6wsHrtPXD/JIllccWNk/ZvrgS/e021vYjD9zRQSKD5tbxdpVwV4mP
         NmUdmQQcbd75FbJYRLAuWgsJKslxfoxtfruj/CnT6CNWkuQ0iDQvrl0d+BxovMrBzzut
         232GDknybcAlQ+Woqiha05Xbq1R/kDhDlrN3z6loFrH6q4jWsOb0c4uQ5H5DGh+hNQN2
         LFSgBIo0vENuuBmdi0jSNFC9If3NF73akqFEf8QPeKjd6Y60LNVFY5s7AvpFbzWh+91c
         KZJ88ULxmTABL8OowNCNmEpgUimYJhfXv5xI4ue+Me+x9xd+5WtUisAPPnBDfAUeaUck
         +ZPw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 185.233.100.1 is neither permitted nor denied by domain of samuel.thibault@ens-lyon.org) smtp.mailfrom=samuel.thibault@ens-lyon.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 185.233.100.1 is neither permitted nor denied by domain of samuel.thibault@ens-lyon.org) smtp.mailfrom=samuel.thibault@ens-lyon.org
Date: Sun, 13 May 2018 11:38:30 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: w.d.hubbs@gmail.com, chris@the-brannons.com, kirk@reisers.ca,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	speakup@linux-speakup.org
Subject: [PATCH] staging: speakup: Fix coding style
Message-ID: <20180513093830.lwspfmjaxjixpaew@var.youpi.perso.aquilenet.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Greg KH <gregkh@linuxfoundation.org>, w.d.hubbs@gmail.com,
	chris@the-brannons.com, kirk@reisers.ca, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, speakup@linux-speakup.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600380656622822002?=
X-GMAIL-MSGID: =?utf-8?q?1600380656622822002?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 drivers/staging/speakup/buffers.c |    3 ++-
 drivers/staging/speakup/main.c    |    5 ++---
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/staging/speakup/buffers.c
+++ b/drivers/staging/speakup/buffers.c
@@ -78,7 +78,8 @@ void synth_buffer_add(u16 ch)
 	if (buff_in > buffer_end)
 		buff_in = synth_buffer;
 	/* We have written something to the speech synthesis, so we are not
-	 * paused any more. */
+	 * paused any more.
+	 */
 	spk_paused = 0;
 }
 
--- a/drivers/staging/speakup/main.c
+++ b/drivers/staging/speakup/main.c
@@ -68,7 +68,7 @@ int spk_punc_level, spk_reading_punc;
 char spk_str_caps_start[MAXVARLEN + 1] = "\0";
 char spk_str_caps_stop[MAXVARLEN + 1] = "\0";
 char spk_str_pause[MAXVARLEN + 1] = "\0";
-bool spk_paused = 0;
+bool spk_paused;
 const struct st_bits_data spk_punc_info[] = {
 	{"none", "", 0},
 	{"some", "/$%&@", SOME},
@@ -1782,8 +1782,7 @@ static void speakup_con_update(struct vc
 		/* Speakup output, discard */
 		return;
 	speakup_date(vc);
-	if (vc->vc_mode == KD_GRAPHICS && !spk_paused && spk_str_pause[0])
-	{
+	if (vc->vc_mode == KD_GRAPHICS && !spk_paused && spk_str_pause[0]) {
 		synth_printf("%s", spk_str_pause);
 		spk_paused = 1;
 	}
