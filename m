Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB3AC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68CC72170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="IuiqhkhY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68CC72170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbeI1FAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 01:00:35 -0400
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:35187
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725972AbeI1FAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 01:00:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1538087999; bh=gu/V/5AeFqOjUHP4KrsoWRnZhdZ49eEN4aPSNl3n/4w=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=IuiqhkhYQms9xgITyBiH9fw9sf4V769/Dx/u9UiRR3t3lDJbyQQP1UF6afEarPr/lkqoSzrHNPlmyxmp8rhLCjARC6Mv5TM6tJqEXW07ZqBz85c+Mc2g0p6eG8PpMzzWcwXJ5XP42jelVtntVg+qpBUgi7oU5p9NJegsdDWlUxHRYQfJPr9cDnuisFYrKzrX36ZrmUBfR6wEaRdt/BqabN2qK17496shliIWwksnrOFGPIl8kCjMz+C1LD1LIlWn21Ml68iUm1vwZHPMpWGNZ0/FvBgXnlErKp8NBqVPa+ozr1uykTWsG3Or56exRehWprpY81N8kmtr58BTFJ5iag==
X-YMail-OSG: 74OYVFsVM1kfz6Yr_9XFOwE5euxgXu2vtdkb1875vd4autfRxmG0FRDUOCu1OzS
 k3tAVm6mFZGFR2fwMJDHOtMBVFxw1UCM.7aBYt6t35kksLEpW2Jn1lebkviEbKzJkeqSbjU1pq9s
 61fvFV8CYWkKLA0Cfk4Hgjja1SK2.Y_OaNcwhnf7jKUdy2ZaVu5WWeYPabMm57Lxnq_ucV1GGG37
 Llfq82OYuJO463b2AZcdktAjz5xqNZD0yZUktMewlvO3dkCeoilUYRPiv0XTvgvcPaoP6Y1iNshF
 P7pz8v6BAqL2HvkSArYcMrUSywWUoSSkdS73_HM_NVoXQQ3qEQMpmPtwbuNzyuefgZjkDfOMzeG.
 9hoIdM7iaHMCG3qi2j6D8Mo_z_iDZB5XN875C1zVyc9fXl3Cqq6Gee5i8eOFQZdyuIcNaxf769JZ
 njGZ_srvsGy2v_lO_1Zjiw8hvHf6_nPJR6WEHqCmfHWae5EfvmXCU8C3xjEqRx1qPwxBAuWm4xfW
 6UVO1A77iDLztegWS3C2y97sHGMIO4LFXnq8HYXf9p.L5lCnwMT.ihkeINQsHunaq9dnPCjCXwsj
 zgSagW4h_wYfUPr11z7CThxwhK.uOR8dlNy5bM1DHX6tfp3quDSIDK4Ke3pRLOWz9FPGD95NtXBr
 mIRyVAnXmbDq1tZ.PAP4KTtDwhNgkbtw68cp03rXkNQw1V5aAQFpkJBkA7whXP5VpR8hc9TcG36C
 o1x.Q2N2ASKYysSylL7YszFCA4uC4oj3Mk8rFK5GRXR43JJUnl17a.xEAE6IoXwLR4KD9OoCk6Hb
 1ePVw6TBV_UQXN6tZsbetND600KiW0_hYQ2HnYmQfpIBvbt39yn5xI.DSyNN0WS5eGzbPiQPyTqP
 5RyTCXSvTX2m6CRglygqyfOXa6bcVrAxoiexq02GgX8m01Mt3pQrKsDLTwyBEOyNwypCmGCJjyhc
 Pi9g2A0_kowTpigoJEj8XxfsoxOAaqFqNJ1.uOgpI_DmbSjvlpC7m9xjtckuDPLhSNj3cCorFaEH
 t4WG0QdTEBbGnsPpbUYPMwpRbGzw-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Thu, 27 Sep 2018 22:39:59 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp425.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID cf8ac775da837c7d6fbb27fa852c5a63;
          Thu, 27 Sep 2018 22:39:54 +0000 (UTC)
Subject: Re: [PATCH v5 5/5] sidechannel: Linux Security Module for sidechannel
To:     James Morris <jmorris@namei.org>,
        Casey Schaufler <casey.schaufler@intel.com>
Cc:     kristen@linux.intel.com, kernel-hardening@lists.openwall.com,
        deneen.t.dock@intel.com, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, arjan@linux.intel.com
References: <20180926203446.2004-1-casey.schaufler@intel.com>
 <20180926203446.2004-6-casey.schaufler@intel.com>
 <alpine.LRH.2.21.1809280744560.8410@namei.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <025d4742-5947-545e-f603-502a0c5ee03f@schaufler-ca.com>
Date:   Thu, 27 Sep 2018 15:39:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1809280744560.8410@namei.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/2018 2:45 PM, James Morris wrote:
> On Wed, 26 Sep 2018, Casey Schaufler wrote:
>
>> +	/*
>> +	 * Namespace checks. Considered safe if:
>> +	 *	cgroup namespace is the same
>> +	 *	User namespace is the same
>> +	 *	PID namespace is the same
>> +	 */
>> +	if (current->nsproxy)
>> +		ccgn = current->nsproxy->cgroup_ns;
>> +	if (p->nsproxy)
>> +		pcgn = p->nsproxy->cgroup_ns;
>> +	if (ccgn != pcgn)
>> +		return -EACCES;
>> +	if (current->cred->user_ns != p->cred->user_ns)
>> +		return -EACCES;
>> +	if (task_active_pid_ns(current) != task_active_pid_ns(p))
>> +		return -EACCES;
>> +	return 0;
> I really don't like the idea of hard-coding namespace security semantics 
> in an LSM.  Also, I'm not sure if these semantics make any sense.

Checks on namespaces where explicitly requested. I think
these are the most sensible, but I'm willing to be educated.
I was also requested to check on potential issues between containers,
but as there is no kernel concept of containers this is the
best I see we can do.

> It least make it user configurable.

Would you have a suggested granularity? I could have a
configuration option for each of cgroups, user and pid
namespaces but that's getting to be a lot of knobs to
twist.

