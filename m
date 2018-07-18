Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E105EECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D1120693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95D1120693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbeGRJCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 05:02:54 -0400
Received: from 4.mo6.mail-out.ovh.net ([87.98.184.159]:58209 "EHLO
        4.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbeGRJCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 05:02:54 -0400
X-Greylist: delayed 1104 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Jul 2018 05:02:52 EDT
Received: from player737.ha.ovh.net (unknown [10.109.159.159])
        by mo6.mail-out.ovh.net (Postfix) with ESMTP id 2E179169E5E
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 10:07:47 +0200 (CEST)
Received: from [192.168.0.230] (22.220.201.77.rev.sfr.net [77.201.220.22])
        (Authenticated sender: sebastien.szymanski@armadeus.com)
        by player737.ha.ovh.net (Postfix) with ESMTPSA id E40B8E009D;
        Wed, 18 Jul 2018 10:07:31 +0200 (CEST)
Subject: Re: [PATCH 1/2] drm/panel: Add support for Armadeus ST0700 Adapt
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20180717072318.18730-1-sebastien.szymanski@armadeus.com>
 <CAOMZO5Dr0zqy4Sf3s=L4qoqePRhZAXWpDk1oTOUidy4_TUQ=QA@mail.gmail.com>
From:   =?UTF-8?Q?S=c3=a9bastien_Szymanski?= 
        <sebastien.szymanski@armadeus.com>
Openpgp: preference=signencrypt
Autocrypt: addr=sebastien.szymanski@armadeus.com; prefer-encrypt=mutual;
 keydata=
 xsBNBFNfZLEBCACv1lqSePHJNpRgcnER+3emy+Arjz84zFax3XkogjY/e3ZneihIgWrVKe5M
 ql16pX4KTkzNgMUKz4bG/XwT3kjcrXshxFLlg7KrHMl287C+W+QOUjnjVeRi/su+SPmjz8VD
 yr11h+ZkVLAWhS+uQJ93jy1NwG8M4t1kBLAVHHD5Vw4FJ+3ouaVYIp1X1Cr8bVKQw33Q1aTd
 ro0kMBb96B9vNu7ciJZ3gvlaBzUEKOgNnq9KaywuLnqrqr4HUIn5JuxZjCjJzt9kTAKcTfp2
 cJM8qpp+2FF5qtbkse9fZ6M64qozgOPr9Tk4Amf9fZEUQ6UNw14mmBZuXSzoHe75gI7TABEB
 AAHNN1PDqWJhc3RpZW4gU1pZTUFOU0tJIDxzZWJhc3RpZW4uc3p5bWFuc2tpQGFybWFkZXVz
 LmNvbT7CwH8EEwECACkFAlNfZLECGyMFCQlmAYAHCwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIX
 gAAKCRCwminogTJk4ss0CACpxtvYO1rCYNtc/j/6fkDsuKKwGtijixHU+C3N+EAJVoHSCdRM
 /PMtyN1fa+94XbW4LHQpZthkXd4kBpcf0aNtrS51193/YZHK5jLpJlUMKLGgU5VHXguakOOF
 ZWptlUCEqZaQ4gR8CUxPZi4urNAg/ORxCiVW2oMO/8GRhoZ+r14QNDGFVphbdlk/4YyY3wr7
 scDKTrRdkGw7kJElAp61I/B2KSbhnvF7U6H646a12/7bm6IEOAWbntoPcBg1h6irlCiNqfxs
 Zfy3r6rVRy840Dl7ldoUzOs7Eon8lUQilr9UorOHBF4NaBTpyD75DtvjRQsF2qV+R1RGS/Em
 IvrjzsBNBFNfZLEBCAC6O44V3Xa1wU0buUgI3pVed48hwSU1/7zeJy/1W21v7GnGvjSYw0sc
 eQwZqLWW0HViMmYkiI1P8Z00RL7Q65emXkrClne2aoromOH0kc8LkKfa3dMqkbsXrK1nsiQd
 cwknRLy8igEhEbfp8ZDgPiMyeMtai7b51q/ki9QF4EzMPk5MsCiAwkVh0yGGrNdZXRo/NoDi
 KWHl52qXjSx30+BEMINDXlmB8pycQEFol+Wj5cNLkqQEErAV0BSHt36aL3jEp1yvjxtgQTs3
 sWL+6+Eu9GurBfbIE0z6XyqlGqqgvrtfm1F+mpUwCoRiicsGhelYqi5YGPD38KIUsgJapU0T
 ABEBAAHCwGUEGAECAA8FAlNfZLECGwwFCQlmAYAACgkQsJop6IEyZOKWTgf/RbOvtKW77EXW
 XBzh04rfkW6prOlbJaIMUjVKZZ1D2OOpAxJbq80whJqCoJ+oVh7uAteozgX3U5TnL7fRx6HP
 zhyidiwKCOXEeTsFrRHEpTOCJYbPz8MTsK14ogz/aUlImt0HbxTaVHz5m65wWM8doCqOj2J9
 Vf12NNpfTxkotmM0QJQAIcEg10RfT3DLG1a68sdghM5rlz/b8mr/wjtOVxYX1TWKMvilCdQy
 YT8NNFcBwMEy5Jt2SXpeASY0CIXGwqqCBLqmQMhh3VcmibIbBBB0hIg4f56Vfn7v8ouFmbYS
 G0Q3TMIWXxYn91KiMXeox+Wsic2Ocw/KpZ/tus0JXQ==
Message-ID: <3bfd3bde-55e2-9b68-a8ab-c69dc98097da@armadeus.com>
Date:   Wed, 18 Jul 2018 10:19:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAOMZO5Dr0zqy4Sf3s=L4qoqePRhZAXWpDk1oTOUidy4_TUQ=QA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17677191491120813079
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtiedrieduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On 07/17/2018 02:28 PM, Fabio Estevam wrote:
> Hi Sébastien,
> 
> On Tue, Jul 17, 2018 at 4:23 AM, Sébastien Szymanski
> <sebastien.szymanski@armadeus.com> wrote:
>> This patch adds support for the Armadeus ST0700 Adapt. It comes with a
>> Santek ST0700I5Y-RBSLW 7.0" WVGA (800x480) TFT and an adapter board so
>> that it can be connected on the TFT header of Armadeus Dev boards.
>>
>> Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
>> ---
>>  .../display/panel/armadeus,st0700-adapt.txt        |  9 +++++++
>>  drivers/gpu/drm/panel/panel-simple.c               | 29 ++++++++++++++++++++++
>>  2 files changed, 38 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/display/panel/armadeus,st0700-adapt.txt
>>
>> diff --git a/Documentation/devicetree/bindings/display/panel/armadeus,st0700-adapt.txt b/Documentation/devicetree/bindings/display/panel/armadeus,st0700-adapt.txt
>> new file mode 100644
>> index 000000000000..a30d63db3c8f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/panel/armadeus,st0700-adapt.txt
>> @@ -0,0 +1,9 @@
>> +Armadeus ST0700 Adapt. A Santek ST0700I5Y-RBSLW 7.0" WVGA (800x480) TFT with
>> +an adapter board.
>> +
>> +Required properties:
>> +- compatible: "armadeus,st0700-adapt"
> 
> Shouldn't this be named "santek,st0700i5y" instead?
> 
> Santek is the vendor of the panel and st0700i5y is the model.

You're right but Armadeus doesn't provide the panel as-is. Armadeus adds
an adapter board so it can be connected on the development boards. [1]
Even though the panel supports MEDIA_BUS_FMT_RGB888_1X24, with the
adapter board the bus format has to be MEDIA_BUS_FMT_RGB666_1X18.

[1] http://www.opossom.com/english/products-peripherals-st0700_adapt.html

Regards,

> 
> Then you could add a "santek" entry in
> Documentation/devicetree/bindings/vendor-prefixes.txt.
> 
> Regards,
> 
> Fabio Estevam
> 


-- 
Sébastien Szymanski
Software engineer, Armadeus Systems
Tel: +33 (0)9 72 29 41 44
Fax: +33 (0)9 72 28 79 26
