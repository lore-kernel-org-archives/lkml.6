Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752492AbeEKHBf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 03:01:35 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35227 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751462AbeEKHBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 03:01:33 -0400
X-Google-Smtp-Source: AB8JxZpi6kdHn6rKl/iDxkWUXzwFa2Vfa7qGLpqaYgPV/YCzU35bYf9XhPW/GPON6g6bHn/gV+uaFA==
Subject: Re: [PATCH 1/2] x86/stacktrace: do not fail when regs on stack for
 ORC
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org
References: <20171130080325.24785-1-jslaby@suse.cz>
 <20171130195710.cu2lsa47kwnow2hi@treble>
 <73526a6b-5083-78f1-8f76-d5f3ac52f958@suse.cz>
 <20171218033749.ihpwkjh7qfnilj4s@treble>
 <20171220174544.g34v2lkjrz2r6kh7@treble>
 <bf832ed0-47f4-2e8c-f320-1f54bce76e5c@suse.cz>
 <20180416221653.bf3or5yarlame3co@treble>
 <20180419134222.truupyqhwcpnhuis@treble>
 <a27a7de0-cc28-cfc8-7d0b-7d284f5d5788@suse.cz>
 <20180510124916.ckgjtgmmcy33ahtd@treble>
From: Jiri Slaby <jslaby@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 xsFNBE6S54YBEACzzjLwDUbU5elY4GTg/NdotjA0jyyJtYI86wdKraekbNE0bC4zV+ryvH4j
 rrcDwGs6tFVrAHvdHeIdI07s1iIx5R/ndcHwt4fvI8CL5PzPmn5J+h0WERR5rFprRh6axhOk
 rSD5CwQl19fm4AJCS6A9GJtOoiLpWn2/IbogPc71jQVrupZYYx51rAaHZ0D2KYK/uhfc6neJ
 i0WqPlbtIlIrpvWxckucNu6ZwXjFY0f3qIRg3Vqh5QxPkojGsq9tXVFVLEkSVz6FoqCHrUTx
 wr+aw6qqQVgvT/McQtsI0S66uIkQjzPUrgAEtWUv76rM4ekqL9stHyvTGw0Fjsualwb0Gwdx
 ReTZzMgheAyoy/umIOKrSEpWouVoBt5FFSZUyjuDdlPPYyPav+hpI6ggmCTld3u2hyiHji2H
 cDpcLM2LMhlHBipu80s9anNeZhCANDhbC5E+NZmuwgzHBcan8WC7xsPXPaiZSIm7TKaVoOcL
 9tE5aN3jQmIlrT7ZUX52Ff/hSdx/JKDP3YMNtt4B0cH6ejIjtqTd+Ge8sSttsnNM0CQUkXps
 w98jwz+Lxw/bKMr3NSnnFpUZaxwji3BC9vYyxKMAwNelBCHEgS/OAa3EJoTfuYOK6wT6nadm
 YqYjwYbZE5V/SwzMbpWu7Jwlvuwyfo5mh7w5iMfnZE+vHFwp/wARAQABzSBKaXJpIFNsYWJ5
 IDxqaXJpc2xhYnlAZ21haWwuY29tPsLBewQTAQIAJQIbAwYLCQgHAwIGFQgCCQoLBBYCAwEC
 HgECF4AFAk6S6P4CGQEACgkQvSWxBAa0cEl1Sg//UMXp//d4lP57onXMC2y8gafT1ap/xuss
 IvXR+3jSdJCHRaUFTPY2hN0ahCAyBQq8puUa6zaXco5jIzsVjLGVfO/s9qmvBTKw9aP6eTU7
 77RLssLlQYhRzh7vapRRp4xDBLvBGBv9uvWORx6dtRjh+e0J0nKKce8VEY+jiXv1NipWf+RV
 vg1gVbAjBnT+5RbJYtIDhogyuBFg14ECKgvy1Do6tg9Hr/kU4ta6ZBEUTh18Io7f0vr1Mlh4
 yl2ytuUNymUlkA/ExBNtOhOJq/B087SmGwSLmCRoo5VcRIYK29dLeX6BzDnmBG+mRE63IrKD
 kf/ZCIwZ7cSbZaGo+gqoEpIqu5spIe3n3JLZQGnF45MR+TfdAUxNQ4F1TrjWyg5Fo30blYYU
 z6+5tQbaDoBbcSEV9bDt6UOhCx033TrdToMLpee6bUAKehsUctBlfYXZP2huZ5gJxjINRnlI
 gKTATBAXF+7vMhgyZ9h7eARG6LOdVRwhIFUMGbRCCMXrLLnQf6oAHyVnsZU1+JWANGFBjsyy
 fRP2+d8TrlhzN9FoIGYiKjATR9CpJZoELFuKLfKOBsc7DfEBpsdusLT0vlzR6JaGae78Od5+
 ljzt88OGNyjCRIb6Vso0IqEavtGOcYG8R5gPhMV9n9/bCIVqM5KWJf/4mRaySZp7kcHyJSb0
 O6nOwU0ETpLnhgEQAM+cDWLL+Wvc9cLhA2OXZ/gMmu7NbYKjfth1UyOuBd5emIO+d4RfFM02
 XFTIt4MxwhAryhsKQQcA4iQNldkbyeviYrPKWjLTjRXT5cD2lpWzr+Jx7mX7InV5JOz1Qq+P
 +nJWYIBjUKhI03ux89p58CYil24Zpyn2F5cX7U+inY8lJIBwLPBnc9Z0An/DVnUOD+0wIcYV
 nZAKDiIXODkGqTg3fhZwbbi+KAhtHPFM2fGw2VTUf62IHzV+eBSnamzPOBc1XsJYKRo3FHNe
 LuS8f4wUe7bWb9O66PPFK/RkeqNX6akkFBf9VfrZ1rTEKAyJ2uqf1EI1olYnENk4+00IBa+B
 avGQ8UW9dGW3nbPrfuOV5UUvbnsSQwj67pSdrBQqilr5N/5H9z7VCDQ0dhuJNtvDSlTf2iUF
 Bqgk3smln31PUYiVPrMP0V4ja0i9qtO/TB01rTfTyXTRtqz53qO5dGsYiliJO5aUmh8swVpo
 tgK4/57h3zGsaXO9PGgnnAdqeKVITaFTLY1ISg+Ptb4KoliiOjrBMmQUSJVtkUXMrCMCeuPD
 GHo739Xc75lcHlGuM3yEB//htKjyprbLeLf1y4xPyTeeF5zg/0ztRZNKZicgEmxyUNBHHnBK
 HQxz1j+mzH0HjZZtXjGu2KLJ18G07q0fpz2ZPk2D53Ww39VNI/J9ABEBAAHCwV8EGAECAAkF
 Ak6S54YCGwwACgkQvSWxBAa0cEk3tRAAgO+DFpbyIa4RlnfpcW17AfnpZi9VR5+zr496n2jH
 /1ldwRO/S+QNSA8qdABqMb9WI4BNaoANgcg0AS429Mq0taaWKkAjkkGAT7mD1Q5PiLr06Y/+
 Kzdr90eUVneqM2TUQQbK+Kh7JwmGVrRGNqQrDk+gRNvKnGwFNeTkTKtJ0P8jYd7P1gZb9Fwj
 9YLxjhn/sVIhNmEBLBoI7PL+9fbILqJPHgAwW35rpnq4f/EYTykbk1sa13Tav6btJ+4QOgbc
 ezWIwZ5w/JVfEJW9JXp3BFAVzRQ5nVrrLDAJZ8Y5ioWcm99JtSIIxXxt9FJaGc1Bgsi5K/+d
 yTKLwLMJgiBzbVx8G+fCJJ9YtlNOPWhbKPlrQ8+AY52Aagi9WNhe6XfJdh5g6ptiOILm330m
 kR4gW6nEgZVyIyTq3ekOuruftWL99qpP5zi+eNrMmLRQx9iecDNgFr342R9bTDlb1TLuRb+/
 tJ98f/bIWIr0cqQmqQ33FgRhrG1+Xml6UXyJ2jExmlO8JljuOGeXYh6ZkIEyzqzffzBLXZCu
 jlYQDFXpyMNVJ2ZwPmX2mWEoYuaBU0JN7wM+/zWgOf2zRwhEuD3A2cO2PxoiIfyUEfB9SSmf
 faK/S4xXoB6wvGENZ85Hg37C7WDNdaAt6Xh2uQIly5grkgvWppkNy4ZHxE+jeNsU7tg=
