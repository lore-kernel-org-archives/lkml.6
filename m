Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752161AbeBALF0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 06:05:26 -0500
Received: from mout.web.de ([212.227.15.14]:55286 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751520AbeBALFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 06:05:23 -0500
Subject: Re: Coccinelle: zalloc-simple: Delete function "kmem_cache_alloc"
 from SmPL rules
To: Julia Lawall <julia.lawall@lip6.fr>, cocci@systeme.lip6.fr
Cc: Gilles Muller <Gilles.Muller@lip6.fr>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <CAK7LNAR27r4j4c1FCh_ObpMpBKXgSP6Vq3P=reA-JKoTji6Q1A@mail.gmail.com>
 <6bee0e11-59ef-b7b1-886e-7abaa30887f2@users.sourceforge.net>
 <alpine.DEB.2.20.1802011040110.3135@hadrien>
 <22276745-4723-4391-4460-07f0820ae85b@users.sourceforge.net>
 <alpine.DEB.2.20.1802011125460.3135@hadrien>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <f2793c7f-af1b-edc0-d9ea-0937c7241733@users.sourceforge.net>
Date: Thu, 1 Feb 2018 12:00:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1802011125460.3135@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:2tj4IDMaRt2ISt50WRNHPEfhQMWQXfylbQtsgU7Q9fwk5G2cMwx
 pU7YSHUtVq2MgqDABWodbX6jSu3aOMiCAfZD3bJPXoFrDuIcuU5jy6M22iZfmfqJ6qhWuLt
 4Ua43vW4ztvFK1iDTGp2SyBJu4VpEHEYR/XDBaJhCaQMc4Szhwzk3+mjsn5NQ+EaLAKZo45
 v7BiYrqU9IHqnqWQc2QQA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GQAuekyevaM=:AMkEC/yCAg+gdSuo4czhxZ
 GIVQrb+SXle68+sgcMLSZQqScfngHDK0kZ/8nOSQIFJoGBpVt9BzCE3qsVXg9a/j6bPvtaAYl
 mCtAcfLlQ/xLfhqVFbS6VaXae5h8YLgW+w5rIkJvljylVXvC7KcDHN9MmcC0yobMeOwWcFFiy
 SQsT9AwfQp4B6bGn1HfoXKYkAqh7rHe6KWOpE27A4PF1dq3Qnr2lz+zLqLS8jx21qODSJTxXh
 oa5DGqJfgI2Ce1j2FD9hGH0IBQFvouPMcsZIB/8vnrx3vFd569HgcBU1EuFbuAv7VIERuK26l
 JDZ9DIuSbxtsJUfpN+E1ELVEN9oYteHo8izlsvB6BKzIMBdTq768Rgb9o4GGikwxYpSv4mO30
 imgdStZ3qU59A/1pyx5k2dyaciK/LxVgXqmswVup4Qxk9uwcfr/ea5+AQD20Ifp/Er1MYrmbI
 1jR7qzhjZIn/bcgzh16QEgaY8XjMuecIjA2TcYzMQjQM5ZBQ54dVAj9NbtbF0eJgYNNl7e7Vk
 jBd5LTc/G4Bz4z/AE2AvX3WpbUpW9gH3NrpDb+RixBmdSWhCKXMRA+zv5VN/25z8J3PMQsjyN
 jJE/AfsTvGzeXUNYKGXgB1eMSzJ3f/zLTIPXFsm6Z9l1ldrdoW92tjpygPfn3iyZvfX8UZi4a
 GV0Hk+i7FhXRWmcKq57StL5l7ql0LDjFHvJoI0AekffcNaABCtm0CfjmV6liMnaOWsqsHBYO4
 AJD9wUqA1xhPUhe5qK3Qw+UaZ0bI7toAbot1kITeoTAJgjY2cy5nCECBxVpH2rQ6f3+5iTMY9
 4vR/YR9skjlN1oSl5AgJ2cpuy2a8w1SlZaLR6JeqcaCCcyCfPg=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> * Do we agree that a proper size determination is essential for every
>>   condition in the discussed SmPL rules together with forwarding
>>   this information?
> 
> No.  I don't mind a few false positives.

I have got other source code analysis expectations there.

This SmPL script contains the tag “Confidence: High”.


> The user can look at the answer and see if it is a false positive or not.

The situation is questionable because of a specific software design detail.

Unsafe source code search patterns could be stored under other script names
(or even different directories).
How do you think about to move the SmPL code (which I proposed for deletion)
to another script if you would insist to preserve it?


> Furthermore, I told you how to address this function so that the size
> issue would be taken care of.

You offered another bit of information.

I find your interpretation of this aspect also unclear at the moment.


> That is the patch that I would accept.

Are there any better development solutions left over?


>> * How can a name be ever relevant (within the published SmPL approach)
>>   for a function when it was designed in the way that it should generally
>>   work without a size parameter?
> 
> No idea what this means.

I am trying again to resolve corresponding communication difficulties.
Thus I suggest to take another look at the following SmPL code fragment.

…
  kmalloc_node(E1, ...)\|kmem_cache_alloc(...)\|kmem_alloc(E1, ...)\|
…
* memset((T2)x,0,E1);
…


How many constraints should be considered for function parameters here?

Regards,
Markus
