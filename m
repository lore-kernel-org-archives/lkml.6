Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1459510-1523022233-5-4145129092770116262
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523022233; b=HLi6D/2Krxke9o7s0raCukkZyxpMSn6M1+UrUA0MB/uptDQg/O
    UL1BPvFMHI+iOrBCcwaDzVCR2NPawJsOG9pdz7M0fp5A/vdiDnp1p4lA015/lVha
    qo3+ccdedscJYzrUvNgPN6NIwG87pm3P5RN0fYuemdaFDNHKhzPTMCK4q9nVoQyl
    JZq0drPLqKKNVOzwFLxAJN9GoBBUYW2oZNyloXbae4rTAC7BtblkTiI2Vf25Bhju
    iu30UlBwUNtIXNl9MvUMXu9+iLVrGG5Zq+QO+QTg1sVOtOE8J3gvxeXb6oEAHMCi
    mhOTYZa5Xgq4fomL4gpoBOpwqqrJivpyBN/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523022233; bh=VmPE82swfQMfgEBXzzmg4KywVpJi45
    YSQQkYHG/A7EI=; b=KQSTCxpc5Pt2pgTNFyIWEbecTUSRR+Yhr4wCfxG7eVqiMM
    PHHimRRt0m5jC7rXpNb/EOA8KDaN8d1OaQIvTP2oFk/88Kko4htzIPsTYBZqeoJG
    jlsC7jp7fPyMqA3cXoJKKZmDxf/PMApvQJG6fOQMw61TUG02CJNNqerO4cozOOGV
    A0MNmjjIX+Efd1KFMXF4km11PYTteTts9kgemwH5NRb87IoNJ6mrBC/HzhVIF2o+
    Jh8VLrP/Kci5o25iibOs4uK3PBxnbuAI6ZvlfPMeVcLrMsY7wF4QrH6FRXPf9LoX
    5/V8xDIdvSy2jztxP4Cr4IfteoLN8hlv8uSvmgZg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfDwLyZ4v2uLi8ootrrVwxJoyX/+RnORgkS5TA+Bi2IHYu2lBHx1kTZ1NZmn27tuXazG1janwXN0vUelh5GR4fwgxYD3Hua9/HxQG6CcCF7JuT+EjsMLF
    GBskaawkUpX0MwZa+iIWIHdZ3u5Qj9zm96E0k/U1hr9fDxsVHPB5H7ZMTy4zY+hX4kwD6UkOsiNRkuq0Y3yRkNe3ErANdbDv0MlI+7RtD/LVzZ2wAeU9P63c
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=ag1SF4gXAAAA:8 a=1EsaE_6oAAAA:8 a=QyXUC8HyAAAA:8 a=KKAkSRfTAAAA:8
    a=yMhMjlubAAAA:8 a=zDgdGgVozOWF3o962G4A:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=3ZumFrijQQ-2J9H5h8ct:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756558AbeDFNnu (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:43:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37454 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756820AbeDFNns (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:43:48 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 71/72] Revert "cpufreq: Fix governor module removal race"
Date: Fri,  6 Apr 2018 15:24:46 +0200
Message-Id: <20180406084354.127651972@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit a853301f77b5c4feb5e17aebfd92018269525523 which was
commit a8b149d32b663c1a4105273295184b78f53d33cf upstream.

The backport was not correct, so just drop it entirely.

Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/cpufreq.c |    6 ------
 1 file changed, 6 deletions(-)

--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -637,8 +637,6 @@ static int cpufreq_parse_governor(char *
 			*governor = t;
 			err = 0;
 		}
-		if (t && !try_module_get(t->owner))
-			t = NULL;
 
 		mutex_unlock(&cpufreq_governor_mutex);
 	}
@@ -767,10 +765,6 @@ static ssize_t store_scaling_governor(st
 		return -EINVAL;
 
 	ret = cpufreq_set_policy(policy, &new_policy);
-
-	if (new_policy.governor)
-		module_put(new_policy.governor->owner);
-
 	return ret ? ret : count;
 }
 
