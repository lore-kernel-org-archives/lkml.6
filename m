Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8F7C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 23:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E92321655
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 23:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E92321655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbeHZDIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 23:08:49 -0400
Received: from mout.gmx.net ([212.227.17.21]:53681 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbeHZDIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 23:08:49 -0400
Received: from localhost.localdomain ([196.52.84.36]) by mail.gmx.com
 (mrgmx103 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0MLvLE-1g1Qg13edY-007mSl; Sun, 26 Aug 2018 01:28:18 +0200
Subject: Re: Disabling CPU vulnerabilities workarounds
To:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-kernel@vger.kernel.org
References: <575b6581-7dcb-96a9-b06e-9f74dda5fa86@gmx.com>
 <3830fa4c-29d6-99e9-6c8e-b1a30cba59f0@schaufler-ca.com>
From:   "Artem S. Tashkinov" <aros@gmx.com>
Message-ID: <4513153f-d907-8dbe-fda9-3117d07ff703@gmx.com>
Date:   Sat, 25 Aug 2018 23:28:16 +0000
MIME-Version: 1.0
In-Reply-To: <3830fa4c-29d6-99e9-6c8e-b1a30cba59f0@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:oyMA/PycCeQCykWUsKua1dmMSa8xgV73UoVUp1jo97S06moSlaT
 2d0lNYUoeiwNSuh+Yff296OOciYWh2kL7kVl1WZpn392lmS0pjOVPLJAJpL5zCpK5Jxl09G
 6611Zgosvj2eC791zYdj5oV71DkXTtle4CqDNUlJ5PG4d99WYpsdBqzYnop0PTepd6jpdO2
 r93bkQtGOGWJOBcO0aH7Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dC1GiGCgWu4=:8vlGerVQa54sbM0fP8fMts
 0wQIIsI4w62hTEauvdaLUMyZIAL00zZsQWRl27L9zqdVDNhuvWvgEHifKrvQRrXv3HF3AQBA9
 h1jiHn/obQMdULitI59TBMo+X8IJiwvIoyKdEViDuJSdPM/opxDB0JlGsN2d402zmbN/e+u2n
 ilB72Vy4tVfTEmGEkZ6qm0CXkMTk2qwYOV4+ajgftGUHMR1x9MCMteBne9IBreHq1zDTk/+Bv
 MNmldckceGi6NX2gkItvyaaowWNBoLU6ZMVjwi+i9QRzDPDRAaTxlQB9GC5SDKvBlW8lFMZiX
 etTTC+k8vxiO9xw8TNvh2hBdDomIaamDTk6cNhjX2fknUylqTzyv9fg2/Je7ASp3B9CnA3VdQ
 7HvuZaifKB6Z1+WDYfs2CBfeKw8yKnO0/f/DQrcD3yxi9rihETaZdXsfG8gaSEhhPmjy7TLVW
 9x00V6y8DnlgBPnnzxsbO1OIyMCpnorzTwSIyhyRH2qGJSrSQ2jrG2MI4QQMo8E6WHcsivKc7
 Y4GFUEpWHkzo/ilWVHEiHIQpUDGdK7AHpaxYE72wGz9aTliInS8l4h5NtwF2Ze0VfBBNQNVoz
 UqAZ9bdEeAK0y9GC/q6ZlradsHjceP5IiJc/t/7IfICdcppWGlBwSZMO/SSHYIzGJTxUE2Zxy
 c+5OCEdOJwVF+G+bxNCtPj+oDFQCXKbq0beYbb8VsZiUNsNgIkXfTJTzdKmMPERB8BTcHj2/4
 QgFn+R6CS0fSBFgpZHPMEt8x5OQ3wR3AQsog2PVJHG8DvyQP1CweWyraD3YcC4OJflf2Xsd6T
 nMWOd1B
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/25/2018 06:39 PM, Casey Schaufler wrote:
> On 8/25/2018 3:42 AM, Artem S. Tashkinov wrote:
>> Hello LKML,
>>
>> As time goes by more and more fixes of Intel/AMD/ARM CPUs vulnerabilities are added to the Linux kernel without a simple way to disable them all in one fell swoop.
> 
> Many of the mitigations are unrelated to each other. There is no one
> aspect of the system that identifies a behavior as a security issue.
> I don't know anyone who could create a list of all the "fixes" that
> have gone in over the years. Realize that features like speculative
> execution have had security issues that are unrelated to obscure attacks
> like side-channels. While you may think that you don't care, some of
> those flaws affect correctness. My bet is you wouldn't want to disable
> those.

As far as I know mitigations started to appear in January 2018 and 
kernels released prior to this date all work just fine without any 
issues with "correctness", so I'm not sure what you're talking about.

I'm quite sure at least Intel perfectly knows, as well as Linus Torvalds 
who coordinates everything.

Also

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index f73fa6f6d85e..e6362717c895 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -991,7 +991,7 @@ static void __init cpu_set_bug_bits(struct 
cpuinfo_x86 *c)
{
u64 ia32_cap = 0;

- if (x86_match_cpu(cpu_no_speculation))
+ //if (x86_match_cpu(cpu_no_speculation))
return;

setup_force_cpu_bug(X86_BUG_SPECTRE_V1);

and setting this in .config:

CONFIG_RETPOLINE=n
CONFIG_PAGE_TABLE_ISOLATION=n

Ostensibly disables all mitigations and everything continues to work 
just fine.

> 
>> Disabling is a good option for strictly confined environments where no 3d party untrusted code is ever to be run, e.g. a rendering farm, a supercomputer, or even a home server which runs Samba/SSH server and nothing else.
> 
> Like maybe the software in centrifuges in a nuclear fuel processing plant?
> 
> All the examples you've cited are network connected and are vulnerable to attack.
> And don't try the "no untrusted code" argument. You'll have code on those systems
> that has been known vulnerable for decades.

I'm not sure

1) why you're trying to mix unrelated classes of vulnerabilities - of 
course there are vulnerabilities other than the ones caused by 
speculative execution;

2) why you're insisting that my argument, that someone may never run 
untrusted code, has no merit. I may perfectly have a standard Linux 
distro installed on my PC/server and never run a web browser or any 
similar applications other than the ones provided by my distro in a form 
of various packages - which means I will never run any untrusted code. I 
will also never run any scriptable applications 
(bash/python/php/ruby/etc) from the net either. How such a configuration 
might be susceptible to speculative execution attacks?

> 
>> I wonder if someone could wrote a patch which implemented the following two options for the kernel:
>>
>> * A boot option option which allows to disable most runtime protections/workarounds/fixes (as far as I understand some of them can't be reverted since they are compiled in or use certain GCC flags), e.g. let's call it "insecure" or "insecurecpumode".
> 
> That would be an interesting exercise for the opposite case. A boot option
> that enables all the runtime protections would certainly be interesting to
> some people. If you could implement one, you could do the other.
> 
> I would be happy to review such a patch. Go for it.

I'd love to leave that task to those who are more proficient in writing 
kernel code and whose work is more likely to be merged. My patch might 
be never streamlined for totally unrelated reasons (and we've seen too 
many examples of that already).

> 
>> * A compile-time CONFIG_ option which disables all these fixes _permanently_ without a way to turn them later back on during runtime.
> 
> This suffers from all the challenges previously mentioned, but would
> be equally interesting, again for the opposite case.

Again, I see no challenges since, for instance, RHEL has gone as far as 
to backport all the patches to previously released officially 
unmaintained kernels, so all these patches could be easily disabled if 
one really wanted to.

> 
>>
>> Right now linux/Documentation/admin-guide/kernel-parameters.txt is a mess of various things which take ages to sift through and there's zero understanding whether you've found everything and correctly disabled it.
> 
> I can't argue with you on that. Again, I believe the greater value would
> come from documenting how to turn everything on.

I guess you meant "turn everything off".


Best regards,
Artem
