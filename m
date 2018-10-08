Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D399BC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912E521557
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:30:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 912E521557
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbeJHWmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:42:14 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:60027 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbeJHWmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:42:14 -0400
Received: from [192.168.1.110] ([77.4.53.57]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MryGj-1fO2yd1XgD-00nuiz; Mon, 08 Oct 2018 17:29:22 +0200
Received: from [192.168.1.110] ([77.4.53.57]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MryGj-1fO2yd1XgD-00nuiz; Mon, 08 Oct 2018 17:29:22 +0200
Subject: Re: Linux 4.19-rc4 released, an apology, and a maintainership note
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Pavel Snajdr <snajpa@snajpa.net>
Cc:     michaeljpwoods@gmail.com, linux-kernel@vger.kernel.org
References: <CA+55aFy+Hv9O5citAawS+mVZO+ywCKd9NQ2wxUmGsz9ZJzqgJQ@mail.gmail.com>
 <93424bb0-180e-71ff-f0d6-602caa2d5883@gmail.com>
 <260205ec45d097fb037f71ae42e7b69e@snajpa.net> <87murtg3ow.fsf@xmission.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <56371a32-14c9-f59c-c98f-2414650d8505@metux.net>
Date:   Mon, 8 Oct 2018 17:29:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87murtg3ow.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:YG2ux9Fzq2xiHinTk0aK1vLIW+rWzBUrQ0bZhaTLr9xte6tVBCV
 zla3Q5dD1LqKzIBmKpAY26162SBv6zpAImErD+wGC1+eFGfn7JCMvpj83FQDUjIeyEx2OJE
 WRXGJ5F2zjBZhr2WO3rvKaMTL7t3OmgIlXq6wsIgnrHIPKPrfh/2JrSX1Ip1PCUljEQL6G/
 ezE2GKxbkUAmSDlYx24Rw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eWXxq0ijvu0=:BAtY3vUXaLYJxWThtyRp/X
 Bg4NmOLAVPexH3wYBP+zdRPPefUrsAGYxbMzQo8xDFOzNvKhmMv/WfVbKiF4a+V7cCZ8s4T4D
 HaZuRi8tZAQC5D8K5dRfGsZKGdqA7jU/fCcDVPME54FzIBPRuhp+QZdVAOjTp4yP1xkmCDLN8
 5WOTITstNEDHKg68Jbz/pYxY2Y2vCoCufHUHP3OLrs4axz1e9TdqQPyioMZRQgtAWksaMie2P
 kyB5yKoymYa5Zx/PweHXQPGa3qjyBE1pJo76ohLuSnoUloe/UwXidRKYvp+ngBiTNgnaIu+ch
 QOIq/7SBjWUZrEpz69UZjO5X3IABfvolyrVuKdDtoRjRJShJaRl4tV/MxVqU8co8vR2HYvHg7
 7nqDgBc6QWYmBCce4ylkL6esVrppRZ8d6p2vZqLfFWlKJqQn9Vh15ecrXDd9mHJ3paUtS+v72
 kCSxoCQZQHeQ2gVNOMHVhjG9//QnMKC3rCQQFRhlQ2dU9RFrLJIm8CEnCPmI6pfBUQpl9SQn7
 OEipO/vbvSGGEGuZ4Devslm1ztsvX3xBGsEosXBukAjoc+e286men3Nf9RAMrNtISYjY04ITq
 cfztoXNgSY3HEemGq8RufsEZiUgd5bOuO9Qi+ALRSOOAl66S+epAIeyJwZpzX7uLdRqVBOmpj
 /N1RpkVInPM4k6PGLx1ZL0193XJacmdIYHvSrhonbupIexUZSEJy297OIZinWpdhv9zvZjl+d
 P6Rqu0nNDK6R2niR
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.10.2018 16:57, Eric W. Biederman wrote:

> Very often people will propose patches that do solve their specific case
> but only do 10% or maybe 20% of what is needed for a general kernel
> level solution.  For something that just works and does not cause
> maintenance problems in the long run.

One of the cases is the hard realtime stuff. A perfect implementation
for hard-RT environments can easily turn out as total crap for
generic server workloads. So, these things really take time make both
worlds fit together. For those cases, it's often better to maintain
it as a separate tree/patchset and step by step try to bring those
pieces to mainline, that fit in there.

> I know many other maintainers get hit with such a stream of bad
> container ideas that they tend to stop listening.  As their priorities
> are elsewhere I don't blame them.

Let's put it that way: these ideas probaly aren't necessarily bad as
such, but just don't fit into mainline (yet).

OVZ is such a case: it's s good thing for a range of usecases, and
pretty successful there. But it conflicts lots of other places that the
mainline has to support. Therefore it has to stay a separate tree, until
we've found a better solution, somewhere in the future.

> Similarly because maintainers have a limited amount of time there are no
> guarantees how much we can help others.  We can try but people have to
> meet maintainers at least half way in figuring out how things work
> themselves, and sometimes there is just not enough time to say anything.

Yes. I've been demotivated by this problem myself. But I know, I can't
expect anybody else do to my homework for me.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
