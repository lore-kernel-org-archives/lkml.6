Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224EtTG2+Ln1t0qmn+cVSw+i1pWMa3BjGw6cjNSRqT2mxxD+ERwdrYcBcrfmbaxYdPCVf2B9
ARC-Seal: i=1; a=rsa-sha256; t=1519411046; cv=none;
        d=google.com; s=arc-20160816;
        b=dSCPrJ38JH5bRAl1xz78Q64cY0xvdT7qro8Xw2itfStYdlyLjnzSoLvdCWNSPSJ7uW
         I+2NR7OQAMtiCABZeBCcoYX7PoV/SKXzn/+U8Njqaw6I1lJk4DXfSV3NJfK7CBd4dHo4
         9zorG+BGG0/1Pd6NY3gG6Lefny5aLnkRJ9k14EcggJEVB13cKBM4TRgVoxb9YLYRlEZA
         8AFJSUB0/Cq15bCRDhXktsWK0XbPzGn0fDhHW+l+5VFJmoSwyNR4jkOm4D4HxQ5PIQpF
         uETiyhKyB7Ywl36qHe9rEIwXfhZH/i3oEdXXGUDQ2YTIbfxdLUmV7PLaxzjLKZrVCxdZ
         u0cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DgIICyZhrEE/sfAW3KCPuMTwNLA4xDo9NJ8sUk6/sJw=;
        b=j2WnGKYicH4F/78iRV7ZhtFUHfILnstry5++5vDXl/MbWixF2rNMGJVJ+Tjm9ZN/y0
         bWwXnpqZnDwKpDCojej0MMBcajV7esVLYVclD+5Pf+9deC/RFMTbNUXVRrPkQi82HUJC
         Rw5LYoQp6IzKL59ORSCT+IPoyuOySNzqaW/Ya1EvWxFGzjnjeiyZcaIm3uryRM1qzL7X
         u4wS8hc+EznsxxxIZOWPgkj+XB0wE/A2KQZdYDlOTHd//UjFpNCBc3LCiZlOl51MDF/i
         WS4s4JxZ3paoHu5Ggj3+6+EZRyAHV2fc2VpkdGd3A++8gH0kEkilK/KdXHkQYiTYt5rJ
         JDew==
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
Subject: [PATCH 4.4 075/193] x86: add MULTIUSER dependency for KVM
Date: Fri, 23 Feb 2018 19:25:08 +0100
Message-Id: <20180223170337.772993957@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217957079496262?=
X-GMAIL-MSGID: =?utf-8?q?1593217957079496262?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
