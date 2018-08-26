Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D3BC433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 20:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D156208B4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 20:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="dsbTFSIm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D156208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbeH0Alx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 20:41:53 -0400
Received: from sonic309-54.consmr.mail.gq1.yahoo.com ([98.137.65.180]:40243
        "EHLO sonic309-54.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726714AbeH0Alx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 20:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1535317091; bh=iVfmrMMsSFldlEt56yk50kE9ZIpt3+achXwC/y/BPLI=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=dsbTFSImg1Fyo78D8ojGDieqWZdBSp/V9T2cXU8NyzBIFHJVH90LrEENCglA6i26MOYT0fch09Aj5QgmyRfGewCHM6zwXdN8TTRkfU8rL8TV3JWJWDLe4EwWRfwTfMqLmVGuHed90Im5IUynRNTje1I4VCHidawRwDqZNZFi5HKGKYTm+MhrmGSJqPRRR+Af7977Bw/9VDbY2zZM0myLF6aVAM40rZdTlHgjd9SKqGaVLX4YKLd0Yn0e5YcSodpRIPc9Y+atvzLiDKnXB25umlvnzIELdBpVZnOANVIRFDeWRLIXoQ96f5qj6r54kcCWR/MZ0gYXymHlTBEJZTTTSw==
X-YMail-OSG: HyUKkfEVM1nMbmRrfGITCdTlstAENXhKoJlJmy93.qu346IBK87y6xzZx.dnIHM
 QyT0F1K44Y3GERlRr7HwdZa3oUqu0pFk.cAGffK1zncc5pyiMk.40raYJPoLtAzpz9rCF3Pvd5KK
 UAo94FiJbvXGT8uqxY0lkm5Xixj8G6wAznUPl9G4TtJfdYFIr99Z1.YbmZmRJImqwTlnDpjJ8LMc
 3qi_wslovms1li2TLTDXPaRw.ngvgnbfuDszS5xdKFc3BYP0h_2RkHBZBpqATlyMz1D27ReFZG2L
 MAyfvgEJGOSrJ_h6p3WKeMx.SjOiU0iH63BXwdrudH6jon.gVf7t3KxNFmUJA9rrejlUtsGc4Vce
 ZsaDdv.K64O67IJxhNvaz8Gk5Ohhn9NsbQ9jH0mVpnILjik5jt_Fzd1Su7gqxGtDXIE04ACLfE_Z
 TE2N9yRYs6cxsu.7JDd3_mpkNivs83OIUx1Hu3Vbzy4Spa3uJCrtSgTDWotUJvKCcThEpUf1N7qU
 kCqDs0lw8sGW0TNKWXd4e.RnZWBZCYyZI8r36CzWHDVtq2z8J4_vyc25w47zP0rjS6y0bGenvPum
 FEpUqA9kKgBdYDswgqdCp2Hl7IAIptNYUYHNJXfc3sTuLXStXxsWH1utTOfw0PkHedyHyik0MjnK
 uDMGQNuxaITCDv7nTzIZ8pNXAqJqoRZAk1gmTDH2Id7E0lTvGgroWrw4LduLjYkB3pOHNqE79ytX
 J9k0Swuj9yFlEcn9ul0WLO2qBFTQ7RRe6HeyAox4qReDAMPMVhIZkaiySoeSpIfz1pYunzutPYf_
 xKwi6upL7p8wItf9wviVoEqWdEZd35bF9W5Y0qMXtJiMQB4VXp_oGE90oVsnb4i.vTtzUFMcXEn7
 TtzILL8vsV4XGVeUT6eEPVlyWOoSK38OvTgmuO3RnTIR4XXu.wkvlSBWyyONp4HvxoW5MTpPYgHs
 lMtDSRJ9U_k6HmjhPmfcEBO8t83eibaAEpBySA4ogiNDOjZf36VoktcFXlIMe9OEZfqWemxz4RSG
 z5dA3R6NB1BtFb6cqeg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Sun, 26 Aug 2018 20:58:11 +0000
Received: from 104.129.192.79 (EHLO [172.26.39.237]) ([104.129.192.79])
          by smtp431.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 3ce6850e214f118c6f2738028abd2c70;
          Sun, 26 Aug 2018 20:54:10 +0000 (UTC)
Subject: Re: Disabling CPU vulnerabilities workarounds
To:     "Artem S. Tashkinov" <aros@gmx.com>, linux-kernel@vger.kernel.org
References: <575b6581-7dcb-96a9-b06e-9f74dda5fa86@gmx.com>
 <3830fa4c-29d6-99e9-6c8e-b1a30cba59f0@schaufler-ca.com>
 <4513153f-d907-8dbe-fda9-3117d07ff703@gmx.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <6ddf1956-2501-407f-de01-a7f369527185@schaufler-ca.com>
Date:   Sun, 26 Aug 2018 13:54:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4513153f-d907-8dbe-fda9-3117d07ff703@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/2018 4:28 PM, Artem S. Tashkinov wrote:
> On 08/25/2018 06:39 PM, Casey Schaufler wrote:
>> On 8/25/2018 3:42 AM, Artem S. Tashkinov wrote:
>>> Hello LKML,
>>>
>>> As time goes by more and more fixes of Intel/AMD/ARM CPUs vulnerabilities are added to the Linux kernel without a simple way to disable them all in one fell swoop.
>>
>> Many of the mitigations are unrelated to each other. There is no one
>> aspect of the system that identifies a behavior as a security issue.
>> I don't know anyone who could create a list of all the "fixes" that
>> have gone in over the years. Realize that features like speculative
>> execution have had security issues that are unrelated to obscure attacks
>> like side-channels. While you may think that you don't care, some of
>> those flaws affect correctness. My bet is you wouldn't want to disable
>> those.
>
> As far as I know mitigations started to appear in January 2018 and kernels released prior to this date all work just fine without any issues with "correctness", so I'm not sure what you're talking about.

Mitigations specific to Specture and Meltdown started showing up then.
Speculative execution has been around for a very long time. It would be
foolish to assume that no work has been done in response to other related
issues before then.

> I'm quite sure at least Intel perfectly knows, as well as Linus Torvalds who coordinates everything.

Don't believe for a minute that no work had been done to address known issues
prior to January.  

>
> Also
>
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index f73fa6f6d85e..e6362717c895 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -991,7 +991,7 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
> {
> u64 ia32_cap = 0;
>
> - if (x86_match_cpu(cpu_no_speculation))
> + //if (x86_match_cpu(cpu_no_speculation))
> return;
>
> setup_force_cpu_bug(X86_BUG_SPECTRE_V1);
>
> and setting this in .config:
>
> CONFIG_RETPOLINE=n
> CONFIG_PAGE_TABLE_ISOLATION=n
>
> Ostensibly disables all mitigations and everything continues to work just fine.

Well, then there's your answer.

>
>>
>>> Disabling is a good option for strictly confined environments where no 3d party untrusted code is ever to be run, e.g. a rendering farm, a supercomputer, or even a home server which runs Samba/SSH server and nothing else.
>>
>> Like maybe the software in centrifuges in a nuclear fuel processing plant?
>>
>> All the examples you've cited are network connected and are vulnerable to attack.
>> And don't try the "no untrusted code" argument. You'll have code on those systems
>> that has been known vulnerable for decades.
>
> I'm not sure

I am.

>
> 1) why you're trying to mix unrelated classes of vulnerabilities - of course there are vulnerabilities other than the ones caused by speculative execution;

Most of the other vulnerabilities are massively easier to exploit than
side-channel. To that end you're right, enabling side-channel mitigations
may be pointless of your systems.

> 2) why you're insisting that my argument, that someone may never run untrusted code, has no merit. I may perfectly have a standard Linux distro installed on my PC/server and never run a web browser or any similar applications other than the ones provided by my distro in a form of various packages - which means I will never run any untrusted code. I will also never run any scriptable applications (bash/python/php/ruby/etc) from the net either. How such a configuration might be susceptible to speculative execution attacks?

