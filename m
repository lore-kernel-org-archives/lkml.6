Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0D7C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B7420672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42B7420672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbeLJThs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:37:48 -0500
Received: from smtprelay0039.hostedemail.com ([216.40.44.39]:48882 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729079AbeLJThr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:37:47 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 45D12181D341C;
        Mon, 10 Dec 2018 19:37:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: duck33_60cb050cb2221
X-Filterd-Recvd-Size: 5097
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Mon, 10 Dec 2018 19:37:45 +0000 (UTC)
Message-ID: <44f0a055e4085824629285e78ac4928e15c494e3.camel@perches.com>
Subject: Re: [PATCH] Input: touchscreen: ad7879: Fix ERROR: foo* bar should
 be "foo *bar"
From:   Joe Perches <joe@perches.com>
To:     Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        dmitry.torokhov@gmail.com
Cc:     michael.hennerich@analog.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 10 Dec 2018 11:37:43 -0800
In-Reply-To: <20181210154433.28319-1-hardiksingh.k@gmail.com>
References: <20181210154433.28319-1-hardiksingh.k@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-10 at 21:14 +0530, Hardik Singh Rathore wrote:
> Fix the coding style problem reported by checkpatch.pl.

While whitespace only checkpatch cleanups are generally not
well accepted, why do one pointer location cleanup when you
could them all:

$ ./scripts/checkpatch.pl -f --types=pointer_location --fix-inplace drivers/input/touchscreen/*.[ch]
$ git diff --stat -p drivers/input/touchscreen/

produces:
---
 drivers/input/touchscreen/ad7879.c   | 2 +-
 drivers/input/touchscreen/ektf2127.c | 2 +-
 drivers/input/touchscreen/gunze.c    | 4 ++--
 drivers/input/touchscreen/inexio.c   | 4 ++--
 drivers/input/touchscreen/mtouch.c   | 4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index 2aae880c8aa6..6fa714c587b4 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -289,7 +289,7 @@ static int ad7879_open(struct input_dev *input)
 	return 0;
 }
 
-static void ad7879_close(struct input_dev* input)
+static void ad7879_close(struct input_dev *input)
 {
 	struct ad7879 *ts = input_get_drvdata(input);
 
diff --git a/drivers/input/touchscreen/ektf2127.c b/drivers/input/touchscreen/ektf2127.c
index 0ed34ff787ce..28fa1b36f7a5 100644
--- a/drivers/input/touchscreen/ektf2127.c
+++ b/drivers/input/touchscreen/ektf2127.c
@@ -51,7 +51,7 @@ struct ektf2127_ts {
 	struct touchscreen_properties prop;
 };
 
-static void ektf2127_parse_coordinates(const u8* buf, unsigned int touch_count,
+static void ektf2127_parse_coordinates(const u8 *buf, unsigned int touch_count,
 				       struct input_mt_pos *touches)
 {
 	int index = 0;
diff --git a/drivers/input/touchscreen/gunze.c b/drivers/input/touchscreen/gunze.c
index 054c2537b392..56cf1a1ea3ea 100644
--- a/drivers/input/touchscreen/gunze.c
+++ b/drivers/input/touchscreen/gunze.c
@@ -53,7 +53,7 @@ struct gunze {
 	char phys[32];
 };
 
-static void gunze_process_packet(struct gunze* gunze)
+static void gunze_process_packet(struct gunze *gunze)
 {
 	struct input_dev *dev = gunze->dev;
 
@@ -72,7 +72,7 @@ static void gunze_process_packet(struct gunze* gunze)
 static irqreturn_t gunze_interrupt(struct serio *serio,
 		unsigned char data, unsigned int flags)
 {
-	struct gunze* gunze = serio_get_drvdata(serio);
+	struct gunze *gunze = serio_get_drvdata(serio);
 
 	if (data == '\r') {
 		gunze_process_packet(gunze);
diff --git a/drivers/input/touchscreen/inexio.c b/drivers/input/touchscreen/inexio.c
index b9bc56233ccc..13bd0bf580a7 100644
--- a/drivers/input/touchscreen/inexio.c
+++ b/drivers/input/touchscreen/inexio.c
@@ -79,7 +79,7 @@ static void inexio_process_data(struct inexio *pinexio)
 static irqreturn_t inexio_interrupt(struct serio *serio,
 		unsigned char data, unsigned int flags)
 {
-	struct inexio* pinexio = serio_get_drvdata(serio);
+	struct inexio *pinexio = serio_get_drvdata(serio);
 
 	pinexio->data[pinexio->idx] = data;
 
@@ -97,7 +97,7 @@ static irqreturn_t inexio_interrupt(struct serio *serio,
 
 static void inexio_disconnect(struct serio *serio)
 {
-	struct inexio* pinexio = serio_get_drvdata(serio);
+	struct inexio *pinexio = serio_get_drvdata(serio);
 
 	input_get_device(pinexio->dev);
 	input_unregister_device(pinexio->dev);
diff --git a/drivers/input/touchscreen/mtouch.c b/drivers/input/touchscreen/mtouch.c
index a3707fad4d1c..8278a9058640 100644
--- a/drivers/input/touchscreen/mtouch.c
+++ b/drivers/input/touchscreen/mtouch.c
@@ -90,7 +90,7 @@ static void mtouch_process_response(struct mtouch *mtouch)
 static irqreturn_t mtouch_interrupt(struct serio *serio,
 		unsigned char data, unsigned int flags)
 {
-	struct mtouch* mtouch = serio_get_drvdata(serio);
+	struct mtouch *mtouch = serio_get_drvdata(serio);
 
 	mtouch->data[mtouch->idx] = data;
 
@@ -110,7 +110,7 @@ static irqreturn_t mtouch_interrupt(struct serio *serio,
 
 static void mtouch_disconnect(struct serio *serio)
 {
-	struct mtouch* mtouch = serio_get_drvdata(serio);
+	struct mtouch *mtouch = serio_get_drvdata(serio);
 
 	input_get_device(mtouch->dev);
 	input_unregister_device(mtouch->dev);


