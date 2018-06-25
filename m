Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE430C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 542C525562
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 542C525562
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753181AbeFYHun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 03:50:43 -0400
Received: from 9.mo179.mail-out.ovh.net ([46.105.76.148]:51495 "EHLO
        9.mo179.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753065AbeFYHuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 03:50:40 -0400
Received: from player778.ha.ovh.net (unknown [10.109.122.15])
        by mo179.mail-out.ovh.net (Postfix) with ESMTP id 22728D4C08
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 09:50:38 +0200 (CEST)
Received: from [192.168.0.230] (22.220.201.77.rev.sfr.net [77.201.220.22])
        (Authenticated sender: sebastien.szymanski@armadeus.com)
        by player778.ha.ovh.net (Postfix) with ESMTPSA id 42BA11800A8;
        Mon, 25 Jun 2018 09:50:20 +0200 (CEST)
Subject: Re: [PATCH v3 1/3] cpufreq: imx6q: check speed grades for i.MX6ULL
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
References: <20180522062853.24799-1-sebastien.szymanski@armadeus.com>
 <20180611053826.GC16091@dragon>
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
Message-ID: <2d63a25f-7265-7aa7-a7dc-fd2379240804@armadeus.com>
Date:   Mon, 25 Jun 2018 10:01:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180611053826.GC16091@dragon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11442802232440018151
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtiedruddvgdejtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/11/2018 07:38 AM, Shawn Guo wrote:
> On Tue, May 22, 2018 at 08:28:51AM +0200, Sébastien Szymanski wrote:
>> Check the max speed supported from the fuses for i.MX6ULL and update the
>> operating points table accordingly.
>>
>> Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
> 
> Acked-by: Shawn Guo <shawnguo@kernel.org>
> 

Thanks, but what about the two others patches ? Now that patch 1 is in
4.18-rc1, should I resend the two others patches ? Should I merge them
together ?

-- 
Sébastien Szymanski

