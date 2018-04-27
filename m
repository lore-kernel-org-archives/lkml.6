Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpP/ZAHryLyp3eY2l9lAydXfJTvCXUolxi1mE4WrNOmGntmQ+etTzVX5BSFAhZQi7DbvSYZ
ARC-Seal: i=1; a=rsa-sha256; t=1524838137; cv=none;
        d=google.com; s=arc-20160816;
        b=dguV1O8TdAmnpaLD3ZtvQSFZeu4uMmpr8Q/steTW/t4SEWv66K1R1jRyCejbOO+14v
         9m4hhsxXQGUC30AUYofb6coMonrsFaLVJ8uMAs2X2BHqcvBAgMBrUilCP+4JBxbMht+i
         XkkSiNJVRs5G/4breXjTHHGaku0eHArL9dbX+nkxz7LbYbUAso6SFaH1XFgjB/2Ib8wA
         HuxjovLgjmPSI+2iaWcFw+hFs3WHLJRNI7HLGaqQwFVy+vYJ6OkdlRzCJGqeTJsyr6Eb
         6+mMHdNe5u6CLXysmfObSHbedKeZwYgPeErxu+pSO9TNcB37IputF3pN7FUvAFA3pg2i
         m+YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=F3Ynh2GTSGh2jJzEqm9A4QOMrQKaVR2LQitXTi8TOmk=;
        b=t9wBpGc2m+ESrv20wrK92zFPgSwnnXCgV3eliGg8cC3ICzbVKFTNhVMEbHE+iDTa6v
         DeUXr8tzLkwER1JE4Kl3CQ82CHGMchb7Scou2u/x7NXYph3bpE8yo6YKxPr+vWNz61rM
         b9ZheWtR8QfIEDxdu4YF3l7HqBrxuog6Ov/vCPjOKH/C5kVq1zWvP3DhCMyOzBxRryZ+
         ODNgsTaIkyy0hyk1SJZPucQCPVSXGxnl9itn9dxoCfJGSyqpcXMnMiM7vfkzjWc7YMfO
         p7MOMPyRHBClEWRlsmIS6trPiI1VnjFveX2HKE9w9CIYfEuljP7wrrC3plSHe8nyO1RL
         VCdg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA72F21864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	kbuild test robot <lkp@intel.com>,
	"Hao, Shun" <shun.hao@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Michal Simek <michal.simek@xilinx.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.14 41/80] Revert "microblaze: fix endian handling"
Date: Fri, 27 Apr 2018 15:58:34 +0200
Message-Id: <20180427135735.038395432@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908674936304034?=
X-GMAIL-MSGID: =?utf-8?q?1598908674936304034?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit ac3d021048be9edb825f0794da5b42f04fefecef which is
commit 71e7673dadfdae0605d4c1f66ecb4b045c79fe0f upstream.

kbuild reports that this causes build regressions in 4.14.y, so drop it.

Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: "Hao, Shun" <shun.hao@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/microblaze/Makefile |   17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

--- a/arch/microblaze/Makefile
+++ b/arch/microblaze/Makefile
@@ -36,21 +36,16 @@ endif
 CPUFLAGS-$(CONFIG_XILINX_MICROBLAZE0_USE_DIV) += -mno-xl-soft-div
 CPUFLAGS-$(CONFIG_XILINX_MICROBLAZE0_USE_BARREL) += -mxl-barrel-shift
 CPUFLAGS-$(CONFIG_XILINX_MICROBLAZE0_USE_PCMP_INSTR) += -mxl-pattern-compare
-
-ifdef CONFIG_CPU_BIG_ENDIAN
-KBUILD_CFLAGS += -mbig-endian
-KBUILD_AFLAGS += -mbig-endian
-LD += -EB
-else
-KBUILD_CFLAGS += -mlittle-endian
-KBUILD_AFLAGS += -mlittle-endian
-LD += -EL
-endif
+CPUFLAGS-$(CONFIG_BIG_ENDIAN) += -mbig-endian
+CPUFLAGS-$(CONFIG_LITTLE_ENDIAN) += -mlittle-endian
 
 CPUFLAGS-1 += $(call cc-option,-mcpu=v$(CPU_VER))
 
 # r31 holds current when in kernel mode
-KBUILD_CFLAGS += -ffixed-r31 $(CPUFLAGS-y) $(CPUFLAGS-1) $(CPUFLAGS-2)
+KBUILD_CFLAGS += -ffixed-r31 $(CPUFLAGS-1) $(CPUFLAGS-2)
+
+LDFLAGS		:=
+LDFLAGS_vmlinux	:=
 
 head-y := arch/microblaze/kernel/head.o
 libs-y += arch/microblaze/lib/
