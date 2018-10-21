Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF08DECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 17:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E31204FD
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 17:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGMPxMD+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7E31204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbeJVB3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 21:29:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51193 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbeJVB3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 21:29:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id i8-v6so7919231wmg.0;
        Sun, 21 Oct 2018 10:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o3HmxdElEan8PDyuuAhOtrH3RdwB6dQE/RImZWBr3E4=;
        b=fGMPxMD++IYRW9PSqM0Q0c5C5gDDgu/MQ3QSjFxgZVyqoOJQZLUE5qAf9Dm4a836es
         ffIaZIgpSJdY5hHIywrpRmJSAohsIxBz4w+bVd/j0nhRfNZIzsj8kueJA91Eou4eV2av
         i3w82VA1JOokFKI06KpVC0eEvexDsMZ4vqmqrSiO7BkT+PL7HHFnee89XlC/4QZOQmtr
         HJ1iEGGaoR5uHBZK/bYPnpXQpaiIAiH13GTqyrdsOKKTsXRvfacsazqT43gSdG3i+xXS
         UBb1McfLljpJEGsVFYKOa3I3sqWi9CC+t4Cj+O+fI/UxJdiaqSaZfVt0Z8QdUgs/5oRk
         iYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o3HmxdElEan8PDyuuAhOtrH3RdwB6dQE/RImZWBr3E4=;
        b=mPyIvorFefokQzKEu6DiRLA1QJNyz8RpkXEQa2nQ+wOiJUFk8b+CIv7wiphcVJW2f5
         bwCYHLNtixZdFflbsslb27/hnRvRVkSRsPeJrbyZEBP96wLz4TJuXI8q/zF0dV5UMgQt
         L/sCPHbZOSsojrDRTWmEAHu5XGKzYnl1IZqXEeLTy5xz/oyAWbWeurUl0gfAfpcCENP4
         E3JPIHyTpkXoffpUY3Rh4I+BXj/SSeMNBgoDUkpQRz5O1yR8uGUK5yEsTq3y3/upJZrW
         s6Q7/Nnon8J2j6RFCflqNMk7IlU7RN9V1haUNiD5v6JOzY5NoOuCfWEbauDkzr1lgnSZ
         aT8g==
X-Gm-Message-State: ABuFfojeHG6ETlICy2qMwKWYrFFgZq5bVkrFKqkHD7hMXjkKvAi/zBFP
        sXp2o55CLZ3iZhN6twFRTPY=
X-Google-Smtp-Source: ACcGV63VoEgw11BkHQDOm+FP4deKD4qzkydCrRtpNdiSmRusJKJ3+/Sz9WCZtw3XDvg+RkEuGvr75A==
X-Received: by 2002:a1c:2384:: with SMTP id j126-v6mr12542954wmj.124.1540142081015;
        Sun, 21 Oct 2018 10:14:41 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id y16-v6sm20860113wru.18.2018.10.21.10.14.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 10:14:40 -0700 (PDT)
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Olof Johansson <olof@lxom.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Burton <paul.burton@mips.com>,
        David Rientjes <rientjes@google.com>, Willy Tarreau <w@1wt.eu>,
        Martin Sebor <msebor@gmail.com>,
        Christopher Li <sparse@chrisli.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Theodore Ts'o <tytso@mit.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Stefan Agner <stefan@agner.ch>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: [PATCH 2/2] Compiler Attributes: auxdisplay: panel: use __fallthrough
Date:   Sun, 21 Oct 2018 19:14:14 +0200
Message-Id: <20181021171414.22674-3-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let gcc know these cases are meant to fall through to the next label
by annotating them with the new __fallthrough statement attribute;
and remove the comment since it conveys the same information
(which was also parsed by gcc to suppress the warning).

Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 drivers/auxdisplay/panel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index 21b9b2f2470a..0755034e49ba 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -1367,7 +1367,7 @@ static void panel_process_inputs(void)
 				break;
 			input->rise_timer = 0;
 			input->state = INPUT_ST_RISING;
-			/* fall through */
+			__fallthrough;
 		case INPUT_ST_RISING:
 			if ((phys_curr & input->mask) != input->value) {
 				input->state = INPUT_ST_LOW;
@@ -1380,11 +1380,11 @@ static void panel_process_inputs(void)
 			}
 			input->high_timer = 0;
 			input->state = INPUT_ST_HIGH;
-			/* fall through */
+			__fallthrough;
 		case INPUT_ST_HIGH:
 			if (input_state_high(input))
 				break;
-			/* fall through */
+			__fallthrough;
 		case INPUT_ST_FALLING:
 			input_state_falling(input);
 		}
-- 
2.17.1

