Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225vmGq+Fyq4v5QETnike0YXK//Ecw/XWsHSJ/CV7lv6ykRdg7mLRsO6empHgvNWSzCN7cVT
ARC-Seal: i=1; a=rsa-sha256; t=1518708545; cv=none;
        d=google.com; s=arc-20160816;
        b=x1rWVDMn/FAr9vBxKptq1p4C4fLsHBydCzRt/B0CPosGbAk/PzJgHtvN65v+5sDW3Z
         7sNOQ78g6TaKYbWRiunpLTYdFR+aCXH+BOYPJtQfgiwc1kKA+Sd3VxVGQCE6lfAqFIk5
         cYPPy7ynMbgoLn79I6E2QXh0bPokZIPtNW1u5fuVpNPkey51XE3lf/H+ZNcOTMMKD6OU
         hlITD3WoAvgQfxul9lXg9T2t6mqMe+C8GnE/wAJHSqi04/z0uHhaP9I5a4mlsKQ1vWJZ
         XYyvr524/IOl05wBmcM73mFWuPP1zXQ8+7t5OU9ohRoXYVLkU3j/tL9hPgXEuCvOKk+8
         aXFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lHA6axcQEO7/dp/tu9O6Hi/mEVqAKKZjSrj33/Xn6GM=;
        b=SAH005IO86aPPVdleKZg+xVbKhW9ntROt75DfrJ2ARobz+TFRUpivuK93e1G0NWbJl
         maYPt+k621o3iqYXbiuAjlaJOUUDhzyms1lEUNCMUYtRYrXmkgPPBd508Z6SOyaXu0oL
         0U4wDOFaW/ZZdXkfoYxPimtwPwo7avLra2lYzooU4LyknBsG4RwBb/S8D8aH8u3TYRh+
         7zgTr96r/R8/iNXguiBxsLQGsCOEeYdME3AePTDQiOZvgqMXmrnnwiTlQnOYD/x6iLfi
         sqCk3P0JyMm/p3PK91M9vV4f6M3UXbbwEB6LD5FpKpvb8fbJpAAHTSVzxbJvcqY+hXxH
         EgUw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Laight <David.Laight@ACULAB.COM>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 80/88] lib/ubsan.c: s/missaligned/misaligned/
Date: Thu, 15 Feb 2018 16:17:47 +0100
Message-Id: <20180215151233.530858313@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481331369811147?=
X-GMAIL-MSGID: =?utf-8?q?1592481331369811147?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Morton <akpm@linux-foundation.org>

commit b8fe1120b4ba342b4f156d24e952d6e686b20298 upstream.

A vist from the spelling fairy.

Cc: David Laight <David.Laight@ACULAB.COM>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/ubsan.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -281,7 +281,7 @@ static void handle_null_ptr_deref(struct
 	ubsan_epilogue(&flags);
 }
 
-static void handle_missaligned_access(struct type_mismatch_data *data,
+static void handle_misaligned_access(struct type_mismatch_data *data,
 				unsigned long ptr)
 {
 	unsigned long flags;
@@ -322,7 +322,7 @@ void __ubsan_handle_type_mismatch(struct
 	if (!ptr)
 		handle_null_ptr_deref(data);
 	else if (data->alignment && !IS_ALIGNED(ptr, data->alignment))
-		handle_missaligned_access(data, ptr);
+		handle_misaligned_access(data, ptr);
 	else
 		handle_object_size_mismatch(data, ptr);
 }
