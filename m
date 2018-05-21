Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZofG+kuyO6xl+qHye31IjwJDcS/H7ZTfZAitj9dlyK3dD71Zj0Q0+QFURpEtKIbTIJRl0gQ
ARC-Seal: i=1; a=rsa-sha256; t=1526937477; cv=none;
        d=google.com; s=arc-20160816;
        b=egCIakiBXB7YTm+vnc4MnriD8weBqxJHgsVjhuAVlNN0vORRxlLnNrEGzOLBE+mqds
         s44vHsuhpRPQurmZ9yKwbR79h52NoSzkiunr8Apoz518DCD/U/nNWJ6ykYrO+kRFgvwc
         bjF99UoqPkqtiG4IL+eKJz95UeJRtYzKLdGqhB8bHE4NSJExgjaxZUuBmZ962/LtXIxC
         Rukcep4wOY1tX3bBlqTHminiV5MPsNwB879UN29/6gsVzr9sjbpdZHuNC7+Ba+QZLyhi
         SaByRKkZZgdaHDM4cRc9r69Rp8tUG9o4QCW86SnWNxlB4J0EDeOTRAjZWg+68zcJxwTq
         vKjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=3AaWYplcBTtCWpfffcCuNFvd3n+31NsuYJKV7/HGZUE=;
        b=RLjuBT2G2Q4KKMptg4/I561eZFskwEHf9MF+hwUWXyhxH4pkfKViJKiV55lak3U0jU
         VnWLtQ6aRdFzYUMpJU2TZZVVcBF3fkHcukOBnqo/hyleMW0lFok0roMylkr1/hP9e1TZ
         hk49uW6VA6B5Wk5LB6Ku1wAFSQ7LsI+segajC1GIYaDnVJQmccRNNHITApW8I0aoraIj
         jEXVdwVYuYfObC/0aTc24s6FxP3vNEh/470CvJyp+hlezmEkudlKdToHngfqwujCTsRU
         ifgs1WGMZQsHeWU8i+XZWcrA9Pu6vVZm8i70pdW+FRTuPzeleIfC4LEbs2hFNirFI6Au
         JuUw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=rF/8q3dX;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=rF/8q3dX;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 4.14 01/95] usbip: usbip_host: refine probe and disconnect debug msgs to be useful
Date: Mon, 21 May 2018 23:10:51 +0200
Message-Id: <20180521210447.506167817@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109741112049597?=
X-GMAIL-MSGID: =?utf-8?q?1601109992761026804?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan <shuahkh@osg.samsung.com>

commit 28b68acc4a88dcf91fd1dcf2577371dc9bf574cc upstream.

Refine probe and disconnect debug msgs to be useful and say what is
in progress.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/usbip/stub_dev.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/usbip/stub_dev.c
+++ b/drivers/usb/usbip/stub_dev.c
@@ -316,7 +316,7 @@ static int stub_probe(struct usb_device
 	struct bus_id_priv *busid_priv;
 	int rc;
 
-	dev_dbg(&udev->dev, "Enter\n");
+	dev_dbg(&udev->dev, "Enter probe\n");
 
 	/* check we should claim or not by busid_table */
 	busid_priv = get_busid_priv(udev_busid);
@@ -418,7 +418,7 @@ static void stub_disconnect(struct usb_d
 	struct bus_id_priv *busid_priv;
 	int rc;
 
-	dev_dbg(&udev->dev, "Enter\n");
+	dev_dbg(&udev->dev, "Enter disconnect\n");
 
 	busid_priv = get_busid_priv(udev_busid);
 	if (!busid_priv) {
