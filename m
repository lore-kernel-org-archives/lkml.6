Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49SfC3iI9akEt0PqwT5O908Zhx5sb8G8RuBHjZA8vBOrYvMbuS4718o+nMWmG0zkFkVEQKu
ARC-Seal: i=1; a=rsa-sha256; t=1524405307; cv=none;
        d=google.com; s=arc-20160816;
        b=fKov2ykeW4HhRRRBe0ytDBwuQMogYvK59SgzR+t0fxpvf8P87fk73I/gaqItBsgs8G
         CwXq0lgyejioNIxbRHyEGtJStthEgQJmsVT0Y149T8+QhZMqzVeGbOX0egaYX7fbdkaP
         bmYw1MqCmMNtWHkbPyNZPoQDktZAHaUH4Wg0RZL7FiqD6Sc9k0y6y7JQDY+lmqHEl7Fn
         xcUqaWlpzFxWKAXhZmUVTEgiV/FUNsIIT6Oh1/B+RoKXEL4QsLGrPL4D2rv9uN8AzKSs
         QsykkytDhXlPpfhPa2VcfEaLG6plndjdoDSxc4VL6XrlBvujyL8rGzOaou43nOX6UHmT
         Pu9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CnHSD0zYetGk6lnbZQnDBgQC9rEnOKayUYxan4TDHoQ=;
        b=ZHQvZrzorWXPlrlwZv0Nk6XIugMF1TGggmgmD7NpqITnmaoTojwDontWQdp5t/O8nB
         qJNqiRkM2uLq8+NI6uEO3TTvthr6pKTJbjc44kdmJXYP1uG7sC1wwk67gKJQBmEW4eGY
         xXBvUzgfL7Ne5YIbaue+IhNWAsdZH/lFsKFQH96djEFM8wMcH0jqnxHpdrYIRY/lILZl
         xwClcF+MnWx5xlpeP6mxf3f6NSJjqvhgeDO26X0NStu9t9WusAvCY4DRLxFpEdoQHj20
         9A1R/krGB+QouCRU5K1HEVs88sWGXUYYGl88wpPSATfBhfIKXrg8lMZMx/95sU+JkVmo
         +HhQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.16 019/196] usb: gadget: udc: core: update usb_ep_queue() documentation
Date: Sun, 22 Apr 2018 15:50:39 +0200
Message-Id: <20180422135105.122012819@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454819260149051?=
X-GMAIL-MSGID: =?utf-8?q?1598454819260149051?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felipe Balbi <felipe.balbi@linux.intel.com>

commit eaa358c7790338d83bb6a31258bdc077de120414 upstream.

Mention that ->complete() should never be called from within
usb_ep_queue().

Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/udc/core.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -238,6 +238,9 @@ EXPORT_SYMBOL_GPL(usb_ep_free_request);
  * arranges to poll once per interval, and the gadget driver usually will
  * have queued some data to transfer at that time.
  *
+ * Note that @req's ->complete() callback must never be called from
+ * within usb_ep_queue() as that can create deadlock situations.
+ *
  * Returns zero, or a negative error code.  Endpoints that are not enabled
  * report errors; errors will also be
  * reported when the usb peripheral is disconnected.
