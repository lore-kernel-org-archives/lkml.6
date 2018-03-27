Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4170472-1522168391-2-15138216122175620793
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
    t=1522168390; b=ALnG4RjIU9aCJSZnBbOnmsjgJUOyVuxMtykwq7lhN6XArIx
    S+M7mMZus8QuFOXuWi5WVH736JgET6XvU8o3cnCSDgiCsUWB5QMEMAGLBMnB2FUh
    bt+/QJlo+41m3xIbDqeYbHpqNRy39RLQlZeZ3Cuc9+wLEn4hTMswkOQJLZTnG9gt
    biWn95sFn24c+q6uiRcSPK16L7BCrMq+m7CKz0q0zBfBuOQtN2EWowiq6THF81ci
    7czYcN4M4q6LtUu1LsrtzzsMdy25rIsv5kC5LsmIdDkDc/54C6g1hCUTKh1OH07T
    aoxKPvx80oyR1KROq3iBIYnpNZpaC+1bCJEsbZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522168390; bh=gfvmjOm5FMEfoG5KL95GWOWwQF
    YGVlSABjXuO1cgYzk=; b=g21qNYN/Z1SoPBrOrngUuf9SbkGlW+HGQj4HyFw0Nk
    UFKF3y8aj4VMzFDufj10ei3LsWuSRDxvtNiNuK65098BSg77hXGuxdCImZi1G3e8
    /xhvMaERCHt3A/2UWNcRA5nezTSpWWb7oKk3vsrpi3ZjBfiNkBjMgkzOLJc3zTJS
    8ClO3pUcuGC18O5fAxWNUzeXNHshLYWEsaF0Ffxxu722IdIKkSozdg7LPsPP5pa/
    UIH05SMg34ttI00TG0Wg6zo2aERtGzu0Mz9kWu9MepMM5Sly8llshSSTnsNBGc3z
    URjwTdLUdHUahgVYK3j331MuiQ83buwW/8vtYiuNHaOQ==
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
X-CM-Envelope: MS4wfGy+/F1iufZGeKnV376MHa3bvb3wXTh+fAvXT5vFAf+E8RGOQsWpisQz6iAuxH0cLWY+LNb093XAGCvMpzGH1xO5z1+V4lNDYomb8zP7stErMyYbQ8Br
    0FZd+ySxtVwy/xHNmZ3Lc7tapORHWjeqH+epngvVkfcO8HckuW+Vs937QEoV7znaWVbBHqpGzkZl6LV4L0MeRlXQxYCzxPklyo428cZhXX7QvAAiCQgXLb6N
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=ag1SF4gXAAAA:8
    a=7ljSc9fCeTOn1i4Z17sA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750880AbeC0QdG (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:33:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43726 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753839AbeC0QdF (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:33:05 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 4.9 60/67] selftests, x86, protection_keys: fix wrong offset in siginfo
Date: Tue, 27 Mar 2018 18:27:52 +0200
Message-Id: <20180327162730.911979074@linuxfoundation.org>
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

From: Dave Hansen <dave.hansen@linux.intel.com>

commit 2195bff041486eb7fcceaf058acaedcd057efbdc upstream.

The siginfo contains a bunch of information about the fault.
For protection keys, it tells us which protection key's
permissions were violated.

The wrong offset in here leads to reading garbage and thus
failures in the tests.

We should probably eventually move this over to using the
kernel's headers defining the siginfo instead of a hard-coded
offset.  But, for now, just do the simplest fix.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/x86/protection_keys.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/testing/selftests/x86/protection_keys.c
+++ b/tools/testing/selftests/x86/protection_keys.c
@@ -192,7 +192,7 @@ void lots_o_noops_around_write(int *writ
 #define SYS_pkey_alloc	 381
 #define SYS_pkey_free	 382
 #define REG_IP_IDX REG_EIP
-#define si_pkey_offset 0x18
+#define si_pkey_offset 0x14
 #else
 #define SYS_mprotect_key 329
 #define SYS_pkey_alloc	 330
