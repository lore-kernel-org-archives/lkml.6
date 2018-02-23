Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227iQJJIFxCUeM2ReS3GBWRdtP8Av1KRg+EbFMgbJf3l80Rm7HC9Lz62cQ3SE7BhlCHs0VFO
ARC-Seal: i=1; a=rsa-sha256; t=1519411637; cv=none;
        d=google.com; s=arc-20160816;
        b=OeAi2gHvIhUjc/v6+H9S+oBRlVwc/9Oh3VCzy4QA4EJRaeJjp919F6+ZczTaTafGST
         lZm14lMxKvPhOIdegldXcb5q1b0dvBsTzDUm9hY7van8iBvu1Zgkcqf2K5HY7gbLA1yg
         Y1Pio3As/k3JlMYe0IuVaZQMpUru4HnppkjOEzaZcxQf/zTc2i2D8DU7A4w89cZH2qt1
         I0UgreK6QY0pJGjMbBJWG8umsDKcki9/jMqtxV90MRCoij7Pn/p8/4YIOhrPv6ta8Z0g
         RDyDOaK2PYObki55JTsjfqzDmj4Lfm43ekxk8Dr8fMuXaGLtatstparW07jFah7oi0zj
         U/ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GdRNSLEZXoEJGQ32RkF+H5Nr/AH0jRzdDtC184yRFe8=;
        b=lF03hOSKrUWu2kKAHtW3XcjH58uSix4a4NVXv5vOsDolekjUHOyiQGXyrQo40PJdzn
         3Z2bSWDYYFvFLEZaa6CmdUAgh4h8oJeJYbpsBaN9wYzAQRKxlpYp2K7SlwtSWGm23+4w
         d6mNHJ22o970kEBjE7OM14uo44m4wSI5fF2tNEpknDd0fg0Yl3xqMFBOMnrfeS1uEnDj
         Gda2fw3NcKoHczwtmLi8SErUYSvZBnF4RnoCCI7Bx1474UOefFUyKecUXQfQR0HPaFMx
         R88+OPkjvE02z+b8n033ie1wwGfdQdFWSiiPt6z9xUKM299+v6jB3+iMjrnLlLveBaKh
         l2lA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 4.9 111/145] x86: add MULTIUSER dependency for KVM
Date: Fri, 23 Feb 2018 19:26:57 +0100
Message-Id: <20180223170739.203651617@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217957079496262?=
X-GMAIL-MSGID: =?utf-8?q?1593218577083401078?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit c2ce3f5d89d57301e2756ac325fe2ebc33bfec30 upstream.

KVM tries to select 'TASKSTATS', which had additional dependencies:

warning: (KVM) selects TASKSTATS which has unmet direct dependencies (NET && MULTIUSER)

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -22,7 +22,7 @@ config KVM
 	depends on HAVE_KVM
 	depends on HIGH_RES_TIMERS
 	# for TASKSTATS/TASK_DELAY_ACCT:
-	depends on NET
+	depends on NET && MULTIUSER
 	select PREEMPT_NOTIFIERS
 	select MMU_NOTIFIER
 	select ANON_INODES
