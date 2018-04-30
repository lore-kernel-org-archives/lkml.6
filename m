Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrEYNWBs5TB0f3XUyYaDXm9kVSo5/6t0P3fboV47MjTxjXKZrLQFxntz/VnazyChQqWEV/b
ARC-Seal: i=1; a=rsa-sha256; t=1525116461; cv=none;
        d=google.com; s=arc-20160816;
        b=hb2c7e4xv6BO+yxhWwqS6MKu5XZe3B3zIzpsbcZjbYnB39zg9VroMnaCqpjIID4lNP
         CwfzvLPoBbf1Xqv22VF0l/4OILh2d9GxXYZls8kNQcFwETiOCziZdks3Pd7fgYG3JHRq
         pB+8FxhvNXNhZp3pFVcdNaCtYglJdtjmp3IVyI9LzXLigrVE+hkUdEIXKYQnRiinXzyw
         HgkUIHorCUwYE3oKqF6Hn8PKLtu4SOiulXSUc2qrgNKs6MpHSu6v5/DOyvBYqmDs3p/S
         G0O4+odBTOEurvmEyQc5/99F/qLIWHpXGpDMepXDlNQhGcic4T05eEWApGxH+1CK+Eub
         eqfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=2gEymZPy7cVRukMWcnU+ZJ2oL+Prwmx9uXOwqym7iwE=;
        b=JvpxeWvkU/LQqHN4mw7HPvLlnfOP+ass/zNg5kDu7ovAviKOcf3Lo0N7R2uf9awn2d
         u8ucPWpjVn0s2disGTMnrs6JI1MMGAN++x7N0h/Z84ospNkypKRHKPz0yYJmWy3glm1v
         r0mYguoemjD7lwAMp08NPO3w5FZeeprc1fsZhRK8pzBhiXWZc5sjhZSGw6OtYXqdkLDS
         f/H4MR3DA9A8I0JFIBEX+jKbIw0WRoi5ijnDkoAoXY8irBx7mDLMl/sz4//w5TNYB1an
         bPXbdHTvw6wmYqbmZH4D/5f04nZDkIiJCt1yPgfJZnFU4cx2RyhgK6ib8q56/BErMwhl
         W9jw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0714322E01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	=?UTF-8?q?Fredrik=20Sch=C3=B6n?= <fredrikschon@gmail.com>
Subject: [PATCH 4.14 83/91] tools/lib/subcmd/pager.c: do not alias select() params
Date: Mon, 30 Apr 2018 12:25:05 -0700
Message-Id: <20180430184008.616426460@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200518600832333?=
X-GMAIL-MSGID: =?utf-8?q?1599200518600832333?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

commit ad343a98e74e85aa91d844310e797f96fee6983b upstream.

Use a separate fd set for select()-s exception fds param to fix the
following gcc warning:

  pager.c:36:12: error: passing argument 2 to restrict-qualified parameter aliases with argument 4 [-Werror=restrict]
    select(1, &in, NULL, &in, NULL);
              ^~~        ~~~

Link: http://lkml.kernel.org/r/20180101105626.7168-1-sergey.senozhatsky@gmail.com
Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Fredrik Schön <fredrikschon@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/lib/subcmd/pager.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/tools/lib/subcmd/pager.c
+++ b/tools/lib/subcmd/pager.c
@@ -30,10 +30,13 @@ static void pager_preexec(void)
 	 * have real input
 	 */
 	fd_set in;
+	fd_set exception;
 
 	FD_ZERO(&in);
+	FD_ZERO(&exception);
 	FD_SET(0, &in);
-	select(1, &in, NULL, &in, NULL);
+	FD_SET(0, &exception);
+	select(1, &in, NULL, &exception, NULL);
 
 	setenv("LESS", "FRSX", 0);
 }
