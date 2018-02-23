Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227eJ0SpEJVoDgp4KfIosRgk6LB8Wphfc1M62YcSHdVroplDbKxvSCB9zvIxEjBhnvLglcps
ARC-Seal: i=1; a=rsa-sha256; t=1519411086; cv=none;
        d=google.com; s=arc-20160816;
        b=o/YZcTt6VR9gtMifpJL1R/r50a05lyM2X95TFXzqvP1j6g93r3o3r8J0kV+8LKfNvl
         ZdqwXrAUCK3esCzqCxm3Yqm/nZ+Nppfrbexsvl/fjPKTVGscyivBXYOvX0drbmrdmQmm
         PqbNegZ6QWm+9pOE8ZpDH9zGWR0mKRuTqr2Di/jNglBplDxa7JPupu3vMfazUT6SVllt
         jKnTefmR06Ro9gQpkSS6BR0Kr/Ake6o84t8sDPT8yHjpP/XBJmDza+AgHpoWMT5G9Bxl
         g/AAkF4PXilpj2B9S9DURAbLrGl5TCa+dAZDI8BSPj8/USGp8aSC19z3pX70xVSh1vj5
         9bzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vZiUbiQjfpD3HYoYTh/I56mRajqZdZOuCI/V7Go8O/8=;
        b=frWoLMfj9nSmv4qtWdygVlQT6PBwSZWYwdOMUZGB4UYr5GDeIg8dLIxGTOrYmbXksU
         tzSTiSL1smx+Fm2oS2DP6v3arAWlA9nf9BMkOQHAW4FGV1MCjn4ix8cS1W3CVzDBzU9m
         G9CoWQ94gOYJONAmD8oJS5CWhFrIQUE9VHtDkKTEtAjRTGRzYxbE/l6GPA2T0mCDOs/S
         NkviySh2W5Rv07QlW8/s70RymineUsw+XKu3eOf3lqGULunfqERGmy6FY5wR7pJnGiZo
         Ap9e9Sd1DuJdyKSx26ExgTR3+Ljw8YJ1MytiMrXSP8dnavDAD51Ev8KePR6vvKff6sNp
         y7xQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.4 078/193] arm64: Kconfig: select COMPAT_BINFMT_ELF only when BINFMT_ELF is set
Date: Fri, 23 Feb 2018 19:25:11 +0100
Message-Id: <20180223170338.273458126@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217998928383123?=
X-GMAIL-MSGID: =?utf-8?q?1593217998928383123?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kefeng Wang <wangkefeng.wang@huawei.com>

commit 2e449048a25eb75d48dff12882b93f26d130a1c6 upstream.

Fix warning:
"(COMPAT) selects COMPAT_BINFMT_ELF which has unmet direct dependencies
(COMPAT && BINFMT_ELF)"

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -785,7 +785,7 @@ source "fs/Kconfig.binfmt"
 config COMPAT
 	bool "Kernel support for 32-bit EL0"
 	depends on ARM64_4K_PAGES || EXPERT
-	select COMPAT_BINFMT_ELF
+	select COMPAT_BINFMT_ELF if BINFMT_ELF
 	select HAVE_UID16
 	select OLD_SIGSUSPEND3
 	select COMPAT_OLD_SIGACTION
