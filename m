Return-Path: <kernelnewbies-bounces+greg=kroah.com@kernelnewbies.org>
X-Cyrus-Session-Id: sloti22d1t05-2056499-1524242012-2-14167212036648079790
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_NONE -0.0001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='96.67.55.147', Host='shelob.surriel.com', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: kernelnewbies-bounces+greg=kroah.com@kernelnewbies.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524242011; b=NFbjODzHAt5wI/pMnB7bJSSHF5IZIdC3fI0JaZS348ZdF7fVfS
    MRxahSsrHDwHUf+oiBQs4XilemTmnNbI8wPRbiU4A96h7acwZo9XT/SjG1LRubwa
    a2oMsyz6qzHxNb4W+BYQFpMLRkKiQ4zn/YRUvB8kufWWrS+RAXM7RajfdGxto9au
    ikh9Rfb823BpHcaSOe+3EIBAvV2xwvnX3xnaLcvP8HlH/gA95ODyF/4ZDTR+EnqU
    SKA8TVF4QHRavQWa1XG+mRnn75ZZY7LZEDSuJdidE/nuWmnlgnSGd3gXaazDRASK
    vin2zCS6ACGxk1egC1ilR/YUeR317BXTuJIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:cc:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding; s=fm2; t=1524242011; bh=cTtVNJJttObB
    AMh2F6HQA0aNEWsZ2tOrJ21FFMkU6zI=; b=RbSRhDl04bwZQVqLBa1SqMHPsQjY
    kKq282tOFERpU78ZOpa/4LWxTNu/vIvn/+WzWAjZeP9+JlsXu+CE/h0YYvxJYUBP
    rYMbEMoXGJbfo3sGpr20H7cxRrFBFmZlPklVSWJruzFITYV/VzXUanGBOHc0cegt
    CHVOfmvUkWktxNLeJj5Pns6/WJHSrTLpQgYhLjtVN6+BkkPosKVfwHdIVlbwzhcK
    4jiyPQBkfbdGqS/pj4UUtuXhMK5SCFya3lyQw+Zx0QmeWgURjjUOvLNlhJ9CL9k9
    AXoQjXGda5Urv8dHoumBKswYKvKPtLvWebQ7S2E3ZYREDZahuaN7IPXYqA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gmx.de;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom="kernelnewbies-bounces+greg=kroah.com@kernelnewbies.org" smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmx.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gmx.de;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom="kernelnewbies-bounces+greg=kroah.com@kernelnewbies.org" smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmx.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPO8q/jgbuIj+XUFpa97nwSl4s6B+2e0gaB9Mtq5ms7SCj9CQWlPALH4T3sNCxigk3qedGASsRHYV9lLHtIIHWRxW0IWC22RH03ue2GcZ+uWYf2L9WiO
    h22qSO1St/+Bo08gydkJROjpRXkSfqi8bR/FUyjW0zI1bxDzA4ey8qqt+8J3MteWIHq9Ksa6XDDjSLdu+hdt6HQzkWKx0qfczvQKsr/hV0Chzz76L7CLHmy2
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=rY4dWIxwDULXyY+dMrlW8Q==:117
    a=rY4dWIxwDULXyY+dMrlW8Q==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=IcWf8OSz_o8A:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=SiqW3_QkAAAA:8 a=tUbq5BKOOXbWIbnlVscA:9 a=BXOZ8SWbsiw1URdZ:21
    a=y9yeXTw0irK36lvf:21 a=CjuIK1q_8ugA:10 a=0-oVHmElw7bdUHZZ8WX8:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
Subject: Re: [PATCH] sched/fair: Change sched_feat(x) in !CONFIG_SCHED_DEBUG
 case
To: Peter Zijlstra <peterz@infradead.org>
References: <20180416085426.24157-1-Phil_K97@gmx.de>
 <20180420075717.GB4064@hirez.programming.kicks-ass.net>
From: Philipp Klocke <Phil_K97@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Phil_K97@gmx.de; prefer-encrypt=mutual; keydata=
 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
 12TtBTzNsw==
