Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516026-1519835031-2-10760575763546207119
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519835030; b=dtgPG3SQHM1d+OFCfVWawzFHqMrM6wI2IXBJDg0/+ZYXkS3
    PGxlbPNtVV5FJl0QFMYGP/i3+hWZtV3jhFc/phTbUpDZKUvZSZGXRC6qZVavrFjy
    4x6jIG8z1w3HPzFAY9Prhh+XXl6hieHNTlCwQ57AXIgZtU8z8eztds4ZBpKi52Fb
    EmijoNgcCLBlb0uZ8iBZ6M1EmgdgLB/dbtsMNg9XypaZJqgaspKvl1GY6gmzEjiM
    gPk6TSykIzFF81Rxs9hG3jNQZAOnxXz2Z/nRKnIFndGiSw0SCDylysf2SOUmBNeC
    QDAd3L/tonIl7NeT8VXsPG/HzxTgcioknCxqsgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835030; bh=TAktqIkCtoBJk+3LKfa
    nRen4QHsxylU/sbwuEzKroz4=; b=MKA2ToLKzqqzn37nROHDxpQdJLF0oH5Gr3U
    FaCfsLacRtpJaROsGBzhcMC7ixlNj+OZ9Gl9uHdBZEZMRWxoZ95Xh68WvAkhl7Jh
    +K340YkZQNZe1MvZlp4wDDhEVIUuPyPL6cjT10SOWLh+oTW+fxXmAEjzBBQMnh42
    OVn4ZjWrbpgppGDi7ngD++xV63dRRLvNSHuY0C+NcvjmWvaD05FtbT6mKL+xdaol
    emB0YHuIk3ZFWDX2AL4v/WcC8AOabRzc4EiOpWuvz9ya213wA0jrOfO5fYCEhpYy
    S5P+pKXebW9OOCjpLTlnnq8pSHcaho5ryNCymQeqabAqWtsv2Fw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934676AbeB1QUr (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:20:47 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35382 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935188AbeB1QUp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:20:45 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        "Liran Alon" <liran.alon@oracle.com>,
        "Nikita Leshenko" <nikita.leshchenko@oracle.com>,
        "Wanpeng Li" <wanpeng.li@hotmail.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.717927981@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 004/254] KVM: x86: emulator: Return to user-mode on
 L1 CPL=0 emulation failure
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Liran Alon <liran.alon@oracle.com>

commit 1f4dcb3b213235e642088709a1c54964d23365e9 upstream.

On this case, handle_emulation_failure() fills kvm_run with
internal-error information which it expects to be delivered
to user-mode for further processing.
However, the code reports a wrong return-value which makes KVM to never
return to user-mode on this scenario.

Fixes: 6d77dbfc88e3 ("KVM: inject #UD if instruction emulation fails and exit to
userspace")

Signed-off-by: Liran Alon <liran.alon@oracle.com>
Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Wanpeng Li <wanpeng.li@hotmail.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5009,7 +5009,7 @@ static int handle_emulation_failure(stru
 		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
 		vcpu->run->internal.suberror = KVM_INTERNAL_ERROR_EMULATION;
 		vcpu->run->internal.ndata = 0;
-		r = EMULATE_FAIL;
+		r = EMULATE_USER_EXIT;
 	}
 	kvm_queue_exception(vcpu, UD_VECTOR);
 
