Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B847AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF0420659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="rHHyV0nl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfANU1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:27:32 -0500
Received: from mail.efficios.com ([167.114.142.138]:59380 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfANU1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:27:31 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id D5E5DB0F9A;
        Mon, 14 Jan 2019 15:27:29 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id GzBoXBPxaKMx; Mon, 14 Jan 2019 15:27:29 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 32687B0F93;
        Mon, 14 Jan 2019 15:27:29 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 32687B0F93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1547497649;
        bh=aPDKfs+asW2ujrwaTzAF1+0kalK7DaZsx/GfoFgxw1M=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=rHHyV0nleeDHJpud868hX7cA/D9JAMeaB0hIrQneEhyj/Snexm7nwQTDnVWwQYMPd
         QqiTDJe+orikieaDqdkxgCtZ1ZLcsnhIAwybHUaYABS3yOCNFdaui6CU818J5bkCZl
         lIekjsIlOfpAS/qhHf7Ksj4WUf77FbaDck7G+/QBCgaZcoxm0cfajvj6nLCFmBmNsi
         HbWLUfqoeAH22VNZnnIurqCIzRIUPy+P+iOFs/UwPisqjJOEAayxNSw/CYzwYiQjT6
         hpOcnvMrsZn45sr7swBIcRRGNu0zfMm8JdK5eSJUZxKu6azCmUJgBn/CTYch3cP+GU
         +wzyVl8EqlSJg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id n8qcijkyLZ8K; Mon, 14 Jan 2019 15:27:29 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 14B8FB0F8D;
        Mon, 14 Jan 2019 15:27:29 -0500 (EST)
Date:   Mon, 14 Jan 2019 15:27:28 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     carlos <carlos@redhat.com>, Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <1031872348.636.1547497648914.JavaMail.zimbra@efficios.com>
In-Reply-To: <87y37n8202.fsf@oldenburg2.str.redhat.com>
References: <20181204192141.4684-1-mathieu.desnoyers@efficios.com> <87h8fkz6qx.fsf@oldenburg2.str.redhat.com> <1681283664.1380.1547152315426.JavaMail.zimbra@efficios.com> <87fttv9iic.fsf@oldenburg2.str.redhat.com> <394676913.486.1547493757710.JavaMail.zimbra@efficios.com> <87y37n8202.fsf@oldenburg2.str.redhat.com>
Subject: Re: [RFC PATCH glibc 1/4] glibc: Perform rseq(2) registration at
 nptl init and thread creation (v4)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3716 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3745)
Thread-Topic: glibc: Perform rseq(2) registration at nptl init and thread creation (v4)
Thread-Index: 7Bn4s7W2wSGVuvgGOq6RJwBqjCZbjA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jan 14, 2019, at 2:37 PM, Florian Weimer fweimer@redhat.com wrote:

> * Mathieu Desnoyers:
>=20
>> ----- On Jan 14, 2019, at 10:55 AM, Florian Weimer fweimer@redhat.com wr=
ote:
>>
>>> * Mathieu Desnoyers:
>>>=20
>>>> Therefore, both symbols will end up in
>>>> sysdeps/unix/sysv/linux/Versions.
>>>=20
>>> I'm not sure what you mean by that.  The physical location in the
>>> directory tree has little effect on which shared object the symbol is
>>> placed in; that will need other changes.
>>
>> I'm currently moving the symbol definitions to csu/rseq-sym.c. On Linux,
>> its content is overridden by a new sysdeps/unix/sysv/linux/rseq-sym.c
>> which contains both __rseq_abi and __rseq_refcount symbols. On other
>> platforms, it is a stub file.
>=20
> You don't need a stub file if you use the =E2=80=9Cifeq ($(subdir),csu)=
=E2=80=9D
> construct.

OK

>=20
> The other question is whether this belongs into the csu subdirectory.
> Since TLS is not available in ld.so, the initialization would have to
> happen rather late, after relocation, but before ELF constructors are
> run.
>=20
> (A side effect is that the rseq area would not be usable from IFUNC
> resolvers.)

Do you have a specific directory location in mind where we should put
the built object ? e.g. "ifeq ($(subdir),posix)" or
"ifeq ($(subdir),misc)" ?

Moreover, from where should we call the rseq initialization ? I'm having
trouble with invalid system calls parameters if I place it in
LIBC_START_MAIN() just before or after the call to __pthread_initialize_min=
imal.
I get what appears to be invalid parameters to sys_rseq, possibly due to
stack corruption (?). I'm investigating at the moment. But if you prefer
we call the rseq init from elsewhere, please let me know.

Thanks,

Mathieu

--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
