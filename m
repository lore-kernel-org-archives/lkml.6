Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226xbFqQ1GgzNTIUDPeXQY22rFlX6Hc0eHJ6udr8FBK4xHhfWLrmlpgGxsMT0J5LkFplTLkN
ARC-Seal: i=1; a=rsa-sha256; t=1518709129; cv=none;
        d=google.com; s=arc-20160816;
        b=dmKhPXh2WuwQmJ0Gtds9EOWlX4lYuE0j74URNYR7evyO7jgX7x06VN/21mcmlExEn/
         a+488tF2nC3m0yKQIgqLIhIk9VlYS451fL5PTYa6P8CWSp1qERiapHtfTCdslgLDNPDr
         UTgQ1fQVYFHypLWu+uoIsdv4wB9QFk3xyjIAjBMTsMaA19HLv2KnFByUL2OOr2QnfRP4
         O0d5iwBfui+vAqLOvszCSQKhzEhRMnwl2ZY83oM6QuAAb5vfADkbbZkAGUkOO+v/1Y2m
         YBjVIy8XWN+ZsHZZyy8m8o4Z2K9eVZwGBPP3WbUzV/TdkEXW/B3vWxg4k1jDFmcBAxGq
         wl4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WC95Ma9KsZaFNGqpX03fpEmWD1Jr0wDa2FmwVT+ouzI=;
        b=Ry5SG+b/XEI7xFnbQKxYBke++j7ac2O2qXT/J+DhFgTcyO09HzDTs5H14DYdMFbRmZ
         7TVsCPDYTUSvujthBQHzktt7l95n+WfVQXDBt7LF7LelGI8XJ46oDTUmbrdBFchdcYvq
         9RqftRGKG+X+rEiKRN+KeaXdG2GuGVvqsrt29Dcz5g+Go9/ZogU8GCP13cMkMGvkNR8a
         7mKAmlTtXndYcuV2Ouni+xeunF+Uwpg1P0by97KsFlOeQswxehH0BqNUeqnxUenm+q3q
         DOVIiiA+mWMulsUlGnmxZSDIBIX9A0C9PaVHFqw7weg53I7lWsGtjr2EWBVPBIlAbB8p
         UpYw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	Matt Turner <mattst88@gmail.com>
Subject: [PATCH 4.14 167/195] alpha: fix reboot on Avanti platform
Date: Thu, 15 Feb 2018 16:17:38 +0100
Message-Id: <20180215151714.352697146@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480766762352193?=
X-GMAIL-MSGID: =?utf-8?q?1592481943970299936?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 55fc633c41a08ce9244ff5f528f420b16b1e04d6 upstream.

We need to define NEED_SRM_SAVE_RESTORE on the Avanti, otherwise we get
machine check exception when attempting to reboot the machine.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/alpha/kernel/pci_impl.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/alpha/kernel/pci_impl.h
+++ b/arch/alpha/kernel/pci_impl.h
@@ -144,7 +144,8 @@ struct pci_iommu_arena
 };
 
 #if defined(CONFIG_ALPHA_SRM) && \
-    (defined(CONFIG_ALPHA_CIA) || defined(CONFIG_ALPHA_LCA))
+    (defined(CONFIG_ALPHA_CIA) || defined(CONFIG_ALPHA_LCA) || \
+     defined(CONFIG_ALPHA_AVANTI))
 # define NEED_SRM_SAVE_RESTORE
 #else
 # undef NEED_SRM_SAVE_RESTORE
