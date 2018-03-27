Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-23226-1522168430-2-17619302209997980446
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522168429; b=cBgK3kiprMp1Pg/54kmeu8rCpzaKaXIGzHcHiy6qb8KJ1aL
    WGvocNJZd+Vd5MtdksJ+ShnSSQrjAUCCBKMZZPZXUXLjlhyobBmizaWGXY/1C80r
    Ew0mduEzIRXTs7DdDQp2eAkJ1ASnCN24kg4qKgTVCECuF8hdmQy0RGOe5YYsZODh
    tGw2NXPiUWAuVmtc4p3rqmjNyiNHWgZkzxq2d8Swn6i3Lt8QiWC50/g7kRiJ+duA
    7RQyOS56uZ8xWHET42AsEcts2mrkUVe9qmRzoXs7C6M7Zklwk6mnbz3JaBb0RLpd
    Ie770uySfZW99+VEewgpeZE0UIxr4s/jtWYXy4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522168429; bh=sZkWULfHA4ywDnP/F9MpbecjlT
    ZAV2kBr/XOO/GBRy4=; b=jJ60JBC+QBqE/rVeLJr35mVt9etsYwhcnkUrMLIApy
    xFxzz5+hfXJPhMjdcuR2LNsnNBcJ3+iPZDXjN7qiUS4jSrHG6uluzrLfxCFtfuBi
    LVdk82PqYDTNzTmakTwno1zTiZtKG2YpHZ5K1BLbEPwglQYnVEE23XXUHiXnHx1k
    Z7U07q5V175BvyonPCGjTqu3M1y2VTgQlGjQbCGYFo5QiUBAbqUD4Eg6cZz+ikdc
    9KleFLJ1sd9/bhiQRelqmek0spCPVVcQV9CGwDZJFp+3p3ZiKmyDkpczp/0QFpyL
    jH4Zlxwm519IVnFvWlLu+pUukxM5/LecD/n15HbGXL2w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCSCMpkEeOEy+rJwiOm8ttdu7PnGwX4jyRH6Db/Wty0Z6db1kM10H5+FDlu8wIK58rBFRys02c6gFIHnlo35+mzr5m6g1LCxqEpIUdvaJU7mZnfDOfwR
    gW/hEUON+DNaUB480HMwTd7xl8DIkhCnJhj796Ski3TWSWf2DJ8k8x3cvZ2QVS+G99qtf6M+GEHabfZvz0NNdXnPIGzrRGM/Y7Mq3D8FaElvP8GDKt9ybIpx
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=hWMQpYRtAAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=ag1SF4gXAAAA:8
    a=DtNzOG49FyenMnN10bwA:9 a=QEXdDO2ut3YA:10 a=KCsI-UfzjElwHeZNREa_:22
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750898AbeC0Qdr (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:33:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44012 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754040AbeC0Qdn (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:33:43 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH 4.9 67/67] bpf, x64: increase number of passes
Date: Tue, 27 Mar 2018 18:27:59 +0200
Message-Id: <20180327162731.491730496@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

commit 6007b080d2e2adb7af22bf29165f0594ea12b34c upstream.

In Cilium some of the main programs we run today are hitting 9 passes
on x64's JIT compiler, and we've had cases already where we surpassed
the limit where the JIT then punts the program to the interpreter
instead, leading to insertion failures due to CONFIG_BPF_JIT_ALWAYS_ON
or insertion failures due to the prog array owner being JITed but the
program to insert not (both must have the same JITed/non-JITed property).

One concrete case the program image shrunk from 12,767 bytes down to
10,288 bytes where the image converged after 16 steps. I've measured
that this took 340us in the JIT until it converges on my i7-6600U. Thus,
increase the original limit we had from day one where the JIT covered
cBPF only back then before we run into the case (as similar with the
complexity limit) where we trip over this and hit program rejections.
Also add a cond_resched() into the compilation loop, the JIT process
runs without any locks and may sleep anyway.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/net/bpf_jit_comp.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1135,7 +1135,7 @@ struct bpf_prog *bpf_int_jit_compile(str
 	 * may converge on the last pass. In such case do one more
 	 * pass to emit the final image
 	 */
-	for (pass = 0; pass < 10 || image; pass++) {
+	for (pass = 0; pass < 20 || image; pass++) {
 		proglen = do_jit(prog, addrs, image, oldproglen, &ctx);
 		if (proglen <= 0) {
 			image = NULL;
@@ -1162,6 +1162,7 @@ struct bpf_prog *bpf_int_jit_compile(str
 			}
 		}
 		oldproglen = proglen;
+		cond_resched();
 	}
 
 	if (bpf_jit_enable > 1)
