Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752426AbeEGJi6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 05:38:58 -0400
Received: from osg.samsung.com ([64.30.133.232]:49868 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752470AbeEGJgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 05:36:07 -0400
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: [PATCH 15/18] iio: iio.h: use nested struct support on kernel-doc markup
Date: Mon,  7 May 2018 06:35:51 -0300
Message-Id: <1a31240699b1b6ee089b5b36889ab27ae14ad94e.1525684985.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1525684985.git.mchehab+samsung@kernel.org>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1525684985.git.mchehab+samsung@kernel.org>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Solve those Sphinx warnings:

    ./include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.sign' not described in 'iio_chan_spec'
    ./include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.realbits' not described in 'iio_chan_spec'
    ./include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.storagebits' not described in 'iio_chan_spec'
    ./include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.shift' not described in 'iio_chan_spec'
    ./include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.repeat' not described in 'iio_chan_spec'
    ./include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.endianness' not described in 'iio_chan_spec'

    ./include/linux/iio/iio.h:191: WARNING: Unexpected indentation.
    ./include/linux/iio/iio.h:192: WARNING: Block quote ends without a blank line; unexpected unindent.
    ./include/linux/iio/iio.h:198: WARNING: Definition list ends without a blank line; unexpected unindent.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 include/linux/iio/iio.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 11579fd4126e..a74cb177dc6f 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -183,18 +183,18 @@ struct iio_event_spec {
  * @address:		Driver specific identifier.
  * @scan_index:		Monotonic index to give ordering in scans when read
  *			from a buffer.
- * @scan_type:		sign:		's' or 'u' to specify signed or unsigned
- *			realbits:	Number of valid bits of data
- *			storagebits:	Realbits + padding
- *			shift:		Shift right by this before masking out
- *					realbits.
- *			repeat:		Number of times real/storage bits
- *					repeats. When the repeat element is
- *					more than 1, then the type element in
- *					sysfs will show a repeat value.
- *					Otherwise, the number of repetitions is
- *					omitted.
- *			endianness:	little or big endian
+ * @scan_type:		struct describing the scan type
+ * @scan_type.sign:		's' or 'u' to specify signed or unsigned
+ * @scan_type.realbits:		Number of valid bits of data
+ * @scan_type.storagebits:	Realbits + padding
+ * @scan_type.shift:		Shift right by this before masking out
+ *				realbits.
+ * @scan_type.repeat:		Number of times real/storage bits repeats.
+ *				When the repeat element is more than 1, then
+ *				the type element in sysfs will show a repeat
+ *				value. Otherwise, the number of repetitions
+ *				is omitted.
+ * @scan_type.endianness:	little or big endian
  * @info_mask_separate: What information is to be exported that is specific to
  *			this channel.
  * @info_mask_separate_available: What availability information is to be
-- 
2.17.0