Message-ID: <16f714bb-1a32-9203-39d5-aab927fba6c9@suse.cz>
Date: Fri, 11 May 2018 09:01:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180510124916.ckgjtgmmcy33ahtd@treble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2018, 02:49 PM, Josh Poimboeuf wrote:
> On Thu, May 10, 2018 at 02:33:03PM +0200, Jiri Slaby wrote:
>> On 04/19/2018, 03:42 PM, Josh Poimboeuf wrote:
>>> On Mon, Apr 16, 2018 at 05:16:53PM -0500, Josh Poimboeuf wrote:
>>>> On Wed, Dec 20, 2017 at 08:07:17PM +0100, Jiri Slaby wrote:
>>>>> On 12/20/2017, 06:45 PM, Josh Poimboeuf wrote:
>>>>>> It might not be until 2018 though.  But in the meantime you can go ahead
>>>>>> and update your patches accordingly and then we can combine them for
>>>>>> testing next year.
>>>>>
>>>>> I already did ;). So when you have that ready, I will send it on top
>>>>> right after.
>>>>
>>>> Sorry for the delay...  Here's a (lightly tested) patch.  Can you test
>>>> it with the latest version of your patches?
>>>
>>> This one actually compiles:
>>>
>>> From: Josh Poimboeuf <jpoimboe@redhat.com>
>>> Subject: [PATCH] x86/unwind/orc: Detect the end of the stack
>>
>> With this patch applied, livepatching never completes. Kthreads are in
>> the unpatched state forever. I have no details yet.
> 
> Hm, I thought I had tested that, but now I'm not sure.  Let me try it
> again.

