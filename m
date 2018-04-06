Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/w5eyd9gSJgxpIO77ZyctSfXx+d2TNSi/P5qp8o3xMWtqoRVivim0gHPMurczL9v9qMvfN
ARC-Seal: i=1; a=rsa-sha256; t=1523021739; cv=none;
        d=google.com; s=arc-20160816;
        b=lq7J4393wXdkgBJA6rDMS/Hfo8cjA0nYit00Nv2fVd4Gqf5bx1xiUkSQafV8494Vdm
         vvcZAOjBfYEbOsUfdCy9E0CHnt6qDrXo4M1OWWMxuCVpY/arB8Jh+wopzVbnXpnhCNuY
         OFBcAqKY1V2HnV4zZA+hwvDrsr6c48xp+3Sb/+fAI8b8GJRDinpWD2LLVuqgpQZY1Plw
         zlTC/jUQwz7KGYlCUIGOGnwtgz9pmbrt5OLtpm6/ykZIbvA1ixD4Ys1efmgONpwzx9GV
         QiJ+7VKs5VVLocp2PH4mR4lMtBRq+4dKAfBP3ANBs0CTfZZ0GDanBQHE1n5FfxF5jafp
         7+yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=eXmmJwNuyQUSHopUOQxeMh/dyNX4kOGghxe1EybGIaM=;
        b=NXadEcFLaI2Nyl/fxVc4aeEBD+eXwMig4OyLcRXzXkdDcbjcqkjVHmJGMh8AJIp/42
         YN9WNuIRQDOy01mMin8o6KMwS8LC675dORJUEycdkHni0R3r5dd5fclbp7+PTQtW4SEV
         8codLJFGf8QC5R4C5ACoCLAeuYbNNMbrc9eboFlE/xNMmo2C6kzBzk5OSi6fQ6v1kCrJ
         Ni0iRPTRwOCT3lwo2D1DfyL1XDgMDgq3y+bgjSvLFbP75cBTzXuVjozmCAZoq09IaBMA
         GMd/t4OrWkI/gW7UTbe0Is+n1M+7GqgjLuENVvXHgW1cTkx7BTF2m2wvY7reydQWqvWA
         UvkA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Greg Hackmann <ghackmann@google.com>,
	Alex Shi <alex.shi@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 4.9 066/102] arm64: Kconfig: Reword UNMAP_KERNEL_AT_EL0 kconfig entry
Date: Fri,  6 Apr 2018 15:23:47 +0200
Message-Id: <20180406084340.808351201@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004043895209602?=
X-GMAIL-MSGID: =?utf-8?q?1597004043895209602?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

commit 0617052ddde3 upstream.

Although CONFIG_UNMAP_KERNEL_AT_EL0 does make KASLR more robust, it's
actually more useful as a mitigation against speculation attacks that
can leak arbitrary kernel data to userspace through speculation.

Reword the Kconfig help message to reflect this, and make the option
depend on EXPERT so that it is on by default for the majority of users.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org> [v4.9 backport]
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Will Deacon <will.deacon@arm.com>
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/Kconfig |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -734,15 +734,14 @@ config FORCE_MAX_ZONEORDER
 	  4M allocations matching the default size used by generic code.
 
 config UNMAP_KERNEL_AT_EL0
-	bool "Unmap kernel when running in userspace (aka \"KAISER\")"
+	bool "Unmap kernel when running in userspace (aka \"KAISER\")" if EXPERT
 	default y
 	help
-	  Some attacks against KASLR make use of the timing difference between
-	  a permission fault which could arise from a page table entry that is
-	  present in the TLB, and a translation fault which always requires a
-	  page table walk. This option defends against these attacks by unmapping
-	  the kernel whilst running in userspace, therefore forcing translation
-	  faults for all of kernel space.
+	  Speculation attacks against some high-performance processors can
+	  be used to bypass MMU permission checks and leak kernel data to
+	  userspace. This can be defended against by unmapping the kernel
+	  when running in userspace, mapping it back in on exception entry
+	  via a trampoline page in the vector table.
 
 	  If unsure, say Y.
 
