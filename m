Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+h+ZyLf/h6ONvQ2ZVhHzX2LMBfxUuJtugFo1wfH+kPhAii93zv6xhrp+R2v4Rj5uMMgqCi
ARC-Seal: i=1; a=rsa-sha256; t=1522168376; cv=none;
        d=google.com; s=arc-20160816;
        b=Mwg5EqpM5o37udmd/rDZMbfhtgVhGtfQLqRlH57LHe2040K0W3CWc8RJ9JJBNPkdBk
         xtcJ1tNPZCDQxrUcv4aJup+PDjOSwJSDznEuq9h6p5ng6ZKv1rh6TTN4TXO8WZ5YgEZn
         J6HheGnjvmI07GZGNiGjk4a7GPuwz9eOflWlny3wa3jQmb4c9blDVvHgcwH+kKRssS2E
         LAERLWS40ly43hngugVWuh0mabscH3rJpHDWIojZy2CZsoT0lqlXnCLRlINljcHXwvEc
         Tn7Cp7edQOd1uqurqNSlyaHBtHo4vj7dIhxzU4E7xBkDSZgc1sB4Ab6FbN/mhmtRu1uS
         +IGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Hc9yVx5zjj0VaSw63jKx/T0JEds7ojKgyNoC3CdLqsY=;
        b=LzwAFJsO2aKk1kp5BNHzORdhHqUMp/nq+gtmepxx1JtlnzqZhGf9JMwsoI1v9y0bQp
         r8yKDEVFNBjTDsbZC4L/moRSf/a6JrTA8J7JSk2BIvkDCs9LopYHrOoMdqYwwmz0XyDF
         FMGPsaR34BO49y2w5hvQyGPFLhB+Chmdzex7oG3NIs92DUWXURokTLxUPqDOY2xQY/xN
         v4irvC9tWxHHmMYOm3c5eaP73QD3Kw09smMvtAwoFp3+vAUamDqC5s8VWH/3qtQoM4bf
         OrYurXpy3LnqGHPwbnR7uUopjMVSdoxsf1/yyNTwMAM0GTNKKpYeQorHRbm1GGWEtklk
         LMhg==
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
Subject: [PATCH 4.9 58/67] iio: ABI: Fix name of timestamp sysfs file
Date: Tue, 27 Mar 2018 18:27:50 +0200
Message-Id: <20180327162730.791168541@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109227407003787?=
X-GMAIL-MSGID: =?utf-8?q?1596109227407003787?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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

---
 Documentation/ABI/testing/sysfs-bus-iio |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
