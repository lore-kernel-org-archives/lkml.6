Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpn+pOejohBWlJ4eh52ypIBeGhLxbhppMTqNi5gw2JS1Bz8WXKM2qJYyvxw542HDBdB6sxk
ARC-Seal: i=1; a=rsa-sha256; t=1525116486; cv=none;
        d=google.com; s=arc-20160816;
        b=WQuYFaZgDHuK6UZ5LsxdB46L0uXMcF9+BmXBVuM+SldFTHHr+XchwrAHEmYwIoWDIg
         j8C3cfzjRHtpWjxFArvKYexCvezSFSCSaTHBgR/UzJjvpn97RXEXAHvc0ONkYn9dhmSr
         GoJHPjPEFikYibZIrmZuqNsMlTRA9Z9RL2Qkf7H3p5Y4i9JW0vqkl4iOMeCt6FAcfdqu
         VLT16FfG9+WO/z4D3323SGhBXkDGaF+iLCa7rH+s3g0yOiqYDUueIcrjjKEmfyFGLn8p
         lQuuAiSmsBTtE3fRiqULXImHJcaM+/LjvxQZYvmNDNvAofjyfSwGwP5Syychiy8RNk5u
         HyNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=oyqBGomcDhWqcxNPfp76h7XCLvnaAhquTRsW9qUdEak=;
        b=EY/TfXFztjsZBUpE9vfAKvsThcozycFtkddpl4h0E+nM1Kf1oOKu1Iii0brVw0FbMF
         L1THOwshPFivmhEPPFGfrHm+vHtqVqwonDE6kAncVcTiqJgcQAagrdxle+zN9HzPyouv
         sj8jfzakIbDkL62PP3JQTDq3zEETWzlaVC9yTnrlef1mzEGI7eAf7k6XtIQuQwn2VVrJ
         DOYTiKLpQxVW1gkD52WmpMtLqb5R9DdD1CG9Lk8nTdqZwgJ/k4onYvvkTMFMO6mU9a0t
         yQZRsgkXdDGv5WXdZxz74LJXPoChP3dFy3ejvqaCMV+ij6lr+HeRl6JL7AILfdfWh6ss
         3R5g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A3DB22DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Fran=C3=A7ois=20Valenduc?= <francoisvalenduc@gmail.com>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.16 003/113] ext4: add MODULE_SOFTDEP to ensure crc32c is included in the initramfs
Date: Mon, 30 Apr 2018 12:23:34 -0700
Message-Id: <20180430184015.219290940@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200544892175194?=
X-GMAIL-MSGID: =?utf-8?q?1599200544892175194?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5868,5 +5868,6 @@ static void __exit ext4_exit_fs(void)
 MODULE_AUTHOR("Remy Card, Stephen Tweedie, Andrew Morton, Andreas Dilger, Theodore Ts'o and others");
 MODULE_DESCRIPTION("Fourth Extended Filesystem");
 MODULE_LICENSE("GPL");
+MODULE_SOFTDEP("pre: crc32c");
 module_init(ext4_init_fs)
 module_exit(ext4_exit_fs)
