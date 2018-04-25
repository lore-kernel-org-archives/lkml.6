Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754761AbeDYUJv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 16:09:51 -0400
Received: from mout.web.de ([212.227.15.14]:41271 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753991AbeDYUJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 16:09:48 -0400
Subject: Re: [PATCH v7 2/5] of: change overlay apply input data from
 unflattened to FDT
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Alan Tull <atull@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jailhouse <jailhouse-dev@googlegroups.com>
References: <1520122673-11003-1-git-send-email-frowand.list@gmail.com>
 <1520122673-11003-3-git-send-email-frowand.list@gmail.com>
 <09e3db63-cbf9-52a2-ee77-520979f17fea@web.de>
 <7bbf615b-3cdd-6bb4-6918-33e48de4225d@gmail.com>
 <a21dbee8-6e4e-9ceb-c798-dda43c2eae2d@web.de>
 <d7e94a45-5d46-0491-e5dc-2b098a11c5b1@gmail.com>
 <CAL_Jsq+MmUTMrd+jNqUB2=A-q3cCy7+QWOKG0iF6zM0hjCy3PQ@mail.gmail.com>
 <e508f3de-f21b-2510-2c6a-b810073ba1a7@web.de>
 <e06d1c0f-f60d-fc23-cd74-82f557dbc432@web.de>
 <7bbb9472-9c96-6012-68e6-4ec2773c7732@gmail.com>
 <4422f58a-ca7c-16e6-e0df-63faea50f553@web.de>
 <3d7cb4d3-5070-e878-51d3-59f9772f756b@gmail.com>
 <53ee2d0b-1867-5cad-667c-7f70085c645d@web.de>
 <e2eb2c23-d580-8c46-5bdb-a142b3791301@gmail.com>
 <c79a60b8-60a3-dd6e-76c3-d1fdfa003e49@gmail.com>
 <3050f0c1-549e-d4b9-50b5-468c11effea9@web.de>
 <CAMuHMdUNDcvKzOJ3JtWBQRVDF9d63K9Lot0-fKQcsaWTsadDvQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@web.de>
Openpgp: preference=signencrypt
Message-ID: <f63f0277-4318-4a98-6ad4-157f7ef164ea@web.de>
Date: Wed, 25 Apr 2018 22:09:38 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUNDcvKzOJ3JtWBQRVDF9d63K9Lot0-fKQcsaWTsadDvQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:i9jEcHp5Sk4/g5JwIBAa5K9CFDyo6Fyyd3gXNMoJ3fRv59biVtY
 MJ92rKjfMu2l8unGrcirVuMa2PvyJ8c3GjkiRx33k6zGE/KcFI5ajDN6Hax4vX2FGVMgXAd
 L67fZO6NbttZipHNsQa8+KewtwI1STpVqL+kTJgXTUJhXS3vtQUJWiQoQvS1kf2FizcC6iu
 u+zj9x+GnX/yzn6ciTV+A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:a5+b8Gx3lfI=:IvFuqjUcJy/AOh8QlUP0xz
 B0lkujZ5el0SPhAH1i6nj6klSIwyKy7TzN7DAm8Jb/lqbtNK5V7QWvQU9FyGTfGB2AMiSKkdD
 9t+tbpARCD4T7QWvrmVaBR7lStyC4PMzxIIv84ROAp0OIhSHvrXECe22MkrjMj2WIFXXJAo/n
 zkin7duHo9iaASU6ceNowIzHINB/mOYzD0VBDJNtfdD/eaxodnWQS1kDf/5gjQpFTSwfauVWn
 +uEzmH6fnPfSn1q1LlsBvHBKjyVQmjb0HIzDXUtscszY0G0r1zOegcKUNbQr08jwrVkgb+O9a
 vrmXmSO7h3G4NrWhcLsZKcFR6WGKCtGx61nYINqQcZTccij+8F5u6dmwCsgT3FTmzpWjmnA/p
 Rq9ZnRhVNwLLy/5QReP9lLI0NchnKRoAK4xNr/VaZm1a8tOS2pEwpu3veZ8tX/sbuBGCez/oG
 5EuFlC95whs/ZXXb94R1+Cc11FPTXU+mTHQNYp8hPG0cWKRcArvGZdgIxL0AwB22pb6MaDjSj
 vHNcZ1uOZ9vqDUa6r4Anl6uYLw+3YKlQrUndMnRyYOfYuqQmfox7yiTgEfzVjPNv09Zgzfe0f
 RtRusBiKH+ngi+VtcSQ4SHjVPrwj8QeW6p5AUY8tpyDnw6dI+j1sE4XbPctXimmHKiHBxBHa0
 CzU8KAfA+HHUVh0pRi3tbuMAqH587LMx/0i/8gt+psh6jRwzW3ty7FU0vyiyylEup2llU39y5
 TP5NRssAYKO5Yl40uuIRUIUXFnYB4ZeZKmXGnqiMa/B/9ILQv88hNFa1qMFCa4/RvtzxROB1h
 h1oNhDe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-25 21:53, Geert Uytterhoeven wrote:
> Hi Jan,
> 
> On Wed, Apr 25, 2018 at 9:40 PM, Jan Kiszka <jan.kiszka@web.de> wrote:
>> What other pointers are we talking about?
> 
> There's also the issue that some data has been allocated using kmalloc(),
> while others hasn't. The "other" pointers point to e.g. early bootmem or
> memblock.

Should not be an issue for overlays or of_changesets, should it?

Yes, I've learned the hard way that it is a very bad idea to build
changesets with properties that were not dynamically allocated. Maybe
that is documented somewhere, how the ownership of those objects change
after apply and how they may get handled later on. But now as I know,
it's kind of consistent and rather easy to account for.

Jan
