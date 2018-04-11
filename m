Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303684-1523479687-2-8400405482369063162
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523479687; b=BBkvrjr0iGUipL9aPtko9h0m8mZbNQSWM11z4U5LwS6cpttmOg
    GG3fkEfIvF1wgurIPyA6ULSqoV/UJD2ozumI8sJCCu4RA4s/Xuo5yfsiMurLfOop
    fp0Tcn7qbxV3PNITA0LijUxlovAdKK1R77h9pDMUni7msI/8GYcTRvLlBbYNF9Fz
    cN0gxqeDbTUPzwolMAk1aV7XdcEe1dpY3d16Iz8V16uKE1RFezVPVZGPTZWOAjwZ
    Ie+/sKVyDOVympoXABmDIpQsuTv1XemUQ2Hv/dWBAEZaR56BWVvgb2hi5DUMAT25
    tXp6nhZsD/PKIQl62KqralZ7/XaZ53EY/d/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479687; bh=0KdeANSGxlV2S+PsezdIPhzQdNteLF
    q8J/nal1Tkigs=; b=qMXRxoTr1dStGsoM4uxfFYDcAdImVpnGSBdkb8Appa/5V+
    ZKn1fpMYHpIvAWWgckgggtyiMrzkY3W+Zw9Ru/E1s11BNjhC4Qde0+xsMtZPXsD4
    EwLyWaE0auRrzDFR1Dy8+8uuY2lCIGQzKhioeZJFOcIEanBIiOupcm2FpjbnuI2j
    HvAZr6CIGImYu8nWb4edOcW2uJM0l0iIPhWmjepWWy9PxRZAerz0ZT3PrCDhAlQm
    2gQa/xIX8F0vK67T1Xuyzq9DBNB/WVuQZ+0N3VmhMhRQS5rUY94bx8EK0ocQpB/w
    WxlCPvBkA0DZynaCMU9oHRe9ZYIuGXg8Nhyph0nA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfJ0jt9Kblko1d6UaJcXgOt2ihdPvBE5bmXCcZAlCKvAqDxzFoXNE5PJcWlYcFm3ICVYgktNpSRPMBV4WcHFL0qs2bGFdPkOkwaynkwiBJd+GZo7+GRQC
    jVrSoed/gLYlwM0MrVa92VpkpkkPtZI2owbqDhRCJLm8x8EcNRgK0XcJfTiY1BwLem4jHJkvDorSGaghNAEM3lzF8jZbhZBy5tHEnc4eEcTJ534sxNudlMUH
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=3HDBlxybAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=S-gNZk8OdBwLLumHJ_4A:9 a=QEXdDO2ut3YA:10 a=laEoCiVfU_Unz3mSdgXN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756544AbeDKUrx (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 16:47:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58910 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755727AbeDKSq0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:46:26 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liping Zhang <zlpnobody@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 069/190] netfilter: ctnetlink: fix incorrect nf_ct_put during hash resize
Date: Wed, 11 Apr 2018 20:35:15 +0200
Message-Id: <20180411183554.349904185@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liping Zhang <zlpnobody@gmail.com>


[ Upstream commit fefa92679dbe0c613e62b6c27235dcfbe9640ad1 ]

If nf_conntrack_htable_size was adjusted by the user during the ct
dump operation, we may invoke nf_ct_put twice for the same ct, i.e.
the "last" ct. This will cause the ct will be freed but still linked
in hash buckets.

It's very easy to reproduce the problem by the following commands:
  # while : ; do
  echo $RANDOM > /proc/sys/net/netfilter/nf_conntrack_buckets
  done
  # while : ; do
  conntrack -L
  done
  # iperf -s 127.0.0.1 &
  # iperf -c 127.0.0.1 -P 60 -t 36000

After a while, the system will hang like this:
  NMI watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [bash:20184]
  NMI watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [iperf:20382]
  ...

So at last if we find cb->args[1] is equal to "last", this means hash
resize happened, then we can set cb->args[1] to 0 to fix the above
issue.

Fixes: d205dc40798d ("[NETFILTER]: ctnetlink: fix deadlock in table dumping")
Signed-off-by: Liping Zhang <zlpnobody@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nf_conntrack_netlink.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -887,8 +887,13 @@ restart:
 	}
 out:
 	local_bh_enable();
-	if (last)
+	if (last) {
+		/* nf ct hash resize happened, now clear the leftover. */
+		if ((struct nf_conn *)cb->args[1] == last)
+			cb->args[1] = 0;
+
 		nf_ct_put(last);
+	}
 
 	return skb->len;
 }
