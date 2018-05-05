Return-Path: <mathieu.malaterre@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525550270; cv=none;
        d=google.com; s=arc-20160816;
        b=XyonVubNQzG5h0xKVpVa9qHHFElBQnrwx1KSBhTS7BM+sSe7MeZgzHYwhdarln2azo
         Z5ZRjqy/xC85eeTuOuCJWXjDHLFjAbMnZL8mV8lE/uhbQAefIAe5SEI4dvsE+OQc1aFc
         Wt2HeaLQxjGX+yOApv8ImhGksZDNfPY8/p6qFllqo8ggZiBOJkSxiZ4ol32itKWEOfby
         zaJO8JbEik0qN4ltZLEjPhA9CkpA69PnxtCmZfTifu452n/4A4kLmqu6wYkH5VdotaSX
         8vnva/bmnPm1tVDMtatAaVR+rf+mKfXTMFKDWGoQ+jWkum8jP2x0s/Jrt2ITk8+PbxZ8
         95OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:dkim-signature:arc-authentication-results;
        bh=ndilg4LX07DATdZlPDKt1QqgPkFBxofIMjkIPfmfX94=;
        b=odfewKCCd1aAlKTbO9v/ecURcfXsFgE4mevaWVmz24MvipjhEre8cLJvWkEOzUrTAf
         FJoHfsDJO67lnn0GaXchEPJAR24SIRNgf6y2x9OmrVzwW6hNU/TV0Z1ToFsNtpvBLDUQ
         0CUU1h2ufr8emZfAvzlG6TKdQJGwekoekuYgfL1rjWfbI5bTNcC6zWBpyweZMuqORalH
         ynGGySzBZaQ5BoiBKuHTKRz818yfv4MMdZUKWB+IbSYl8x7AetaHzJM8dgQXHd+P0744
         G2GGf9x40Ed06gL+GJ9snkKxhKJzCXc/JzGK1FduB2O93yzSeheR8xo867+DGdynwW3d
         IBGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mTaWBPZp;
       spf=pass (google.com: domain of mathieu.malaterre@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mathieu.malaterre@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mTaWBPZp;
       spf=pass (google.com: domain of mathieu.malaterre@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mathieu.malaterre@gmail.com
X-Google-Smtp-Source: AB8JxZp0GLZaQKhOCT7alkkj0DFE2AXb9eQmCbXc4RVs1jyJosJ7o+3cy/xAgd/bgv6oCugWd2Y0aw==
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mathieu Malaterre <malat@debian.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] driver core: add __printf verification to device_create_groups_vargs
Date: Sat,  5 May 2018 21:57:41 +0200
Message-Id: <20180505195741.16617-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599655400415939492?=
X-GMAIL-MSGID: =?utf-8?q?1599655400415939492?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

__printf is useful to verify format and arguments. Remove the following
warning (with W=1):

  drivers/base/core.c:2435:2: warning: function might be possible candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/base/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index b610816eb887..357e774ba13b 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2406,7 +2406,7 @@ static void device_create_release(struct device *dev)
 	kfree(dev);
 }
 
-static struct device *
+static __printf(6, 0) struct device *
 device_create_groups_vargs(struct class *class, struct device *parent,
 			   dev_t devt, void *drvdata,
 			   const struct attribute_group **groups,
-- 
2.11.0
