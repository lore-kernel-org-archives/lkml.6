Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2999894-1526000316-2-3336455619700491767
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526000316; b=L9QghkX+ouE3AD07dw69NYWyvUVYflOu3N8NJ+YfWuWJVKGofA
    dBdSOCCz0YKa32A6sooZYGZwl5FpoJJxfqPLtSVir1N08+DhCqUKi+wQNU6Y2846
    4Z6xJia2ImJm62aBgeOSCpGT8USFPsDh/LfrvtVmEGmfK+SqtgtE6CMs8klyjosI
    uxJ/aQdWo30v8hzXpvJtwJpERXfCCLpEWUnT8OIYyMb2x5NYR9xN0ThwWaUwb5vV
    Kb6sfkLuvkdjHxtCf+oLiyTb9V2sYyUTnAmH0vujXfJFefAhQOTvnCCm6XM12h09
    o1CYG7v7uK0sFSv040zDQ7kwb88dQWe8jJHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526000316;
    bh=aIooguSq+YbN2F2JIEP7xXRCrLGq/7onEKwkbs93eiw=; b=Ph2OJKEVZhFq
    TD2yG7aLWWfm8be+sGEreSXQTdWnANt0pmKoPecYgF8bZvV7kl6isSo3cTT/jDoZ
    +vFUomMOse22zVWJYkbL2pOzdqlE5wlGY+JzEuvQaSDP9YoPP+dfT/AZltwJ8W+m
    RZyXa1nmpU+0bOkKIlqurcyR2FraXj29LFrLtKaHm5IX1leRLCzoa2VkGFeXakEa
    YWFr1hfoLHTpVJ6APsYtdLfZMkj1bqK8i24ABqWactg1fQ2+BuLXNN867GEzb5ow
    IkiV1tfoWGvvuvr/wEoFiVPWRww+08+foHL9dDuY1mjH1j5p1D/vcZGTCqT/eVIQ
    ZeksQGAB4w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=yahoo.com header.i=@yahoo.com header.b=g4cDHMnS x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=s2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=schaufler-ca.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=schaufler-ca.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-80 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=yahoo.com header.i=@yahoo.com header.b=g4cDHMnS x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=s2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=schaufler-ca.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=schaufler-ca.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-80 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFNjhDhUtdY2MuzFMD5bGCFDNtbEFfJnlR1E77YZEgWY5dzlAo4qsiLLBJdNAw48NtwgNfFvQuUzXXxuFHxYoiF3+eZVrgpY1uWAZmc6sVoX9B3Dn24W
    QKP1jEW6e3RMuTEQH1j1ys/cn1RVFZ1PlEOXZ3fdXlrflEYS2VJniNZS3y/+q4N/yWX3B4z0PLvmARz7WQLEbY0+8+shwrgCsAOp25n43vlAvhR+lq+U6gkb
    TJSXIYwsr29h25l2o/b8gg==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=5HJ6KZJP-kkA:10
    a=VUJBJC2UJ8kA:10 a=zK_QHpzxcnYA:10 a=3NGxsLzzGfgA:10 a=ZZnuYtJkoWoA:10
    a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=QoSpRxTWSFORfd2O5jsA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751947AbeEKA6d (ORCPT <rfc822;linux@kroah.com>);
        Thu, 10 May 2018 20:58:33 -0400
Received: from sonic311-29.consmr.mail.ne1.yahoo.com ([66.163.188.210]:41389
        "EHLO sonic311-29.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750890AbeEKA6c (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 10 May 2018 20:58:32 -0400
X-YMail-OSG: Vw0JL8IVM1m5D9UAGv0yRj8N9y8NpJM317XiKv_Pv9cAhAxoChWaAa.L6h.5jQx
 3sPNsNicaCGeobBF8.UemfIJFQa_HsJoB8fFo4QBHvAWItu3hpttEuqBal7Vqg5uvTz7j37ETurr
 CUfV51JKaHNrUMvDfgPe3KpEXg_AgoC8niB036O7B_n_egmm2BrtYlysm.7OPF9.ivPiE008T9Pg
 gzZbUlEvhA1CqDC1z5fBL8VoGFPmWMxm_IYr5hGTV66.Jn5nulqJX0WTp1AjFsvQcFFa97QDrQni
 VsnSyQqB7pRWO98sUiTCfd8ttI_Ihb4K8JLMz4HKkKBYYueiOqvCgvVNMtp5XGAEPI98_40X.AwX
 ZBSIRfkmFqj0S4QZoVziTnYuA4pe6apnzyyIWc5YzosVFXyq7jfo2q80fzqxcVFUpNj1Lutsv8sy
 R3coQGmAtBzLDZvLDBLD1UX7dHDyAJSfzEtBp_kAWRSOtyNSsmZl_1o_4vdvciFtphGhvliedPRZ
 edUHrBtZywWo1mQhnAAOD8lCllWP1KtU9VkThgPubB33DYpnE.k_cYDs4P7Cud8QI36SCdtogYo2
 3ixb.LGEmX7TRe24BwkdObzvpSBPaqEmAP2xjNktEWS7nzB_fVwYr0lZZ9ucS386QHbIt9z6TYCh
 GjVsYEpInFi8ToCDIqbm5AM8-
Subject: Re: [PATCH 00/23] LSM: Full security module stacking
To: LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        SE Linux <selinux@tycho.nsa.gov>,
        "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        James Morris <jmorris@namei.org>
References: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <f226eb00-8103-90cf-640c-e6911004efcf@schaufler-ca.com>
Date: Thu, 10 May 2018 17:58:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 5/10/2018 5:30 PM, Casey Schaufler wrote:
> Subject: [PATCH 00/23] LSM: Full security module stacking
>
>
Git tree: git://github.com/cschaufler/lsm-stacking.git#stacking-4.18


