Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932343AbeCLPBO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 11:01:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33052 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751613AbeCLPBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 11:01:11 -0400
From: Colin King <colin.king@canonical.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] echoaudio: remove redundant initialization of pointer 'pipe'
Date: Mon, 12 Mar 2018 15:01:00 +0000
Message-Id: <20180312150100.8089-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointer 'pipe' is being initialized with a value that is never
read and it is re-assigned later, hence the initialization is redundant
and can be removed. Also remove pointer 'runtime' as it is no longer
required.

Cleans up clang warning:
sound/pci/echoaudio/echoaudio.c:740:20: warning: Value stored to 'pipe'
during its initialization is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/echoaudio/echoaudio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index d68f99e076a8..0935a5c8741f 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -736,8 +736,7 @@ static int pcm_prepare(struct snd_pcm_substream *substream)
 static int pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct echoaudio *chip = snd_pcm_substream_chip(substream);
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct audiopipe *pipe = runtime->private_data;
+	struct audiopipe *pipe;
 	int i, err;
 	u32 channelmask = 0;
 	struct snd_pcm_substream *s;
-- 
2.15.1
