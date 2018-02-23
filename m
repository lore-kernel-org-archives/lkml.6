Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2257r9IwoNiP/h6GfnroEOZflyMA5BP/2DQYQeQp6gtUdD5QVqMItnMsgemgR2iY2KGZtT7e
ARC-Seal: i=1; a=rsa-sha256; t=1519411730; cv=none;
        d=google.com; s=arc-20160816;
        b=g7aOfMXbpAeo8RYAkq6ZCNJU5/awARzAUPbseifIgjY3kEqHvLFgWwRVg2mr3ZVS41
         IhmtdUu8HVXm4ensCFAQY+v31YqHjrjyHUmwT+m1RBQxTJ8auyjHIUB3OcIhWl6RiPSf
         aVoUJTMyQmqLD23Sj0d0Qw8YTGpQXFXU9clJlX1mOlo7b5+JyWQHG7wcGZZThL1ffYAe
         CB+fsoTWWmqEDF2DRwcnhGjH2d5d+d8eZ5gReq3IasuCX/S1osI7GAUbGjo7x2SuXyeu
         V1C9tz099cPN43JYbmyJ2IMWsysVYwUlo9xW/A1XgaJQ9urX2+AXhnKDzZ5H5M2fQDqs
         F8Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZyAiG6DP4Xf9c93d4jNHErqAZwLBEI5o0UAWmAoQwPM=;
        b=rgF4lIpzJlLrq6ptE4cwJsiKRvJKNQjV8BKGV5LwxR/5rwz90Q4lIEZDgfktQ3ciXW
         HYADvLZJXml//vub77VXN5dava+cYBw9fEUYdADa2TD1AzjUEYU8CCjAC3TzZ85fd6OH
         LnIFXHJCOq3pCRTfDYDR8yRTO4l/JaxUD5l1qw2BHJ295hLYBZv7gCkD/KXr1CBbY7Td
         u0B3j7may93QkTnZms5VkP5JENmTifa3f0XOpqUn5h30KJMjhQt6AlzjgE7S/x9AkRRs
         PcNhpa0JYRY4GGEGmqAC5FKacV2v2y2592vtn7wWWGm8NHijKgZJ8wzIod4dVTojEe8z
         KaqA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jan Dakinevich <jan.dakinevich@gmail.com>,
	Ladi Prosek <lprosek@redhat.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	Jack Wang <jinpu.wang@profitbricks.com>
Subject: [PATCH 4.9 143/145] KVM: VMX: clean up declaration of VPID/EPT invalidation types
Date: Fri, 23 Feb 2018 19:27:29 +0100
Message-Id: <20180223170743.179670791@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218232987820369?=
X-GMAIL-MSGID: =?utf-8?q?1593218674224362211?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Dakinevich <jan.dakinevich@gmail.com>

commit 63f3ac48133a19110c8a3666028dbd9b1bf3dcb3 upstream

- Remove VMX_EPT_EXTENT_INDIVIDUAL_ADDR, since there is no such type of
   EPT invalidation

 - Add missing VPID types names

Signed-off-by: Jan Dakinevich <jan.dakinevich@gmail.com>
Tested-by: Ladi Prosek <lprosek@redhat.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
[jwang: port to 4.4]
Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/vmx.h |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -399,10 +399,11 @@ enum vmcs_field {
 #define IDENTITY_PAGETABLE_PRIVATE_MEMSLOT	(KVM_USER_MEM_SLOTS + 2)
 
 #define VMX_NR_VPIDS				(1 << 16)
+#define VMX_VPID_EXTENT_INDIVIDUAL_ADDR		0
 #define VMX_VPID_EXTENT_SINGLE_CONTEXT		1
 #define VMX_VPID_EXTENT_ALL_CONTEXT		2
+#define VMX_VPID_EXTENT_SINGLE_NON_GLOBAL	3
 
-#define VMX_EPT_EXTENT_INDIVIDUAL_ADDR		0
 #define VMX_EPT_EXTENT_CONTEXT			1
 #define VMX_EPT_EXTENT_GLOBAL			2
 #define VMX_EPT_EXTENT_SHIFT			24
@@ -419,8 +420,10 @@ enum vmcs_field {
 #define VMX_EPT_EXTENT_GLOBAL_BIT		(1ull << 26)
 
 #define VMX_VPID_INVVPID_BIT                    (1ull << 0) /* (32 - 32) */
+#define VMX_VPID_EXTENT_INDIVIDUAL_ADDR_BIT     (1ull << 8) /* (40 - 32) */
 #define VMX_VPID_EXTENT_SINGLE_CONTEXT_BIT      (1ull << 9) /* (41 - 32) */
 #define VMX_VPID_EXTENT_GLOBAL_CONTEXT_BIT      (1ull << 10) /* (42 - 32) */
+#define VMX_VPID_EXTENT_SINGLE_NON_GLOBAL_BIT   (1ull << 11) /* (43 - 32) */
 
 #define VMX_EPT_DEFAULT_GAW			3
 #define VMX_EPT_MAX_GAW				0x4
