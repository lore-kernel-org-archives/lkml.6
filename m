Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E11C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 18:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A72521655
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 18:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="sC7vFQuT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A72521655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeHYWTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 18:19:42 -0400
Received: from sonic303-10.consmr.mail.bf2.yahoo.com ([74.6.131.49]:33194 "EHLO
        sonic303-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726854AbeHYWTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 18:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1535222394; bh=r/SNa/I8zHBUriNBSDhxHgiQSmzY9dXaVynzrHILmzE=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=sC7vFQuTk/ROMHSp70VUisCLS6cyFsnvEU88/nAkZu4yYzuNgQclkox+VC+u3oh4fBj//dtzFZ/fhzmIH5j/hE62qOn+0rr95KZzjDS+DK6nJlo+jcg4d25ea/iuuMQoUdU/HxysUFN4aTC3YFjFpmbq7r5Vbu+iH541pn8mW93VUQLZd17HiMgu/82auapIudovuPgW1XYWM1Br/ALz/LMsv+xa+RUI2yFyCuqk5tpo2ncLgTeXRVT4hMjKe5wZ52//EfUHaqrvAYxuqviAsOd313Ksxv2/Zpst24bU0pgAWLHqTOQlbdqfT94DLx/F3pISCuJJxYvhrICGcF+HDA==
X-YMail-OSG: 6nSLZZMVM1ka0UxVFgoh_MRBk4.62o.aOFctUf2g...NSuZEeBcfRlnbgrSp_Te
 rM45qddKMWDNiTG6dtsFrvmAMdPGTpgs37uJzejFgNP04o84jcsuMF1RtUtRTHeVjP69KZzBxRzS
 DsQXxrsS7418RCUQ_SaF5q6bdvlplAH1972vNEdfWv7ajg2CRMsHitsCcJTGnHtdEIdZqQU_VCPp
 63fExMWf7BIRLjh3UZKPr7jz.kl2fFkF0l1eDdo8aLW7Skw8uMyN7zrUMEeRfRKHHZxEPty3c05S
 N0V.cfMCFeRAyehpIuLmuGJcaDpCz1_rBAy7Hxx2eKKhB5LqEFKOXdJ8yHhtCtM04PGvS_0j8MCH
 7cFF_j2PL779v7.cyeHJSVv_XP4GxUwd.e2GTPlCldfbE56ODuVG_dDHjZDxQkLFYMwAKscd2bcY
 RSpHVkDu.DPQD45nkUS_Nby_g5dnDs94FQq5dsdlBXmqjJTyw.5ejYR5TgCkZBYs.hd6ZA5KcoP8
 av7gj9IaZ4K3PwpCOENwMrjNMywO6U6f5NIvVYF8un9BMm3IVN1id17xnXoNwVLcKPdm24.p4qp8
 oR.DU2yxxOJE3w4kDZRMHOUbxixtQO295qP28h2028LeG5ohG3sf4PMAJvnH2CbCqan82nJrbTbs
 9uDae1RZGTbtnF3aDB6D8if0RYOX_tadn213v4DT2F9DIoKEwYJ8cUY6pJy7kzs2GM7ICs7_zLvH
 D1bha2ooSQ7IelmrkFTHRmiJrnP5SsSwkwSjgV6g1g87e45N_xoy2JFfu01a4VjitD.9sC8oNsmr
 R4BTRTzEmWVa1VPYHfdpGghEdI7A3K2umy2wQjw8WStsy.OMJ_AAQRDxzSYe6LteyZGXbuTDzqXd
 pIlu8zYuoZEOyvVOaDCS68vYqIAVllGLOJb1RxsLoItDeDIFRCd1lAtMT587DYqoHhulHVzRiWFS
 niwFun0hSkCymhQk_eM1HeoV0FsDLXh5lxExtca6F7bPhgRXQw4cIlkoOxehTYZNIWkLvdTW8wFC
 8xY8Yog--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Sat, 25 Aug 2018 18:39:54 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp421.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9d3171a83154e2bcadd17b8feabdad88;
          Sat, 25 Aug 2018 18:39:50 +0000 (UTC)
Subject: Re: Disabling CPU vulnerabilities workarounds
To:     "Artem S. Tashkinov" <aros@gmx.com>, linux-kernel@vger.kernel.org
References: <575b6581-7dcb-96a9-b06e-9f74dda5fa86@gmx.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <3830fa4c-29d6-99e9-6c8e-b1a30cba59f0@schaufler-ca.com>
Date:   Sat, 25 Aug 2018 11:39:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <575b6581-7dcb-96a9-b06e-9f74dda5fa86@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/2018 3:42 AM, Artem S. Tashkinov wrote:
> Hello LKML,
>
> As time goes by more and more fixes of Intel/AMD/ARM CPUs vulnerabilities are added to the Linux kernel without a simple way to disable them all in one fell swoop.

Many of the mitigations are unrelated to each other. There is no one
aspect of the system that identifies a behavior as a security issue.
I don't know anyone who could create a list of all the "fixes" that
have gone in over the years. Realize that features like speculative
execution have had security issues that are unrelated to obscure attacks
like side-channels. While you may think that you don't care, some of
those flaws affect correctness. My bet is you wouldn't want to disable
those.

> Disabling is a good option for strictly confined environments where no 3d party untrusted code is ever to be run, e.g. a rendering farm, a supercomputer, or even a home server which runs Samba/SSH server and nothing else.

Like maybe the software in centrifuges in a nuclear fuel processing plant?

All the examples you've cited are network connected and are vulnerable to attack.
And don't try the "no untrusted code" argument. You'll have code on those systems
that has been known vulnerable for decades.

> I wonder if someone could wrote a patch which implemented the following two options for the kernel:
>
> * A boot option option which allows to disable most runtime protections/workarounds/fixes (as far as I understand some of them can't be reverted since they are compiled in or use certain GCC flags), e.g. let's call it "insecure" or "insecurecpumode".

That would be an interesting exercise for the opposite case. A boot option
that enables all the runtime protections would certainly be interesting to
some people. If you could implement one, you could do the other.

I would be happy to review such a patch. Go for it.

> * A compile-time CONFIG_ option which disables all these fixes _permanently_ without a way to turn them later back on during runtime.

This suffers from all the challenges previously mentioned, but would
be equally interesting, again for the opposite case.

>
> Right now linux/Documentation/admin-guide/kernel-parameters.txt is a mess of various things which take ages to sift through and there's zero understanding whether you've found everything and correctly disabled it.

I can't argue with you on that. Again, I believe the greater value would
come from documenting how to turn everything on.

> Best regards,
> Artem

