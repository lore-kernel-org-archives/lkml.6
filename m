Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F9CC070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 22:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 217B621473
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 22:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 217B621473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbeIMEDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 00:03:33 -0400
Received: from mga06.intel.com ([134.134.136.31]:34247 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725751AbeIMEDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 00:03:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2018 15:56:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,366,1531810800"; 
   d="scan'208";a="79999188"
Received: from schen9-desk.jf.intel.com (HELO [10.54.74.135]) ([10.54.74.135])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Sep 2018 15:56:52 -0700
Subject: Re: [PATCH v5 2/2] x86/speculation: Enable cross-hyperthread spectre
 v2 STIBP mitigation
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <nycvar.YFH.7.76.1809101119280.15880@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1809101123520.15880@cbobk.fhfr.pm>
 <alpine.DEB.2.21.1809101158080.1402@nanos.tec.linutronix.de>
 <nycvar.YFH.7.76.1809101259520.15880@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1809101343370.15880@cbobk.fhfr.pm>
 <f0fcbcd9-4619-391e-3c1b-34d06b00de50@linux.intel.com>
 <alpine.DEB.2.21.1809112315320.1427@nanos.tec.linutronix.de>
 <f95c28d6-70f2-3f18-4ab9-c756c7581126@amd.com>
 <d098fa9b-f244-68d2-77f2-e3f5dd30f174@linux.intel.com>
 <nycvar.YFH.7.76.1809122330090.15880@cbobk.fhfr.pm>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <18977608-cf8e-339b-788f-a5e461d22b11@linux.intel.com>
Date:   Wed, 12 Sep 2018 15:56:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YFH.7.76.1809122330090.15880@cbobk.fhfr.pm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2018 02:45 PM, Jiri Kosina wrote:
> On Wed, 12 Sep 2018, Tim Chen wrote:
> 
>> I'm working on a patch for choosing the Spectre v2 app to app
>> mitigation option.
>>
>> Something like the following:
>>
>> enum spectre_v2_app2app_mitigation {
>>         SPECTRE_V2_APP2APP_NONE,
>>         SPECTRE_V2_APP2APP_LITE,
>>         SPECTRE_V2_APP2APP_IBPB,
>>         SPECTRE_V2_APP2APP_STIBP,
>>         SPECTRE_V2_APP2APP_STRICT,
>> };
>>
>> static const char *spectre_v2_app2app_strings[] = {
>>         [SPECTRE_V2_APP2APP_NONE]               = "App-App Vulnerable",
>>         [SPECTRE_V2_APP2APP_LITE]               = "App-App Mitigation: Protect only non-dumpable process",
>>         [SPECTRE_V2_APP2APP_IBPB]               = "App-App Mitigation: Protect app against attack from same cpu",
>>         [SPECTRE_V2_APP2APP_STIBP]              = "App-App Mitigation: Protect app against attack from sibling cpu",
>>         [SPECTRE_V2_APP2APP_STRICT]             = "App-App Mitigation: Full app to app attack protection",
>> };
>>
>> So the APP2APP_LITE protection's intention is to turn on STIBP and IBPB for non-dumpable
>> process.  But in my first version I may limit it to IBPB as choosing
>> STIBP based on process characteristics will require some frobbing of
>> the flags as what we've done in SSBD.  That will require more careful
>> work and tests.
>>
>> The STRICT option will turn STIBP on always and IBPB always on
>> non-ptraceable context switches.
>>
>> Is this something reasonable?
> 
> It's probably 100% correct, but it's also 100% super-complex at the same 
> time if you ask me.
> 
> Try to imagine you're a very advanced senior sysadmin, who has heard that 
> spectre and meltdown existed of course, but figured out that updating to 
> latest kernel/distro vendor update fixes all the security issues (and it 
> actually indeed did).
> 
> Now, all of a sudden, this new option pops up, and the poor sysadmin has 
> to make a decision again.
> 
> 	"Do you care only about security across non-dumpable process 
> 	 boundaries?"
> 
> 	"Scheduled to same CPU at the time of attack? Can you guarantee that this 
> 	 is (not) happening?"
> 
> 	"If the processess can actually ptrace/debug each other, are you okay with 
> 	 them attacking each other?"
> 
> 	 "Shared HT siblings return target buffer, do you want it or 
> 	  not?"
> 
> These are the questions that even an excellent sysadmin might not have 
> qualified answers to so far. Now, all of a sudden, he/her has to make 
> these decisions?
> 
> I don't think that's how it should work. It all should be digestible by 
> "linux end-users" (where users are also super-advanced sysadmins) easily.
> 
> We currently have "I do care about spectrev2 / I don't care about 
> spectrev2" boot-time switch, and I don't see us going any deeper / more 
> fine-grained without sacrificing clarity and sanity.
> 
> Or do you see a way how to do that nicely?
> 

How about just these options:

static const char *spectre_v2_app2app_strings[] = {
        [SPECTRE_V2_APP2APP_NONE]               = "App-App Vulnerable",
        [SPECTRE_V2_APP2APP_LITE]               = "App-App Mitigation: Protect only non-dumpable process",
        [SPECTRE_V2_APP2APP_STRICT]             = "App-App Mitigation: Full app to app attack protection",
};

Tim
