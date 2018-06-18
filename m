Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78D0C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D67B208E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:42:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D67B208E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=juzza.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968170AbeFRImD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:42:03 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:41799 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967000AbeFRIl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:41:58 -0400
Received: from null ([172.19.249.30]) by mrelayeu.kundenserver.de (mreue004
 [212.227.15.163]) with ESMTPSA (Nemesis) id 0LkUgR-1g5YWW3Cxf-00cNFe; Mon, 18
 Jun 2018 10:41:47 +0200
Date:   Mon, 18 Jun 2018 09:41:44 +0100 (BST)
From:   Justin Skists <justin.skists@juzza.co.uk>
To:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        "Speakup is a screen review system for Linux." 
        <speakup@linux-speakup.org>, Gregory Nowak <greg@gregn.net>,
        linux-kernel@vger.kernel.org
Message-ID: <1117674358.626563.1529311304239@email.1and1.co.uk>
In-Reply-To: <20180618053444.GA1614@gregn.net>
References: <20180604095212.GA18381@tanglefoot>
 <20180606132628.fxykchbznrwzgwqt@var.youpi.perso.aquilenet.fr>
 <20180611225703.csi47cdafhy6rxcf@var.youpi.perso.aquilenet.fr>
 <20180611235122.GA28343@gregn.net>
 <20180612063105.7urgjfckrwjvqs6k@var.youpi.perso.aquilenet.fr>
 <20180618053444.GA1614@gregn.net>
Subject: Re: [PATCH] staging: speakup: refactor synths array to use a list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev28
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:OyrIMwyd9XgDKL2LxEW6qaCB8i/pNgJdj40LDYXjA3B5s7g9v7m
 m0vjxV1MvfEvJpr77wPVMTUvh4bGryloFAP5nM0ubZNEttibZI5VyItlIaoO+OHMehcj1YM
 hfzVr6kTNXKh9gyRJsCLTf+sWsZTqdLV4aWGe/TlnmP15X9b+IHr8BUuCyYnoJHxIcfPVVr
 gdxyyerXHNOhNvLK8ZjLQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zi4um1Ijeac=:CCMtDqYfC6njmYqsSa+TAo
 1NTAPMSeP6xQcQHsroDN/zgYj47bhsHqDJIiooeMLbpGib0NNrGod7BMH0nol9oZdOYv2wrkh
 TeJ47V3xT206HkSPAphcy5MhbaxfNqvdUNmjkk8uiMX1TCWtmPGHvarsybQ6t//t/AbIxv0Gd
 QDGeVUM11u1ryUaUPpdZwtNQIIZ7QeEUTsGn2LTAG0ZFt/Ja4GfpvPZ+atnp/Ob/QOtUi3Viw
 FjejqtDThXxv14X+lFaqH7nZIDBTuWzjVFrU8fajNfzFF9FvSnaAwYgnhkkSNoEKA56T5DONy
 pKhLuurwLp6niSqEfYeu4N2+/TEn1xk87s2cZ6Pxtvq7xcF9eWVn7O9oRaDUUl+4z/0ANEb6/
 Uk9SgTNLvbXxbTThrXHNnpd4VhCEwz38HT4epLM0MzONw3f5tgWgRMTxrALmGxZOQMYbOm9iC
 2uVXtxZGbXflr8rifYStDjRp+3aWEZ6NoEO3zGurR8WrgaGJUUN/OUIGYKCyy59j9QjayaBBv
 3TBW9yMAGzbW35ajjN2nlazTa+XFuf0Iy5oveMd/JdFvWg+T/U9zIdnDOZ3PoUupO3ysUV2AA
 kLKpKnfUCId/qXICvcrJvOTpa0Pr7khP1yjsdJEWyEsIhT4y/yHtKL7hExXU6CakPYA5ngMmy
 Zb39YOpyGCq8OEhNjT6S59f4niaGSwMVVQ03P6ZghtECMH/Rj9hPFYImkSAQp6Gt1qFqlg4zB
 AoDLGC+Abp4P350L
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 18 June 2018 at 06:34 Gregory Nowak <greg@gregn.net> wrote:
> 
> 
> On Tue, Jun 12, 2018 at 08:31:06AM +0200, Samuel Thibault wrote:
> > The load/unload is about the module itself, i.e. modprobe speakup_bns ;
> > modprobe speakup_soft, switch between them, then rmmod speakup_bns ;
> > speakup_soft or the converse (to exercise both orders).
> 
> # uname -a
> Linux p41box 4.17.1 #1 SMP Sat Jun 16 11:19:57 MST 2018 i686 GNU/Linux
> # lsmod |grep "speakup"
> speakup_bns            16384  0
> speakup_soft           16384  1
> speakup                94208  3 speakup_bns,speakup_soft
> 
> With /sys/accessibility/speakup/synth set to bns, I am getting output
> alternately from the bns and from soft. It's as if speakup can't make
> up its mind which synthesizer is being used. When I echo soft
> >/sys/accessibility/speakup/synth, I get no speech at all from either
> synthesizer.

Is this a known issue, or a regression due to the patch?


Justin.
