Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DD0C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAFEA208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oJlEE6Hs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAFEA208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbeJPFLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 01:11:47 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:38818 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbeJPFLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 01:11:47 -0400
Received: by mail-pf1-f201.google.com with SMTP id 25-v6so18171163pfs.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 14:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XdDvq16Aoq4crU+4Fz49GrYwimNLB0jx9BeAUk8FnK8=;
        b=oJlEE6HsJeOHRrA31CBWhjgGbE0cwFxBjKbixRKKm1aAU/D/7HC205MudwkWYNYuAp
         IqO1vw3kr3jbzpiE9DU0J+e/spPsaU5rCgeQWRQEZGjU1+u9F4RZ6kbVwGthxF8AD7ka
         woaQa2B4+8S94Gyc25WrBdYEpyX1iKQGJMLpVXSjBjIYoYFkE2M5s3hu0Ar94U7dDvIu
         TdsKBfWxyuaPjDgE3ebN/fzxXKt2kcRgGG/lC/j2pNDF6iZx7UyYFuxTxyTbA8hticzo
         8h5HFw1t6A3cWfcUTLzbwE+ztgRRAMdV/jC9bCuAJ7jHLXU7klQcbr/Errrv821SrZWD
         6XTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XdDvq16Aoq4crU+4Fz49GrYwimNLB0jx9BeAUk8FnK8=;
        b=tnJ3xoB14JI6yaXuNpNdAx8MV4/Yh9dlA0YLdhn/j0q3uaY15QlmD6QyDvPsACIug3
         NUJ9lTQaRaLipYChQhSM3yXSUKDgzFf2nxbsa/o8RKw6cwY/d1/FvtYSBg1nF5OHEyLD
         EB8tDmsFVSvTInrTCOlZyKdQw2nTL8rD0/RS69OHcWOJ2IP22pYnwAyaJkG+NVeCMte3
         MO7BZMhMS7SSLgI9V22dPCdsCTMo9W0oaRC954TJ0R/021pswj7BO5Yls1jqUDg4RdlI
         1jEBdDVQIpZLdEZkH1HGmV4FrDuUA9Cxj3Yd4heDDlZ3gdVX+nriTYkyN3eiHvqyRmOY
         /CdA==
X-Gm-Message-State: ABuFfoj2+Mx39BsGUqFVWhlNzN/37ZfNCZW0hZ8cFilb2xK3Nm01HCkU
        bJOw0Rov4Vp5KcrWDfaEqCZp68RQGE2rAoHNiIU=
X-Google-Smtp-Source: ACcGV62XvXUwddaRuZ521Tx+K7g6CvB1CHknb4pBOTf0NJpBY42Z/3TMJSQ3yMFXfSlnEYVofOc7gT37/Eak7NeQTQc=
X-Received: by 2002:a63:1b03:: with SMTP id b3-v6mr9186939pgb.13.1539638686426;
 Mon, 15 Oct 2018 14:24:46 -0700 (PDT)
Date:   Mon, 15 Oct 2018 14:24:27 -0700
In-Reply-To: <CANiq72=PMEqu__HjQ-Y7DmzbWMRQPY6gQ5MF0cd9gF6vbCj=8Q@mail.gmail.com>
Message-Id: <20181015212428.260810-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <CANiq72=PMEqu__HjQ-Y7DmzbWMRQPY6gQ5MF0cd9gF6vbCj=8Q@mail.gmail.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [PATCH] compiler-gcc: remove comment about gcc 4.5 from unreachable()
From:   ndesaulniers@google.com
To:     miguel.ojeda.sandonis@gmail.com
Cc:     luto@amacapital.net, jpoimboe@redhat.com, natechancellor@gmail.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the comment about being unable to detect __builtin_unreachable.
__builtin_unreachable was implemented in the GCC 4.5 timeframe. The
kernel's minimum supported version of GCC is 4.6 since commit
cafa0010cd51 ("Raise the minimum required gcc version to 4.6"). Commit
cb984d101b30 ("compiler-gcc: integrate the various compiler-gcc[345].h
files") shows that unreachable() had different guards based on GCC
version.

Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 include/linux/compiler-gcc.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 4d36b27214fd..9890411b33d5 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -107,10 +107,6 @@
  * Mark a position in code as unreachable.  This can be used to
  * suppress control flow warnings after asm blocks that transfer
  * control elsewhere.
- *
- * Early snapshots of gcc 4.5 don't support this and we can't detect
- * this in the preprocessor, but we can live with this because they're
- * unreleased.  Really, we need to have autoconf for the kernel.
  */
 #define unreachable() \
 	do {					\
-- 
2.19.1.331.ge82ca0e54c-goog

