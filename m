Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2782356-1520539259-2-12273520952623288840
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520539258; b=ZSzCbFfOD0QXRofgwQFNTE6HY8LDbY4DN/ap+W2zUWDfJyT
    nUwAJZjOVYY2jqVqzZni9Cigylo0MAEOjmHvZcDaZAbB+6jKqurOsvE2ek3g6QfQ
    8i8Rtza2H0tI2Na8SFPSd86/h8yjZ2WlqJZx5K1Uj9ZoC4O8aYbmr1smH/SOKfXP
    RU2k3yPlGjJvKWPXHDgj/2leSWIx6JssKFOFTGV1IZb8uwv6z+pA9j2sstAuPBr/
    v3h2uOvNkPTCkYRzKDxvA7NzidwJE8Pxdzlzo2VCLtBiv+UF0yBjW08CrZ6YtyFD
    aNNzoHgThnI8rjfA9B2iQLK2UU4lY3wwEvluLjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520539258;
    bh=/4FlVPZhxazRwCHZM3XMaGj89FgZWBCF+P+R3rtE16s=; b=bCduBvM1uauP
    oGGzfn1Eo7bwEbxlQGF++X65BTnLsHLoJI+fOD4RtUYCMC+RLX6Y8C78I2jM+x4N
    wDu0m0uGSTcHl29DsRQc3AWqVrzCbw9Lh5NFxotpeJtnzC1eMGmH1e7YjsdPTOTh
    3Xgg8i46Hw6p0IsZK0d08U3X6GbpH7iO4WjqYt6Gj3Bs79mpUl9nkAv1D3OmjyaY
    oaS+jBZa6pCrhydthq27zb0FT2JKjZhtwaDudtECysHvMtJF8uyg3+brN/d36wfl
    7Uoxlb96IG+r+gDPUxXqd3tZYZGHfSMlYLnJzZ8IikvWiJPCO++Yz0T4hiEadIyw
    W5y1YJj5OA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752182AbeCHTwN (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 14:52:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:60530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752065AbeCHTwK (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 14:52:10 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A1D421795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, stable@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 32/54] perf intel-pt: Fix error recovery from missing TIP packet
Date: Thu,  8 Mar 2018 16:50:07 -0300
Message-Id: <20180308195029.14991-33-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Adrian Hunter <adrian.hunter@intel.com>

When a TIP packet is expected but there is a different packet, it is an
error. However the unexpected packet might be something important like a
TSC packet, so after the error, it is necessary to continue from there,
rather than the next packet. That is achieved by setting pkt_step to
zero.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/1520431349-30689-4-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 00f25f4b5f48..5e4d0bbafc8b 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1616,6 +1616,7 @@ static int intel_pt_walk_fup_tip(struct intel_pt_decoder *decoder)
 		case INTEL_PT_PWRX:
 			intel_pt_log("ERROR: Missing TIP after FUP\n");
 			decoder->pkt_state = INTEL_PT_STATE_ERR3;
+			decoder->pkt_step = 0;
 			return -ENOENT;
 
 		case INTEL_PT_OVF:
-- 
2.14.3
