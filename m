Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49mdcxNBQtUwgnbyfOtFKaZ39vlC0AlcUaMD9meg6xzRYzP2hWIQpDabZ2UaY8U9+9dvVrz
ARC-Seal: i=1; a=rsa-sha256; t=1522168979; cv=none;
        d=google.com; s=arc-20160816;
        b=M9J0p+WmcCm54PomCmYczZAZkD4DddiKBtdzUI5SLd5pgPDYQRZgQYHPn6zrvVtOM1
         zLnA5tWaHLLX7zLSy2lxLccSzJIQnjdiUzsivxSYguPXDlxDfJrH51dj3TgTDLgC0CUB
         KlX8E86O5hdq6KPhTqYGMF4bV+pm6jm0yGUa3y11QsrSQH8mnnT4hDyhuhMILD2X9IkU
         yG8iJHdLrkU7a5hDcYt7ixQpvdfzgWcu50p75QCvnmqKFOeUFWi/Jr/4ZhRdlUKEmWWf
         a4pXzDEnmkVXTrBjqqJ0XxaBF4rUamk6zqXWdSRt117mgYV/gnkn9dTW6DUUirSVzSuD
         1lPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=hmOjPdDen0aPcTQQXRmK70lWkKhm89ORqYKz6zEBJUw=;
        b=VYmKBk4Uhmv60G7uTHVifN6MKDYZO+w3u9TokDpoWnRxAh2ogn5d/mdZBbfHS7epgU
         gG1tTGUlcyPLBktf9fpgjUfpouDbS3rpfv9oS5RJXUOdoTcDlK6o7x1uBKxngwVckbfj
         4/4+9HhJ6pYAunJLBtZ6xyVXjTCJ9SeQMLun0HxQBtfGp6F2g/rVS3C6/6C/CldARYCs
         3gnu6VgFxtGPQR4WT9LTLMHhSCtN0Lq9wuIOEa2EqMrgaYsxv3Pgo/e8lmE+ylsUZX+i
         98lVJHb2HzMkKXbUKdU3GDEdLqkNPkOnCcj5SUcdp7BKNhRlC4oNUOewWkjSh0XHUDpR
         4F4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Gregor Boirie <gregor.boirie@parrot.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.15 099/105] iio: ABI: Fix name of timestamp sysfs file
Date: Tue, 27 Mar 2018 18:28:19 +0200
Message-Id: <20180327162804.041480247@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109227407003787?=
X-GMAIL-MSGID: =?utf-8?q?1596109859722152027?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Walleij <linus.walleij@linaro.org>

commit b9a3589332c2a25fb7edad25a26fcaada3209126 upstream.

The name of the file is "current_timetamp_clock" not
"timestamp_clock".

Fixes: bc2b7dab629a ("iio:core: timestamping clock selection support")
Cc: Gregor Boirie <gregor.boirie@parrot.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 9cc0ea1c0273..6a5f34b4d5b9 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -32,7 +32,7 @@ Description:
 		Description of the physical chip / device for device X.
 		Typically a part number.
 
-What:		/sys/bus/iio/devices/iio:deviceX/timestamp_clock
+What:		/sys/bus/iio/devices/iio:deviceX/current_timestamp_clock
 KernelVersion:	4.5
 Contact:	linux-iio@vger.kernel.org
 Description:
