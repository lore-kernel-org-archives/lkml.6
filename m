Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752537AbeBAM2x (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 07:28:53 -0500
Received: from mout.web.de ([212.227.15.14]:61270 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751916AbeBAM2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 07:28:48 -0500
To: cocci@systeme.lip6.fr, Julia Lawall <julia.lawall@lip6.fr>
References: <1517478532-5444-1-git-send-email-Julia.Lawall@lip6.fr>
Subject: Re: Coccinelle: reduce false positives
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <9878b76a-bbd5-94d9-a08f-711a3c2abf30@users.sourceforge.net>
Date: Thu, 1 Feb 2018 13:28:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1517478532-5444-1-git-send-email-Julia.Lawall@lip6.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:vvV0mkrdR08zOWNoDQHyCWX+huIW2sN6RKC4z4dOB6pNSw4poiD
 fbAmeTm7XRRhClteo+Hm4h0I0dI+YKjPKAz0sUvMqCpWrPUWQLaFxvMEUDlaKTSlebTFtDF
 a7tqT6HrMdh/OVhAG/mMf0R+EGYHlEVssKRABbrFcfCS/Hy13UIOZlAvEaGcmnhEcfxC9fU
 pAkD5w1D1f10MvUFU7SUQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+qkRXwRqlIA=:qFefBmVC4gL6eT0SJOdVp1
 wzeFZ/ymHCJd+67vectNIPT0CbYbP2KKd+L3pmwspbNw8+rCrEsRA+KTX8gFQOoAMUNyaIgpo
 SbF54ZGz6LgfQu62MLNsLq29FAVEmxzKfRI3yHufKOnAxqkVVWQTJJYQufEIRsuZRjiToxK0Z
 BonCtRya/M3z4cyBKyEe/OVEkDW/3Y67EgQyPTM47U/6zb0QrvEoMclubHr5kOphLBlhRMJJ3
 YmNRrp1UskqrY1cWrSIKZ/Ie/gooJ8G75CAGPQd+4hP6kkeI2A19Ua48kRVo/JcknuoFOYfKQ
 YVB1RNWLNIKxN6gh/Q0UjaYxbAZt29Qd9Pw9O5KTF85xLCUBFwQgph41rTqKFe7OkGVr872st
 04UU4u+R1g7TCJdBodZ+Q8K1Wpf/6nDfEc75O9EiCRZv9zC6mCl2OF9x61+FoR4B/v+R0Wrex
 pf3veUZ7QC3AiM806lHUWhXtMHC0sqSFXDZrD7hw0rrF0o75vksFKRZ040QzCKwSfdNWCO6Pk
 i+MYrUIvzUKa2L+wPrJS1VTaHkLaXv0qhykYlSrQGYXGzW4ozfk2m2XYVqnxmMsFv6KH5j0Jb
 8WnzLIEbguG1yZl2DK0bPsCjo5fMH1uaa/JkvT8marQXnIHF8EwMW1ZUY7KQ0UXaXLlJv69Aw
 CFpIMdmVI9tgbpfjPUY6lc2qFsEFiQTvk5MhIdBpzbX44SUZSADBilB5EXn3xHYTllS91SVIi
 UPrQXbpdZSY/Us7y0a38Vhwph2Jz0Ib8AvWR4C00NAcCBVUJzlolv7kmbLZGQ4Opwvv5nbJ1E
 GGoSzUk0z07Vtzra0vkaLAWniVGF3U+treQ8XBuSQt3eocwpAo=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +@safe depends on context || org || report exists@
> +expression x;
> +position p;
> +@@
> +
> +(
> + x = kmalloc(...)
> +|
> + x = kvasprintf(...)
…

* How do you think about to reduce also a bit of duplicate SmPL code?

* Can it help to work with nested SmPL disjunctions here?

Regards,
Markus
