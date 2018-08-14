Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B037C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 19:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530A02087F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 19:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qbE8eKB0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 530A02087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbeHNW1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 18:27:16 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52128 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbeHNW1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 18:27:16 -0400
Received: by mail-wm0-f67.google.com with SMTP id y2-v6so13418165wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 12:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=p+yT9bU25Z0jttTyWIsrJixlhiLAEn6t8dJgKPVcykg=;
        b=qbE8eKB0zAGwA0CTLGuSe91z9KrKYdRV7yP9UJpB8wfisP1nl+/R9/1Jf9OSqNcgur
         aXf/zge/2VTubqJFElHSHnAeGamkHpxTVVXRU859/1bpivk88JdO/fIGmhqWJhoe62qL
         jRuXRWbY7VJxjwLhgZp4J9DnaduXplOTnLT2kJWuzRxkv1pdtfAr2bGfXQphReBxDMLK
         MOCOi8ilaYf/cjKLWoutQLc+X5NzjMqlSjHcSJHTGBTzGqqJma4sN8cRfPI7EhWPu19n
         DuUlBtJuS9UjI65RflSX8X5yd4zC59SrTjSjCGIi0+3SgTmjmbNDWna2Lh0wMciBvsFi
         c5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=p+yT9bU25Z0jttTyWIsrJixlhiLAEn6t8dJgKPVcykg=;
        b=HOw/UYijWVW4WPyWj4mB6YKUyQMUk7IkSebtQ/Dov8PAPyfjS6fidEhS5Qb47Tgvhu
         vcMByVyBFHmOT2WSMQ+5PlaHNoSiXazP0/h/znRcv8fBIZaQ1U+jkkMz/C4S+HSNDnfk
         +mrKZt0HKu4uW6PwiE0+ZkCXy3/C2NmB43XUs6KZvJL3NPWHrEFqRpzK3gsvGHMpn36k
         HFqOPeOh9gQdwkIC6GxWER/6XIew5AQktRUSPa1xQQNiZiQKXalUbY5YT2+ta+dSDHzT
         cscF2E8MQbb45ANYgLKQ+9MzhfUTyTo07cZSJeO49otjbq1bUYIuD1HRv3JJKjnQI+FC
         1+/g==
X-Gm-Message-State: AOUpUlFUwd4Qy1/A19s6Bn/fS0w7aZs+kuxN9MjkP4Lzw6PWW18SmUyo
        XyCkrJ9MJ77QjDJkdW5XWdY=
X-Google-Smtp-Source: AA+uWPynmnnRZeRpH3rVf+Tk7AhRHTqiH8ZF0xGVwpGZpFG5Dm4TscGxsT+B+LiGjiILNi3UuNjU7w==
X-Received: by 2002:a1c:3:: with SMTP id 3-v6mr10760736wma.99.1534275511192;
        Tue, 14 Aug 2018 12:38:31 -0700 (PDT)
Received: from gmail.com (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id q70-v6sm27435495wmd.39.2018.08.14.12.38.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 12:38:30 -0700 (PDT)
Date:   Tue, 14 Aug 2018 21:38:26 +0200
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Willy Tarreau <w@1wt.eu>, Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Will Deacon <will.deacon@arm.com>,
        David Rientjes <rientjes@google.com>,
        Martin Sebor <msebor@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] auxdisplay: panel: avoid gcc 8's Wstringop-truncation
 warning
Message-ID: <20180814193826.GA5459@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let gcc know it is not meant to be NUL-terminated by annotating with
the new __nonstring variable attribute; and remove the comment since it
conveys the same information.

Cc: Willy Tarreau <w@1wt.eu>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Martin Sebor <msebor@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Joe Perches <joe@perches.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
v3:
  Moved #ifdef block to the bottom of the file as suggested
  by Joe. Updated description of the nonstring attribute
  in the patch and in the commit message from the GCC docs.
  Put all Cc people in both patches since the second is
  really an example of the first. Added Linus and Greg.

v2:
  Re-sending this since a few months have passed, Martin has improved
  GCC's feature and warnings are appearing in Geert's build bot.
  Added an example in the second patch as requested by David.

 drivers/auxdisplay/panel.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index 3b25a643058c..21b9b2f2470a 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -155,10 +155,9 @@ struct logical_input {
 			int release_data;
 		} std;
 		struct {	/* valid when type == INPUT_TYPE_KBD */
-			/* strings can be non null-terminated */
-			char press_str[sizeof(void *) + sizeof(int)];
-			char repeat_str[sizeof(void *) + sizeof(int)];
-			char release_str[sizeof(void *) + sizeof(int)];
+			char press_str[sizeof(void *) + sizeof(int)] __nonstring;
+			char repeat_str[sizeof(void *) + sizeof(int)] __nonstring;
+			char release_str[sizeof(void *) + sizeof(int)] __nonstring;
 		} kbd;
 	} u;
 };
-- 
2.17.1

