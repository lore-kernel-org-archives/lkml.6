Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49cvPGeiBrj2tQvIDiCe4CzTTXgHoZwMlyiHXs7nXqQZjKe5uEJzbmb6ANwKAn5nx8OD5jc
ARC-Seal: i=1; a=rsa-sha256; t=1522168676; cv=none;
        d=google.com; s=arc-20160816;
        b=caVQypB/Iu9qEBeiuo2SFWJd/dMXzNGte4VCfqoPa5TVa+xTJKbKu3IL/I3fhOQ+vs
         ydiRsmjPqqLuYaTwDY6CgUvrxg6tPIZKe1jJiAHO6l3qTIUj/CF4HDfWOz2WBtV1S7Kx
         Xr4RshBT/f8XwtqzXqWuYXzKRDSX3DVFz3HM3eeon3rVcieizEMHv/iZlehqQ5VguTpd
         3Mv5oJnS7qgt6yl+sMs55vmZivANcqw6heDlu+d60ucoKkEpLJlPRsoS9U6PgyqGQvOb
         LVzengFyd4itbACIkmvHHRi+ykYgUV5Q/SuoH5KcGrqPCYagnJEFRhgz4JxxsOJkImVH
         INSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jGwLanNFB2Z5QKqGzj5uFrTSWGyukd3LbvFkyD+4tEs=;
        b=VyAJ0Bn2PLmbjzyMj682LP+C8ICo68/zOkxq3VjYLE333DR5KT5lmERwjYiKZ56Mz5
         /zsJZcZqBji9aQq05WWkD2zFBvPUP1WFkeFaUMDKrbdtOSzeVPZs8QqtDYKJ1y0m54Ly
         KLimwgQfVhTpgWsVmP3m53ozOqJUTykajRQ2yQlmaQyA4G0ER+RgSoTUzlJw7j9xl4BC
         BUESieZwzK+TpGqpfW5G3eIz7372/ACE67NfQRk8m1p0kGYPqjcRqy7e+jIoNfXDb7oP
         Hy2SVqKLcdIDemKfPBiwF3Q8lW99wf526cN9zHkFLJKnZN6vhB6Zp3kTw39+yTxZgKF/
         3EVg==
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
Subject: [PATCH 4.14 092/101] iio: ABI: Fix name of timestamp sysfs file
Date: Tue, 27 Mar 2018 18:28:04 +0200
Message-Id: <20180327162755.674564278@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109227407003787?=
X-GMAIL-MSGID: =?utf-8?q?1596109542691481780?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
