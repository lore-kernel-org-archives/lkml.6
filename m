Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoYC3ViL1lg6k8n8Z3H6eqe8sZqLgZjv/GYViyQ/nJMYqMmB+JxMI3hu9s/OPV/vT0CMEYQ
ARC-Seal: i=1; a=rsa-sha256; t=1526937665; cv=none;
        d=google.com; s=arc-20160816;
        b=RyRnJztzb59QpeV8JgzwVEkUq3k/tkKi4cLYhI8phyrK2aXs6mOqjSI3py7D6v4UtS
         5z03m9J9Q2G6TFVQvwJ4Q2HHenvnJMwZwYCePAp9wUqaSaj3cYVx8+QsNj2ZZmBeHp71
         vzPL4u8d/8mUGnhE7fcMgFRnoAde9sWFel1WNGhW3FdujauHOCv/Fuup+Wu1WXqa/D+g
         DLuzRJMZZkLb1rsHMI2cO9QSNBHRmhj1oIhdIYuhoF7xYzbVFuG76lUVY450MgEya3r9
         gcktu3KFY4KjEdnGmCRigvsupbtjqN4R1aPX4jq+EBy4Pc9TY8KEXXLtLGQTCBULGOE4
         ET9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=4QX8vpsDjjkH/+TYWIa+PQ6IgEFqWSUVtxW6X71VKAg=;
        b=GvS0eG6jy8F+osHNf/c+q/0DYserEJ5mOKM64MO5/YCTGVg0zXudnLNBrWwSVgLKOy
         dkZYUq2ysUtq84WtRRtqBgQOAlJk7fTHaLrp+qloJk4n3KMKXQMqsRsUv9F/U5iyebIV
         hLSD+sbP2paM0+SYn5kEIeFyya+prwU9t/Y4eY3AU7keZoU32Q/1R6O7DXXEpAHdcfpc
         0PLkwwy0ScP3gWKzusixUjwUNJS6Fln7gEHYO8arQLt1PiTdn/2ugvLMwX04fFS1iymq
         pKswhCdx8awdRGaI/TQ58v3hhsrOHjun6bLFIJ7PfX4d+0RYns/DzqUcYsGcsRBPt4UV
         zCwQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=jwQp1Rnn;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=jwQp1Rnn;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jiri Kosina <jkosina@suse.cz>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.14 77/95] x86/bugs: Make cpu_show_common() static
Date: Mon, 21 May 2018 23:12:07 +0200
Message-Id: <20180521210501.834999782@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109910295501859?=
X-GMAIL-MSGID: =?utf-8?q?1601110190062665176?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Kosina <jkosina@suse.cz>

commit 7bb4d366cba992904bffa4820d24e70a3de93e76 upstream

cpu_show_common() is not used outside of arch/x86/kernel/cpu/bugs.c, so
make it static.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -640,7 +640,7 @@ void x86_spec_ctrl_setup_ap(void)
 
 #ifdef CONFIG_SYSFS
 
-ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr,
+static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr,
 			char *buf, unsigned int bug)
 {
 	if (!boot_cpu_has_bug(bug))
