Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZofQ9FpfkrB1v60MavAYOadUGin5tHeoUJzvmsFZPrrp3nOCkzQu21S2vp+AetcI3XcnUoI
ARC-Seal: i=1; a=rsa-sha256; t=1525116504; cv=none;
        d=google.com; s=arc-20160816;
        b=Uo5rJ5wwgWzCAQCdqBzZXpcx+gUZLxJ6h1mugkgCwv8iytf5aJq57tUqANZ+hsqjyh
         t3JkRi18YWqVb45Np2ufw0GUiepfGQNdnFmKzzWMv3FLfMO0L59WkyrNmjy475YFlZ5x
         UpJGLu8YicBlUnDXLne9fycl1YKJpJuyggDegcqOBfN6FIVufm0oxhvKHhM/hKGLrZla
         WNkTX8HDDXiKCdjd0HotvAKeqmp0n3jq7p1OhzJdPEqAgslkvgHQuyrC5ibqMxezMT4e
         RzcdLh6zsTssXZhPPsl8JN5LAeeEK0ZoKaW0E3rpr7GM+tiZKxqGYuzeA02VIcaWUwY2
         H2tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=Rusb5ksCH7tsm6/tpn7CnG5/RRb/Sk3+TnZj6dLDRlU=;
        b=Y9+pdDkVp2WV5hmvjr4l+kI6cwHvaN2J4B3MR4vV1GQu30ppNOAaWK8v8FLedhrP+5
         zhy/YgJQTNH8aTCRU26GXzZywQnoV1N14N3QYAHbxgCI0S2fjJYDnLbYCTofCBN/zF5M
         6enY0PV2LBIMdSnjIBxMxoaOrc8i0dcDCGJe9dvEkYA44mW1AyEwq0xFmsobuigaqCCP
         HzWySIP4T/IMrmeN8I3hHva6X2vYPwrlo2R4mWm+fpis6sr6aXi+2GjJJMpPUA5DRXDr
         XA+qdkJEgiJ3LnFVOSSrEEPuqMnRKFIn2Pr4AhDOuTXeRQCJCEMqAIod/0ST2OGuycce
         lHzw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EAE522DC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>,
	syzbot+209c0f67f99fec8eb14b@syzkaller.appspotmail.com,
	syzbot+7fb6d9525a4528104e05@syzkaller.appspotmail.com,
	syzbot+2e63711063e2d8f9ea27@syzkaller.appspotmail.com,
	syzbot+de73361ee4971b6e6f75@syzkaller.appspotmail.com
Subject: [PATCH 4.16 060/113] kobject: dont use WARN for registration failures
Date: Mon, 30 Apr 2018 12:24:31 -0700
Message-Id: <20180430184017.590388497@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200285796531709?=
X-GMAIL-MSGID: =?utf-8?q?1599200564116476216?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Vyukov <dvyukov@google.com>

commit 3e14c6abbfb5c94506edda9d8e2c145d79375798 upstream.

This WARNING proved to be noisy. The function still returns an error
and callers should handle it. That's how most of kernel code works.
Downgrade the WARNING to pr_err() and leave WARNINGs for kernel bugs.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Reported-by: syzbot+209c0f67f99fec8eb14b@syzkaller.appspotmail.com
Reported-by: syzbot+7fb6d9525a4528104e05@syzkaller.appspotmail.com
Reported-by: syzbot+2e63711063e2d8f9ea27@syzkaller.appspotmail.com
Reported-by: syzbot+de73361ee4971b6e6f75@syzkaller.appspotmail.com
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/kobject.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -232,14 +232,12 @@ static int kobject_add_internal(struct k
 
 		/* be noisy on error issues */
 		if (error == -EEXIST)
-			WARN(1, "%s failed for %s with "
-			     "-EEXIST, don't try to register things with "
-			     "the same name in the same directory.\n",
-			     __func__, kobject_name(kobj));
+			pr_err("%s failed for %s with -EEXIST, don't try to register things with the same name in the same directory.\n",
+			       __func__, kobject_name(kobj));
 		else
-			WARN(1, "%s failed for %s (error: %d parent: %s)\n",
-			     __func__, kobject_name(kobj), error,
-			     parent ? kobject_name(parent) : "'none'");
+			pr_err("%s failed for %s (error: %d parent: %s)\n",
+			       __func__, kobject_name(kobj), error,
+			       parent ? kobject_name(parent) : "'none'");
 	} else
 		kobj->state_in_sysfs = 1;
 
