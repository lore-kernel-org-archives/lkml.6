Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvjnk4Ba66geGWfnUEiiNZDiQ304ZD5yCe1ow8D66kYwXuQEyrBcHtSLCpbbk9/xSK5CqnG
ARC-Seal: i=1; a=rsa-sha256; t=1520451580; cv=none;
        d=google.com; s=arc-20160816;
        b=LW3TT7zF/1ikIioRk54oLVd3Qx8cnsozcnJvo8MUCOPuHEg1aHmq8QH7JTgk9JYTeR
         5BdOlx607AdpRS0BQReOTabp98LgCuwlze/UVy19q4zkJo8O2c8WNwSHBE9PXGmmfl/d
         NVhMIvIch6yXBxvsn/xLXdaWJxSJyMCs8vdP92Fn9bjXhxJdMWEMc90lNPZJveh3l9VM
         qe7UeN7FQA+DfMcG5amSWMeEsRWfiN7JyGASY/Rp200NqSEhl76BA9XqUvZAbZj+i4Vn
         le4BEnQdX2fBROEmVYbBnpGU077JQ7cD3LwnJ0XR6K2gJZwhAryCh08EjvWKO+IClSvs
         5/Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=e7CqiNFKFYnuagURskU9IhD9/O52u1qm3L7F/ycYD5A=;
        b=bMF4rv3HdlvrFkZIVEHjL70gTTUK3HOOxeHOJq6ZvNuqitovW9m1VNly/nzjSUYg9I
         JkjECZhKXzjHY+7ZeL/H5jQqoafLNZQJeyyeCsmxG4xaOMwdx3NwPSvba21rheJcgavH
         3BwjdvW7qOFiTO79EWQNZ+h6KIIC9H2r2Vd+o8Oune8dagNZyamhyDDNDWLAnzIbavA8
         BRTTm6jO4UGW2gdO3tn6+gCtf90AoihR+5KVL65MHZbCn4d0rKCJx2w8a3mjSaQQHU4u
         rmCMdOV1CE6SFbtDBwnYSm0E/9vndLt0v2p48Od0n5gHERibqZu2MJXL/EbySVwWUkC1
         5yCw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Joe Perches <joe@perches.com>,
	Kees Cook <keescook@chromium.org>,
	"Roberts, William C" <william.c.roberts@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Laight <David.Laight@ACULAB.COM>,
	Randy Dunlap <rdunlap@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Adam Borowski <kilobyte@angband.pl>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH 4.15 001/122] vsprintf: avoid misleading "(null)" for %px
Date: Wed,  7 Mar 2018 11:36:53 -0800
Message-Id: <20180307191729.373118279@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309036618641205?=
X-GMAIL-MSGID: =?utf-8?q?1594309036618641205?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adam Borowski <kilobyte@angband.pl>

commit 3a129cc2151425e5aeb69aeb25fbc994ec738137 upstream.

Like %pK already does, print "00000000" instead.

This confused people -- the convention is that "(null)" means you tried to
dereference a null pointer as opposed to printing the address.

Link: http://lkml.kernel.org/r/20180204174521.21383-1-kilobyte@angband.pl
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Joe Perches <joe@perches.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: "Roberts, William C" <william.c.roberts@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Laight <David.Laight@ACULAB.COM>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Adam Borowski <kilobyte@angband.pl>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/vsprintf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1849,7 +1849,7 @@ char *pointer(const char *fmt, char *buf
 {
 	const int default_width = 2 * sizeof(void *);
 
-	if (!ptr && *fmt != 'K') {
+	if (!ptr && *fmt != 'K' && *fmt != 'x') {
 		/*
 		 * Print (null) with the same width as a pointer so it makes
 		 * tabular output look nice.
