Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48PxKTENbsqvVKi4iTnK1Yp5we80lOMPRcsgLHl5xf/Oh13o25qD5NQ500S4cnP3T357e2H
ARC-Seal: i=1; a=rsa-sha256; t=1524406273; cv=none;
        d=google.com; s=arc-20160816;
        b=PX1TePPcgBNK/Y5XATOU4Slw95szQOzU8bKydZOzmuyHXWevbf/WZlgl9iuM4eeAad
         OlUKJVTU+uVhVdTxdBrSrGHuMJCQqy9jBoDKUtE4qPWEaf/zmKw7N5Wf4fX2cIissAQe
         EPvWJdLZ0rA1YeQnONVylf8ry2sPtXqyds0cYV9n/m3qNFwWVyMFMosOa0cXN/5N6OU5
         /cByBTqmAX+By9hXD043KWlXnNsMiOyt77cyIx7fhYC0ZLdTGFzpqskt5zIe+yPU3b+r
         Bh7VVHky7nxwaPjG1krWwP19XST2IQwzO0CHRBoUE6kmA05Z5GRRs7WiBq9uAeFY0F8I
         ZfqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=672FQMKbF6XikzFKMx3kINkSkMQTGynqajO2c0D3FcM=;
        b=YImJq01ziOKa4kVctrj+nNPc3JjXC2tdaz2xrieYPQH9lOekQHiMI4SVAI3+b82U08
         AZawIviwFyZU/Vo4nsgDOJRqJh6Qz5xEVXT5XHmnSrdEpqlhqEwAcekx49zlzDILoTU+
         lTmbR5c1M/H1Tfsc+/bLNRVOLPGk2qUytdz7jFT/Wg6hwlmlHux1WYOgRKC9gO4s+HEG
         eUqqUSMg3WTB1OlO3Z6ouJPnXD058/0PK61/f3VlVVnt17ATQNYtLdO80V8+LqEV9qVl
         4hudaL99U2jxYLLHMUZnDEd7/66KB4Qpg3onOoCZMBM4YcFdFUcFZ/lMcA8SC6rGhfDG
         2fDg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.9 11/95] usb: gadget: udc: core: update usb_ep_queue() documentation
Date: Sun, 22 Apr 2018 15:52:40 +0200
Message-Id: <20180422135210.885025428@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454819260149051?=
X-GMAIL-MSGID: =?utf-8?q?1598455832913940297?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -248,6 +248,9 @@ EXPORT_SYMBOL_GPL(usb_ep_free_request);
  * arranges to poll once per interval, and the gadget driver usually will
  * have queued some data to transfer at that time.
  *
+ * Note that @req's ->complete() callback must never be called from
+ * within usb_ep_queue() as that can create deadlock situations.
+ *
  * Returns zero, or a negative error code.  Endpoints that are not enabled
  * report errors; errors will also be
  * reported when the usb peripheral is disconnected.
