Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu5lVCEBfohqM00KUqq2zxEEPiJv8zbj2IxcgCwYi+O4pOhn03T0n26RdEuIDzncw8MuXY3
ARC-Seal: i=1; a=rsa-sha256; t=1519411309; cv=none;
        d=google.com; s=arc-20160816;
        b=xUCmtCOnI8UmPWjuF6Jbx3zFa3n2I+2NO4d+PENX+BkbzgM4CkGWhJp4SbUoCm77VO
         ltbYk+wGDPdMfpTqz0C3YXf/4QdrqlgHsP+voI/oWhLa7OqGXLz+3V3H1rAWRkesFICR
         c5Mg4yU+QlC4dtOVK1ghnZwQjvqVEgdgi+EPwesa5iiISORvC/8dnOHOrpW2MO6T4eFZ
         k1eDsvgfoOEd7VrTfXkFHnx3+/l6znIGG35xwNERJMMbTneY5PfJGaTnjWXYV8WxaR2N
         EbDh+0DwphVr1ir3CbWw+A3M67d6b9Eym5AAuy9wD92ioJ5tGhPZX0T8qznAjbQ9xTkm
         OW6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=77/BU3eTFpM0XQNpp8v6WxJpcfj7MzNnURGu7VJF32o=;
        b=SzGwceKP0U0B/Pe42g2Nh9A+kK76S/LMCdjvDTntptILU7QZwXdgTk0YP2ta1x+7y+
         EDCgTkp1YbKJZk14gOnKyqtPKGq/ZX8BUKOzM1HGVTyeg1V08MmxAbNT+Su29KoRqtxj
         CIjj3ZASipGW94d9dLe68cisGs3jsySOWUNttIx9jDA3Xcps5w+3uW8wM4mOYpyqUgD1
         OPuCZKKlyTAinqQx0KxXF0Sz9Q2cHF3h3s6W7UZU9VBD/pWWq6Ob8wRtUUkOdYFtPm4T
         8SwYEUTP0+dnePYblUv6OBqZ8/3UxC9ysXBwuYXdAADkAksL7QGdGafe4oCA5DsORifo
         WZrw==
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
Subject: [PATCH 4.4 191/193] KVM: VMX: clean up declaration of VPID/EPT invalidation types
Date: Fri, 23 Feb 2018 19:27:04 +0100
Message-Id: <20180223170356.343070253@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218232987820369?=
X-GMAIL-MSGID: =?utf-8?q?1593218232987820369?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -400,10 +400,11 @@ enum vmcs_field {
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
@@ -420,8 +421,10 @@ enum vmcs_field {
 #define VMX_EPT_EXTENT_GLOBAL_BIT		(1ull << 26)
 
 #define VMX_VPID_INVVPID_BIT                    (1ull << 0) /* (32 - 32) */
+#define VMX_VPID_EXTENT_INDIVIDUAL_ADDR_BIT     (1ull << 8) /* (40 - 32) */
 #define VMX_VPID_EXTENT_SINGLE_CONTEXT_BIT      (1ull << 9) /* (41 - 32) */
 #define VMX_VPID_EXTENT_GLOBAL_CONTEXT_BIT      (1ull << 10) /* (42 - 32) */
+#define VMX_VPID_EXTENT_SINGLE_NON_GLOBAL_BIT   (1ull << 11) /* (43 - 32) */
 
 #define VMX_EPT_DEFAULT_GAW			3
 #define VMX_EPT_MAX_GAW				0x4
