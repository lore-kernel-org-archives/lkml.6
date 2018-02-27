Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753386AbeB0NrN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 08:47:13 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:44487 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753171AbeB0NrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 08:47:11 -0500
X-Google-Smtp-Source: AG47ELvQ0gK95k4zNXpBUxzlFj6zvFtB2JaxsSgll4GX0tzKpOgmd51CtYPf+7fF1YaLavR31LR1Lg==
Date: Tue, 27 Feb 2018 10:47:06 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: daniel.baluta@nxp.com, kernel-janitors@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] iio:dummy: Add extra paragraphs on Kconfig
Message-ID: <7cfd9fd93e76fede44d328045e7885cd78324a78.1519738995.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1519738995.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1519738995.git.rodrigosiqueiramelo@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warning:

drivers/iio/dummy/Kconfig:21: WARNING: please write a paragraph that
describes the config symbol fully
drivers/iio/dummy/Kconfig:27: WARNING: please write a paragraph that
describes the config symbol fully

This patch expands the explanation about IIO_DUMMY_EVGEN by using the
code documentation found in iio/dummy/iio_dummy_evgen.c. In the same
way, the information related to IIO_SIMPLE_DUMMY_BUFFER was extracted
from file iio_simple_dummy_buffer.c.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/iio/dummy/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/dummy/Kconfig b/drivers/iio/dummy/Kconfig
index 85e13b2e35bf..c4fd108e91d3 100644
--- a/drivers/iio/dummy/Kconfig
+++ b/drivers/iio/dummy/Kconfig
@@ -24,6 +24,10 @@ config IIO_SIMPLE_DUMMY_EVENTS
 	help
 	  Add some dummy events to the simple dummy driver.
 
+	  The purpose of this is to generate 'fake' event interrupts thus
+	  allowing that driver's code to be as close as possible to that
+	  a normal driver talking to hardware.
+
 config IIO_SIMPLE_DUMMY_BUFFER
 	bool "Buffered capture support"
 	select IIO_BUFFER
@@ -32,6 +36,9 @@ config IIO_SIMPLE_DUMMY_BUFFER
 	help
 	  Add buffered data capture to the simple dummy driver.
 
+	  Buffer handling elements of industrial I/O reference driver.
+	  Uses the kfifo buffer.
+
 endif # IIO_SIMPLE_DUMMY
 
 endmenu
-- 
2.16.2
