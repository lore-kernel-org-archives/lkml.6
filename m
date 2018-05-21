Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrE4QgcbDJrDdHgEeYEeik6MR1p3vpmGu2BFFIvXoQ6toKAdkCmVYQEjU1FPIb8IGZoUj2y
ARC-Seal: i=1; a=rsa-sha256; t=1526937399; cv=none;
        d=google.com; s=arc-20160816;
        b=jZ34aZJowtkLjZET+aURcJyzaWhSg5Z8hVrijJQaruEYLfFV9zcHXDu6f8CktU8hT4
         YxX2sxc0XTYH1eBmRHhme7AlvFmx2/CpJIkvzJER+YRMk1ncRB4DRniPehZnDKOELM/A
         f6qRgsph60XEUvBw0MmwD58kxhtnZEHOA/VFaCyf+GF3EL3xpQlFTsWz4jJEHWjfbJjc
         6QuOvRCbe4UimCBAaYKnyFO3O/mY6ReOm07fL9fmDhrOifffv4ezsldbMDFBbyoPPtS8
         SAUDdr9d0Y8YRFquJ97Hbj1MzGWhISvXWAHcBzRmYi/OVn4YLbuFkt/UBIBYS7TBS5EN
         /2fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Z1qfZVsBLFdg5bQo3sBpdrBhnPoQZDLoz/WvMfMhoak=;
        b=hsFRBr/CmUtfCE2WJ964PqVJHo3UVf1JdnPPFjvAsKKXiTjI6/yVZPPzHrKNL2/T9+
         fFfldBWlKmVhcGSQPT4xNN4NGy+nNpFP3cDnuFcgYCSF8Gskvy8+GYTs5lpolsQW/FYH
         Y9tzyYi5hNMFzgK1rlpWNd+HjSw2Ej88Mgj2xQzh1d+0y4S8YrCMBtZIaEKIEQYBXU3l
         b7iuycNyeeh/kXMk8FpSsQKAIGrfqmz3c45JPZenXuR7tGFO4ZIta1yTS6gAdynPfjx9
         4LEOL2Pjfa10QKcyQAl1/6lgZ56QDlm18ql1lm8P4saRj1DjzXVtmB6Xi1XDbvbslcDE
         xZyw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=xCucgbWe;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=xCucgbWe;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jiri Kosina <jkosina@suse.cz>,
	Thomas Gleixner <tglx@linutronix.de>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 68/87] x86/bugs: Make cpu_show_common() static
Date: Mon, 21 May 2018 23:11:44 +0200
Message-Id: <20180521210426.062438550@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109910295501859?=
X-GMAIL-MSGID: =?utf-8?q?1601109910295501859?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Kosina <jkosina@suse.cz>

commit 7bb4d366cba992904bffa4820d24e70a3de93e76 upstream

cpu_show_common() is not used outside of arch/x86/kernel/cpu/bugs.c, so
make it static.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -639,7 +639,7 @@ void x86_spec_ctrl_setup_ap(void)
 
 #ifdef CONFIG_SYSFS
 
-ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr,
+static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr,
 			char *buf, unsigned int bug)
 {
 	if (!boot_cpu_has_bug(bug))