Message-ID: <34572fee-36d0-36e1-ba6d-f098b145aba4@gmx.de>
Date: Fri, 20 Apr 2018 18:29:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180420075717.GB4064@hirez.programming.kicks-ass.net>
Content-Language: en-US
X-Provags-ID: V03:K1:21MWT+ns+NPtOtGY+yn8fZjoC/a5fyj88C9dU0YGvDFYGrWM5r1
 ELxFs04GwsfTwY8AgUPRpz6JzJntLEZjuF7HmdRGdfwdJNZH/dPfxgI7x+fhWSMndFnylGn
 461VFlYNESvbjUxI36g0Mb9On33dQnoKH9CG0/AV8nc62ivESxTYMEMwB1fa1oIkSXF4myS
 TV7K5rw7kV6pzd4pEDnDQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yf7Che9Rtew=:IiHYIVHpfywmAE+ZShNYmg
 gRMXsCbclSb/srGQ8BDlU3m+JOI1UGX6YZZxRo8fTGXvKkuoMig6EGqOsMzrAvOKfQCII9S9w
 nUYDj5ULtdrDTX6P5Xe7CIKqk8YGzsrhby+cxSpdIx8WUjr8u4mjw4LuuMEkiVLpRHX5+2oD6
 mCQ8kRIwPmH9WUoLm19LoON5AxGm+MF6oH+6knBmADvggVrQ16/l+6h/Z9UFJDVswF9eO7ATd
 9Tnij4b2LFcxOjHsB+TsadDKJQVegypDfnaH4ndnlZt9rE4vocAnTf5Q3+CwqRmpaLC3QrJrF
 RGhpMIjMoxjtCiyXmTVFpmE473WJpPBLpsE8VbtTMIP0D8mHpRIFJ4yWgRlfR2FownhDaJSfv
 ta3xvReyZeSkvB59f2w6y9kj5n+8bYteGHK2nxknlMMfnZLfrf+Fo4hIou/qQpfJQueLogXIV
 poX9d6CrwRVhGEPu3P4V79YpyQ7kHe42m5/CQDKJ8905QESDX5czAJAO1wV9+yYfCAxMXHZg3
 hk8SMExL+a/FH6K9y53/lB46l5ywtTkGeNLtajMQZxxbudRifOmGpv2S0sDagtY5JK698X2NS
 VKWUDxDVDpCmhr7KVha8Qem1SFQFg806KhsdKSk38eXtfqJlE7hCYMeqOhLhEV3M+b6WLdSlt
 lIA1GX5InhXtF6/P2MbaLwlw7JASKG/Y7A1r4566QcOynoD35hXemCpnxWRilzXl6xAhTGaxv
 C0gVjh88pNXLzFNwOZAhiu1b4gSUyBltfz8o+O+uyNphwzFcmFC/D8QByRxJ1374qMdCm4+Yl
 HoOlvI3Zq/bI848MH4/jOaPZptJedQ4fXjyR7JG2BculW3sX/A=
Cc: sil2review@lists.osadl.org, kernelnewbies@kernelnewbies.org,
 llvmlinux@lists.linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, der.herr@hofr.at, lukas.bulwahn@gmail.com
X-BeenThere: kernelnewbies@kernelnewbies.org
X-Mailman-Version: 2.1.15
List-Unsubscribe: <https://lists.kernelnewbies.org/mailman/options/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=unsubscribe>
List-Archive: <http://lists.kernelnewbies.org/pipermail/kernelnewbies/>
List-Post: <mailto:kernelnewbies@kernelnewbies.org>
List-Help: <mailto:kernelnewbies-request@kernelnewbies.org?subject=help>
List-Subscribe: <https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kernelnewbies-bounces+greg=kroah.com@kernelnewbies.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 20.04.2018 09:57, Peter Zijlstra wrote:

> On Mon, Apr 16, 2018 at 10:54:26AM +0200, Philipp Klocke wrote:
>
>> This patch is motivated by the clang warning Wconstant-logical-operand,
>> issued when logically comparing a variable to a constant integer that is
>> neither 1 nor 0.  It happens for sched_feat(x) when sysctl_sched_features
>> is constant, i.e., CONFIG_SCHED_DEBUG is not set.
>>
>> kernel/sched/fair.c:3927:14: warning: use of logical '&&' with constant operand [-Wconstant-logical-operand]
>>         if (initial && sched_feat(START_DEBIT))
>>                     ^  ~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/sched/fair.c:3927:14: note: use '&' for a bitwise operation
>>         if (initial && sched_feat(START_DEBIT))
>>                     ^~
>>                     &
>> kernel/sched/fair.c:3927:14: note: remove constant to silence this warning
>>         if (initial && sched_feat(START_DEBIT))
>>                    ~^~~~~~~~~~~~~~~~~~~~~~~~~~
>> @@ -1305,7 +1305,11 @@ static const_debug __maybe_unused unsigned int sysctl_sched_features =
>>  	0;
>>  #undef SCHED_FEAT
>>  
>> +#ifdef CONFIG_SCHED_DEBUG
>>  #define sched_feat(x) (sysctl_sched_features & (1UL << __SCHED_FEAT_##x))
>> +#else
>> +#define sched_feat(x) ((sysctl_sched_features >> __SCHED_FEAT_##x) & 1UL)
>> +#endif
> So this is extra ugly, for no gain?
The gain is stopping a warning that clutters the output log of clang.
To improve readability, one can drop the ifdef-structure and just keep
the right shift version, like Nicholas suggested. This will have a (very
small)
impact on performance in CONFIG_SCHED_DEBUG case, but when
debugging, performance is no problem anyways.
> WTH does clang complain about a constant? Can't you just disable that
> stupid warning?
There are 2 ways to disable the warning. Either disable it for this
particular
occurrence, which clutters the code with #pragma's. THIS is really ugly.
Or disable it globally and maybe miss some important/helpful warnings.
> Also, if sysctl_sched_features is a constant, the both expressions
> _should_ really result in a constant and clang should still warn about
> it.
No, because clang only warns if the constant is neither 1 nor 0.
(These being the 'best' integer representations of booleans)
> I'm really not seeing why we'd want to do this. Just fix clang to not be
> stupid.
>


_______________________________________________
Kernelnewbies mailing list
Kernelnewbies@kernelnewbies.org
https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
