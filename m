Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFDDECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 14:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B58E2089F
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 14:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B58E2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sourceforge.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbeGNOyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 10:54:33 -0400
Received: from mout.web.de ([212.227.15.3]:57553 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbeGNOyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 10:54:33 -0400
Received: from [192.168.1.3] ([92.228.101.215]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Ma2hT-1fLRCy1PGJ-00LrFn; Sat, 14
 Jul 2018 16:35:03 +0200
To:     Dominique Martinet <asmadeus@codewreck.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        kernel-janitors@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
References: <1531555951-9627-1-git-send-email-asmadeus@codewreck.org>
Subject: Re: [v2] Coccinelle: Replace strncpy() + truncation by strscpy()
From:   SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <4bbe41a6-a9c6-ddd7-6683-14c792c16de0@users.sourceforge.net>
Date:   Sat, 14 Jul 2018 16:34:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1531555951-9627-1-git-send-email-asmadeus@codewreck.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:v8G0uByQ6MMIcIv5Ii3X0/k6ofGcuu1dpMKNUaCljXuExYXIww4
 BnDLt4DdhvkRMmiQD2gYyJz9MMLlqwnKIhZKdHS9MZaEgVx7ORvN73Le/OxC9i/fhiAf6kL
 vdxBee9DROH5Z4ciB12jAo1rsEtd1GahA7mMPL0sRCoByVFrRUkWk7o+A57vygmhB9ZdAF8
 4O/r6JAtics7NosLHtMWQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:F/ONM8SBmAA=:LS+FCbzk5COUf/VsWym3vH
 sj974RgE/FXexJhfIDJaor4TbPROL60YWUuSn8aH8jqbpsmzX55AZh5T5DmW/44tWO7bvQ2tz
 ijP0L5qTjlWBhFWPubrWDyZfUs3YA9fnfsaYRo2YAfiYnEZNeGpWqpENMhVb8PtoG/Bf8XKcL
 ddjIL2sUYg4ZAvNcJ7tkMZ7x1VCFuiWNK4BR0zbaq8iMQTtz4ylPhD8pMVhOVqyi4jyR4wMTR
 Sw/tb7M3tvtwWHhAF8RGlHAJSsSWjhXe9SRAXQvNRhPGmEFx/KMkeTfXhvVoK4yRdaDXSHXCS
 iShpT16UvzU3DwqWWNwggtfO2t0HdQBGbMkjIO4Ch9R4aqZ45+5U2mQ2t82lbzGPi1IxEnZrr
 XRwMFVyqQOOkBdrHVkYKCZk1/0jkykfJuforeYDaHYIG9zmP5Zjd062Mu1bYJ+pgvb1Cgvvb7
 vn1vjGRaK1LIJ2CEH0qagn5JvreS+xvzeExK9uQy3hxC9eYH35bnYJdLrjeaRgFxscV6E/6Q0
 8qvjGtxdBtgwCbuYzlcgADkWnpkkvtWetbCejwRyf0o8aNehamqKWl6unowCi5vuXYO9gwmF7
 EEwc2oW3QUfexmmTz/gAHkCkgUOR4KOMyjeQd2Dfk42b9P694sKn5SK4fu0QLAKHsZHX9LQk5
 nwLdNoUgsej/0T6SYmrV+Akg+yB3yEuVHeHRDZseWuiKpKiuifUtuOE5BEG8Yj1zDwg2OHlO0
 /auMsJIgTHLp1ZjtEpqkZFf14h4eGpU0sHEB1O5yRBJrpcQ4OOtxmMiXNH4TQ6CRCsuWbMWmd
 TMf+zZ0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to contribute another bit of patch review for your proposal.

https://patchwork.kernel.org/patch/10524633/
https://lore.kernel.org/lkml/1531555951-9627-1-git-send-email-asmadeus@codewreck.org/


* I have noticed that an action word was missing in the commit subject.

* The commit description was started with the wording “Besides being simpler, …”.
  I would prefer an other ordering of information there.

  It seems that the mentioned compilation error gave you motivation for
  the shown source code transformation.
  I suggest to move the concrete update suggestion behind it.


> +virtual patch
> +virtual report
> +virtual org

How do you think about to reduce a bit of code repetition?

+virtual patch, report, org


> In particular, I have conciously not removed the intermediate msg
> variable; as I made the message longer I actually added one more of
> these for the org mode section.

I propose again to reconsider such an implementation detail once more
so that unnecessary Python code could be avoided.
The Linux coding style supports the usage of long message strings.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?id=2db39a2f491a48ec740e0214a7dd584eefc2137d#n81

Can string literals be nicer than extra variables (because of questionable
source code layout concerns)?

Regards,
Markus
