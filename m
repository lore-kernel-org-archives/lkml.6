Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2389914-1522789173-2-8036909004671505585
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES dacaen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522789172; b=n/2uILOvr4yVI0HxMzCKZ0LMq7/HdCnagtNZD2+2Os1ZH1YfgD
    k0eD3plRkhnh8B4x8xNARYSdiNtumgNuchr9kAWuCDusPo1jYwt/FxLD1+o/8cTZ
    DjPKl3YS6mPIu1W8pZUECBYCraQaLcNdLQD/MlzDqCxb6TTV6FD9D8U6YtWeT1LE
    TTHnZFYEh8s5EMgfv9HC4SuUpNnN8WcBGbfdgAOSWL43tpQaOsLn0BlrZMEIbg1Z
    QvAmpIcmiGgvbPaqYKZJNwjHZLrspJ4tGAuGNDw1tTxh3Dp5lWDBv1QBNJ0YiKL+
    4sv7pzGtb+Kirb2YOpcSdGaRDFKSULQU8RlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:reply-to:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522789172; bh=H2R2Z
    xiYuwAf7m5g9YT98v4KlUWTB6ngzl7wAKpB9Ks=; b=Ndjrw8qS9wim7b0PpJpbZ
    M1B//OpgHXWbKtrvXjjKe9ddM9uv2+acPHyVpLf9qMLAGzD9FbDiKstQqc+uLq3/
    nKeVp5FIXajXyd30v3ubDLZv1JysE04/a87Is3an0uGZs9uTABY0Ew28jgFZ0lDq
    5ww9DprkWapJWNQPPBN4BD9q+BdLTeFm5rhH26HE3XHs6xKrMUQD5eD/R2pGXaa4
    dqDHWOaKTzVSslHu53f7UKwTumFzSlJVBaw+01yyIt3evzKQXP4fefHyjzeWCgk5
    S2x06cCBiammMDVdKp0tUx0bCt3J/isOXpHZ7KdPPCI5fy/ojqTH+pG19lLVM3xB
    w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=MYZJfekE x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YJx9+AB6;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=MYZJfekE x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YJx9+AB6;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCBVWC/zQ8bTFnGcGVbuCqBFpQmsFhXOtejw9crRZ9SOm4nnLgYyOx23EVE9b6HUx54DXfR9qbYp/E/0ftEeQa3dLsbKcsaHymOWpPHBRhtTLtP7+Jzo
    T7N141ObqOrEtuU2roVm+2iY532ztefaAT1wtwYhM7viuBZTL3zoSW1w1GUnHeIE8GXyJfiGBWMmb7Zg6B9DASrL45H18RrutJK134mHxMOqmowoR8CpO+u3
    C65dC5+mUD9hxVXND5pWUw==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=b8aGf-dT0oUA:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=yMhMjlubAAAA:8 a=DDOyTI_5AAAA:8 a=Mr14mP2xmx9isVhkax4A:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4/VR1bfzijH1jK1H57motnkHiDykk4ltZS/pbjiwh8bDk+vrjZeFmLMw1JHCe0JeePuF6HYeA==
From: mhkelley58@gmail.com
X-Google-Original-From: mikelley@microsoft.com
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
 vkuznets@redhat.com, jasowang@redhat.com, leann.ogasawara@canonical.com,
 marcelo.cerri@canonical.com, sthemmin@microsoft.com, kys@microsoft.com
Subject: [PATCH v2 char-misc 1/1] x86/hyperv: Add interrupt handler annotations
Date: Tue,  3 Apr 2018 13:59:08 -0700
Message-Id: <1522789148-1787-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 2.7.4
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Reply-To: mikelley@microsoft.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Michael Kelley <mikelley@microsoft.com>

Add standard interrupt handler annotations to
hyperv_vector_handler().

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
Changes in v2:
* Fixed From: line
---
 arch/x86/kernel/cpu/mshyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 4488cf0..20f6849 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -41,7 +41,7 @@ static void (*hv_stimer0_handler)(void);
 static void (*hv_kexec_handler)(void);
 static void (*hv_crash_handler)(struct pt_regs *regs);
 
-void hyperv_vector_handler(struct pt_regs *regs)
+__visible void __irq_entry hyperv_vector_handler(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
