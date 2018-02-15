Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224XQUofSSNOAzvrSQKJ+EtUwJ0FGp/2Dtxwr2dj03Awvl7LEsP5Lj9otxV02uVR8vURdFqZ
ARC-Seal: i=1; a=rsa-sha256; t=1518708343; cv=none;
        d=google.com; s=arc-20160816;
        b=jDiln3aXUkd/ssFirAOJMXwAkBjed0ullOdvkgfkIdac5PQBVQ7xC6PlA70x/ifoCb
         NOMWOIRKVbKeFB3tzVNoL9ugn3wEF90KuVGleaINvVaFa+SJF7Myry5S24KFreB3eXKG
         zMy3NjuCWCzE2hc/1zXRtcmq0y8CjCHCJQynU6is/8xHpERuyFaNUvXDppnezMvcCnB3
         4wX5ZYOaapONwoLeR2spf6Dv2YoPSPa9wIgCWZROBaZWmbtPisECVSVOWr5g2oR5SjWv
         s3JKNpNi+NR0nrAgRldtePRH9svaA2vJYLTTfl0xPkIAt70e1VAa3icNdH79hW9wVo7l
         O2Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=o3V+EiuMPmL2OS1O345OtkduBYSR11bpCZjKVFPOFw0=;
        b=0Dx7mkDyqJpanFnZmMFyGeiwm3M5tD1DOqzsPU0f8wUjL8lP5h/r2kIMr0qFc8ktcd
         /gBYtBUCsCWI3ILr83gTka1Wszy7hwbuOtZmHj2N+2/x2dx8k2/+CIENY0a3syBoOAin
         eg9Do3NQnuVPutikJ9GvTD+ACRyQtPPzw5rrl0lPkTxrZwaToSPWtNLDhUy29HUz9Pny
         dYSeT/nIkaBwkh2RLZUSkR8NX49jUUhqGy3O979F8Z7qx+2d0CqL4BGiViBmJpMQ5V9K
         JwplOpgJo+HGYEnJMVNTQorYB0alFRgAHw0bulEjSgE+UTOrU1erlbW2HXaa/0RlMfW5
         7cHQ==
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
Subject: [PATCH 4.9 01/88] powerpc/pseries: include linux/types.h in asm/hvcall.h
Date: Thu, 15 Feb 2018 16:16:28 +0100
Message-Id: <20180215151222.616200916@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480899715300330?=
X-GMAIL-MSGID: =?utf-8?q?1592481119322396640?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -319,6 +319,7 @@
 #define H_CPU_BEHAV_BNDS_CHK_SPEC_BAR	(1ull << 61) // IBM bit 2
 
 #ifndef __ASSEMBLY__
+#include <linux/types.h>
 
 /**
  * plpar_hcall_norets: - Make a pseries hypervisor call with no return arguments