We need to propagate end from hints to orcs. This works for me™:

commit ad05e939b5809db104528731ed0147ad59466db5
Author: Jiri Slaby <jslaby@suse.cz>
Date:   Fri May 11 09:00:12 2018 +0200

    objtool: take end hint into account

    Signed-off-by: Jiri Slaby <jslaby@suse.cz>

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 5409f6f..fef15ce 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1109,6 +1109,7 @@ static int read_unwind_hints(struct objtool_file
*file)

                cfa->offset = hint->sp_offset;
                insn->state.type = hint->type;
+               insn->state.end = hint->end;
        }

        return 0;
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index c6b68fc..000ecf3 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -30,6 +30,7 @@ struct insn_state {
        struct cfi_reg regs[CFI_NUM_REGS];
        int stack_size;
        unsigned char type;
+       unsigned char end;
        bool bp_scratch;
        bool drap;
        int drap_reg, drap_offset;
diff --git a/tools/objtool/orc_dump.c b/tools/objtool/orc_dump.c
index c334382..a9bf1861 100644
--- a/tools/objtool/orc_dump.c
+++ b/tools/objtool/orc_dump.c
@@ -203,7 +203,9 @@ int orc_dump(const char *_objname)

                print_reg(orc[i].bp_reg, orc[i].bp_offset);

-               printf(" type:%s\n", orc_type_name(orc[i].type));
+               printf(" type:%s", orc_type_name(orc[i].type));
+
+               printf(" end:%u\n", orc[i].end);
        }

        elf_end(elf);
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 18384d9..f413cc2 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -31,6 +31,9 @@ int create_orc(struct objtool_file *file)
                struct cfi_reg *cfa = &insn->state.cfa;
                struct cfi_reg *bp = &insn->state.regs[CFI_BP];

+               //if (insn->hint)
+                       orc->end = insn->state.end;
+
                if (cfa->base == CFI_UNDEFINED) {
                        orc->sp_reg = ORC_REG_UNDEFINED;
                        continue;

thanks,
-- 
js
suse labs
