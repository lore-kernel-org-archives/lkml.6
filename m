Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+zNyz8i7velXV7YhxExahuhok9bCSvzBtgt8pBIUeltZB7yPQtmHJ501mFozR94+vZPS6q
ARC-Seal: i=1; a=rsa-sha256; t=1524652790; cv=none;
        d=google.com; s=arc-20160816;
        b=icErqD3vTVi6KyimP6harVWevOffy+JkASxDcuJxBA5AmxNl3rNLkX4VshbkV/eM8I
         eK2zgw3kYOSu/guJw3r0ksSKo+Kytkui+/vnSw3+CVL7hA8iDVOpnFSIjLMtf+Mp+iU5
         sZO77Ghs8Z0suhXL96pnBAE+Xj92uwUuXboSweq+KCMnuIqu2QuUpkivcIMLdNZGz+M1
         8icb9hvisAXr4EHEs7lUObshNY6WczXGN4rny0BySvB810UpWxDg6FXexttKijobdElg
         pzwd6Eo2fGzuKFpryV01CLswlrDX0wwsK4HrkqUyEsZK7jpqD8HfojUKf3KqtssIlrRt
         IK+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=n0E5GYW3C4h+QCJqyNMiRCZWWwtxcawqUCTyul444oE=;
        b=XrkdFsFEUyM+3OsIFqb4i54vQdOhlH5J/CkJ04E1BaCd0GpaHeoK9cmJE49H7BxYIr
         l+WtNNulihy+His3hQVZMj/ZLMk/hEdZZqpia3q3DPAZx+tbQGpoFBDzTeaBx1cvcaYh
         bq1mY9uhGgW2V3/CJWBGXUHDOGaddW8AmlqLhrC2XSbq8Kcg89wh1HDxs9rzDNAYKPw8
         csW7KA1WebCC94kVuzzVxmmTdA3nJbAnq22XeKqgHlij+3wEz6bAP2XuOJPmdfeIphWU
         +Rj/pKTUyn1ZGxhbAKdFeZtTcgkdTc4bX4LJvTnT0sOGST+6omgUPT8nE3Tp0yg6bUlm
         S1rQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jesper Dangaard Brouer <brouer@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 033/183] libbpf: Makefile set specified permission mode
Date: Wed, 25 Apr 2018 12:34:13 +0200
Message-Id: <20180425103243.916550229@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714325013528269?=
X-GMAIL-MSGID: =?utf-8?q?1598714325013528269?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jesper Dangaard Brouer <brouer@redhat.com>


[ Upstream commit 7110d80d53f472956420cd05a6297f49b558b674 ]

The third parameter to do_install was not used by $(INSTALL) command.
Fix this by only setting the -m option when the third parameter is supplied.

The use of a third parameter was introduced in commit  eb54e522a000 ("bpf:
install libbpf headers on 'make install'").

Without this change, the header files are install as executables files (755).

Fixes: eb54e522a000 ("bpf: install libbpf headers on 'make install'")
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/lib/bpf/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -183,7 +183,7 @@ define do_install
 	if [ ! -d '$(DESTDIR_SQ)$2' ]; then		\
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$2';	\
 	fi;						\
-	$(INSTALL) $1 '$(DESTDIR_SQ)$2'
+	$(INSTALL) $1 $(if $3,-m $3,) '$(DESTDIR_SQ)$2'
 endef
 
 install_lib: all_cmd
