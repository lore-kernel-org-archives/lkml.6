Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2283457-1522785524-2-1453879383324451270
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES daensv, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522785524; b=RfwPsdAxXKnculp8Bba8EK8GRAbwPQQu51ZSlXwDz1ayG2WYGe
    E3QKf6YkXhVVibuqW2pquwQEGgslKElilvBw87FMdS60jOqyjNSNW6+fQ8XA0oPp
    Prbs3Vdzgt7qWPeNJB/OjI9QSNiN0nDHrn2haLteoR4Q+M2i8onP1nzGeCnPx/QQ
    9Y7ZeMkKxGsTj+Q4dunBE1p8z1J0SbM6375qzr8e7wloYx/+ingc42UlNJtBybCR
    0+dCk0YSMK5HAum3fKwGueguvebGGhLK4VrTuZxh5TQ4KgSTxNpa7Q+uZc7sGVUj
    v32dpysIW8+ThCBMBiv3iu1C0r9kuj+oyXcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:reply-to:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522785524; bh=GnZzN
    ILVVHe9XTjKO8AJ7fXLoNViFIqb6gRu+mYLUgA=; b=CCER+MCFMMpMfa/7vvotD
    Px/YgY9TX/qbjslTM6/fh8dI92ooaCJs9WvAi8kQ2wJXZrscQ9DL2p1r6ZMW1zma
    s3SCrpSrTaVXVDVR1ZRcQIy2B+eBFsISNzN1xczIySl0hxwqAFja2Tveakb0La2U
    oVkipn/K/VSlRYe/QTPKpDmXDHKfcDTi6Hau024+UdP8NUREL6YdlKax0GyZmx5z
    a2Ep3IR6k/bslksBpD2egqzbAUM40Y0QPZXxSsbvNtCIq+ebFEU+tECLIUw4uWA+
    0KNdF1zsh29u4JWniO0YL69DVcQDZbTqOdK2ZxVpqIQEnwvET4jZxDYPFNYBTtw0
    g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Xezgkf2e x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=caaZX7XJ;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Xezgkf2e x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=caaZX7XJ;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNS57cLUJYkmJkz99vEC7jW9SH9kqthCTKhjSlidXvqZjh+5i0fuXnF5JrcbRHMMpXtz3Y86feBKWJhu83bQ4HAPyIuFAsn7UeI8t0G7KtCAVZT9YYQY
    OobH2uLCS9LI93L723p50yB1DSVx+Nd3Cj8RXieL0N+em6Xhm/j9/xT2mnhDnBTMFpT4+ZKuKUCets0tC6v1Qlty4KTY8phUfK/1+3HszBA2InrKxp0PDtdG
    aKe8gXi9ttvwlmcR+tFP6Q==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=b8aGf-dT0oUA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8 a=DDOyTI_5AAAA:8 a=9Wu0NMqQoUBuZzJhhl0A:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx48jFuTyl4jTf5l5M7y8cGQKyQ7zFHHzCN73PN9EQ4W3IGM/2Y6quxd7/g5YEUd5amsoDD4Cyg==
From: Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mikelley@microsoft.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
 vkuznets@redhat.com, jasowang@redhat.com, leann.ogasawara@canonical.com,
 marcelo.cerri@canonical.com, sthemmin@microsoft.com, kys@microsoft.com
Subject: [PATCH char-misc 1/1] x86/hyperv: Add interrupt handler annotations
Date: Tue,  3 Apr 2018 12:57:35 -0700
Message-Id: <1522785455-1445-1-git-send-email-mikelley@microsoft.com>
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
Cc: mikelley@microsoft.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add standard interrupt handler annotations to
hyperv_vector_handler().

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
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
