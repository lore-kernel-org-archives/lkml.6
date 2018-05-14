Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-289078-1526281479-2-4284188719068308789
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526281478; b=gkegq6VB+8ECD9klhHWIXm3ku2WY99mZdsonFvQwujfmHORzao
    R1r5APqK5uNZkyX03R5a7JuvSrQTVh6sdFrO1JxYWsyFNYzvcAcYaYwMEK/++Ouu
    069c0cSp0MU/NJWX4rRyheeVO5qLS/7rqCeNOKto+hcLjrTiTYjgXTFld8J7X9LZ
    TkUaLnx8QgM+wK8tOG5j7CHSliISMnhs6A+UQ5sWl8Ska/kTmnnKVaUcwp57skRL
    PYoQnkR7ODn6WHd4wV3GEorVqTruzxzWe77MvdQXdFADaIxSw6XuMS0ZF3gi8aaN
    vmJ3OlH05WQORUntrOXSNGtZP/2r5miwpS2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526281478; bh=TJ9YoNaes7BYwc1lem3uIbojh5MGRb
    uO9RvbMiEf+9o=; b=XkVjUo5xc1XK0QyTKChcrrCTnkZ28pygMm4T/0vTyZ4qP1
    l0Q4coGhLlUK1+OfDfChzK3lsYyhJzAtovJyq7KOkncVEnBN45DfWsXqyGzxFKqa
    8w+RT650hALOboTuPnXxXVC5G+S4LtFOdl5i0Bp1LyyZNyKbQbTNuv1eDKOHCiHE
    jvMb+YgZ77PNcdIJZEXEmuDI8J/McwUqobXChhlI/HQnOCx1E2Wr/gCOKhlu6Fad
    p9v/VngYybVZ7+5/8GAumDFfTvPnSqCADHW3bzGKhHYdF2G6Gx4auvKlI3v2ze/O
    SoRQz9BG16mSibPlFvQVu5swmd2lGniLxdBRW+Jg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=zmjPZ1Sg x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=zmjPZ1Sg x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIP3JpQPUmV2BRJ028hsRtJLxtcgCMb/S+4pRf3QrWPHBmgpQpMDapX1CEzxaV5/3MhgokiDe9bm5vUibhpl1CRCdhp/7uZgg2ZP1scs6JLKDTLLrb3v
    BPgQQB+T6l+ryxRTEFXLrSZE5o+NMH2zV1nqPgJ+TLsHhlJtaNA0ZeOuv6wQImH63Yi0flRMJLRZEqaG7W1jmOt6PjJCGXMjweX5+GrG97M/Ew7dYPHhWlXV
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
    a=my_lbr29hPUGU-qXvBYA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754116AbeENHAE (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 03:00:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753673AbeENHAC (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 14 May 2018 03:00:02 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.16 54/72] cpufreq: schedutil: Avoid using invalid next_freq
Date: Mon, 14 May 2018 08:49:11 +0200
Message-Id: <20180514064826.549591047@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit 97739501f207efe33145b918817f305b822987f8 upstream.

If the next_freq field of struct sugov_policy is set to UINT_MAX,
it shouldn't be used for updating the CPU frequency (this is a
special "invalid" value), but after commit b7eaf1aab9f8 (cpufreq:
schedutil: Avoid reducing frequency of busy CPUs prematurely) it
may be passed as the new frequency to sugov_update_commit() in
sugov_update_single().

Fix that by adding an extra check for the special UINT_MAX value
of next_freq to sugov_update_single().

Fixes: b7eaf1aab9f8 (cpufreq: schedutil: Avoid reducing frequency of busy CPUs prematurely)
Reported-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: 4.12+ <stable@vger.kernel.org> # 4.12+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/sched/cpufreq_schedutil.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -290,7 +290,8 @@ static void sugov_update_single(struct u
 		 * Do not reduce the frequency if the CPU has not been idle
 		 * recently, as the reduction is likely to be premature then.
 		 */
-		if (busy && next_f < sg_policy->next_freq) {
+		if (busy && next_f < sg_policy->next_freq &&
+		    sg_policy->next_freq != UINT_MAX) {
 			next_f = sg_policy->next_freq;
 
 			/* Reset cached freq as next_freq has changed */