You have millions of lines of code in a standard distribution.
Some of that code has not been updated since the Reagan administration.
Why on earth would you trust it?

>
>>
>>> I wonder if someone could wrote a patch which implemented the following two options for the kernel:
>>>
>>> * A boot option option which allows to disable most runtime protections/workarounds/fixes (as far as I understand some of them can't be reverted since they are compiled in or use certain GCC flags), e.g. let's call it "insecure" or "insecurecpumode".
>>
>> That would be an interesting exercise for the opposite case. A boot option
>> that enables all the runtime protections would certainly be interesting to
>> some people. If you could implement one, you could do the other.
>>
>> I would be happy to review such a patch. Go for it.
>
> I'd love to leave that task to those who are more proficient in writing kernel code and whose work is more likely to be merged. My patch might be never streamlined for totally unrelated reasons (and we've seen too many examples of that already).

OK, but if you want the feature, who better than you to
contribute it?

>
>>
>>> * A compile-time CONFIG_ option which disables all these fixes _permanently_ without a way to turn them later back on during runtime.
>>
>> This suffers from all the challenges previously mentioned, but would
>> be equally interesting, again for the opposite case.
>
> Again, I see no challenges since, for instance, RHEL has gone as far as to backport all the patches to previously released officially unmaintained kernels, so all these patches could be easily disabled if one really wanted to.

If you really want to, go ahead and do it!

>
>>
>>>
>>> Right now linux/Documentation/admin-guide/kernel-parameters.txt is a mess of various things which take ages to sift through and there's zero understanding whether you've found everything and correctly disabled it.
>>
>> I can't argue with you on that. Again, I believe the greater value would
>> come from documenting how to turn everything on.
>
> I guess you meant "turn everything off".

Oh no, I'm pretty good at distinguishing "on" from "off".

>
>
> Best regards,
> Artem
>

