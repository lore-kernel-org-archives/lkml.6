Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr1cnyE+7nkzaGXGX3RmYk0A0t55ayf4X9anDNtzjC2rM+rNp2gv1Zo9vIhLqCbYxk6tZ/k
ARC-Seal: i=1; a=rsa-sha256; t=1525116405; cv=none;
        d=google.com; s=arc-20160816;
        b=LiXWYX7YOIistLoJfYL4fkqoUDVrdtWT0guxuQOA7YK3B2Y5EAI6FI2AuNfQqFJQOa
         TQUHPhTwdAGZpY2UEF/efQoWDjXCiAaknztRyONgl+XlmFrHKqUbnj+AOe/Oq6EXFFlC
         tj4u70haGqJoTl2fJkK/PdxLoy5RV5bOTBgTZI9Yo25bGLNKDbdqRZUubCZswq1RvceY
         bgYDcfGf4YPjsEMDqyRGVp9Le0Z9cH/AtcmFJBzOEj3nyIVfTPbrUGdsfuInfYJJU/1S
         9+wFp6kXXJi7pzoC9laXBCWDx33vIgqhOkcImEuAV0U6a2OgXkaGDtKMRorajY3d+6gp
         Fruw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=lf80Q9oTkGvVHstpXtZpLu8D11o12snuC4KYPNVgymA=;
        b=lyoI4mcKhUr60vYFe/jDtfwOyc278oJ1SHMYhRS3atyRjMPZERCUUHMeNNDv88rjjc
         WRTxtERQLOBfV77XtU7bSqUkKukBkto/sr/23eoaafhHubH4prPF+eIPHOPG74y0rbcy
         Ntzu37x3Ht7halNwmw8NUoj9HLmBKaiXndFyIiF2O/mO1Z6fJuZLeqmyTQ8q8gh7kQRz
         TSdpVSGLz6sGsaUKBOTMtUKIMfqhWkD+ujjz1KL0PG4De+5+v/R0yXVBuuQz+iPIQRM2
         O06QFMr0fWkDqtl/rsmY5CU6oZCJ3sT4tfmwiU0KksqalepdbQwL9OLbHr515ghKTJnR
         iS+g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F6622DBF
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
Subject: [PATCH 4.9 57/61] tools/lib/subcmd/pager.c: do not alias select() params
Date: Mon, 30 Apr 2018 12:25:00 -0700
Message-Id: <20180430183956.107877025@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200518600832333?=
X-GMAIL-MSGID: =?utf-8?q?1599200460671960841?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -29,10 +29,13 @@ static void pager_preexec(void)
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
