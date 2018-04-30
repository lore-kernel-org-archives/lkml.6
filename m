Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqiieGfOodOMUZjcNijsKSplAZoajNbmuA/5WYKwKV3gGGg8XSmN6LMJsvYxhcbSseMWTeN
ARC-Seal: i=1; a=rsa-sha256; t=1525116425; cv=none;
        d=google.com; s=arc-20160816;
        b=XWVo4OS2e64pXlrDDu1V1RTSKmi9LV8IvfXo9ZVJQ5P2HewI4x0KBH07cDilB4kavz
         j3e+XdWOM7V5+TScs/a8Vo0cQOamlBVCG7nIWmWLzoag9mkDmLEGF0XR1Py1AORtlL23
         RPPkuFvr2ga6t6QfYwJmNs8iKVeUZitu9PcdLuN8SFBgS+zmdI09TYtwz/0ttCfZJtQw
         a8fsl/K01wcAx47gmu6cq4yuBMMkiazxbMAYQrtvG8oLpKP3pnqzuCuhtskLEZHyml4y
         2XmYha+UPiRgsytjWyt/7AuAYH73b6K9/twEe72AnDp0Ktxu14gMF2b8yXkluko0ODWs
         CL/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=ofyjRU3sihpGLbPzGxLXjb5WpdEPCr0v8mnKGP0Lxus=;
        b=u07AaTFX/ou74b/XKb8ggxVSRAG+V8sobN9fOADehoXQYpI0wsAK9qAIKMFe834mnt
         lzOncOt+gKv+KaYbXn0KoHpsnv9F982bpekTc4/nEY4V7JUHlp8/FRy6YPT65AJiTJrB
         N813dQ0JMUh8Dru68efFQ77PRZzqQe0JCxkHhXkuFRrraYX11s+G0vgcAp26mnjNm6MS
         cxy/Sx7pQUQnRNt6laLYbptRnsVr4z++ynvtSnWGGgcvcfqu4UzHdurJ4ekfrEEu7aKn
         o0UdfCfaV5SmK9+psMbCdxOA8J1DVCx6cGd5VJjg/lAYepF3MfloXedg1wOK3lUPWsPV
         Dshw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DFE822DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Fran=C3=A7ois=20Valenduc?= <francoisvalenduc@gmail.com>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.14 03/91] ext4: add MODULE_SOFTDEP to ensure crc32c is included in the initramfs
Date: Mon, 30 Apr 2018 12:23:45 -0700
Message-Id: <20180430184004.399963244@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200544892175194?=
X-GMAIL-MSGID: =?utf-8?q?1599200480885109741?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 7ef79ad52136712172eb0525bf0b462516bf2f93 upstream.

Fixes: a45403b51582 ("ext4: always initialize the crc32c checksum driver")
Reported-by: François Valenduc <francoisvalenduc@gmail.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/super.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5865,5 +5865,6 @@ static void __exit ext4_exit_fs(void)
 MODULE_AUTHOR("Remy Card, Stephen Tweedie, Andrew Morton, Andreas Dilger, Theodore Ts'o and others");
 MODULE_DESCRIPTION("Fourth Extended Filesystem");
 MODULE_LICENSE("GPL");
+MODULE_SOFTDEP("pre: crc32c");
 module_init(ext4_init_fs)
 module_exit(ext4_exit_fs)
