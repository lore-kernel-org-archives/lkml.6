Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2250lSfk2cCiisWyNb++mrKX0+yvdfEzZx82aCtSYoQ3UfHtz9NFmXfUjIN8sAsYVJ+pw+bZ
ARC-Seal: i=1; a=rsa-sha256; t=1518708598; cv=none;
        d=google.com; s=arc-20160816;
        b=MMPHzUQ3tCfEAKgwdyqwJlf0MrfDjvorjOxUZNwIAmyhJ4lBnuvifT5bssJ8C7kJQi
         idQsulFw+YsqzHs4aw9ysFcQiCQlYHVeSsimAZ4A7OdxoevpuJhaW/0zetKPfEvSgZhO
         OTIh07fopHeFusNYWomvAAqIbpe0TS6u3bwQJ5UXyR6CgxlXgmKDG3pBh+FaMcioLXNq
         ezwci4n90hecIUlWNEexZfIw8EaWY3p7l3uKpq2sku0DWEcMhaHmwD57FClxspnTW/3t
         6Imf06Gaa1tQHpzkMvjEh+MGPxVPWQx2PKhSAf8cboN2IOmhUn5Bu+4Coky0Hc5hNxYJ
         u4GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=u402gGmaPaAfni0gPyvzMqQSf+oDXFd0Fzs8JCDMniw=;
        b=xilNrQzaMJb3rn9tKwO7t7Z6Zp+wuS2CgZbaIM7aAPHg6hCTntGA8ItMrFPC/Ovzix
         xtsRRVjvx45umjqpbQD/rE1oMaFYNNScygLe+SEKmR1sT7ENaUyc+/iOZ3cyUPzeQO9U
         7oIK+5dGo4zFVYpgi9qF+GtxaG2Wdnea1emgUBIN/E4xY9lUyIV5IP8yOYOK0Bky5CD/
         5Z83m4FtkOP2PtOaidGsShrXs5aACyN3/r4BMGZqlmv5ssuIDtJ+FUe51CyELGCp5v6D
         NbytlzBHjAS5hMCMgReIa0hFkEZ2xNlM/+j2uiegtM2t6igwMGeVnNsZ43fGtFbj06Q7
         YiBg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michal Suchanek <msuchanek@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 002/195] powerpc/pseries: include linux/types.h in asm/hvcall.h
Date: Thu, 15 Feb 2018 16:14:53 +0100
Message-Id: <20180215151705.864138492@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480899715300330?=
X-GMAIL-MSGID: =?utf-8?q?1592481386819607035?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Suchanek <msuchanek@suse.de>

commit 1b689a95ce7427075f9ac9fb4aea1af530742b7f upstream.

Commit 6e032b350cd1 ("powerpc/powernv: Check device-tree for RFI flush
settings") uses u64 in asm/hvcall.h without including linux/types.h

This breaks hvcall.h users that do not include the header themselves.

Fixes: 6e032b350cd1 ("powerpc/powernv: Check device-tree for RFI flush settings")
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/include/asm/hvcall.h |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -353,6 +353,7 @@
 #define PROC_TABLE_GTSE		0x01
 
 #ifndef __ASSEMBLY__
+#include <linux/types.h>
 
 /**
  * plpar_hcall_norets: - Make a pseries hypervisor call with no return arguments
