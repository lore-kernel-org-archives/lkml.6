Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751368AbeDYFiQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 01:38:16 -0400
Received: from mout.web.de ([212.227.15.3]:46379 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750888AbeDYFiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 01:38:12 -0400
Subject: Re: [PATCH v7 2/5] of: change overlay apply input data from
 unflattened to FDT
To: Alan Tull <atull@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
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
 <CANk1AXQKSS+rwbXzPRkF4V_TXA56fQR+1EVFyspCM7dpVNJaQA@mail.gmail.com>
 <CANk1AXT=zuKHgV4yUVTyWTHmbh5mYtNaO5GfiyDo99zhe4sQXQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@web.de>
Openpgp: preference=signencrypt
Message-ID: <becdd908-f075-e434-1ac0-6bc9cfe3829e@web.de>
Date: Wed, 25 Apr 2018 07:38:02 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <CANk1AXT=zuKHgV4yUVTyWTHmbh5mYtNaO5GfiyDo99zhe4sQXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:5/teONuAYq54hgzOgk7hfdvyHL/Lvew58qG8Je4gmFy5oZF3HKL
 17KItsH5ozzKgZdrpaZQkuGFqjdfOfAtvdKdjkgJ3rnh1Z4iHx34d++aE0G486eusFOcPq9
 9BNxJJyO8aeZuqFiVvU1JJQXst3g1fCRGRZL6TY4isHEnzj72CD/OgF0JgCaOWU5sGqXM3o
 3pXUParr5TJCji94pK12A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zKskJkUj9wE=:K5Ws9UEE4oqTUFuPVhCDKZ
 DiPUHKuSd3koa2avcqwm3k/ylgCtpZCEbjZGwzXTsPUbRD5S/yLgww42yLtOHGass2gcjhuSa
 VLTu8nTd4tNlDR/2pMUBDowVPGqi8aLTprmqCMhHvHndHQC9OKL4MJMxQDj5oBbt+ew0wld3t
 poZr1YM3hx5hrF/1pFP7WaONsqKCW8feSqbsdyK3GJUeVl5j+sXP4J87h6PnT0wy2FkuIjzXV
 Ad7nSvAkVyjzgRpSw33ByfYNBEKrmnb0tdBDzYnYiU7JWC8xDcEstk2nrVqFa376maURENFFE
 zoHWR/0ut5q7gB4Z36av4WfsCYx6W8PeYN8KWIAeA1LcKR+U9KKXab8osOAlTmkSz6Wa4fMwQ
 V6HB08w7Iy4zNQlIlNzgMpdGMNR4n1vWlRliSa6rvugxkfyNLfoymo6GS9Qo+Bioy1OANMD6p
 d3151alMDjXdXMRv3bV4TJhLZECdehTC8deM8rmbxmS0nJ+40H79rlnG0ivzguvQuMFb2yIkm
 Mr+uOTF8xfvW5odykbAatuVmKz5GL+4ImRklGBKbm/CTH46pH2gC/j5B9phSbwXuNAnhQIfrz
 vlBerEKijfyPFstK5jowRF75ljEjD5t/6Cv2axO6cHSIvnbXNbm1Irzu3NQdKXwZwMmMEhC/6
 rWnhXAuovPdYQcVDOczfnSqQqJR8bfB46ddu/AQ0tva6hGdygZzjB1NwfYNihyAgK+kkkMly2
 2Cot+HGvRKWmLDN7O4wP9NnL6ksMpWOKx7RNhAw4UFA9Af3IegVCEjNcdPV4nwZOEuLZi5AhN
 3+Th9mwXa5s4o644r7JlqoF4WSU33DooTxw0x2sXf7yMsmuDAo=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-24 20:26, Alan Tull wrote:
> On Tue, Apr 24, 2018 at 11:08 AM, Alan Tull <atull@kernel.org> wrote:
>> On Tue, Apr 24, 2018 at 12:29 AM, Jan Kiszka <jan.kiszka@web.de> wrote:
>>>
>>> We have drivers/fpga/of-fpga-region.c in-tree, and that does not seem to
>>> store any pointers to objects, rather consumes them in-place. And I
>>> would consider it fair to impose such a limitation on the notifier
>>> interface.
>>
>> The FPGA code was written assuming that overlays could be removed.
> 
> To be more specific, drivers/fpga/of-fpga-region.c currently saves a
> pointer to the overlay and uses it only during the pre-apply
> notification.

Even more exactly: You are saving a reference during pre-apply and
freeing that one again on the corresponding post-remove. That is what I
would have expected as normal usage of the notification API as well.

Jan
