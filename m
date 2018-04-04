Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/h6Ud5fnA03/g75WXAz2vGJ8Fml30JJBdB99Qbmtuvz00DkzMxuisC9z2XytN8RgKNdBo0
ARC-Seal: i=1; a=rsa-sha256; t=1522855967; cv=none;
        d=google.com; s=arc-20160816;
        b=tPsUFZNQmYIHTL3KEDRlBH/sCbY86uQO716p5KvLqWmk2Kys4ke1kxSV6VwFyn32tW
         BDhpm+BaIQHGC0+HyPuddmqUwkYMyqOT8xihmF5E2A1Xi3Ng3Q7K//PcypoyJ6X3wrI4
         MjReTfXiSjIDDfkp1TsOcVTeDyPiN8tNiWPjp7jO+ngYGrU7kQnhfIbfaljhRXkr8Iss
         ZFowWFYsFFKX/tFVm/33DrUSFn5TpWqujwJ1G1P1oUoomKazYyB1qOFm9qfmGYejYFff
         7Tn0vh6GVR2M/C/M4WFln4ddR5VOaFeHS97VPDyxdlS4Qqnv3yQIegzihcpx2uTaXta0
         +HnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :from:cc:to:subject:arc-authentication-results;
        bh=CJK64OxA4FTxwygf18JqqmWeN2Hfyj6Oi8yAAzy2qDc=;
        b=q2HMadWYc+L5OcIl1SscEaWHKa4gZkT/NfNBDTu8DEdbBBuOAVWdmppueh/Ai19oye
         7pdxMmfM+wasRaUWkKwFLuhZ6cjHdJcxpz/uWrGkBNWobVjFTBS+VgFmQuXL5Reg9/aV
         KNV7MGjaIbDKbpCVaKXcQKdFGbAUlMP6huESAfnZs3iwQLxQb/mnkTWH1JuFiJ6W70TJ
         828GXRm41nKkXRdVVg3tdE6JTjtMkp+MlU0U5ZaNtYHVrhSPDz80epYdAZplMvtlKxYV
         jvDu0wITGmXfMElQGbCAQPS9lZLU1ITLFfHhD9N75zVzoITVQ8eQTx+x55zn+nh7qR8D
         op5w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Subject: Patch "media: v4l2-compat-ioctl32: use compat_u64 for video standard" has been added to the 3.18-stable tree
To: mchehab@s-opensource.com,gregkh@linuxfoundation.org,linux-kernel@vger.kernel.org,linux-media@vger.kernel.org,mchehab@infradead.org
Cc: <stable@vger.kernel.org>, <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Apr 2018 17:32:41 +0200
In-Reply-To: <2ba9505436180b463d47d6da4ce5e059b383938e.1522260310.git.mchehab@s-opensource.com>
Message-ID: <152285596114471@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596830218508661830?=
X-GMAIL-MSGID: =?utf-8?q?1596830218508661830?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


This is a note to let you know that I've just added the patch titled

    media: v4l2-compat-ioctl32: use compat_u64 for video standard

to the 3.18-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     media-v4l2-compat-ioctl32-use-compat_u64-for-video-standard.patch
and it can be found in the queue-3.18 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From foo@baz Wed Apr  4 17:30:18 CEST 2018
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Date: Wed, 28 Mar 2018 15:12:36 -0300
Subject: media: v4l2-compat-ioctl32: use compat_u64 for video standard
To: Linux Media Mailing List <linux-media@vger.kernel.org>, stable@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Mauro Carvalho Chehab <mchehab@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <2ba9505436180b463d47d6da4ce5e059b383938e.1522260310.git.mchehab@s-opensource.com>

From: Mauro Carvalho Chehab <mchehab@s-opensource.com>

Instead of using the "v4l2_std_id" typedef, use compat_u64,
as otherwise it fails to properly handle some ioctls.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -686,7 +686,7 @@ struct v4l2_input32 {
 	__u32	     type;		/*  Type of input */
 	__u32	     audioset;		/*  Associated audios (bitfield) */
 	__u32        tuner;             /*  Associated tuner */
-	v4l2_std_id  std;
+	compat_u64   std;
 	__u32	     status;
 	__u32	     capabilities;
 	__u32	     reserved[3];


Patches currently in stable-queue which might be from mchehab@s-opensource.com are

queue-3.18/media-v4l2-compat-ioctl32.c-copy-m.userptr-in-put_v4l2_plane32.patch
queue-3.18/media-v4l2-compat-ioctl32.c-avoid-sizeof-type.patch
queue-3.18/media-v4l2-compat-ioctl32.c-drop-pr_info-for-unknown-buffer-type.patch
queue-3.18/media-v4l2-compat-ioctl32-use-compat_u64-for-video-standard.patch
queue-3.18/media-v4l2-compat-ioctl32.c-add-missing-vidioc_prepare_buf.patch
queue-3.18/vb2-v4l2_buf_flag_done-is-set-after-dqbuf.patch
queue-3.18/media-v4l2-compat-ioctl32.c-refactor-compat-ioctl32-logic.patch
queue-3.18/media-v4l2-ctrls-fix-sparse-warning.patch
queue-3.18/media-v4l2-compat-ioctl32.c-fix-ctrl_is_pointer.patch
queue-3.18/media-v4l2-compat-ioctl32.c-move-helper-functions-to-__get-put_v4l2_format32.patch
queue-3.18/media-media-v4l2-ctrls-volatiles-should-not-generate-ch_value.patch
queue-3.18/media-v4l2-compat-ioctl32.c-don-t-copy-back-the-result-for-certain-errors.patch
queue-3.18/media-v4l2-compat-ioctl32.c-make-ctrl_is_pointer-work-for-subdevs.patch
queue-3.18/media-v4l2-compat-ioctl32.c-fix-the-indentation.patch
queue-3.18/media-v4l2-compat-ioctl32-copy-v4l2_window-global_alpha.patch
queue-3.18/media-v4l2-ioctl.c-don-t-copy-back-the-result-for-enotty.patch
queue-3.18/media-v4l2-compat-ioctl32.c-copy-clip-list-in-put_v4l2_window32.patch
queue-3.18/media-v4l2-compat-ioctl32-initialize-a-reserved-field.patch
