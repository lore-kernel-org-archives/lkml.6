Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227JhOjsLXRffG9mh4cmR9pQ/HidevInXGchtDCik1WabUoLVWnj1krjeH1eXmQxGWus7Yyt
ARC-Seal: i=1; a=rsa-sha256; t=1518708523; cv=none;
        d=google.com; s=arc-20160816;
        b=hovL6inyBAZS/8KxaW9LrMoRtYCJaCbi+v1Nz/ve99jDIgg7msCoGmB0NAoFM7kPnn
         KE3nfQ4Iv4SZYPUSt0a654ijQc3rbDhmRVOg7Bup5VL+rLsh5W22Gj9DoZy5ReBrbdMJ
         6MGSDe8pN/uJCPoY5AU+SGif5ESgTBdTBaWlluLOaBmghQ1Y5RhDpmv98sG82BABS76a
         tL4EA+n1doRSHuYIw0RKZXL3IBB7DfhZGJvGZK+GdwgquHAvyRPoFbrCWlRei6wGeaYO
         klYrfVPpkfVTZH75wsdPJv1C2gbg3bY/b/W44D4On+RTCdN7rJyJ2NCG+6KRDbbVrfvD
         CJGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2Uvck40xrcoe79THcPDkTg+Ya/A+Rb4usn8cyn7miuc=;
        b=iJcY+g59mcYbIoOpSSDCn44P9zT1plyYb7AkAA2jE3jq4q7GO7WSOF1x7iCB4ecSbt
         PhTSRXnFvRiMO+JndoXRRJY1IAtovKZgieNCSz9aN7XxyRaFZZCNwql3INytuH/wYj4S
         1xydimEe0dxytFYgEJjN6MIlIhevIEkd1uiGO7KQNO3xSBpXT50F7keITWn9C+tvykcL
         iLweBCp5C1HdOmsco3JWMrW8QjJpSLx1CtiBXuUkAi4THinFQ0f/hNrI70NSKIKNPbji
         uS2HE0uRQ0HRXpwFoF/sDdP94vDXsRdUnfahqYbU3n1Ai3CPVwNTw29QAsPKTQo+5XhQ
         rm/A==
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
Subject: [PATCH 4.9 73/88] alpha: fix reboot on Avanti platform
Date: Thu, 15 Feb 2018 16:17:40 +0100
Message-Id: <20180215151232.634951946@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480766762352193?=
X-GMAIL-MSGID: =?utf-8?q?1592481308901241959?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -143,7 +143,8 @@ struct pci_iommu_arena
 };
 
 #if defined(CONFIG_ALPHA_SRM) && \
-    (defined(CONFIG_ALPHA_CIA) || defined(CONFIG_ALPHA_LCA))
+    (defined(CONFIG_ALPHA_CIA) || defined(CONFIG_ALPHA_LCA) || \
+     defined(CONFIG_ALPHA_AVANTI))
 # define NEED_SRM_SAVE_RESTORE
 #else
 # undef NEED_SRM_SAVE_RESTORE
