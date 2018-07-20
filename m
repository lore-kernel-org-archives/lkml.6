Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209B5ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E7A20673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:00:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E7A20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sourceforge.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731000AbeGTLsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 07:48:17 -0400
Received: from mout.web.de ([212.227.17.12]:57555 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728307AbeGTLsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 07:48:17 -0400
Received: from [192.168.1.2] ([92.228.185.52]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LwqBg-1g4WMH3HWC-016NMZ; Fri, 20
 Jul 2018 13:00:13 +0200
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
References: <alpine.DEB.2.20.1807200745400.2349@hadrien>
Subject: Re: [v3] Coccinelle: suggest replacing strncpy+truncation by strscpy
To:     Julia Lawall <julia.lawall@lip6.fr>,
        kernel-janitors@vger.kernel.org
From:   SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <154c8cbb-c396-d3b6-c53c-f28b4e44c0ed@users.sourceforge.net>
Date:   Fri, 20 Jul 2018 13:00:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1807200745400.2349@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:CrkfPoY53fzfkECYrkK4MfyproyxKfGkIuwlus+pbF/VDoYBWAj
 wG9LDiRltLyPmsZKRd1GhTnXjEGRHpHbaZT7aUBFZOzHFHL+wjcHijDGu/Fl1eCUHZfWrOe
 ZF6rwyJ66MkbQnnnbBP6N+nGpxsKTWxNJWiqiwu+xBNojG0cD7EfSBvo5rZEjwrMUkRUioD
 MNoDMH8M76Ibiehlw0HwQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:52M7QvtMte8=:i1iDWw4Et47z1T+ntFKRH/
 XFYRnsVe8Hwoa2B+N33E1nRjBkWU4hhmDV6zjXDjy7QH3Kv4kridhKaUjyyYORNAGUxveZieL
 2AeKA8cDRXsmX1O48RvDeSZRGUhBZTldR0GUtF0HwRfiESKCC9Fl8wyPwZcvOh+9oplLfZ6UV
 MOcN/d3n6PYRhNuGJCkEhW9mNLp0aO2+yaEaiFVNmhrtgfCXyetv5otGGHFs4EJaFTH0xA5Fd
 aBM1xAEwUXIr0KhBktYdAezVdWfI9u3/yWpK7Tq7fIpapGqJPMo0TABc7WdqPXOwqtczxjByh
 1zqjWu9N+jiKKwUjVny8JZnvG5N8t7W9BBu1+NmsnhapLmd5xizHxsNfLVsZtfJ0oC0CoL6qi
 X4LqeDrleX70pFaJ1YE6IySFzuWACysw60IKQiVRGeU2BZHuiz+M6DQUzMtQhN6mwJbMaWj8e
 ewA0kSbZyKhM7kun8zG7djkGewa+OGNwQ3vf/kWySclLZHS0DOOSZCNhsDp1lvj271AMWVyNS
 NjSEVPEQs4E/Q0ZnZ4iEWhWde3BnA4JXXFdiZ9GdsoR0p2JFdZ3x+1dm7vz4+Y4pFvRMGSmHl
 TxweeCSBMd6g8GoCcgOB+FNGeV7ydWqImehZTy8VmxjdArtUCQasSElw7e6hfnhBG+sxdazLn
 SHbZLkyepDmoB2Uta4XqO4TrFtzyK8ZUikZNUR6jhdIPj04JrHA5jS71sl5arJFAxWGlGrZzF
 b6WdThwQ/53AnuEOlOK+sz/hAnl9TVG7Kgt0MauxhE2ZMrNmpnUloIKqGXK9+JOad/VpPgBVQ
 Flla2Gy
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem is that I don't know if the script is correct

Will the clarification of such a concern evolve into another interesting
software development adventure?


> - I'm not familiar with these string functions.

How are the chances to improve the understanding of affected programming
interfaces anyhow?
https://elixir.bootlin.com/linux/v4.18-rc5/source/lib/string.c#L154
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/string.c?id=28c20cc73b9cc4288c86c2a3fc62af4087de4b19#n154

Regards,
Markus
