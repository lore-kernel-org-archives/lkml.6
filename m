Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+rTk3SSogsUY7JwYQB0FMQPvcSxrNdJb52eOZr8SpqavLw3azbSpWIkGAHVXcnXrNONK9I
ARC-Seal: i=1; a=rsa-sha256; t=1524405873; cv=none;
        d=google.com; s=arc-20160816;
        b=atG6IsLU02FBDknq2IPWWtvPssgK7aBSUn2irz/ACNwFTC88gr28fQGWJ3CqfihY7P
         xECgSrxaRgXNPsy1cH4fxE1dc8N4zLdbeWk6008lCD23PvMve6UPJ5UnEE0qpUPw8c18
         O8dbNinCyJGCkOZ9x4rYftrkeVrYTsBp2tojLZyIx/OqfTW4OLlRvdDb0qgrEvsoYbZe
         EfNtLijU8NpXzgcaoX1/EuF+eXFmKEN1zC7iuR/cf4vJqAUCBW0PghfLO7dce0Z3wgQq
         dHc64tAuPPTpmHomjUDtCn0mifuWMk/xEJBGwLP2rhFOHbBksaKJHT4x9Nq7z6x+f2Z3
         w+7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yg/aR3SEh4mT3HqfD9wHVLz3SpjK1yPharqZVqkPWfk=;
        b=1K5KcPEmnl/mIU7ZGgrlpMtgzx/rwZXFVBcgA/rfMQRn6r34JzDPM3iA4G3ozfAQ7g
         fp3NkJ+Dr7S2SwP6zG5p9Rz8pvZxKQmaUjYlTuw3YyjnruF7lwvfXZt8+8SjzIahBnYm
         bY3bOvKbnZxHkpd31FIPPD4d3ttTZCzVU9q1t8UuN4VwuPPVHeM/ot8/cUbudTXoNpD5
         Jn/BaabDChepp2QAS79K4xMrLZH87L2ayXy2oflmoZnjsvg5LE/FnZgFL3N2Lx91591P
         FCTdK9R8tfNnNkMtBEADiUMC1Ivy6MLzJpY2tYKlZ7xvNy90is5Z/9nd0c1awJTZlLmK
         NPTg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.14 029/164] media: atomisp_fops.c: disable atomisp_compat_ioctl32
Date: Sun, 22 Apr 2018 15:51:36 +0200
Message-Id: <20180422135136.597970452@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454857064706845?=
X-GMAIL-MSGID: =?utf-8?q?1598455412924693638?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hverkuil@xs4all.nl>

commit 57e6b6f2303e596a6493078b53be14b789e7b79f upstream.

The atomisp_compat_ioctl32() code has problems. This patch disables the
compat_ioctl32 support until those issues have been fixed.

Contact Sakari or me for more details.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Cc: <stable@vger.kernel.org>      # for v4.12 and up
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/media/atomisp/pci/atomisp2/atomisp_fops.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/staging/media/atomisp/pci/atomisp2/atomisp_fops.c
+++ b/drivers/staging/media/atomisp/pci/atomisp2/atomisp_fops.c
@@ -1285,7 +1285,10 @@ const struct v4l2_file_operations atomis
 	.mmap = atomisp_mmap,
 	.unlocked_ioctl = video_ioctl2,
 #ifdef CONFIG_COMPAT
+	/*
+	 * There are problems with this code. Disable this for now.
 	.compat_ioctl32 = atomisp_compat_ioctl32,
+	 */
 #endif
 	.poll = atomisp_poll,
 };
@@ -1297,7 +1300,10 @@ const struct v4l2_file_operations atomis
 	.mmap = atomisp_file_mmap,
 	.unlocked_ioctl = video_ioctl2,
 #ifdef CONFIG_COMPAT
+	/*
+	 * There are problems with this code. Disable this for now.
 	.compat_ioctl32 = atomisp_compat_ioctl32,
+	 */
 #endif
 	.poll = atomisp_poll,
 };
