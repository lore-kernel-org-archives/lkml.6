Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp1/GIgkEzbISjGcsSlRTHdKb37oWwwiFknrurdGz0SrLgOiwao+NHvohAoTcmPgEALGUDh
ARC-Seal: i=1; a=rsa-sha256; t=1526937662; cv=none;
        d=google.com; s=arc-20160816;
        b=JuYl6A/Y2Zt1GPlKN/6Bak7IvOMPsboI/SN/9r4LtjRYW1ohlv2QyVWsS5Vk4Y0gbT
         yepDbA51huCVB/UUdv1TjosOJwCo1dPxtJY1nQxQwtzXDr3Ftkr5BB32fU5INCWAoxIw
         EIpZ4TdW09icn4k5uIstSwqhFGRrcZRFVy6ie0Ej66CMU+4ykU/21eKqJGxwb7XBrK2j
         KhyK3D4OfSSktNpxWYJ4VgZ8jDZOe9ilxrIwtH1JaVhOgk7BqAGeHcOzmbJnXP7Irl8w
         SdDZ9pAEUm7WxZN6FzmkLfXVAFkTekQ0kb572jgWmocBWtPPU8CBfc9QEPdV63rzQ94m
         F3HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=PBOTBySI000gtQwEeJf4TFFhT776ZpVCA0KJnwuVU/g=;
        b=gREY6NOD/W06nDTWxWZDlTuFteoDiZs5/MCWceDqjHUX92uinTTIkmaPgJWPhIZykA
         boQlyrdZnOLs4FyNGthebW+5EAI51RjqhiKoGGjsCkXKs1+c6Hk2cRnKnrqxUNcIFJTG
         w12cVtAOjuEOROUBGco7b0/wGAawmY8X8zHRuEg3Yn6iHtBs25foMR9aEEjbN6+Xtd7f
         G5u12IdwCjO6j4zqyEEB61sGlbX1ZB0Rsf38AJdLs6v5mNGyEHrLW5M+WtFotO5EjTP7
         +4CH4SbVvTwHNzVpn0hSaffoj/JDC3FIBvjbwA3lfOY5bSxuQG4B7FyLAVWHo8vrwDEb
         Mp2g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ShERN3DO;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ShERN3DO;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jiri Kosina <jkosina@suse.cz>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.14 76/95] x86/bugs: Fix __ssb_select_mitigation() return type
Date: Mon, 21 May 2018 23:12:06 +0200
Message-Id: <20180521210501.709718173@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109906725705241?=
X-GMAIL-MSGID: =?utf-8?q?1601110186853152168?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Kosina <jkosina@suse.cz>

commit d66d8ff3d21667b41eddbe86b35ab411e40d8c5f upstream

__ssb_select_mitigation() returns one of the members of enum ssb_mitigation,
not ssb_mitigation_cmd; fix the prototype to reflect that.

Fixes: 24f7fc83b9204 ("x86/bugs: Provide boot parameters for the spec_store_bypass_disable mitigation")
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -468,7 +468,7 @@ static enum ssb_mitigation_cmd __init ss
 	return cmd;
 }
 
-static enum ssb_mitigation_cmd __init __ssb_select_mitigation(void)
+static enum ssb_mitigation __init __ssb_select_mitigation(void)
 {
 	enum ssb_mitigation mode = SPEC_STORE_BYPASS_NONE;
 	enum ssb_mitigation_cmd cmd;
