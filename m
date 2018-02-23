Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225FdnoOzA4UGKfSwuZfQj+gSQkOLas0OnILHcz6NuzN1n8G8x2CJMzmCJIig5TbzVf5++Mn
ARC-Seal: i=1; a=rsa-sha256; t=1519411690; cv=none;
        d=google.com; s=arc-20160816;
        b=JyLx/BEWbYWSCCGxWqNGgGTHH4LCHmXzUEK5gaMnUC6MVDbFLryZWPhX8oSUVXuDCH
         ZL4ozUEXF+OQEJxvdLeUMPYR7QCJ6xV+d8K/eFd1CzgTnlG2v7X6v/iZXzPS6KYJX4fN
         frHUlw7xMfitYAIEqukaGH1oq/pCvQPk9OaWdnDvHz1GKJ+Wi9/6CdUQ8tEc+YHFpw95
         msfBhmlXhHC7TB2C0LhMGqOypmkKmFrNs0EADHFXMOLSBkyB0XCluP5NEWvrEPqmwCGF
         ocf/wQFzoI3G1bbVayWZPhuebEH7vmEw8YnYBMbLlMyroLm00pAQV2vsyaPWCckTXipv
         ovjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bQeWhqvwkrkUMBxq8HsqPv9VgT9LzBAePJ3KFFbdPvk=;
        b=ypmzY2yF49BSFUxI7uSsWcfpD5gmK/vnSnSpVH3QrmOSP5lc+xJc6ybOWMTto+dSvi
         KT51fc2Xi6tHKPKxAYpTRZsXaofl5urqAh397Iyf3wWjlFZGV/7D7Ng2gFediDGuoFrH
         +QHqhMiLbBN2ulKl8X5quc4eIYKlbzNkLAXLlcFbGxgqVGTiu9Wb/U2XNYCEQmjbljI2
         97OkRP1G4Kw7glp+0BufVwWhPUvx9sHx/cxCYMWx95HQbG78Sk0YZjOZeIRVHFU4xnlS
         k26IjBvTnz54O68NJSlNsU6IdGT+a3gzbXvMoZoPmmNY16yvQzukXpOYKWlnLE6HEbph
         IhBQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 4.9 122/145] rbd: silence bogus -Wmaybe-uninitialized warning
Date: Fri, 23 Feb 2018 19:27:08 +0100
Message-Id: <20180223170740.589869854@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218632643881712?=
X-GMAIL-MSGID: =?utf-8?q?1593218632643881712?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilya Dryomov <idryomov@gmail.com>

commit d4c2269b3d5d06a8ea434b1841fbcaec336ed396 upstream.

drivers/block/rbd.c: In function ‘rbd_watch_cb’:
drivers/block/rbd.c:3690:5: error: ‘struct_v’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
drivers/block/rbd.c:3759:5: note: ‘struct_v’ was declared here

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/rbd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3756,7 +3756,7 @@ static void rbd_watch_cb(void *arg, u64
 	struct rbd_device *rbd_dev = arg;
 	void *p = data;
 	void *const end = p + data_len;
-	u8 struct_v;
+	u8 struct_v = 0;
 	u32 len;
 	u32 notify_op;
 	int ret;
