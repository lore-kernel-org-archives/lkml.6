Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1691124-1527155159-2-4700162955893343170
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527155157; b=S3RyHI7gXelYnaI7qNne3+cF4LcrhTPcspysHSsqxlhAvTKcBu
    YF+OGQQkL/u4HX8i7Lq4bfQbaP6K96KLo6sIb7UllL75zDYpz8RzUByEouWgztRI
    5FMjfSFRGKvTEHlQgxETM4I9I46S01JcJO6HoFRgiOIi9kFSpXwN/DD1YpEkipQV
    fpIfd5kDlgeWcGQfkG7mgxihcho5IHW7MjzOIQtRo8mZjWzx+iAOiHapuOOq0DXk
    2qBDw0tIqlmrJu3D5ETbFIgteO3NwBYevi7ZPgtLPIYJEnOQsQDiS66TygF9SKg9
    dpRIDvuDalKqSKEh65tpdn8ixrLGKY/arFtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527155157; bh=Cv/ATLCSE+EOQtyMhpltNczKRf+lnO
    oQOnt9ZTSqFjc=; b=PshnUErafGcYAJgcSJXb/JeMQ8/V2kDFAsKxXUwPLXQVlk
    xat3v7pRwbBjxXo0PqbNXeIYoWRDkj7z8YXy1MlEEWcZ7JA4uVvuGFKGwOkyp2hX
    +crsP2RLutHPfJMKjxAkVYhc4E0w1D3EHyAYDi6y0EM32K8FuNTHwJJSlrVK4J8u
    8EILdUUwYY8B01PQbZkK+B5iAby+67USVaxg0PMFvlsjqIt524JajtLNuj4Mw6jK
    6nOsB5PEWpPhouzo4C3fnPyK6rxPFrPP4LCYPMVQLFbnZ0AGBb4aqnf1YbFEmb2j
    QUhFMK04GNo3H/1/3WJggMjn2cNfZ3ZBE1JdXwlA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=dYpcWqTK x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=dYpcWqTK x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfDmZApjm+9j3mYCO/oPyPSIGQdTS4QLKVJLx1r3/d4WP4DVkHwRb1/PFbBw0kaSv39T+VvGc7oPh4CdFKUsbNDEixzG2u2qMPRIc0tBIzcyAdfaMY9AA
    uC9OmPLebTUIclh020hBblKA2C36zjLZDXdh1SMkm67QjrnAa5FDFVMsytznXYsTR49nJmfVcrzCLqZPO0KGiWsMilJ6Q0RUIXVZ4sRHMErbfjWphIvJzvhH
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=KKAkSRfTAAAA:8 a=QyXUC8HyAAAA:8 a=ag1SF4gXAAAA:8 a=pJxnRZf-bbsmWOJlxq0A:9
    a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966063AbeEXJpx (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:45:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966818AbeEXJps (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:45:48 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mike Galbraith <mgalbraith@suse.de>
Subject: [PATCH 4.4 45/92] cpuidle: coupled: remove unused define cpuidle_coupled_lock
Date: Thu, 24 May 2018 11:38:22 +0200
Message-Id: <20180524093203.670229755@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
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

From: Anders Roxell <anders.roxell@linaro.org>

commit 75274b33e779ae40a750bcb4bd0b07c4dfef4746 upstream.

This was found with the -RT patch enabled, but the fix should apply to
non-RT also.

Used multi_v7_defconfig+PREEMPT_RT_FULL=y and this caused a compilation
warning without this fix:
../drivers/cpuidle/coupled.c:122:21: warning: 'cpuidle_coupled_lock'
defined but not used [-Wunused-variable]

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Mike Galbraith <mgalbraith@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cpuidle/coupled.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/cpuidle/coupled.c
+++ b/drivers/cpuidle/coupled.c
@@ -119,7 +119,6 @@ struct cpuidle_coupled {
 
 #define CPUIDLE_COUPLED_NOT_IDLE	(-1)
 
-static DEFINE_MUTEX(cpuidle_coupled_lock);
 static DEFINE_PER_CPU(struct call_single_data, cpuidle_coupled_poke_cb);
 
 /*
