Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt00yTe9iLZgDROaVr77lrQ8gpPXPwPM6iycXYGFx3nci+gGnJIa1lW7SwI63eSRRye8fMu
ARC-Seal: i=1; a=rsa-sha256; t=1519411134; cv=none;
        d=google.com; s=arc-20160816;
        b=MJvIQ7ETKuzH+5ZKOgZxQ3BLegI0pYo5cYSKIqRfctN3Cq4tyQI7XC9K6mg9zXUTVu
         XcYxLwaVDq0FtaNLVR0BqxDkBL6Ky2d8VBHI7XJuEdvpPxY99Sta5XhbGdyHQbxkd8CW
         UZmvsxxuf6kMkKxwn5ApAXPtActy97G7ZSt7vJ0kb3rmuNonYJ/KZ8OxjMup6gT6P/Xi
         7BX2Pee4dpL92AsQBXc3QNX093lGBLGUI9KjLjdomELEX5ZrM45yLTmp/ljre7lMoY5Z
         yTOqOQFGBbikXCAbo7yqpwguwLj9Yio4297vOujJC28+w8FvqLFlo5WJtBd3Kqz3ueNd
         tsKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=riKI/dKiXSczYDdZEFoCcT75OMafyYNalLOppksHGHo=;
        b=EM5LvxRHtx3Fp6uqOmC5wlw64Wqx59YNpwZGHlDcOLyey5j3H9Nn+gwMaXVrLWiKmz
         zKuzwaG1llXoNvTpwgsZI0V5Ku3a43lsx6JKufQpTc1iQ0kieMv8HXIMS2zd/6z3w+H9
         fQ0YzZADtEqT409mVwrVhpGDdPB24mWOI8kZAkdtkAX6T/yWO+pfxi1wUWChVokE61qs
         jYqhS/WKDadRl60HVcmqlBOL5t9YYf3JEHjQL0UuQOJHTizRQB8EGsULJvpb/+MkIF1o
         bQrcvAzentE9KT2gVfNbA/50gLF27dhp1hTWSfHNby3pi2mthCK56P0umjWtuelO/xP+
         /UMg==
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
Subject: [PATCH 4.4 133/193] KVM: add X86_LOCAL_APIC dependency
Date: Fri, 23 Feb 2018 19:26:06 +0100
Message-Id: <20180223170346.665314740@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218049468964929?=
X-GMAIL-MSGID: =?utf-8?q?1593218049468964929?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit e42eef4ba38806b18c4a74f0c276fb2e0b548173 upstream.

The rework of the posted interrupt handling broke building without
support for the local APIC:

ERROR: "boot_cpu_physical_apicid" [arch/x86/kvm/kvm-intel.ko] undefined!

That configuration is probably not particularly useful anyway, so
we can avoid the randconfig failures by adding a Kconfig dependency.

Fixes: 8b306e2f3c41 ("KVM: VMX: avoid double list add with VT-d posted interrupts")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -23,6 +23,7 @@ config KVM
 	depends on HIGH_RES_TIMERS
 	# for TASKSTATS/TASK_DELAY_ACCT:
 	depends on NET && MULTIUSER
+	depends on X86_LOCAL_APIC
 	select PREEMPT_NOTIFIERS
 	select MMU_NOTIFIER
 	select ANON_INODES
